
QT      += core gui
QT      += network

CONFIG += warn_off
TARGET = ../run
TEMPLATE = app

SOURCES += main.cpp\
    SpinalCoreQT/Com/ClientLoop.cpp \
    SpinalCoreQT/SpinalCore.cpp \
    SpinalCoreQT/Database/Database.cpp \
    SpinalCoreQT/Model/Bool.cpp \
    SpinalCoreQT/Model/Directory.cpp \
    SpinalCoreQT/Model/Lst.cpp \
    SpinalCoreQT/Model/LstWithType.cpp \
    SpinalCoreQT/Model/Model.cpp \
    SpinalCoreQT/Model/ModelWithAttr.cpp \
    SpinalCoreQT/Model/ModelWithAttrAndName.cpp \
    SpinalCoreQT/Model/Path.cpp \
    SpinalCoreQT/Model/Ptr.cpp \
    SpinalCoreQT/Model/Str.cpp \
    SpinalCoreQT/Model/Val.cpp \
    SpinalCoreQT/Sys/BinRd.cpp \
    SpinalCoreQT/ModelPointer.cpp \

HEADERS  += SpinalCoreQT/Com/ClientLoop.h \
    SpinalCoreQT/Com/ClientLoop_parser.h \
    SpinalCoreQT/SpinalCore.h \
    SpinalCoreQT/Database/Database.h \
    SpinalCoreQT/Model/Bool.h \
    SpinalCoreQT/Model/Directory.h \
    SpinalCoreQT/Model/Lst.h \
    SpinalCoreQT/Model/LstWithType.h \
    SpinalCoreQT/Model/Model.h \
    SpinalCoreQT/Model/ModelWithAttr.h \
    SpinalCoreQT/Model/ModelWithAttrAndName.h \
    SpinalCoreQT/Model/Path.h \
    SpinalCoreQT/Model/Ptr.h \
    SpinalCoreQT/Model/Str.h \
    SpinalCoreQT/Model/TypedArray.h \
    SpinalCoreQT/Model/Val.h \
    SpinalCoreQT/Sys/BinOut.h \
    SpinalCoreQT/Sys/BinRd.h \
    SpinalCoreQT/Sys/S.h \
    SpinalCoreQT/ModelPointer.h \

