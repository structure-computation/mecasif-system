# Copyright 2015 SpinalCom  www.spinalcom.com
#

class SiteContentModel extends Model
    constructor: ( params = {}) ->
        super()

        @add_attr
            content : []
            project_name : if params.project_name? then params.project_name else "Project name"
            
        @build_content()

    #--------------------------------------------------------------------------------------------------------------
    # add content in the @page_content container
    #--------------------------------------------------------------------------------------------------------------  
        
    title: ( row_id, title, balise ) ->
        _title = new TitleModel
                row_id : row_id
                title : title
        @add_content _title     
        
    row: ( id ) ->
        _row = new RowModel
                id : id
        @add_content _row     
        
    col: ( row_id, id, width ) ->
        _col = new ColModel
                row_id: row_id
                id : id
                width: width
        @add_content _col    
        
    panel: ( col_id, id, title, balise ) ->
        _panel = new PanelModel
                col_id: col_id
                id: id
                title : title
                balise: balise
        @add_content _panel
      
    iframe: ( col_id, id, title, balise, src, format ) ->
        _iframe = new IFrameModel
                col_id: col_id
                id: id
                title : title
                src: src
                balise: balise
                format: format
        @add_content _iframe      
      
    paragraph: ( panel_id, txt ) ->
        _paragraph = new ParagraphModel
                txt : txt
                panel_id: panel_id
        @add_content _paragraph      
      
    heading: ( panel_id, num, title ) ->
        _heading = new HeadingModel
                num: num
                title : title
                panel_id: panel_id
        @add_content _heading      
     
    image: ( panel_id, src, width = "1000px" ) ->
        _image = new ImageModel
                src : src
                panel_id: panel_id
                width: width
        @add_content _image         
    
    gallery: ( panel_id, lst, lst_captions = [], lst_href = [], col = 3 ) ->
        _gallery = new GalleryModel
                lst : lst
                panel_id: panel_id
                lst_captions: lst_captions
                lst_href: lst_href
                col: col
        @add_content _gallery   
        
    code: ( panel_id, type, txt ) ->
        _code = new CodeModel
                type: type
                txt: txt
                panel_id: panel_id
        @add_content _code
        
    tree: ( panel_id, tree_id ) ->
        _tree = new TreeModel
                panel_id: panel_id
                id: tree_id
        @add_content _tree
        return _tree
        
    table: ( panel_id, lst ) ->
        _table = new TableModel
                lst : lst
                panel_id: panel_id
        @add_content _table      
        
        
    #--------------------------------------------------------------------------------------------------------------
    # add content in the @page_content container
    #--------------------------------------------------------------------------------------------------------------  
    add_content: ( contentItem ) ->
        @content.push contentItem
        
    
    #--------------------------------------------------------------------------------------------------------------
    # function to overload in each specific doc model 
    #--------------------------------------------------------------------------------------------------------------    
    build_content: ( ) ->
        console.log "overload this function to add content"

        
        
      
    
        
        
         
        
        
        
        
            
        
        
        
        
        
        
        
        
        
            
    
            
