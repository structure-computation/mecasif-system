#
class CastemTrussPGDItem extends TreeItem_Computable
    constructor: ( name = "Castem PGD" ) ->
        super()
        
        @_name.set name

        @add_child new TrussItem @_output
        @add_output new StrainedTrussItem @_children[0]

        @add_attr
            _files_to_save: []
            _names_to_save: []
            result_filename: "Sortie_PGD_Treillis.txt"
            
        @_files_to_save.push new Path
        @_names_to_save.push @result_filename
        
        @bind =>
            if @result_filename.has_been_modified()
                @_names_to_save[0].set @result_filename.get()
        
        
    display_suppl_context_actions: ( context_action )  ->
        context_action.push  new TreeAppModule_Download            

    accept_child: ( ch ) ->
        false
