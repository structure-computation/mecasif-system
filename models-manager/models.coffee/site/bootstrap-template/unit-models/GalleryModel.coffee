# Copyright 2015 SpinalCom  www.spinalcom.com
#

class GalleryModel extends UnitModel
    constructor: ( params = {} ) ->
        super()

        @_name._set if params.name? then params.name else "unit_site_text" 
        
        @add_attr
            lst : if params.lst? then params.lst else []
            lst_captions: if params.lst_captions? then params.lst_captions else []
            lst_href: if params.lst_href? then params.lst_href else []
            panel_id: if params.panel_id? then params.panel_id else "" 
            col : if params.col? then params.col else 3
            height : if params.height? then params.height else "200px"