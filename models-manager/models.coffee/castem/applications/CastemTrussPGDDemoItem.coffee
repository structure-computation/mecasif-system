class CastemTrussPGDDemoItem extends TreeItem
    constructor: (name = 'Truss PGD')->
        super()
                
        @_name.set name
        
        @add_attr
            edited_by : 'LMT'
            stamp: "img/CastemTrussPGD.png"
            txt: "Castem PGD : Truss (LMT)"
            demo_app : "CastemTrussPGDDemoItem"
            directory : "CastemTrussPGD"
            video_link : undefined
            publication_link : "http://resources.is-sim.com/Louf_Champaney_FINEL.pdf"

    associated_application: ()->
        apps = new Lst
        apps.push new TreeAppApplication_CastemTruss
        return apps
    
    run_demo : (app_data)->
        app = new TreeAppApplication
        a = app.add_item_depending_selected_tree app_data, CastemTrussPGDItem, (object) =>
            app_data.watch_item object._children[0]
            app_data.watch_item object._children[0]._children[0]
            app_data.watch_item object._children[0]._children[1]
            app_data.watch_item object._children[0]._children[2]
        
    read_me: ( c ) ->
        c.panel "col2", "rm", "Read me", "readme"
        c.heading "rm", 5, "Application"
        c.heading "rm", 5, "Interface"
        c.heading "rm", 5, "Usage"
