class CastemTrussPGDDemoItem extends TreeItem
    constructor: (name = 'Truss PGD')->
        super()
                
        @_name.set name
        
        @add_attr
            edited_by : 'LMT'
            stamp: "img/CastemTrussPGD.png"
            txt: "demo truss PGD LMT"
            demo_app : "CastemTrussPGDDemoItem"
            directory : "CastemTrussPGD"
            video_link : undefined
            tutorial_link : undefined
            publication_link : "http://resources.is-sim.com/Louf_Champaney_FINEL.pdf"

    associated_application: ()->
        apps = new Lst
        apps.push new TreeAppApplication_CastemTruss
        return apps
    
    run_demo : (app_data)->
        app = new TreeAppApplication
        a = app.add_item_depending_selected_tree app_data, CastemTrussPGDItem
        
            
    onclick_function: ()->
        window.location = "softpage.html#" +  "CastemTrussPGDDemoItem" #+ @demo_app
                