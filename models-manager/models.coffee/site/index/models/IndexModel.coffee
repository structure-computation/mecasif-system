# Copyright 2015 SpinalCom  www.spinalcom.com
#

class IndexModel extends SiteContentModel
    constructor: ( ) ->
        super()
        
                
    build_content: ( ) ->
        
        
        
        @row "1"
        @image "1", "img/big_logo_mecasif.png", "300px"
        @title "1", "<center><b>M</b>odèles r<b>É</b>duits pour une <b>C</b>onception <b>A</b>mont de <b>S</b>ystèmes <b>I</b>ndustriels <b>F</b>iables<br>&nbsp"
        
        @col "1", "col1", 6
        @col "1", "col2", 6
        
        @panel "col1", "obj", "Objectifs", "objectifs"
#         @paragraph "obj", "<br>MECASIF vise des avancées significatives dans l’obtention de modèles réduits innovants, directement exploitables dans la pratique industrielle. 
#         L‘efficacité pratique de l’usage de modèles (numériques) réduits dans des workflows de conception de systèmes dynamiques multiphysiques a été mise en évidence dans 
#         un programme précédent : CSDL (conception optimisée, robustesse, etc). MECASIF mettra l'accent sur : 
#         <ul><li> les cas difficiles identifiés par CSDL : phénomènes évolutifs non linéaires, et/ou propagatifs </li>
#         <li> l’intégrabilité directe dans des workflows de conception industriels caractéristiques. </li></ul>"
#         @table "obj", [ ["",""],["",""] ]
        
        @heading "obj", 4, "Modèles réduits"
        @paragraph "obj", "
        Les <b>modèles réduits</b> sont des modèles de substitution allégés, approchant suffisamment le comportement d'un système sur un certain domaine. Partant d'un 
        modèle exploité par éléments finis, il s'agit de réduire la base de projection des solutions permettant ainsi une simulation plus rapide. La réduction peut s'effectuer 
        a posteriori suivant les données d'une première simulation, ou bien a priori par la mise en pratique d'une connaissance métier."
        @image "obj", "img/hyper_reduction.png"
        @paragraph "obj", "<center>Hyper-réduction du modèle éléments finis de l'impact d'une barre cylindrique"
        
        @heading "obj", 4, "<br>Le projet"
        @paragraph "obj", "
        Partant du besoin exprimé par des industriels en dynamique non-linéaire où l'état de l'art de la réduction de modèle bute, ce <b>projet</b> vise à explorer les méthodes 
        existantes (a posteriori) et novatrices (a priori) de réduction de modèle afin d'en dégager des outils et méthodes aussi généraux que possibles et faciles à 
        implémenter dans l'industrie.<br><br>
        Poussés par des imperatifs de compétitivité, les industriels s'imposent un rythme de
        conception toujours plus élevé, ce qui necessite l'utilisation de modèles fidèles mais aussi 
        suffisamment rapides. La pratique industrielle s'oriente déjà vers l'usage de modèles réduits, 
        mais se limite le plus souvent à des méthodes faciles d'implémentation. Ces méthodes sont 
        cependant de véritables boîtes noires qui ne permettent généralement aucun contrôle sur la 
        précision, la stabilité ou le domaine de validité du modèle et qui sont de plus mises à mal par 
        la complexité sans cesse croissante des nouveaux systèmes. Des cas d'étude sont 
        proposés par les partenaires industriels afin d'illustrer ces difficultés et d'évaluer la 
        performance des solutions apportées par le projet.<br><br>
        L’état de l’art de la recherche propose d'ores et déjà réponses à deux des verrous technologiques auxquels ce projet fait face :
        <ul><li> La <b>non­linéarité</b> des problèmes qui rend les calculs couteux et met à défaut bon nombre de méthodes.</li>
        <li>La <b>non­localité des perturbations</b> dûes aux phénomènes propagatifs qui sont donc plus difficiles à capter avec un modèle réduit.</li></ul>
        En plus de l'intégration de ces nouvelles méthodes dans un outil à portée industrielle, ce projet vise aussi à fournir :
        <ul><li>Des <b>critères de qualité</b> relatifs à un modèle réduit (prédictivité, robustesse, représentativité, domaine d'application, maîtrise des incertitudes)</li>
        Des méthodes permettant de choisir une <b>famille de modèles réduits</b> répondant à un compromis entre le poids d'un modèle (finesse) et le nombre de modèles (valides 
        par point de fonctionnement).</li></ul>  
        Chaque domaine ayant son lot de spécificités, les techno­providers développent les outils 
        répondant au besoin en intégrant les nouvelles méthodes issues de la recherche et leurs 
        compétences métier. Afin de valider la pertinence des méthodes utilisées, les outils seront 
        évalués par domaines au travers de cas d'usage spécifiques proposés par les partenaires industriels.
        "
        
        
        
       
        @panel "col1", "con", "Consortium", "consortium"
#         silkan_logo = "img/logo_silkan_2.jpg"
#         snecma_logo = "img/logo_SAFRAN_snecma.png"
#         renault_logo = "img/logo_renault_2.jpg"
#         sc_logo = "img/logo_sc2.png"
#         dassault_logo = "img/logo_dassault_2.png"
#         bertin_logo = "img/logo_bertin_2.jpg"
#         esi_logo = "img/logo_esi_2.jpg"
#         scilab_logo = "img/logo_scilab_2.jpg"
#         lmt_logo = "img/logo_LMT.png"
#         cadlm_logo = "img/logo_cadlm_2.jpg"
#         armines_logo = "img/logo_armines_2.jpg"
#         dps_logo = "img/logo_dps_2.png"
#         @gallery "con", [ silkan_logo, snecma_logo, renault_logo, sc_logo, 
#                          dassault_logo, bertin_logo, esi_logo, scilab_logo,
#                          lmt_logo, cadlm_logo, armines_logo, dps_logo ]
        @image "con", "img/consortium_1.png"
        @image "con", "img/consortium_2.png"
        @image "con", "img/consortium_3.png"

        @panel "col1", "fin", "Financeurs / Pôle de compétitivité", "financeurs"
#         essone_logo = "img/logo_ESSONE_2.png"
#         bpi_logo = "img/logo_BPI_France_2.png"
#         idf_logo = "img/logo_idf_2.png"
#         systematic_logo = "img/logo_systematic_2.png"
#         @gallery "fin", [ essone_logo, bpi_logo, idf_logo, systematic_logo ]
        @image "fin", "img/financeurs.png"
        @image "fin", "img/pole.png", "335px"
        
                
        
        @panel "col2", "wp", "Work Packages", "workpackages"
        @table "wp", [ 
            [ "<h4>&nbsp&nbsp&nbsp&nbsp&nbsp WP0 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</h4>", 
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
            [ "<h5>27/05/2016</h5>", "<h5>28, 29 JUIN : Ter@tec - Projet MECASIF</h5>
            Si vous êtes familier de la conception virtuelle de systèmes complexes, vous avez déjà constaté qu'un processus de simulation représentatif de phénomènes 
            physiques et contrôlé, est particulièrement coûteux en temps de calcul. Avec les méthodes actuelles, les applications en temps contraint comme la virtualisation 
            des bancs d'essais ou encore les simulateurs d'entraînement sont très souvent compliquées à mettre en place.<br>
            Par l'exploration de nouvelles techniques de réduction de modèle, les partenaires du projet français MECASIF entreprennent de résoudre cette problématique. 
            L'équipe Scilab et ses partenaires vous présenteront le <b>28 et 29 Juin</b> au <b>Ter@tec 2016</b> sur le stand <b>Systematic</b> les avancées du projet.<br>&nbsp" ],
            
            [ "<h5>26/05/2016</h5>", "<h5>Le site MECASIF fait peau neuve !</h5>
            Beaucoup de changements depuis Structure Computation : nouveau nom, nouveau design, nouvelle technologie, nouvelles applications !<br>
            Des démos des différents prototypes logiciels dans le cadre du WP2 sont disponibles en dessous. Ces modules comprennent pour l'instant :
            Un calcul PGD avec Castem sur une structure treillis, et un calcul PGD avec Castem sur une liaison collée 2D.<br>&nbsp" ],
            
            [ "<h5>26/11/2015</h5>", "<h5>Doctoral Workshop on Model Reduction in nonlinear dynamics of fluids and structures</h5>
            <b>January 25-29 2016 at Mines ParisTech.</b><br> 
            We present recent advances in model reduction for nonlinear mechanics of fluids and structures. Reduced-Order models aim at reducing the computational 
            time required to obtain solutions of Partial Differential Equations which are physically-based and parameter dependent. They reduce the computational complexity 
            of optimization procedures, parametric analyses, or metamodel generation.<br>
            <a href=\"http://matperso.mines-paristech.fr/Personnel/david.ryckelynck/\" target=\"_blank\">Workshop program</a><br>&nbsp" ],   
            
            [ "<h5>01/05/2015</h5>", "<h5>Mise en ligne de la plate-forme web MECASIF</h5>
            La première version de la plate-forme web MECASIF est en ligne.<br>&nbsp" ],            
            ]


        @panel "col1", "art", "Articles", "articles"
        papers_href_lst = [ "http://resources.is-sim.com/2015-LS-DYNA-template-paper_KAYVANTASH.pdf",
                      "http://resources.is-sim.com/Ryckelynck.pdf",
                      "http://resources.is-sim.com/Workshop_PGD_LMT.pdf",
                      "http://resources.is-sim.com/F1.1a-Rapport_bibliographique.v1.pdf"]
        papers_caption_lst = [ "Model Reduction Techniques for LS-DYNA ALE and Crash Applications <br><br><b>Kambiz Kayvantash</b>",
                            "Hyper-reduction framework for model calibration in heterogeneous plasticity <br><br><b>David Ryckelynck</b>",
                            "PGD-Reduced Models for several parametrized nonlinear problems <br><br><b>David Néron</b>",
                            "Revue critique des méthodes applicables aux problèmes hyperboliques <br><br><b>D.Ryckelinck, L.Fourment, <br> P.Almeida, L.Blanc, A.Grolet, F.Thouverez, <br>P.-A.Boucard, <br>Y.Maday </b>"]
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
