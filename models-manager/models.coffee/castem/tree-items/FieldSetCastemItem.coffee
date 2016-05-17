#
class FieldSetCastemItem extends TreeItem_Automatic
    constructor: ( name = "Field_V2", id_c = 0) ->
        super()
        
        # default values
        @_name.set name
        #@_ico.set "img/part_collection.png"
        @_viewable.set true

        
        # attributes
        @add_attr
            id : id_c
            visualization: new FieldSet


            
            #visualisation attributes
            _has_result : false
            _old_visualisation_field : ""
            _old_time_step : -1
            time : -1
            
   
    accept_child: ( ch ) ->
        false
        
    sub_canvas_items: ->
        res = [@visualization]
        return res
        
   
    information: ( div ) ->
        if not @txt?
            @txt = new_dom_element
                parentNode: div
                
        @txt.innerHTML = @_norm_2_history.get()
   
   