# Copyright 2015 SpinalCom  www.spinalcom.com
#

class TableView extends Process
    constructor: ( @site_item, @el) ->
        super @site_item

        @table = new_dom_element
            nodeName: "table"
            className: "table"
            parentNode: @el
        
        @thead = new_dom_element
            nodeName: "thead"
            parentNode: @table
        
        for i in [ 0 ... @site_item.lst.length ]

            @tr = new_dom_element
                nodeName: "tr"
                parentNode: @thead
                
            for j in [ 0 ... @site_item.lst[i].length ]
            
                @td = new_dom_element
                    nodeName: "td"
                    parentNode: @tr
                    txt: @site_item.lst[i][j]
                    style:
                        verticalAlign: "middle"
                    
                    
                
                
                
