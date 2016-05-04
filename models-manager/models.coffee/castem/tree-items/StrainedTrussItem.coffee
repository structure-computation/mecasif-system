#
class StrainedTrussItem extends TreeItem
    constructor: ( _truss_item, name = "Strained Truss" ) ->
        super()
        
        @_name.set name
        @_viewable.set true
        
        @add_attr
            _dimensions :
                L1 : 0.250
                L2 : 0.5
            _truss_item : if _truss_item? then _truss_item else undefined
                
        @add_attr
            _mesh: new Mesh( not_editable: true )              
            _p_mesher: new Lst
            _p_plot: new Lst
            
        @add_attr
            Ux : 0.0
            Uy : 0.0
            _Ux_disp : 0.0
            _Uy_disp : 0.0
            warp_factor: new ConstrainedVal( 1, { min: 1, max: 1000} )  
            
        @add_attr
            k :
                k1 : new ConstrainedVal( 0, { min: 1, max: 10, div: 10 } )
                k2 : new ConstrainedVal( 0, { min: 1, max: 10, div: 10 } )
                k3 : new ConstrainedVal( 0, { min: 1, max: 10, div: 10 } )            
            
        @_mesh.visualization.display_style.num.set 1            
        @_mesh.move_scheme = MoveScheme_2D
                
        @bind =>
        
            if @warp_factor.val.has_been_modified()
                @_p_plot.clear()
                @_Ux_disp.set ( @Ux.get() * @warp_factor.val.get() )
                @_Uy_disp.set ( @Uy.get() * @warp_factor.val.get() )   
                
            truss_item = @_truss_item
            
            if truss_item._children[0]?.PGD.n_val.has_been_modified()
                @k.k1.set_params
                    max: truss_item._children[0].PGD.n_val 
            if truss_item._children[1]?.PGD.n_val.has_been_modified()
                @k.k2.set_params
                    max: truss_item._children[1].PGD.n_val
            if truss_item._children[2]?.PGD.n_val.has_been_modified()
                @k.k3.set_params
                    max: truss_item._children[2].PGD.n_val    
                    
                    
            if @k.k1.val.has_been_modified() or @k.k2.val.has_been_modified() or @k.k3.val.has_been_modified()
                if truss_item._psi[0] != undefined and truss_item._lambda[0] != undefined
                    ux = 0
                    uy = 0
                    for p in [0..truss_item._psi.length-1]
                        ux += truss_item._psi[p][0][3] * truss_item._lambda[p][0][@k.k1.get()] * truss_item._lambda[p][1][@k.k2.get()] * truss_item._lambda[p][2][@k.k3.get()]
                        uy += truss_item._psi[p][1][3] * truss_item._lambda[p][0][@k.k1.get()] * truss_item._lambda[p][1][@k.k2.get()] * truss_item._lambda[p][2][@k.k3.get()]
                    @Ux.set ux
                    @Uy.set uy


            if @Ux.has_been_modified() or @Uy.has_been_modified()
                @_Ux_disp.set ( @Ux.get() * @warp_factor.val.get() )
                @_Uy_disp.set ( @Uy.get() * @warp_factor.val.get() )


            if @_dimensions.L1.has_been_modified() or @_dimensions.L2.has_been_modified() or @_Ux_disp.has_been_modified() or @_Uy_disp.has_been_modified()        
            
                @_mesh.clear()
                @_p_mesher.clear()
                
                coord_A = [ -1*@_dimensions.L1, @_dimensions.L2, 0 ]
                coord_B = [ 0, @_dimensions.L2, 0 ]
                coord_C = [ @_dimensions.L1, @_dimensions.L2, 0 ]
                coord_D = [ @_Ux_disp, @_Uy_disp, 0 ]
                
                pm_A = new PointMesher coord_A
                pm_B = new PointMesher coord_B
                pm_C = new PointMesher coord_C
                pm_D = new PointMesher coord_D
                
                @add_point pm_A
                @add_point pm_B
                @add_point pm_C
                @add_point pm_D
                        
                @_mesh.add_point coord_A
                @_mesh.add_point coord_B
                @_mesh.add_point coord_C
                @_mesh.add_point coord_D
                    
                @_mesh.add_element new Element_Line [ 0, 3 ] 
                @_mesh.add_element new Element_Line [ 1, 3 ] 
                @_mesh.add_element new Element_Line [ 2, 3 ]             
                
                @_mesh.visualization.line_color.g.set 0
                @_mesh.visualization.line_color.b.set 0


                already_a_point = false
                coord = [ @_Ux_disp, @_Uy_disp, 0 ]
                point_mesher = new PointMesher coord, 1, 1
                for pm in @_p_plot
                    if pm.point.pos[0].get() == point_mesher.point.pos[0].get() and pm.point.pos[1].get() == point_mesher.point.pos[1].get() and pm.point.pos[2].get() == point_mesher.point.pos[2].get()
                        already_a_point = true
                if already_a_point == false
                    @_p_plot.push point_mesher

                        
         
                                        
                    
                    
    cosmetic_attribute:( name ) ->
        super( name ) or ( name in [ "_mesh", "_p_mesher", "_p_plot", "Ux", "Uy", "_Ux_disp", "_Uy_disp", "_dimensions", "truss_item"  ] ) 

    sub_canvas_items: ->
        lst = [@_mesh]
        for pm in @_p_mesher
            lst.push pm
        for pm in @_p_plot
            lst.push pm
        return lst

   
    add_point: ( p = new PointMesher ) ->
        if p instanceof PointMesher
            @_p_mesher.push p                  
            
    on_mouse_down: ( cm, evt, pos, b ) ->
        []


        