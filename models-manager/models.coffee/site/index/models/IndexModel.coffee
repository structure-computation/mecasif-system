# Copyright 2015 SpinalCom  www.spinalcom.com
#

class IndexModel extends SiteContentModel
    constructor: ( ) ->
        super()
        
                
    build_content: ( ) ->
        
        @title "<b>M</b>odèles r<b>É</b>duits pour une <b>C</b>onception <b>A</b>mont de <b>S</b>ystèmes <b>I</b>ndustriels <b>F</b>iables"
        
        @row "1"
        @col "1", "col1", 6
        @col "1", "col2", 6
        
        @panel "col1", "obj", "Objectifs", "objectifs"
        @image "obj", "img/big_logo_mecasif.png", "300px"
        @paragraph "obj", "<br>MECASIF vise des avancées significatives dans l’obtention de modèles réduits innovants, directement exploitables dans la pratique industrielle. 
        L‘efficacité pratique de l’usage de modèles (numériques) réduits dans des workflows de conception de systèmes dynamiques multiphysiques a été mise en évidence dans 
        un programme précédent : CSDL (conception optimisée, robustesse, etc). MECASIF mettra l'accent sur : 
        <ul><li> les cas difficiles identifiés par CSDL : phénomènes évolutifs non linéaires, et/ou propagatifs </li>
        <li> l’intégrabilité directe dans des workflows de conception industriels caractéristiques. </li></ul>"
        
       
        @panel "col1", "con", "Consortium", "consortium"
        silkan_logo = "img/logo_silkan_2.jpg"
        snecma_logo = "img/logo_SAFRAN_snecma.png"
        renault_logo = "img/logo_renault_2.jpg"
        sc_logo = "img/logo_sc2.png"
        dassault_logo = "img/logo_dassault_2.png"
        bertin_logo = "img/logo_bertin_2.jpg"
        esi_logo = "img/logo_esi_2.jpg"
        scilab_logo = "img/logo_scilab_2.jpg"
        lmt_logo = "img/logo_LMT.png"
        cadlm_logo = "img/logo_cadlm_2.jpg"
        armines_logo = "img/logo_armines_2.jpg"
        dps_logo = "img/logo_dps_2.png"
        @gallery "con", [ silkan_logo, snecma_logo, renault_logo, sc_logo, 
                         dassault_logo, bertin_logo, esi_logo, scilab_logo,
                         lmt_logo, cadlm_logo, armines_logo, dps_logo ]

        @panel "col1", "fin", "Financeurs", "financeurs"
        essone_logo = "img/logo_ESSONE_2.png"
        bpi_logo = "img/logo_BPI_France_2.png"
        idf_logo = "img/logo_idf_2.png"
        systematic_logo = "img/logo_systematic_2.png"
        @gallery "fin", [ essone_logo, bpi_logo, idf_logo, systematic_logo ]
                
        
        @panel "col2", "wp", "Work Packages", "workpackages"
        @table "wp", [ 
            [ "<h4>&nbsp&nbsp&nbsp&nbsp&nbsp WP0 &nbsp&nbsp&nbsp&nbsp&nbsp</h4>", 
            "<h4>GOUVERNANCE DU PROJET</h4>
            <h5>Pilote : Silkan / Participants : tout le consortium </h5>
            <ul>
                <li><b>Gestion du projet</b> : délais, qualité, efficacité.</li>
                <li><b>Reporting du projet</b> : auprès des financeurs et des pôles.</li>
            </ul>" ],
            [ "<h4>&nbsp&nbsp&nbsp&nbsp&nbsp WP1 &nbsp&nbsp&nbsp&nbsp&nbsp</h4>", 
            "<h4>MÉTHODES TRANSVERSES</h4>
            <h5>Pilote : Armines / Participants : tout le consortium </h5>
            <ul>
                <li><b>Revue des métodes</b> : Application à la Mécanique Vibratoire non linéaire, à la Dynamique rapide et à la Dynamique des fluides.</li>
                <li><b>Sélection des méthodes</b> : méthodes qui seront implémentées dans les chaînes de calcul des partenaires.</li>
            </ul>" ],
            [ "<h4>&nbsp&nbsp&nbsp&nbsp&nbsp WP2 &nbsp&nbsp&nbsp&nbsp&nbsp</h4>", 
            "<h4>MÉCANIQUE VIBRATOIRE NON LINÉAIRE</h4>
            <h5>Pilote : Renault / Participants : ECL/LTDS, LMT-CACHAN, SNECMA, DPS, SPINALCOM </h5>
            <ul>
                <li><b>Développement de méthodes et de prototypes logiciels</b> : application aux cas d'usages industriels.</li>
                <li><b>Évaluation et intégration</b> : intégration dans le processus de conception des industriels.</li>
                <li><b>Mise en place d'un nouveau service</b> : déléguation de la mise en place des modèles réduits.</li>
            </ul>" ],            
            [ "<h4>&nbsp&nbsp&nbsp&nbsp&nbsp WP3 &nbsp&nbsp&nbsp&nbsp&nbsp</h4>", 
            "<h4>DYNAMIQUE RAPIDE</h4>
            <h5>Pilote : ESI group / Participants : ARMINES, CADLM, LMT-CACHAN, RENAULT, SNECMA, SILKAN </h5>
            <ul>
                <li><b>Développement de ressources pour la réduction de modèle en dynamique rapide pour :</b></li>
                    <ul><li>le crash / Renault</li>
                    <li>les impacts balistiques / Silkan</li>
                    <li>la perte d'aubes / Snecma</li>
                    </ul>
            </ul>" ],            
            [ "<h4>&nbsp&nbsp&nbsp&nbsp&nbsp WP4 &nbsp&nbsp&nbsp&nbsp&nbsp</h4>", 
            "<h4>DYNAMIQUE DES FLUIDES</h4>
            <h5>Pilote : DASSAULT AVIATION / Participants : BERTIN, INRIA, FW4SEA, SCILAB ENTREPRISE, UPMC/LJLL </h5>
            <ul>
                <li><b>Modèles réduits couplés fluide/structure</b> : modèles permettant d'explorer de vastes espaces de conception.</li>
                <li><b>Simulation de systèmes \"temps réel\"</b> : avec un objectif de fonctionnement sur des ordinateurs de bureau.</li>
            </ul>" ],   
            [ "<h4>&nbsp&nbsp&nbsp&nbsp&nbsp WP5 &nbsp&nbsp&nbsp&nbsp&nbsp</h4>", 
            "<h4>PROMOTION & DISSÉMINATION</h4>
            <h5>Pilote : SCILAB ENTREPRISE / Participants : tout le consortium</h5>
            <ul>
                <li><b>Dissémination</b> : identification des aléas, difficultés, spécificités liées aux essais d'identification.</li>
            </ul>" ]            
            ]


        @panel "col2", "new", "News", "news"
        @table "new", [
            [ "<h5>26/05/2016</h5>", "<h5>Le site MECASIF fait peau neuve !</h5>
            Beaucoup de changements depuis Structure Computation : nouveau nom, nouveau design, nouvelle technologie, nouvelles applications !<br>
            Des démos des différents prototypes logiciels dans le cadre du WP2 sont disponibles en dessous. Ces modules comprennent pour l'instant :
            Un calcul PGD avec Castem sur une structure treillis, et un calcul PGD avec Castem sur une liaison collée 2D.<br>&nbsp" ],
            [ "<h5>26/11/2015</h5>", "<h5>Doctoral Workshop on Model Reduction in nonlinear dynamics of fluids and structures</h5>
            <b>January 25-29 2016 at Mines ParisTech.</b><br> 
            We present recent advances in model reduction for nonlinear mechanics of fluids and structures. Reduced-Order models aim at reducing the computational 
            time required to obtain solutions of Partial Differential Equations which are physically-based and parameter dependent. They reduce the computational complexity 
            of optimization procedures, parametric analyses, or metamodel generation.<br>
            <a href=\"http://matperso.mines-paristech.fr/Personnel/david.ryckelynck/\" target=\"_blank\">Workshop program</a><br>&nbsp" ]   
            [ "<h5>01/05/2015</h5>", "<h5>Mise en ligne de la plate-forme web MECASIF</h5>
            La première version de la plate-forme web MECASIF est en ligne.<br>&nbsp" ],            
            ]


        @panel "col1", "art", "Articles", "articles"
        papers_href_lst = [ "http://resources.is-sim.com/2015-LS-DYNA-template-paper_KAYVANTASH.pdf",
                      "http://resources.is-sim.com/Ryckelynck.pdf",
                      "http://resources.is-sim.com/Workshop_PGD_LMT.pdf" ]
        papers_caption_lst = [ "Model Reduction Techniques for LS-DYNA ALE and Crash Applications <br><br><b>Kambiz Kayvantash</b>",
                            "Hyper-reduction framework for model calibration in heterogeneous plasticity <br><br><b>David Ryckelynck</b>",
                            "PGD-Reduced Models for several parametrized nonlinear problems <br><br><b>David Néron</b>" ]
        papers_icon_lst = []
        for p in papers_href_lst
            papers_icon_lst.push "img/papers.png"
        @gallery "art", papers_icon_lst, papers_caption_lst, papers_href_lst, 4
        
        

        @panel "col2", "dem", "Démos", "demos"
        icons_lst = []
        captions_lst = []
        href_lst = []
        for demo in DEMOS
            icons_lst.push demo.stamp
            captions_lst.push demo.txt
            href_lst.push "demo.html#" + demo.demo_app           
        @gallery "dem", icons_lst, captions_lst, href_lst, 4
