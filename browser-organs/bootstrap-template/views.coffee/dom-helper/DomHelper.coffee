# Copyright 2015 SpinalCom  www.spinalcom.com

#
# This file is part of SpinalCore.
#
# SpinalCore is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# SpinalCore is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with SpinalCore. If not, see <http://www.gnu.org/licenses/>.



# create a new dom element
#  nodeName to specify kind (div by default)
#  parentNode to specify a parent
#  style { ... }
#  txt for a text node as a child
#  other paramers are used to set directly set attributes
new_dom_element = ( params = {}, nodeName = "div" ) ->
    n = document.createElement params.nodeName or nodeName
    for name, val of params
        switch name.indexOf "data"
            when 0
                n.setAttribute ("data-" + name.substring 4), val     
                
        switch name
            when "parentNode"
                val.appendChild n
            when "nodeName"
                undefined
            when "style"
                for k, v of val
                    n.style[ k ] = v
            when "txt"
                #r = new RegExp " ", "g"
                #n.appendChild document.createTextNode val.replace r, "\u00a0"
                n.innerHTML = val
            when "role"
                n.setAttribute name, val
            when "tabindex"
                n.setAttribute name, val                
            else
                n[ name ] = val
    return n

# obj is a DOM object. src is a string or an array of string containing one or several classNames separated with spaces
add_class = ( obj, src ) ->
    if typeof src == "string"
        return add_class obj, src.split " "
    old = ( obj.className or "" ).split " "
    p_1 = src.filter( ( x ) -> x not in old )
    obj.className = ( old.concat p_1 ).filter( ( x ) -> x ).join( " " )
    
# obj is a DOM object. src is a string or an array of string containing one or several classNames separated with spaces
rem_class = ( obj, src ) ->
    if typeof src == "string"
        return rem_class obj, src.split " "
    old = ( obj.className or "" ).split " "
    obj.className = ( old.filter ( x ) -> x not in src ).join( " " )

# real position of an object
get_left = ( l ) ->
    if l.offsetParent?
        return l.offsetLeft + get_left( l.offsetParent )
    else
        return l.offsetLeft

# real position of an object
get_top = ( l ) ->
    if l.offsetParent?
        return l.offsetTop + get_top( l.offsetParent )
    else
        return l.offsetTop

# make a popup window.
# returns the creted "inside" div 
# clicking outside closes the window.
# drag title permits to move he window
# class names :
#  - PopupTitle
#  - PopupWindow
# Possible params:
#  - fixed_opacity (for the fixed background)
#  - fixed_background (for the fixed background)
#  - width
#  - height
#  - event
#  - child -> child of the main div
#  - onclose -> callback function
_index_current_popup = 100
new_popup = ( title, params = {} ) ->
    b = new_dom_element
        parentNode : document.body
        id         : "popup_closer"
        onmousedown: ->
            params.onclose?()
            document.body.removeChild b
            document.body.removeChild w
        ondrop: ( evt ) ->
            if not evt
                evt = window.event
            evt.cancelBubble = true
            evt.stopPropagation?()
            evt.preventDefault?()
            evt.stopImmediatePropagation?()
            return false
            
        style      :
            position  : "fixed"
            top       : 0
            bottom    : 0
            left      : 0
            right     : 0
            background: params.fixed_opacity or "#000"
            opacity   : params.fixed_opacity or 0
            zIndex    : _index_current_popup

    if params.event? && params.event.clientX #testing clientX to differenciate keyboards event
        clientX = params.event.clientX
        clientY = params.event.clientY
    else
        clientX = window.innerWidth / 2 - 10
        clientY = window.innerHeight / 2 - 10
    
    top_x = params.top_x or -1000
    top_y = params.top_y or -1000
    old_x = 0
    old_y = 0
    
    w = undefined
    
    if params.width?
        width = params.width
    if params.height?
        height = params.height
    
    #alert "top : " + top_y + " left : " + top_x + " width : " +  width + " height : " + height
    
    repos = ->
        top_x = clientX - w.clientWidth  / 2
        top_y = clientY - w.clientHeight / 2
        if ( top_x + w.clientWidth ) > window.innerWidth
            top_x = window.innerWidth  - w.clientWidth  - 50
            
        if ( top_y + w.clientHeight ) > window.innerHeight
            top_y = window.innerHeight  - w.clientHeight  + 50
            
        if top_x < 50
            top_x = 50
        if top_y < 50
            top_y = 50
            
        w.style.left = top_x
        w.style.top  = top_y
        
    

    #alert "top : " + top_y + " left : " + top_x + " width : " +  width + " height : " + height
    
    _drag_evt_func = ( evt ) ->
        top_x += evt.clientX - old_x
        top_y += evt.clientY - old_y
        w.style.left = top_x
        w.style.top  = top_y
        old_x = evt.clientX
        old_y = evt.clientY
        evt.preventDefault?()
                
    _drag_end_func = ( evt ) ->
        document.detachEvent? "onmousemove", _drag_evt_func
        document.detachEvent? "onmouseup"  , _drag_end_func
        document.removeEventListener? "mousemove", _drag_evt_func, true
        document.removeEventListener? "mouseup"  , _drag_end_func, true
    
    extention =  "px"
    if !params.top_x
      setTimeout repos, 1
      extention =  "%"
    
    w = new_dom_element
        parentNode : document.body
        className  : "Popup"
        style      :
            position  : "absolute"
            left      : top_x 
            top       : top_y
            width     : width + extention
            height    : height + extention
            zIndex    : _index_current_popup + 1
            
    _index_current_popup += 2
    
    close_element = new_dom_element
        parentNode : w
        className  : "PopupClose"
        txt        : "Close"
        onmousedown: ( evt ) ->
            params.onclose?()
            document.body.removeChild b
            document.body.removeChild w
            
    if title
        t = new_dom_element
            parentNode : w
            className  : "PopupTitle"
            innerHTML  : title
            onmousedown: ( evt ) ->
                old_x = evt.clientX
                old_y = evt.clientY
                top_x = parseInt w.style.left
                top_y = parseInt w.style.top
                document.addEventListener "mousemove", _drag_evt_func, true
                document.addEventListener "mouseup"  , _drag_end_func, true
                evt.preventDefault?()
            
    res = new_dom_element
        parentNode : w
        className  : "PopupWindow"
        style      :
            padding  : "6px"

    if params.child?
        res.appendChild params.child
    
    res
    