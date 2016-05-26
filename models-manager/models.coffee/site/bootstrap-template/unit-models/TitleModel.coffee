# Copyright 2015 SpinalCom  www.spinalcom.com
#




class TitleModel extends UnitModel
    constructor: ( params = {} ) ->
        super()

        @_name._set if params.name? then params.name else "unit_site_text" 
        
        @add_attr
#             num : if params.num? then params.num else 0
            title : if params.title? then params.title else ""
            balise     : if params.balise? then params.balise else "paragraph_balise"
