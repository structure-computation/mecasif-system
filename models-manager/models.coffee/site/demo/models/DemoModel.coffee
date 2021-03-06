# Copyright 2015 SpinalCom  www.spinalcom.com
#

class DemoModel extends SiteContentModel
    constructor: ( ) ->
        super()
        
                
    build_content: ( ) ->

        hash = document.URL.substr( document.URL.indexOf("#") + 1 )
        for demo in DEMOS
            demo_model = new window[demo]()
            if hash.indexOf( demo_model.demo_app.get() ) != -1
                @demo = demo_model
                break
        
        
        @row "1"
        @title "1", "<center>Demo : " + @demo.txt.get()
        @col "1", "col1", 12
        @col "1", "col2", 6
        @col "1", "col3", 6
        @col "1", "col4", 6
        
        @iframe "col1", "lab", "is-sim Lab", "lab", "demo_iframe.html#" + hash, "page-height"
        
        @demo.read_me(this)
            
        if @demo.publication_link
            @iframe "col3", "pub", "Publication", "publication", @demo.publication_link.get(), "page-height"
            
        if @demo.video_link
            if @demo.publication_link
                @iframe "col2", "vid", "Video", "video", @demo.video_link.get(), "16by9"
            else
                @iframe "col3", "vid", "Video", "video", @demo.video_link.get(), "16by9"
