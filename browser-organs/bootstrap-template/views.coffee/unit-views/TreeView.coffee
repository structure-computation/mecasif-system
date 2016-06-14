# Copyright 2015 SpinalCom  www.spinalcom.com
#

class TreeView extends Process
    constructor: ( @site_item, @el) ->
        super @site_item

        @jstree = new_dom_element
            id: @site_item.id.get()
            className: "jstree jstree-1 jstree-default"
            parentNode: @el
                    
        @render @site_item, @jstree
        
        
    render: ( item, el ) ->
        if item._children.length > 0

            @ul = new_dom_element
                nodeName: "ul"
                parentNode: el
            
            li = []
            for child in item._children 
                if child.type.get() == "file"
                    li.push new_dom_element
                        nodeName: "li"
                        parentNode: @ul
                        datajstree: '{ "icon" : "fa fa-file fa-lg text-primary" }'
                        txt: child.txt.get()
                else if child.type.get() == "symlink"
                    li.push new_dom_element
                        nodeName: "li"
                        parentNode: @ul
                        datajstree: '{ "icon" : "fa fa-link fa-lg text-primary" }'
                        txt: child.txt.get()
                else if child.type.get() == "opened"
                    li.push new_dom_element
                        nodeName: "li"
                        parentNode: @ul
                        datajstree: '{"opened":true, "icon" : "fa fa-folder fa-lg text-warning" }'
                        txt: child.txt.get()                      
                else
                    li.push new_dom_element
                        nodeName: "li"
                        parentNode: @ul
                        datajstree: '{"opened":false, "icon" : "fa fa-folder fa-lg text-warning" }'
                        txt: child.txt.get()
                        
            for i in [ 0 .. item._children.length-1 ]
                @render item._children[i], li[i]
            
