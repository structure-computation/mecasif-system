# Copyright 2015 SpinalCom  www.spinalcom.com
#

class RowView extends Process
    constructor: ( @site_item, @el) ->
        super @site_item
        
        @section = new_dom_element
            parentNode: @el
            nodeName: "section"
            datascrollview: "true"
        
        @row = new_dom_element
            parentNode: @section
            className: "row"
            id: @site_item.id.get()

