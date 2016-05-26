# Copyright 2015 SpinalCom  www.spinalcom.com
#

class RowModel extends UnitModel
    constructor: ( params = {} ) ->
        super()

        @_name._set if params.name? then params.name else "unit_site_text" 
        
        @add_attr
            id: if params.id? then params.id else undefined
