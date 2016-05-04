#ifndef FIELDSETUPDATER_H
#define FIELDSETUPDATER_H

#include "SpinalCoreQT/ModelPointer.h"
class SpinalCore;

/**
*/
class FieldSetUpdater {
public:
    void exec( ModelPointer mp );

    SpinalCore *sc;
};

#endif // FILEUPDATER_H
