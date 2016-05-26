# Copyright 2015 SpinalCom  www.spinalcom.com
#

class SiteMenuView extends Process
    constructor: ( @el, @model, params = {} ) ->
        super @model
        for key, val of params
            this[ key ] = val    #language = "fr" ou "en"
    
        @content = new_dom_element
            id : "sidebar"
            className: "sidebar"
            parentNode: @el
            style:
               paddingTop: "54px"
        
#         @render()
# 
#     #--------------------------------------------------------------------------------------------------------------
#     # create the unit views inside the part depending on the selected item in the site tree    
#     #--------------------------------------------------------------------------------------------------------------
#     create_unit_view: (item) ->
#         if item instanceof TitleModel
#             new TitleView item, @content     
#         if item instanceof PanelModel
#             new PanelView item, @content 
#         if item instanceof ParagraphModel
#             panel = document.getElementById item.panel_id
#             new ParagraphView item, panel            
#         if item instanceof HeadingModel
#             panel = document.getElementById item.panel_id
#             new HeadingView item, panel             
#         if item instanceof ImageModel
#             panel = document.getElementById item.panel_id
#             new ImageView item, panel                  
#         if item instanceof CodeModel
#             panel = document.getElementById item.panel_id
#             new CodeView item, panel       
#         if item instanceof TreeModel
#             panel = document.getElementById item.panel_id
#             new TreeView item, panel           
#             
#     #--------------------------------------------------------------------------------------------------------------
#     # render site page   
#     #--------------------------------------------------------------------------------------------------------------
#     render: ->  
#         for item in @model.content
#             @create_unit_view item



                        
