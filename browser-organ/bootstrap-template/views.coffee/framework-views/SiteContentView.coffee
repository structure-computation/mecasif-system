# Copyright 2015 SpinalCom  www.spinalcom.com
#

class SiteContentView extends Process
    constructor: ( @el, @model, params = {} ) ->
        super @model
        for key, val of params
            this[ key ] = val    #language = "fr" ou "en"
    
        @content = new_dom_element
            id : "content"
            className: "content"
            parentNode: @el
        
        @render()

    #--------------------------------------------------------------------------------------------------------------
    # create the unit views inside the part depending on the selected item in the site tree    
    #--------------------------------------------------------------------------------------------------------------
    create_unit_view: (item) ->
        if item instanceof TitleModel
            new TitleView item, @content   
        if item instanceof RowModel
            new RowView item, @content        
        
        if item instanceof ColModel
            row = document.getElementById item.row_id
            new ColView item, row
        
        if item instanceof PanelModel
            col = document.getElementById item.col_id
            new PanelView item, col
        if item instanceof IFrameModel
            col = document.getElementById item.col_id
            new IFrameView item, col   
            
        if item instanceof ParagraphModel
            panel = document.getElementById item.panel_id
            new ParagraphView item, panel            
        if item instanceof HeadingModel
            panel = document.getElementById item.panel_id
            new HeadingView item, panel             
        if item instanceof ImageModel
            panel = document.getElementById item.panel_id
            new ImageView item, panel   
        if item instanceof GalleryModel
            panel = document.getElementById item.panel_id
            new GalleryView item, panel              
        if item instanceof CodeModel
            panel = document.getElementById item.panel_id
            new CodeView item, panel       
        if item instanceof TreeModel
            panel = document.getElementById item.panel_id
            new TreeView item, panel           
        if item instanceof TableModel
            panel = document.getElementById item.panel_id
            new TableView item, panel           
            
    #--------------------------------------------------------------------------------------------------------------
    # render site page   
    #--------------------------------------------------------------------------------------------------------------
    render: ->  
        for item in @model.content
            @create_unit_view item



                        
