# Copyright 2015 SpinalCom  www.spinalcom.com
#

class CodeModel extends UnitModel
    constructor: ( params={} ) ->
        super()

        @add_attr
            txt  : if params.txt? then params.txt else "Code text here"
            type : if params.type? then params.type else "coffeescript"
            panel_id: if params.panel_id? then params.panel_id else "id"
        