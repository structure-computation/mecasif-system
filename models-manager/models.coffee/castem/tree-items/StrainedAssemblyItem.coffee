#
class StrainedAssemblyItem extends TreeItem
    constructor: ( _item, name = "Strained Assembly" ) ->
        super()
        
        @_name.set name
        @_viewable.set true
        
        @add_attr
            _assembly_item : if _item? then _item else undefined
                
        @add_attr
            _mesh: new Mesh( not_editable: true )              

        @add_attr
            warp_factor: new ConstrainedVal( 1, { min: 1, max: 100} )  
             
        @add_attr
            k :
                k1 : new ConstrainedVal( 0, { min: 1, max: 10, div: 10 } )
                k2 : new ConstrainedVal( 0, { min: 1, max: 10, div: 10 } )
                k3 : new ConstrainedVal( 0, { min: 1, max: 10, div: 10 } )            
                k4 : new ConstrainedVal( 0, { min: 1, max: 10, div: 10 } )            
                k5 : new ConstrainedVal( 0, { min: 1, max: 10, div: 10 } )               

        @add_attr
            _x_field: new NodalField @_mesh
            _y_field: new NodalField @_mesh
          
        @add_attr
            _xf           : new NamedParametrizedDrawable( "deplacement X", new InterpolatedField )
            _yf           : new NamedParametrizedDrawable( "deplacement Y", new InterpolatedField )
            field_set     : new FieldSet

        @field_set.color_by.lst.push @_xf
        @field_set.color_by.lst.push @_yf
        @field_set.warp_by.lst.push new NamedParametrizedDrawable "dep", new VectorialField "dep", [ @_xf, @_xf, @_xf ] 
        

        @_mesh.visualization.display_style.num.set 1            
        @_mesh.move_scheme = MoveScheme_2D
        
        @_mesh.visualization.line_color.r.set 50
        @_mesh.visualization.line_color.g.set 0
        @_mesh.visualization.line_color.b.set 0  
        
        @result_ok = false
        
        @bind =>
            if @_assembly_item._children[0]?.PGD.n_val.has_been_modified()
                @k.k1.set_params
                    max: @_assembly_item._children[0].PGD.n_val 
            if @_assembly_item._children[1]?.PGD.n_val.has_been_modified()
                @k.k2.set_params
                    max: @_assembly_item._children[1].PGD.n_val
            if @_assembly_item._children[2]?.PGD.n_val.has_been_modified()
                @k.k3.set_params
                    max: @_assembly_item._children[2].PGD.n_val    
            if @_assembly_item._children[3]?.PGD.n_val.has_been_modified()
                @k.k4.set_params
                    max: @_assembly_item._children[3].PGD.n_val                
            if @_assembly_item._children[4]?.PGD.n_val.has_been_modified()
                @k.k5.set_params
                    max: @_assembly_item._children[4].PGD.n_val   

            if @_assembly_item._psi[0]?.has_been_modified() and @_assembly_item._lambda[0]?.has_been_modified()
                @result_ok = true
                @draw_field()

    draw: ( info ) ->
        if @result_ok and ( @k.k1.val.has_been_directly_modified() or @k.k2.val.has_been_directly_modified() or @k.k3.val.has_been_directly_modified() or @warp_factor.val.has_been_directly_modified() )
            @draw_field()
            
    draw_field: () ->
        delete @_x_field
        @_x_field = new NodalField @_mesh
        delete @_y_field
        @_y_field = new NodalField @_mesh 
        
        for i in [ 0 .. @_mesh.points.length-1 ]
            ux = 0
            uy = 0
            for p in [0..@_assembly_item._psi.length-1]
                ux += @_assembly_item._psi[p][0][ i ] * @_assembly_item._lambda[p][0][@k.k1.get()] * @_assembly_item._lambda[p][1][@k.k2.get()] * @_assembly_item._lambda[p][2][@k.k3.get()] * @_assembly_item._lambda[p][3][@k.k4.get()] * @_assembly_item._lambda[p][4][@k.k5.get()]
                uy += @_assembly_item._psi[p][1][ i ] * @_assembly_item._lambda[p][0][@k.k1.get()] * @_assembly_item._lambda[p][1][@k.k2.get()] * @_assembly_item._lambda[p][2][@k.k3.get()] * @_assembly_item._lambda[p][3][@k.k4.get()] * @_assembly_item._lambda[p][4][@k.k5.get()]
            @_mesh.points[i].pos[0].set @_assembly_item._mesh.points[i].pos[0].get() + ( ux * @warp_factor.val.get() )
            @_mesh.points[i].pos[1].set @_assembly_item._mesh.points[i].pos[1].get() + ( uy * @warp_factor.val.get() )                   
        
            @_x_field._data.set_val i, ux
            @_y_field._data.set_val i, uy
             
        pos = new Lst
        pos_v = { axe_name: "time", axe_value: 0 }
        pos.push pos_v
        
        @_xf.data._data.clear()
        @_xf.data._data.push 
            pos : pos
            field : @_x_field
        @_yf.data._data.clear()
        @_yf.data._data.push 
            pos : pos
            field : @_y_field 
            
                   
    cosmetic_attribute:( name ) ->
        super( name ) or ( name in [ "_mesh", "_assembly_item", "_x_field", "_y_field", "_xf", "_yf", "field_set"  ] ) 

    sub_canvas_items: ->
        lst = [@_mesh, @field_set]
        return lst


        