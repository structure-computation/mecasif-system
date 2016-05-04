#include "SpinalCoreQT/SpinalCore.h"
#include <QtGui/QImageReader>
#include <QtCore/QByteArray>
#include <QtCore/QBuffer>
#include <QtGui/QImage>
#include "TiffFileUpdater.h"
#include <boost/concept_check.hpp>
#include "ImgInterp.h"
#include <QtCore/QFile>
#include <QtCore/QString>
#include <QtCore/QTextStream>
#include <QtCore/QIODevice>
#include <fstream>
#include <sstream>


static bool is_an_image( QString name ) {
    QList<QByteArray> l = QImageReader::supportedImageFormats();
    foreach( QString t, l )
        if ( name.endsWith( '.' + t ) )
            return true;
    if ( name.endsWith( '.tif' ) )
            return true;
    return false;
}

void TiffFileUpdater::exec( ModelPointer mp ) {
    
    // t : integer which increase when conversion failed because of no .tiff file in data.db yet
    int t = mp[ "_has_been_converted" ];
    
    // try to convert 1000 times, then stop trying 
    if ( t < 1000 ){
        //qDebug() << "Tiff update try " << t;
        
        quint64 ptr_tiff = mp[ "_ptr_tiff" ];
        QString name = mp[ "name" ];

        if ( is_an_image( name ) and not mp[ "_info.img" ].ok() ) {
            ModelPointer data = sc->load_ptr( ptr_tiff );
            if ( data.ok() and data.type() == "Path" ) {
                int rem = mp[ "_info.remaining" ];
                if ( not rem ) {
                    // reading the path to data.db
                    QString p = data;
                    
                    // conversion to .jpeg in data.db
                    char magic_number[ 4 ];
                    std::ifstream f( p.toLatin1().data());
                    f.read( magic_number, 4 );
                    f.close();
                    // if the .tiff file is totally created in data.db, then this condition is ok
                    if ( magic_number[ 0 ] == 0x49 and magic_number[ 1 ] == 0x49 and magic_number[ 2 ] == 0x2A and magic_number[ 3 ] == 0x00 ) {
                        
                        // conversion
                        LMT::ImgInterp<double,2> img( p.toLatin1().data() );
                        QImage qimg = img.to_QImage( true );
                                        
                        // save the img file in data.db
                        quint64 ptr_png = mp[ "_ptr" ];
                        ModelPointer data_png = sc->load_ptr( ptr_png );
                        QString adr_png = data_png;
                        qimg.save( adr_png, "JPEG", 20 );       // .jpeg format, with compression factor of 20 (0: very compressed, 100: uncompressed)
                        
                        // miniature for the FileSystem
                        QImage res( qimg.scaled( QSize( 128, 128 ), Qt::KeepAspectRatio ) );    // resizing to 128*128 pixels
                        QByteArray ba;
                        QBuffer buffer( &ba );
                        buffer.open( QIODevice::WriteOnly );
                        res.save( &buffer, "JPEG", 20 );  // .jpeg format, compressed
                        QByteArray b6;
                        b6.append( "data:image/png;base64," );
                        b6.append( ba.toBase64() );
                        mp[ "_info.img" ] = QString::fromLatin1( b6.data(), b6.size() );
                        
                        // conversion succeeded, t -> 1000 in order to stop trying to convert
                        t = 1000;
                        mp[ "_has_been_converted" ] = t;
                        
                        mp.flush();
                    }
                    // if the .tiff file is not created in data.db yet
                    else {
                        t += 1; // increase of counter
                        mp[ "_has_been_converted" ] = t;
                        mp.signal_change();     // to reload TiffFileUpdater
                    }
                }
            }
        }
    }
}


