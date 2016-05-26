# Copyright 2015 SpinalCom  www.spinalcom.com
#

class TableModel extends UnitModel
    constructor: ( params = {} ) ->
        super()

        @_name._set if params.name? then params.name else "unit_site_table" 
        
        @add_attr
            lst : if params.lst? then params.lst else ""
            panel_id: if params.panel_id? then params.panel_id else ""