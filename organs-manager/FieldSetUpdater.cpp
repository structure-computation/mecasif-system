#include "SpinalCoreQT/SpinalCore.h"
#include "FieldSetUpdater.h"
#include <QtCore/QBuffer>
#include <QtGui/QImage>
#include <fstream>

void FieldSetUpdater::exec( ModelPointer mp ){

    ModelPointer output_visu = mp;

    if(output_visu.type() == "FieldSetCorreliItem"){

        int time = output_visu[ "time.val" ];
        int old_time = output_visu[ "_old_time_step" ];

        if(time != old_time){

            ModelPointer data_directory = sc->load_ptr( output_visu[ "_img_field_set_ptr" ]);
            quint64 ptr;
            ptr = data_directory[ "_children" ][time][ "_result_ptr" ];
            if (not ptr)
                ptr = data_directory[ "_children" ][time]["_children"][0][ "_result_ptr" ];
            ModelPointer output_field = sc->load_ptr( ptr );

            ModelPointer list_visualisation_output = output_field["visualization.color_by.lst"];
            ModelPointer list_visualisation = output_visu["visualization.color_by.lst"];
               
            for(int i=0; i<list_visualisation_output.size(); i++){
                ModelPointer data = list_visualisation_output[i]["data._data"];
                ModelPointer data_visu = list_visualisation[i]["data._data"];
                for(int j=0; j<data.size(); j++){
                    data_visu.clear();
                    data_visu << data[j];
                }    
            }
            
            
            
//////////////////////////////////////////////////////////////////////            
            ModelPointer data_visu;
            if(time == 0){
                for(int i=0; i<12; i++){
                ModelPointer data_visu = list_visualisation[i]["data._data"];
                data_visu.clear();
                }
            }
////////////////////////////////////////////////////////////////////////:
            output_visu[ "_old_time_step" ] = time;
            qDebug() << "time_step : " << time;
//             qDebug() << "field : " << list_visualisation_output[0]["data._data[0].field._data"];
//             qDebug() << "field type : " << list_visualisation_output[0]["data._data[0].field._data"].type();
           
        }
        output_visu.flush();
    }
}


