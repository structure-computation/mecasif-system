# Copyright 2015 SpinalCom  www.spinalcom.com
#

class ColView extends Process
    constructor: ( @site_item, @el) ->
        super @site_item
        
        
        
        @width = "col-lg-" + @site_item.width.get()
        
        @col = new_dom_element
            parentNode: @el
            className: @width
            id: @site_item.id
    
