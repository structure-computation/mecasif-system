#ifndef CASTER2DUPDATER_H
#define CASTER2DUPDATER_H

#include "SpinalCoreQT/Updater.h"
class SpinalCore;
class QDataStream;

/**
*/


class Castem2DUpdater : public Updater {
protected:
    virtual QString type() const { return "Castem2DUpdater"; }
    
public:
    bool run( ModelPointer mp );
    SpinalCore *sc;
    const char*& test();

    
};

#endif // CASTER2DUPDATER_H
