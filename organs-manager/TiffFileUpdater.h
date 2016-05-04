#ifndef TIFF2PNG_H
#define TIFF2PNG_H

#include "SpinalCoreQT/ModelPointer.h"
class SpinalCore;

/**
*/
class TiffFileUpdater {
public:
    void exec( ModelPointer mp );

    SpinalCore *sc;
};

#endif // TIFF2PNG_H
