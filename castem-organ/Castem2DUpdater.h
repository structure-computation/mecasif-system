#ifndef CASTER2DUPDATER_H
#define CASTER2DUPDATER_H

#include <SpinalCoreQT/Updater.h>
class SpinalCore;
class QDataStream;

/**
*/


class Castem2DUpdater : public Updater {
protected:
    bool run( ModelPointer mp );
    virtual QString type() const { return "Castem2DUpdater"; }
    
public:
    SpinalCore *sc;
    const char*& test();

    
};

#endif // CASTER2DUPDATER_H
