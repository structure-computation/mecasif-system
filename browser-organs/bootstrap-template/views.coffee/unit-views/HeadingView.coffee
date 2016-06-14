# Copyright 2015 SpinalCom  www.spinalcom.com
#

class HeadingView extends Process
    constructor: ( @site_item, @el) ->
        super @site_item

        if @site_item.num.get() == 1
            @h1 = new_dom_element
                nodeName: "h1"
                parentNode: @el
                txt: @site_item.title.get()
            
        else if @site_item.num.get() == 2
            @h2 = new_dom_element
                nodeName: "h2"
                parentNode: @el
                txt: @site_item.title.get()    

        else if @site_item.num.get() == 3
            @h3 = new_dom_element
                nodeName: "h3"
                parentNode: @el
                txt: @site_item.title.get()    
                
        else if @site_item.num.get() == 4
            @h4 = new_dom_element
                nodeName: "h4"
                parentNode: @el
                txt: @site_item.title.get()    
                
        else if @site_item.num.get() == 5
            @h5 = new_dom_element
                nodeName: "h5"
                parentNode: @el
                txt: @site_item.title.get()                    
                
        else if @site_item.num.get() == 6
            @h6 = new_dom_element
                nodeName: "h6"
                parentNode: @el
                txt: @site_item.title.get()                    
                
                
                
                
                
                
