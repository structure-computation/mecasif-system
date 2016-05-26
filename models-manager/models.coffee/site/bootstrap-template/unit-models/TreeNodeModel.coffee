# Copyright 2015 SpinalCom  www.spinalcom.com
#




class TreeNodeModel extends UnitModel
    constructor: ( params = {} ) ->
        super()

        @_name._set if params.name? then params.name else "unit_site_text" 
        
        @add_attr
            txt:  if params.txt? then params.txt else "node"
            type : if params.type? then params.type else "folder"
