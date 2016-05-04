#ifndef IMGUPDATER_H
#define IMGUPDATER_H

#include "SpinalCoreQT/ModelPointer.h"
class SpinalCore;

/**
*/
class ImgUpdater {
public:
    void exec( ModelPointer mp );

    SpinalCore *sc;
};

#endif // IMGUPDATER_H
