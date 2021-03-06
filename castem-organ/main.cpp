#include "SpinalCoreQT/SpinalCore.h"
#include "CastemTrussUpdater.h"
#include "Castem2DUpdater.h"

int main( int argc, char **argv  )
{
    // connect to the hub
    QString IP = "127.0.0.1";
    QHostAddress adress( IP );
    QString port = "8890";
    qint32 userid = 1657;
    QString password = "4YCSeYUzsDG8XSrjqXgkDPrdmJ3fQqHs";
    SpinalCore* sc = new SpinalCore( adress, port.toInt(), userid, password );
    
    //id du model à traiter
    quint64 model_id = atoi(argv[1]);   
    sc->load_type( "CastemTrussPGDItem" );
    sc->load_type( "Castem2DPGDItem" );
    ModelPointer mp = sc->load_ptr(model_id);
    qDebug() << "############### launch Castem ###############" ;
    
    if (mp.type() == "CastemTrussPGDItem"){
        CastemTrussUpdater updater;
        updater.sc = sc;
        updater.run( mp );
        mp.flush();
    }
    else if (mp.type() == "Castem2DPGDItem"){
        Castem2DUpdater updater;
        updater.sc = sc;
        updater.run( mp );
        mp.flush();
    }    
    qDebug() << "############### finish Castem ###############" ;
}
    

