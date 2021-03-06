class TreeAppApplication_Castem2D extends TreeAppApplication
    constructor: ->
        super()
        
        @name = 'Castem PGD 2D'
        @powered_with    = 'LMT Cachan'
        @description = 'Example of a PGD computation with Cast3m on a 2D glued assembly model.'

        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
            
        @actions.push
            ico: "img/castem_pgd_2d.png"
            siz: 1
            txt: "Castem"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                castem = @add_item_depending_selected_tree app.data, Castem2DPGDItem
#                 app.data.watch_item castem._children[0]
#                 app.data.watch_item castem._children[0]._children[0]
#                 app.data.watch_item castem._children[0]._children[1]
#                 app.data.watch_item castem._children[0]._children[2]                
        
            key: [ "Shift+M" ]

        
            