#
class CastemTrussPGDItem extends TreeItem_Computable
    constructor: ( name = "Castem PGD" ) ->
        super()
        
        @_name.set name

        @add_child new TrussItem @_output
        @add_output new StrainedTrussItem @_children[0]

        @add_attr
            _files_to_save: []
        @_files_to_save.push new Path
        
    display_suppl_context_actions: ( context_action )  ->
        context_action.push  new TreeAppModule_Download            

    accept_child: ( ch ) ->
        false
