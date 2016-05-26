# Copyright 2015 SpinalCom  www.spinalcom.com
#

class HeadingModel extends UnitModel
    constructor: ( params = {} ) ->
        super()

        @_name._set if params.name? then params.name else "unit_site_text" 
        
        @add_attr
            num: if params.num? then params.num else 1
            title : if params.title? then params.title else ""
            panel_id: if params.panel_id? then params.panel_id else ""