# Copyright 2015 SpinalCom  www.spinalcom.com
#

class IFrameModel extends UnitModel
    constructor: ( params = {} ) ->
        super()

        @_name._set if params.name? then params.name else "unit_site_text" 
        
        @add_attr
            col_id: if params.col_id? then params.col_id else undefined
            id: if params.id? then params.id else undefined
            title : if params.title? then params.title else "Title"
            balise : if params.balise? then params.balise else undefined
            src : if params.src? then params.src else ""
            format: if params.format? then params.format else "16by9"
