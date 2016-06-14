# Copyright 2015 SpinalCom  www.spinalcom.com
#

class ImageView extends Process
    constructor: ( @site_item, @el) ->
        super @site_item

#         @gallery = new_dom_element
#             className: "gallery isotope"
#             parentNode: @el
# #             style:
# #                 position: "relative"
# #                 overflow: "hidden"
# #                 height: "1047px"
# 
#         @gallery_group = new_dom_element
#             className: "image gallery-group-1 isotope-item"
#             parentNode: @gallery
#             style:
#                 position: "absolute"
#                 left: "0px"
#                 top: "0px"
#             
#         @image_inner = new_dom_element
#             className: "image inner"
#             parentNode: @gallery_group
            
#         @a = new_dom_element
#             nodeName: "a"
#             className: "media-right"
#             parentNode: @el
#             href: "javascript:;"
            
        @img = new_dom_element
            nodeName: "img"
            className: "img-responsive"
            parentNode: @el
            src: @site_item.src
            style: 
                width: @site_item.width
                margin: "auto"
    
