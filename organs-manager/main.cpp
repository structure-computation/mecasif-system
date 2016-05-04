#include "SpinalCoreQT/SpinalCore.h"
#include "JobList.h"
#include "ServerAssistedVisualizationUpdater.h"
#include "FileUpdater.h"
#include "ImgUpdater.h"
#include "FieldSetUpdater.h"
#include "TiffFileUpdater.h"

int main( ) {
    // connect to the hub
    QString IP = "127.0.0.1";
    QHostAddress adress( IP );
    QString port = "8890";
    SpinalCore* sc = new SpinalCore( adress, port.toInt() );

    // type d'item observé
    sc->load_type( "CastemTrussPGDItem" ); 
    sc->load_type( "Castem2DPGDItem" ); 
    
    //liste des job en cours
    JobList job_list;
    
    // attente
    while ( SpinalCore::Event event = sc->event() ) {
        ModelPointer mp = event.mp();
        //test : verification de l'existance d'un job, ou création du job si necessaire

        // qDebug() << "model : " << mp;
        // qDebug() << "recu ";
        if ( mp.type() == "ServerAssistedVisualization" ) {
            ServerAssistedVisualizationUpdater mu;
            mu.sc = sc;
            mu.exec( mp );
        } else if ( mp.type() == "File" ) {
            FileUpdater fu;
            fu.sc = sc;
            fu.exec( mp );
        } else if ( mp.type() == "TiffFile" ) {
            TiffFileUpdater tfu;
            tfu.sc = sc;
            tfu.exec( mp );
        } else if ( mp.type() == "FieldSetCorreliItem" ) {
            FieldSetUpdater fsu;
            fsu.sc = sc;
            fsu.exec( mp );
        } else{
            job_list.kill_jobs();
            int i_job = job_list.find_job_index(mp, sc);
            
            if(i_job >= 0){
//                 qDebug() << "i_job : " << i_job ;
//                 qDebug() << "job_list.jobs.size() : " << job_list.jobs.size();
                Job *current_job;
                current_job = job_list.jobs[i_job];
                current_job->putLauncherInAThread(mp);
                
    //             mp[ "_computation_mode" ] = false;
            }else if(i_job == -1 ){
//                 qDebug() << "i_job : " << i_job ;
            }else if(i_job == -2 ){
                mp[ "_computation_mode" ]   = false;
                mp[ "_ready_state" ]        = false;
                mp[ "_computation_state" ]  = false;
                mp[ "_pending_state" ]      = false;
                mp[ "_processing_state" ]   = false;
                mp[ "_finish_state" ]       = false;
                mp[ "_stop_state" ]         = true;
//                 qDebug() << "i_job : " << i_job ;
                mp.flush();
            }
        }     
    }
}
