/*
 Copyright 2015 SpinalCom - www.spinalcom.com
*
* This file is part of SpinalCore.
*
* Please read all of the following terms and conditions
* of the Free Software license Agreement ("Agreement")
* carefully.
*
* This Agreement is a legally binding contract between
* the Licensee (as defined below) and SpinalCom that
* sets forth the terms and conditions that govern your
* use of the Program. By installing and/or using the
* Program, you agree to abide by all the terms and
* conditions stated or referenced herein.
*
* If you do not agree to abide by these terms and
* conditions, do not demonstrate your acceptance and do
* not install or use the Program.
*
* You should have received a copy of the license along
* with this file. If not, see
* <http://resources.spinalcom.com/licenses.pdf>.
*/

#ifndef MODEL_H
#define MODEL_H

#ifdef METIL_COMP_DIRECTIVE
#pragma inc_path /usr/include/qt4
#endif // METIL_COMP_DIRECTIVE

#include <QtCore/QtGlobal>
#include <QtCore/QVector>
#include <QtCore/QString>
#include <QtCore/QVector>
#include <QtCore/QDebug>
class Database;
class BinOut;

/**
*/
class Model {
public:
    struct Callback {
        QObject *receiver;
        const char *member;
    };

    Model();

    void bind( QObject *receiver, const char *member );

    virtual void     write_str ( QDebug dbg ) const = 0;
    virtual void     add_attr  ( QString key, Model *m );
    virtual void     push      ( Model *m );
    virtual int      attr_index( QString key ) const;
    virtual Model   *attr      ( QString key ) const;
    virtual Model   *attr      ( int index   ) const;
    virtual QString  key       ( int index ) const;
    virtual int      size      () const;
    virtual QString  type      () const = 0;
    virtual void     write_usr ( BinOut &nut, BinOut &uut, Database *db ) = 0;
    virtual bool     clear     () { return false; }
    quint64          get_server_id( Database *db ); ///<
    virtual QString  underlying_type() const;

    void write_nsr( BinOut &nut, BinOut &uut, Database *db );

    virtual operator int       () const { return 0; }
    virtual operator quint64   () const { return 0; }
    virtual operator double    () const { return 0; }
    virtual operator QString   () const { return "0"; }

    virtual bool _set( int info, QVector<Model *> &model_stack, QVector<QString> &string_stack );
    virtual bool _set( const char *str, int len );
    virtual bool _set( qint64 a, qint32 b );
    virtual bool _set( QString a );
    virtual bool _set( Model *m );
    virtual bool _set( qint64 a );

    void add_parent( Model *p );
    void rem_parent( Model *p );

    bool has_been_modified( quint64 cur_date ) const { return _date_last_change >= cur_date; }
    bool has_been_directly_modified( quint64 cur_date ) const { return _date_last_change == cur_date + 1; }

    QVector<Model *>  parents;
    quint64           _date_last_change;
    mutable qint64    _server_id;
    QVector<Callback> _onchange_list;
    bool              _changed_from_ext; ///< true if last change come from the server

    mutable quint64   _op_id;
    static  quint64   _cur_op_id;
};

QDebug operator<<( QDebug dbg, const Model *c );

#endif // MODEL_H
