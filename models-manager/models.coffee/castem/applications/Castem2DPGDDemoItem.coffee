class Castem2DPGDDemoItem extends TreeItem
    constructor: (name = '2D PGD')->
        super()
                
        @_name.set name
        
        @add_attr
            edited_by : 'LMT'
            stamp: "img/Castem2DPGD.png"
            txt: "demo 2D PGD LMT"
            demo_app : "Castem2DPGDDemoItem"
            directory : "Castem2DPGD"
            video_link : undefined
            tutorial_link : undefined
            publication_link : "http://resources.is-sim.com/Louf_Champaney_FINEL.pdf"

    associated_application: ()->
        apps = new Lst
        apps.push new TreeAppApplication_Castem2D
        return apps
    
    run_demo : (app_data)->
        app = new TreeAppApplication
        a = app.add_item_depending_selected_tree app_data, Castem2DPGDItem
        
            
    onclick_function: ()->
        window.location = "softpage.html#" +  "Castem2DPGDDemoItem" #+ @demo_app
                