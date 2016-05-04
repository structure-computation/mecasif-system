#ifndef MAKEIMGRAWVOLUME_H
#define MAKEIMGRAWVOLUME_H

#include "SpinalCoreQT/ModelPointer.h"
class SpinalCore;

void _make_img_raw_volume( unsigned char *ptr, float *z, int width, int height, ModelPointer mp, ModelPointer view_item, double time, SpinalCore *sc );

#endif // MAKEIMGRAWVOLUME_H
