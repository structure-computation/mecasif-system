#include "SpinalCoreQT/SpinalCore.h"
#include <sstream>

int main( ) {
    // connect to the hub
    QString IP = "127.0.0.1";
    QHostAddress adress( IP );
    QString port = "8890";
    qint32 userid = 1657;
    QString password = "4YCSeYUzsDG8XSrjqXgkDPrdmJ3fQqHs";
    SpinalCore* sc = new SpinalCore( adress, port.toInt(), userid, password );

    sc->load_type( "Castem2DPGDItem" ); 
    sc->load_type( "CastemTrussPGDItem" ); 
    
    while ( SpinalCore::Event event = sc->event() ) {
        ModelPointer mp = event.mp();
        quint64 test = mp[ "_computation_state" ];
        
        int mp_server_id = mp.get_server_id();
        std::stringstream strs;
        strs << mp_server_id;
        std::string temp_str = strs.str();        
        std::string commande;
        int output;        
        if ( test == true ){
            if ( mp.type() == "CastemTrussPGDItem" || mp.type() == "Castem2DPGDItem" ){
                commande = "../castem-organ/run " + temp_str ;
                output = std::system(commande.c_str());
            }    
            mp[ "_computation_mode" ] = 0;
            mp[ "_computation_state" ] = false;
            mp.flush();
        }
    }
}
