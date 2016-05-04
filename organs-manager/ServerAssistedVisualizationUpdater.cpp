#include "ServerAssistedVisualizationUpdater.h"
#include "MakeImgRawVolume.h"
#include <QtCore/QBuffer>
#include <QtGui/QImage>
#include <limits>

static ModelPointer _find_view_item( ModelPointer roots, QString key ) {
    for( int num_ch = 0; num_ch < roots.size(); ++num_ch ) {
        ModelPointer ch = roots[ num_ch ];
        if ( ch.type() == "ViewItem" and QString( ch[ "_panel_id" ] ) == key )
            return ch;
        ModelPointer lc = ch[ "_children" ];
        if ( lc.ok() ) {
            ModelPointer res = _find_view_item( lc, key );
            if ( res.ok() )
                return res;
        }
    }
    return ModelPointer();
}

void _make_img( uchar *ptr, float *z, int width, int height, ModelPointer mp, ModelPointer view_item, double time, SpinalCore *sc ) {
    if ( mp.type() == "RawVolume" )
        _make_img_raw_volume( ptr, z, width, height, mp, view_item, time, sc );
    //for( int i = 0; i < mp[ "_children" ].size(); ++i )
    //    _make_img( ptr, z, width, height, mp[ "_children" ][ i ], view_item, time, sc );
}

bool hmodi( ModelPointer layout, ModelPointer cam, ModelPointer time, const QVector<ModelPointer> &obj_to_draw ) {
    if ( layout.has_been_modified() ) return true;
    if ( cam   .has_been_modified() ) return true;
    if ( time  .has_been_modified() ) return true;
    for( int i = 0; i < obj_to_draw.size(); ++i )
        if ( obj_to_draw[ i ].has_been_modified() )
            return true;
    return false;
}

void ServerAssistedVisualizationUpdater::exec( ModelPointer mp ) {
    ModelPointer layout = mp[ "layout" ];
    for( int num_layout = 0; num_layout < layout.size(); ++num_layout ) {
        QString key = layout.model()->key( num_layout );
        int width  = layout[ key ][ "width"  ];
        int height = layout[ key ][ "height" ];
        // qDebug() << key << " -> " << width << height;
        ModelPointer roots = mp[ "data.tree_items" ];
        ModelPointer view_item = _find_view_item( roots, key );
        ModelPointer time = mp[ "data.tree_items[ 0 ].time" ];
        if ( view_item.ok() ) {
            double t = time[ "val" ];

            ModelPointer vi = mp[ "data.visible_tree_items" ][ key ];
            QVector<ModelPointer> obj_to_draw;
            for( int nvi = 0; nvi < vi.size(); ++nvi ) {
                ModelPointer obj = vi[ nvi ];
                if ( obj.type() == "RawVolume" )
                    obj_to_draw << obj;
                else if ( obj.type() == "ImgSetItem" ) {
                    if ( obj[ "_children" ].size() ) {
                        int s = std::min( t, obj[ "_children" ].size() - 1.0 );
                        if ( obj[ "_children" ][ s ].type() == "RawVolume" )
                        obj_to_draw << obj[ "_children" ][ s ];
                    }
                }
            }

            if ( obj_to_draw.size() and hmodi( layout, view_item[ "cam" ], time, obj_to_draw ) ) {
                qDebug() << "obj_to_draw.size()" << obj_to_draw.size();
                for( int i = 0; i < obj_to_draw.size(); ++i )
                    qDebug() << obj_to_draw[ i ].type();

                QImage img( width, height, QImage::Format_ARGB32 );
                QVector<float> z; z.resize( width * height ); z.fill( std::numeric_limits<float>::max() );
                for( int i = 0; i < obj_to_draw.size(); ++i )
                    _make_img( img.bits(), z.data(), width, height, obj_to_draw[ i ], view_item, time, sc );

                // -> png
                QByteArray ba;
                QBuffer buffer( &ba );
                buffer.open( QIODevice::WriteOnly );
                img.save( &buffer, "PNG" );

                // -> base64
                QByteArray b6;
                b6.append( "data:image/png;base64," );
                b6.append( ba.toBase64() );

                // save
                view_item[ "_repr" ] = QString::fromLatin1( b6.data(), b6.size() );
            } else if ( obj_to_draw.size() == 0 )
                view_item[ "_repr" ] = "";
        }
    }
}
