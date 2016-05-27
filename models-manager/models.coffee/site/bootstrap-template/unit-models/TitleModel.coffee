# Copyright 2015 SpinalCom  www.spinalcom.com
#




class TitleModel extends UnitModel
    constructor: ( params = {} ) ->
        super()

        @_name._set if params.name? then params.name else "unit_site_text" 
        
        @add_attr
            row_id : if params.row_id? then params.row_id else undefined
            title : if params.title? then params.title else ""
            balise : if params.balise? then params.balise else "paragraph_balise"
