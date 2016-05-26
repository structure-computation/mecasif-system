# Copyright 2015 SpinalCom  www.spinalcom.com
#

class UnitModel extends Model
    constructor: ->
        super()

        @add_attr
            _name      : ""
            _children  : []


    # child must be an instance of TreeItem
    add_child: ( child ) ->
        @_children.push child

