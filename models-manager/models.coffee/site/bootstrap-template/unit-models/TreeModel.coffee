# Copyright 2015 SpinalCom  www.spinalcom.com
#




class TreeModel extends UnitModel
    constructor: ( params = {} ) ->
        super()

        @_name._set if params.name? then params.name else "unit_site_text" 
        
        @add_attr
            panel_id: if params.panel_id? then params.panel_id else ""
            id: if params.id? then params.id else ""