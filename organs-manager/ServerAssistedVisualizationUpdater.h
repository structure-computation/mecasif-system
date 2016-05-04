#ifndef SERVERASSISTEDVISUALIZATIONUPDATER_H
#define SERVERASSISTEDVISUALIZATIONUPDATER_H

#include "SpinalCoreQT/ModelPointer.h"
class SpinalCore;


/**
*/
class ServerAssistedVisualizationUpdater {
public:
    void exec( ModelPointer mp );
    SpinalCore *sc;
};

#endif // SERVERASSISTEDVISUALIZATIONUPDATER_H
