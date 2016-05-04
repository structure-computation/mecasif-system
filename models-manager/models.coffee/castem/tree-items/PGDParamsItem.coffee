#
class PGDParamsItem extends TreeItem
    constructor: ( name = "PGD Parameters" ) ->
        super()
        
        @_name.set name
        
        @add_attr
            N1couple : 2
            N1pf : 50
            eps0 : 0.0000001
    
    
    accept_child: ( ch ) ->
        false