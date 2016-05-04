#ifndef FILEUPDATER_H
#define FILEUPDATER_H

#include "SpinalCoreQT/ModelPointer.h"
class SpinalCore;

/**
*/
class FileUpdater {
public:
    void exec( ModelPointer mp );

    SpinalCore *sc;
};

#endif // FILEUPDATER_H
