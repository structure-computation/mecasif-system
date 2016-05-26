# Copyright 2015 SpinalCom  www.spinalcom.com
#

class ColModel extends UnitModel
    constructor: ( params = {} ) ->
        super()

        @_name._set if params.name? then params.name else "unit_site_text" 
        
        @add_attr
            row_id: if params.row_id? then params.row_id else undefined
            id: if params.id? then params.id else undefined
            width: if params.width? then params.width else 12
