

#main program
launch_index = ( ) ->
    content_model = new IndexModel
    content_view = new SiteContentView document.getElementById( "page-container" ), content_model