#
class SolidItem extends TreeItem
    constructor: ( name = "Solid" ) ->
        super()
        
        @_name.set name
        @_viewable.set true
        
        @add_attr
            _mesh: new Mesh
                not_editable: true
        
            materials:
                young_modulus : 200000
                poisson_coefficient : 0.3
                
            PGD:
                k_min : 0.9
                k_max : 1.1
                n_val : 20        
                
        @_mesh.visualization.display_style.num.set 1            
        @_mesh.move_scheme = MoveScheme_2D          
        
                
    accept_child: ( ch ) ->
        false
        
    sub_canvas_items: ->
        [@_mesh]    
        
    draw: ( info ) ->
        app_data = @get_app_data()
        sel_items = app_data.selected_tree_items[0]
        if sel_items?.has_been_directly_modified()
            if sel_items[ sel_items.length-1 ] == this
                @colorize "blue"
            else
                @colorize() 

    colorize: ( color ) ->
        for drawable in @sub_canvas_items() 
            if color == "blue"
                drawable.visualization.line_color.r.val.set 77
                drawable.visualization.line_color.g.val.set 188
                drawable.visualization.line_color.b.val.set 233
            else
                drawable.visualization.line_color.r.val.set 255
                drawable.visualization.line_color.g.val.set 255
                drawable.visualization.line_color.b.val.set 255
                
    is_app_data: ( item ) ->
        if item instanceof TreeAppData
            return true
        else
            return false
       
    get_app_data: ->
        it = @get_parents_that_check @is_app_data
        return it[ 0 ]        
      