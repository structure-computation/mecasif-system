# Copyright 2015 SpinalCom  www.spinalcom.com
#

class ImageModel extends UnitModel
    constructor: ( params = {} ) ->
        super()

        @_name._set if params.name? then params.name else "unit_site_text" 
        
        @add_attr
            src : if params.src? then params.src else ""
            panel_id: if params.panel_id? then params.panel_id else "" 
            width: if params.width? then params.width else "1000px"
