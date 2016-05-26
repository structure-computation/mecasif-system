# Copyright 2015 SpinalCom  www.spinalcom.com
#

class TitleView extends Process
    constructor: ( @site_item, @el) ->
        super @site_item
            
        @page_header = new_dom_element
            parentNode: @el
            nodeName: "h1"
            className: "page-header"        
            txt: @site_item.title.get()    
        
        
