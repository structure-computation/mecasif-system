# Copyright 2015 SpinalCom  www.spinalcom.com
#

class IFrameView extends Process
    constructor: ( @site_item, @el) ->
        super @site_item
                
        @panel_inverse = new_dom_element
            parentNode: @el
            className: "panel panel-inverse"
                
        @panel_heading = new_dom_element
            parentNode: @panel_inverse
            className: "panel-heading"        
        
        @panel_heading_btn = new_dom_element
            parentNode: @panel_heading
            className: "panel-heading-btn"  
        
        @expand = new_dom_element
            parentNode: @panel_heading_btn
            nodeName: "a"
            className: "btn btn-xs btn-icon btn-circle btn-default"
            href: "javascript:;"
            dataclick : "panel-expand"
        
        fa_expand = new_dom_element
            parentNode: @expand
            nodeName: "i"
            className: "fa fa-expand"
        
#         @reload = new_dom_element
#             parentNode: @panel_heading_btn
#             nodeName: "a"
#             className: "btn btn-xs btn-icon btn-circle btn-success"
#             href: "javascript:;"
#             dataclick : "panel-reload"
#                 
#         fa_reload = new_dom_element
#             parentNode: @reload
#             nodeName: "i"
#             className: "fa fa-repeat"
                
        @collapse = new_dom_element
            parentNode: @panel_heading_btn
            nodeName: "a"
            className: "btn btn-xs btn-icon btn-circle btn-warning"
            href: "javascript:;"
            dataclick : "panel-collapse"                
                
        fa_collapse = new_dom_element
            parentNode: @collapse
            nodeName: "i"
            className: "fa fa-minus"                
                
#         @remove = new_dom_element
#             parentNode: @panel_heading_btn
#             nodeName: "a"
#             className: "btn btn-xs btn-icon btn-circle btn-danger"
#             href: "javascript:;"
#             dataclick : "panel-remove"                
#                 
#         fa_remove = new_dom_element
#             parentNode: @remove
#             nodeName: "i"
#             className: "fa fa-times"
                
        panel_title = new_dom_element
            parentNode: @panel_heading
            nodeName: "h2"
            className: "panel-title"
            txt: @site_item.title.get()
                
        if @site_item.format.get() == "page-height"
            @window_height = document.body.clientHeight - 130
            @panel_content = new_dom_element
                id: @site_item.id.get()
                parentNode: @panel_inverse
                className: "embed-responsive"# embed-responsive-16by9"
                style:
                    height: @window_height + "px"
                    
        else if @site_item.format.get() == "16by9"
            @panel_content = new_dom_element
                id: @site_item.id.get()
                parentNode: @panel_inverse
                className: "embed-responsive embed-responsive-16by9"
                    
        @iframe = new_dom_element
            nodeName: "iframe"
            className: "embed-responsive-item"
            parentNode: @panel_content
            src: @site_item.src
        

        