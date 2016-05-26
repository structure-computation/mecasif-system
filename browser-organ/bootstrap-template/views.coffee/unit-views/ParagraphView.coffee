# Copyright 2015 SpinalCom  www.spinalcom.com
#

class ParagraphView extends Process
    constructor: ( @site_item, @el) ->
        super @site_item

        @p = new_dom_element
            nodeName: "p"
            parentNode: @el
            txt: @site_item.txt.get()
            
    
