#
class AssemblyItem extends TreeItem
    constructor: ( name = "Assembly" ) ->
        super()
        
        @_name.set name
        @_viewable.set true
        
        @add_attr
            dimensions:
                solid_1:
                    L1: 60.0
                    H1: 20.0
                solid_2:
                    L2: 30.0
                    X2: 10.0
                    H2: 30.0
                    E2: 5.0
                    R2: 10.0
                solid_3:
                    H3: 40.0
                    X3: 40.0
                    E3: 5.0
                
            pressure :
                Px : 0.0
                Py : -50.0
            
        @add_attr
            _psi : new Lst
            _lambda : new Lst
            _mesh: new Mesh( not_editable: true )
            
        @_mesh.visualization.display_style.num.set 1            
        @_mesh.move_scheme = MoveScheme_2D            
        
        @add_child new SolidItem "Solid 1"
        @add_child new SolidItem "Solid 2"
        @add_child new SolidItem "Solid 3"
        
        glue_1 = new SolidItem "Glue 1"
        glue_2 = new SolidItem "Glue 2"
        glue_1._viewable.set false
        glue_2._viewable.set false
        @add_child glue_1
        @add_child glue_2
        
        @add_child new PGDParamsItem

        
        @bind =>
            if @dimensions.solid_2.X2.has_been_modified() or @dimensions.solid_2.L2.has_been_modified() or @dimensions.solid_3.X3.has_been_modified()
                @dimensions.solid_3.X3.set @dimensions.solid_2.X2.get() + @dimensions.solid_2.L2.get()

#     cosmetic_attribute:( name ) ->
#         super( name ) or ( name in [ "_strain_assembly_item"  ] ) 
    
   
    on_mouse_down: ( cm, evt, pos, b ) ->
        []
        
    accept_child: ( ch ) ->
        false
        
    sub_canvas_items: ->
        [@_mesh]                  