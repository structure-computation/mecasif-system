#
class TrussItem extends TreeItem
    constructor: ( _output, name = "Truss" ) ->
        super()
        
        @_name.set name
        @_viewable.set true
        
        @add_attr
            dimensions :
                L1 : 0.250
                L2 : 0.5
                
            force :
                Fx : 10000.0
                Fy : -50000.0
            _strain_truss_item : if _output? then _output else undefined    
                
        @add_attr
            _mesh: new Mesh
                not_editable: true
            _p_mesher: new Lst
            
        @add_attr
            _psi : new Lst
            _lambda : new Lst
            
        @_mesh.visualization.display_style.num.set 1            
        @_mesh.move_scheme = MoveScheme_2D
        
        
        @add_child new BeamItem "Beam 1"
        @add_child new BeamItem "Beam 2"
        @add_child new BeamItem "Beam 3"
        @add_child new PGDParamsItem

        @bind =>
            if @dimensions.L1.has_been_modified() or @dimensions.L2.has_been_modified()        
                
                @_mesh.clear()
                @_p_mesher.clear()
                for substruct in @_children when substruct instanceof BeamItem
                    substruct._mesh.clear()
                    substruct._p_mesher.clear()
                
                coord_A = [ -1*@dimensions.L1, @dimensions.L2, 0 ]
                coord_B = [ 0, @dimensions.L2, 0 ]
                coord_C = [ @dimensions.L1, @dimensions.L2, 0 ]
                coord_D = [ 0, 0, 0 ]
                
                pm_A = new PointMesher coord_A
                pm_B = new PointMesher coord_B
                pm_C = new PointMesher coord_C
                pm_D = new PointMesher coord_D
                
                @add_point pm_A
                @add_point pm_B
                @add_point pm_C
                @add_point pm_D
                        
                @_children[0]._mesh.add_point coord_A
                @_children[0]._mesh.add_point coord_D
                @_children[1]._mesh.add_point coord_B
                @_children[1]._mesh.add_point coord_D
                @_children[2]._mesh.add_point coord_C
                @_children[2]._mesh.add_point coord_D


                @_children[0]._mesh.add_element new Element_Line [ 0, 1 ] 
                @_children[1]._mesh.add_element new Element_Line [ 0, 1 ] 
                @_children[2]._mesh.add_element new Element_Line [ 0, 1 ]     
                

                strained_truss_item = @_strain_truss_item[0]
                strained_truss_item._dimensions.L1.set @dimensions.L1.get()
                strained_truss_item._dimensions.L2.set @dimensions.L2.get()
                    
        
    cosmetic_attribute:( name ) ->
        super( name ) or ( name in [ "_strain_truss_item"  ] ) 
    
    sub_canvas_items: ->
        lst = [@_mesh]
        for pm in @_p_mesher
            lst.push pm
        return lst

   
    add_point: ( p = new PointMesher ) ->
        if p instanceof PointMesher
            @_p_mesher.push p                  
            
    on_mouse_down: ( cm, evt, pos, b ) ->
        []
        
    accept_child: ( ch ) ->
        ch instanceof BeamItem     
        ch instanceof PGDParamsItem     
        
               