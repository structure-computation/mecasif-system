# Copyright 2015 SpinalCom  www.spinalcom.com
#




class ParagraphModel extends UnitModel
    constructor: ( params = {} ) ->
        super()

        @_name._set if params.name? then params.name else "unit_site_text" 
        
        @add_attr
            txt : if params.txt? then params.txt else ""
            panel_id: if params.panel_id? then params.panel_id else ""