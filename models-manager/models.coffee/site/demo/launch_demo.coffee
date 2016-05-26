

#main program
launch_demo = ( ) ->
    content_model = new DemoModel 
    content_view = new SiteContentView document.getElementById( "page-container" ), content_model