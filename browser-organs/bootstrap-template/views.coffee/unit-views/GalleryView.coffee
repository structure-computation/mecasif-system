# Copyright 2015 SpinalCom  www.spinalcom.com
#

class GalleryView extends Process
    constructor: ( @site_item, @el) ->
        super @site_item

#         @table = new_dom_element
#             nodeName: "table"
#             className: "table"
#             parentNode: @el
#         
#         @thead = new_dom_element
#             nodeName: "thead"
#             parentNode: @table
#         
#         for i in [ 0 ... @site_item.lst.length ]
# 
#             @tr = new_dom_element
#                 nodeName: "tr"
#                 parentNode: @thead
#                 
#             for j in [ 0 ... @site_item.lst[i].length ]
#             
#                 @td = new_dom_element
#                     nodeName: "td"
#                     parentNode: @tr
#                     style:
#                         border: "none"
#                         verticalAlign: "middle"
# 
# 
#                 @image_inner = new_dom_element
#                     className: "image-inner text-center"
#                     parentNode: @td
#                     
#                 
#                 @a = new_dom_element
#                     nodeName: "a"
#                     parentNode: @image_inner
# 
# 
#                 @i = new_dom_element
#                     nodeName: "img"
#                     parentNode: @a
#                     src: @site_item.lst[i][j]
# 
#                 if @site_item.lst_captions[i]?[j]?
#                 
#                     @info = new_dom_element
#                         className: "image-info text-center"
#                         parentNode: @td               
#                         
#                     @t = new_dom_element
#                         nodeName: "h5"
#                         className: "text-center"
#                         parentNode: @info
#                         txt: @site_item.lst_captions[i][j][0]
#                     
#                     @d = new_dom_element
#                         className: "text-center"
#                         parentNode: @info
#                         txt: @site_item.lst_captions[i][j][1]



        @row = new_dom_element
            className: "row"
            parentNode: @el
        
        @width = "col-sm-6 col-md-" + @site_item.col.get() + " col-lg-6"
        
        for i in [ 0 ... @site_item.lst.length ]

            @col = new_dom_element
                parentNode: @row
                className: @width
            
#             for j in [ 0 ... @site_item.lst[i].length ]
            
            if @site_item.lst_href[i]
                @a = new_dom_element
                    nodeName: "a"
                    parentNode: @col
                    href: @site_item.lst_href[i]
            else 
                @a = new_dom_element
                    nodeName: "a"
                    parentNode: @col            
        
            @image = new_dom_element
                className: "image-info text-center"
                parentNode: @a
                
            @image_inner = new_dom_element
                className: "image-inner text-center"
                parentNode: @image  
                    
            @i = new_dom_element
                nodeName: "img"
                parentNode: @image_inner
                src: @site_item.lst[i]
                    
            if @site_item.lst_captions[i]?
                @t = new_dom_element
                    nodeName: "h5"
                    className: "text-center"
                    parentNode: @image
                    txt: @site_item.lst_captions[i]
#                 @d = new_dom_element
#                     className: "text-center"
#                     parentNode: @image
#                     txt: @site_item.lst_captions[i][1]
                
                    
                
                
                
