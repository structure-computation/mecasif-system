#include "ImgInterp.h"
#include "ImgUpdater.h"
#include <QtCore/QBuffer>
#include <QtGui/QImage>
#include <fstream>

//static bool is_an_image( QString name ) {
//    QList<QByteArray> l = QImageReader::supportedImageFormats();
//    foreach( QString t, l )
//        if ( name.endsWith( '.' + t ) )
//            return true;
//    return false;
//}

void ImgUpdater::exec( ModelPointer mp ) {
//     qDebug() << "-----------in ImgUpdater ";
//     if ( not mp[ "_repr" ].ok() ) {
        QString name( mp[ "src" ] );
//         qDebug() << "updater for " << name;
        char magic_number[ 4 ];
        std::ifstream f( name.toLatin1().data() );
        f.read( magic_number, 4 );
        f.close();
        if ( magic_number[ 0 ] == 0x49 and magic_number[ 1 ] == 0x49 and magic_number[ 2 ] == 0x2A and magic_number[ 3 ] == 0x00 ) {
            LMT::ImgInterp<double,2> img( name.toLatin1().data() );
            QImage qimg = img.to_QImage( true );

            // -> png
            QByteArray ba;
            QBuffer buffer( &ba );
            buffer.open( QIODevice::WriteOnly );
            qimg.save( &buffer, "PNG" );

            // -> base64
            QByteArray b6;
            b6.append( "data:image/png;base64," );
            b6.append( ba.toBase64() );

            // save
            mp[ "_repr" ] = QString::fromLatin1( b6.data(), b6.size() );

            //            QString repr( name + "_repr.png" );
            //            img.save( repr.toAscii().data(), true );

            //            mp[ "_repr" ] = ModelPointer::new_path( repr );
            // qDebug() << mp;
            mp.flush();
        }
//     }
}


// #include "ImgInterp.h"
// #include "ImgUpdater.h"
// #include <fstream>
// 
// //static bool is_an_image( QString name ) {
// //    QList<QByteArray> l = QImageReader::supportedImageFormats();
// //    foreach( QString t, l )
// //        if ( name.endsWith( '.' + t ) )
// //            return true;
// //    return false;
// //}
// 
// void ImgUpdater::exec( ModelPointer mp ) {
//     if ( not mp[ "_repr" ].ok() ) {
//         QString name( mp[ "src" ] );
//         // qDebug() << name;
//         char magic_number[ 4 ];
//         std::ifstream f( name.toLatin1().data() );
//         f.read( magic_number, 4 );
//         f.close();
//         if ( magic_number[ 0 ] == 0x49 and magic_number[ 1 ] == 0x49 and magic_number[ 2 ] == 0x2A and magic_number[ 3 ] == 0x00 ) {
//             LMT::ImgInterp<double,2> img( name.toAscii().data() );
//             // img.data *= 255.0 / LMT::max( img.data );
// 
//             QString repr( name + "_repr.png" );
//             img.save( repr.toAscii().data(), true );
// 
//             mp[ "_repr" ] = ModelPointer::new_path( repr );
//             qDebug() << mp;
//             mp.flush();
//         }
//     }
// }
