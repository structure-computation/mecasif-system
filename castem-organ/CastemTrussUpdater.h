#ifndef MESHUPDATER_H
#define MESHUPDATER_H

#include <SpinalCoreQT/Updater.h>
class SpinalCore;
class QDataStream;

/**
*/


class CastemTrussUpdater : public Updater {
protected:
    bool run( ModelPointer mp );
    virtual QString type() const { return "CastemTrussUpdater"; }
    
public:
    SpinalCore *sc;
    const char*& test();

    
};

#endif // MESHUPDATER_H
