# Copyright 2015 SpinalCom  www.spinalcom.com
#

class CodeView extends Process
    constructor: ( @site_item, @el) ->
        super @site_item


        @pre =  new_dom_element
            parentNode : @el
            nodeName  : "pre"
            className : @site_item.type
            txt: @site_item.txt              
            style:
                fontSize: "10px"
                background: "#d9e0e7"

#         @code =  new_dom_element
#             parentNode : @pre
#             nodeName  : "code"
#             className : @site_item.type
#             txt: @site_item.txt               
        
        hljs.highlightBlock(@pre)
        
        
        
        
       
