#include <SpinalCoreQT/SpinalCore.h>
#include <SpinalCoreQT/Model/Path.h>
#include <SpinalCoreQT/Model/TypedArray.h>
#include <QtCore/QFile>
#include <QtCore/QTemporaryFile>
#include <QtCore/QDataStream>
#include <QtCore/QString>
#include "CastemTrussUpdater.h"
#include <QtCore/QTextStream>
#include <QtCore/QIODevice>


bool CastemTrussUpdater::run( ModelPointer mp ) {
    
    // récupération des paramètres du modèle
    ModelPointer truss = mp[ "_children[ 0 ]" ];
    double L1 = truss[ "dimensions" ][ "L1" ];
    double L2 = truss[ "dimensions" ][ "L2" ];
    double Fx = truss[ "force" ][ "Fx" ];
    double Fy = truss[ "force" ][ "Fy" ];
    
    ModelPointer substruct_params_1 = truss[ "_children[0]" ];
    double E1 = substruct_params_1[ "materials" ][ "young_modulus" ];
    double S1 = substruct_params_1[ "materials" ][ "section_diameter" ];
    double nu1 = substruct_params_1[ "materials" ][ "poisson_coefficient" ];
    double rho1 = substruct_params_1[ "materials" ][ "density" ];
    double kmin1 = substruct_params_1[ "PGD" ][ "k_min" ];
    double kmax1 = substruct_params_1[ "PGD" ][ "k_max" ];
    double nval1 = substruct_params_1[ "PGD" ][ "n_val" ];

    ModelPointer substruct_params_2 = truss[ "_children[1]" ];
    double E2 = substruct_params_2[ "materials" ][ "young_modulus" ];
    double S2 = substruct_params_2[ "materials" ][ "section_diameter" ];
    double nu2 = substruct_params_2[ "materials" ][ "poisson_coefficient" ];
    double rho2 = substruct_params_2[ "materials" ][ "density" ];
    double kmin2 = substruct_params_2[ "PGD" ][ "k_min" ];
    double kmax2 = substruct_params_2[ "PGD" ][ "k_max" ];
    double nval2 = substruct_params_2[ "PGD" ][ "n_val" ];
    
    ModelPointer substruct_params_3 = truss[ "_children[2]" ];
    double E3 = substruct_params_3[ "materials" ][ "young_modulus" ];
    double S3 = substruct_params_3[ "materials" ][ "section_diameter" ];
    double nu3 = substruct_params_3[ "materials" ][ "poisson_coefficient" ];
    double rho3 = substruct_params_3[ "materials" ][ "density" ];
    double kmin3 = substruct_params_3[ "PGD" ][ "k_min" ];
    double kmax3 = substruct_params_3[ "PGD" ][ "k_max" ];
    double nval3 = substruct_params_3[ "PGD" ][ "n_val" ];
    
    ModelPointer pgd_params = truss[ "_children[ 3 ]" ];
    double n1couple = pgd_params[ "N1couple" ];
    double n1pf = pgd_params[ "N1pf" ];
    double eps0 = pgd_params[ "eps0" ];
    
    // conversion des valeurs (doubles) en Qstring
    QString L1_str = QString::number(L1);
    QString L2_str = QString::number(L2);
    
    QString Fx_str = QString::number(Fx);
    QString Fy_str = QString::number(Fy);
    
    QString E1_str = QString::number(E1);
    QString S1_str = QString::number(S1);
    QString nu1_str = QString::number(nu1);
    QString rho1_str = QString::number(rho1);
    QString kmin1_str = QString::number(kmin1);
    QString kmax1_str = QString::number(kmax1);
    QString nval1_str = QString::number(nval1);

    QString E2_str = QString::number(E2);
    QString S2_str = QString::number(S2);
    QString nu2_str = QString::number(nu2);
    QString rho2_str = QString::number(rho2);
    QString kmin2_str = QString::number(kmin2);
    QString kmax2_str = QString::number(kmax2);
    QString nval2_str = QString::number(nval2);

    QString E3_str = QString::number(E3);
    QString S3_str = QString::number(S3);
    QString nu3_str = QString::number(nu3);
    QString rho3_str = QString::number(rho3);
    QString kmin3_str = QString::number(kmin3);
    QString kmax3_str = QString::number(kmax3);
    QString nval3_str = QString::number(nval3);
    
    QString n1couple_str = QString::number(n1couple);
    QString n1pf_str = QString::number(n1pf);
    QString eps0_str = QString::number(eps0);
    
    
    // création et chargement en écriture seule du fichier Treillis_PGD_test.dgibi 
    QString dgibi_name = "Treillis_PGD_3par.dgibi";
    QFile dgibi("../castem-organ/castem/" + dgibi_name);
    if (!dgibi.open( QIODevice::WriteOnly | QIODevice::Text )){
        add_message( mp, ET_Error, "Unable to open .dgibi file" );
        return false;   
    }
    
    
    // texte à écrire dans le fichier .dgibi
    QString texte = "\
* \n\
* F. LOUF \n\
* 15/09/2015 \n\
* LMT Cachan \n\
* \n\
* --------------------------------------------------------------------------------- \n\
* Exemple d'illustration de la PGD espace/parametres sur un treillis à trois barres \n\
* \n\
* Objectif : construire la dépendance du champ de déplacement à (E1,E2,E3) \n\
*            par la PGD \n\
* \n\
* Problème traité : voir article \n\
*         LOUF_CHAModelPointerANEY_2013 dans Finite Elements in Analysis and Design \n\
* \n\
* --------------------------------------------------------------------------------- \n\
* \n\
* ================================================================================= \n\
*  Parametres PGD \n\
* ================================================================================= \n\
* \n\
* Nombre de n-uplets dans la base finale \n\
* \n\
N1COUPLE = " + n1couple_str + " ; \n\
* \n\
* Nombre d'itérations maximales du point fixe \n\
* \n\
N1PF = " + n1pf_str + " ; \n\
* \n\
* Critère d'arrêt du point fixe \n\
* \n\
EPS0 = " + eps0_str + " ; \n\
* \n\
* ================================================================================= \n\
*                   DEFINITION DE LA GEOMETRIE ET DU MODELE \n\
* ================================================================================= \n\
* \n\
* Options Cast3M : pas d'écho après les commandes, dimension 2 \n\
* \n\
OPTI ECHO 0 ;\n\
OPTI DIME 2 ;\n\
OPTI ELEM SEG2 ; \n\
* \n\
* Dimensions principales \n\
* \n\
L1 = " + L1_str + " ;\n\
L2 = " + L2_str + " ;\n\
* \n\
* Points du treillis (3 points en haut, 1 point en bas)\n\
* \n\
P1 = (0.-L1)  L2 ;\n\
P2 =  0.      L2 ;\n\
P3 = (0.+L1)  L2 ;\n\
P4 =  0.      0. ;\n\
* \n\
* Les trois barres du treillis\n\
* \n\
L14 = DROI 1 P1 P4 ;\n\
L24 = DROI 1 P2 P4 ;\n\
L34 = DROI 1 P3 P4 ;\n\
* \n\
* Définition des 3 zones à paramètre identique\n\
* \n\
Z1 = L14 ;\n\
Z2 = L24 ;\n\
Z3 = L34 ;\n\
* \n\
* Maillage complet \n\
* \n\
MAI1 = Z1 ET Z2 ET Z3 ;\n\
* \n\
* Matrice de raideur nominale sur la zone 1\n\
* Il faut le module de Young, la section\n\
YOU1 = " + E1_str + "   ;\n\
SEC1 = " + S1_str + "  ;\n\
MOD1 = MODE Z1 MECANIQUE ELASTIQUE ISOTROPE BARRE ;\n\
MAT1 = MATE MOD1 YOUNG YOU1 NU " + nu1_str + " RHO " + rho1_str + " ;\n\
PRO1 = CARA MOD1 SECT SEC1 ;\n\
* \n\
RIG1 = RIGI MOD1 (MAT1 ET PRO1) ;\n\
* \n\
* Matrice de raideur nominale sur la zone 2\n\
*  \n\
YOU2 = " + E2_str + "   ;\n\
SEC2 = " + S2_str + "  ;\n\
MOD2 = MODE Z2 MECANIQUE ELASTIQUE ISOTROPE BARRE ;\n\
MAT2 = MATE MOD2 YOUNG YOU2 NU " + nu2_str + " RHO " + rho2_str + " ;\n\
PRO2 = CARA MOD2 SECT SEC2 ;\n\
* \n\
RIG2 = RIGI MOD2 (MAT2 ET PRO2) ;\n\
* \n\
* Matrice de raideur nominale sur la zone 3\n\
* \n\
YOU3 = " + E3_str + "   ;\n\
SEC3 = " + S3_str + "  ;\n\
MOD3 = MODE Z3 MECANIQUE ELASTIQUE ISOTROPE BARRE ;\n\
MAT3 = MATE MOD3 YOUNG YOU3 NU " + nu3_str + " RHO " + rho3_str + " ;\n\
PRO3 = CARA MOD3 SECT SEC3 ;\n\
* \n\
RIG3 = RIGI MOD3 (MAT3 ET PRO3) ;\n\
* \n\
* Conditions aux limites en déplacement\n\
* \n\
BLO0 = BLOQ DEPL (P1 ET P2 ET P3) ;\n\
* \n\
* Construction d'un effort au point P4\n\
* \n\
FOR0 = FORC (" + Fx_str + " " + Fy_str + ") P4 ;\n\
* \n\
* =================================================================================\n\
*                   MISE EN DONNEE SOUS LA FORME ADAPTEE \n\
* ================================================================================= \n\
* \n\
SS1 = TABLE ;\n\
* \n\
* Premiere sous structure : \n\
* \n\
SS1 . 1 = TABLE ;\n\
SS1 . 1 . 'K'   = RIG1 ;\n\
SS1 . 1 . 'KMIN' = " + kmin1_str + " ;\n\
SS1 . 1 . 'KMAX' = " + kmax1_str + " ;\n\
SS1 . 1 . 'NVAL' = " + nval1_str + "  ;\n\
* \n\
* Deuxieme sous structure :  \n\
* \n\
SS1 . 2 = TABLE ;\n\
SS1 . 2 . 'K'  = RIG2  ;\n\
SS1 . 2 . 'KMIN' = " + kmin2_str + " ;\n\
SS1 . 2 . 'KMAX' = " + kmax2_str + " ;\n\
SS1 . 2 . 'NVAL' = " + nval2_str + "  ;\n\
* \n\
* Troisieme sous structure : \n\
* \n\
SS1 . 3 = TABLE ;\n\
SS1 . 3 . 'K'  = RIG3  ;\n\
SS1 . 3 . 'KMIN' = " + kmin3_str + " ;\n\
SS1 . 3 . 'KMAX' = " + kmax3_str + " ;\n\
SS1 . 3 . 'NVAL' = " + nval3_str + "  ;\n\
* \n\
* Conditions aux limites\n\
* \n\
CL1 = TABLE ;\n\
CL1 . 'CU' = BLO0 ;\n\
CL1 . 'CF' = FOR0 ;\n\
* \n\
* Nombre de sous-domaine à parametre uniforme \n\
* \n\
N1S = DIME SS1 ;\n\
* \n\
* Recuperation des différentes inconnues primales et duales \n\
* \n\
RIG1TOT = SS1 . 1 . 'K' ;\n\
SI (N1S > 1) ;\n\
  REPE BCL1S (N1S-1) ;\n\
    RIG1TOT = RIG1TOT ET SS1 . (&BCL1S+1) . 'K' ;\n\
  FIN BCL1S ;\n\
FINSI ;\n\
* \n\
L1U = EXTR RIG1TOT 'COMP'        ;\n\
L1F = EXTR RIG1TOT 'COMP' 'DUAL' ;\n\
* \n\
* =================================================================================\n\
*                         CALCUL DU MODELE PGD \n\
* ================================================================================= \n\
*  \n\
* Initialisation du temps de calcul\n\
* \n\
TEMPS 'ZERO' ;\n\
* \n\
* Liste de mot pour les matrices de masse\n\
* \n\
L1T = MOTS 'T'  ;\n\
L1Q = MOTS 'Q'  ;\n\
* \n\
* Création d'un maillage de l'espace des parametres\n\
* 1 maillage 1D par paramètre\n\
* \n\
REPE BCL1J N1S ;\n\
* \n\
* Maillage support du parametre Ki (associé à E)\n\
* \n\
  K1MIN = SS1 . &BCL1J . 'KMIN' ;\n\
  K1MAX = SS1 . &BCL1J . 'KMAX' ;\n\
  N1ELE = SS1 . &BCL1J . 'NVAL' ;\n\
* \n\
  SI ((VALE DIME) EGA 2) ;\n\
    SUPP1 = DROI N1ELE (K1MIN 0.   ) (K1MAX 0.   ) ;  \n\
  SINON ;\n\
    SUPP1 = DROI N1ELE (K1MIN 0. 0.) (K1MAX 0. 0.) ;  \n\
  FINSI ;\n\
  SS1 . &BCL1J . 'SUPP' = SUPP1 ;\n\
* \n\
* Creation de la matrice de masse associée au support\n\
* \n\
  MOD1 = MODE SUPP1 THERMIQUE ISOTROPE BARRE ;\n\
  MAT1 = MATE MOD1 'C' 1. 'RHO' 1. 'SECT' 1. ;\n\
  MAS1 = CAPA MOD1 MAT1 ;\n\
  SS1 . &BCL1J . 'MAS1' = MAS1 ;\n\
* \n\
* Initialisation des lambda\n\
* \n\
  CL1K = COOR 1 SUPP1 ;\n\
  SS1 . &BCL1J . 'LAMB' = CL1K NOMC 'T' ;\n\
  SS1 . &BCL1J . 'LAM0' = CL1K NOMC 'T' ;\n\
* \n\
* Calcul de la matrice de masse avec propriete de masse linéaire\n\
* On prend un x lineaire par élément\n\
* \n\
  N1E = NBEL SUPP1 ;\n\
  REPE BCL1E N1E ;\n\
* \n\
    EL1 = ELEM &BCL1E SUPP1 ;\n\
    X1MIN = COOR 1 (EL1 POIN 1) ;\n\
    X1MAX = COOR 1 (EL1 POIN 2) ;\n\
    M1E11 = (X1MAX**2)+(2*X1MIN*X1MAX)-(3*(X1MIN**2)) ;\n\
    M1E12 = (X1MAX**2)-(X1MIN**2) ;\n\
    M1E22 = (3*(X1MAX**2))-(2*X1MIN*X1MAX)-(X1MIN**2) ;\n\
    L1M = PROG M1E11 M1E12                  \n\
               M1E12 M1E22 ;\n\
    M1E = MANU 'RIGIDITE' EL1 L1T 'DUAL' L1Q L1M ;\n\
    M1E = M1E/12. ;\n\
    SI (&BCL1E EGA 1) ;\n\
      M1TOT = M1E ;\n\
    SINON ;\n\
      M1TOT = M1TOT ET M1E ;\n\
    FINSI ;\n\
*   \n\
  FIN BCL1E ; \n\
* \n\
  SS1 . &BCL1J . 'MASK' = M1TOT ;\n\
* \n\
* Champ de 1 sur le support de lambda \n\
* \n\
  UNI1 = MANU CHPO SUPP1 1 'T' 1. NATURE DISCRET ;\n\
  SS1 . &BCL1J . 'CHP1' = UNI1 ;   \n\
* \n\
FIN BCL1J ; \n\
* \n\
* Boucle (point fixe) permettant de construire le premier jeu Lambda - Psi \n\
* On fixe le nombre d'iterations maxi pour le moment\n\
* \n\
BAS1 = TABLE ;\n\
BAS1 . 0 = TABLE ;\n\
BAS1 . 0 . 'LAM' = TABLE ;\n\
* \n\
* List contenant les itérations du PF nécessaires pour converger \n\
* \n\
PF1CONV = PROG ;\n\
* \n\
REPE BCL1PF N1PF ;\n\
* \n\
* --------> Calcul du champ Psi 0\n\
* \n\
* On calcule le produit des lambda_mj . Mj . lambda_mj (pour RIG0TOT)\n\
* On calcule le produit des lambda_mj . Mj . 1 (pour FOR0TOT)\n\
* \n\
  PRD1 = 1. ;\n\
  PRD2 = 1. ;\n\
* \n\
  REPE BCL1J N1S ;\n\
*    \n\
    LAM0MJ = SS1 . &BCL1J . 'LAMB' ;\n\
    MAS11J = SS1 . &BCL1J . 'MAS1' ;\n\
    UNI1   = SS1 . &BCL1J . 'CHP1' ;\n\
* \n\
    PRD1 = PRD1*(XTMX LAM0MJ MAS11J) ;\n\
* \n\
    PRD2 = PRD2*(YTMX UNI1 LAM0MJ MAS11J) ;\n\
* \n\
  FIN BCL1J ; \n\
* \n\
* Assemblage de la rigidite\n\
* \n\
  RIG0TOT = CL1 . 'CU' ;\n\
* \n\
  REPE BCL1I N1S ;\n\
*   \n\
    LAM0MI = SS1 . &BCL1I . 'LAMB' ;\n\
    MAS11I = SS1 . &BCL1I . 'MAS1' ;\n\
    MAS1KI = SS1 . &BCL1I . 'MASK' ; \n\
    RIG1I  = SS1 . &BCL1I . 'K'    ;\n\
* \n\
    RIG0TOT = RIG0TOT  ET\n\
    (PRD1*(XTMX LAM0MI MAS1KI)*RIG1I/(XTMX LAM0MI MAS11I)) ;\n\
* \n\
  FIN BCL1I ;\n\
* \n\
* Second membre\n\
* \n\
  FOR0TOT = (CL1 . 'CF')*PRD2 ;\n\
* \n\
* Resolution du système donnant le champ PSI\n\
* \n\
  PSI0 = ENLE (RESO RIG0TOT FOR0TOT) 'LX' ;\n\
* \n\
* --------> Calcul des champs Lambda_n\n\
* \n\
  FPSI0 = XTY CL1 . 'CF' PSI0 L1F L1U ;\n\
*     \n\
  REPE BCL1K N1S ;\n\
* \n\
    LAM0MK = SS1 . &BCL1K . 'LAMB' ;\n\
    MAS11K = SS1 . &BCL1K . 'MAS1' ;\n\
    MAS1KK = SS1 . &BCL1K . 'MASK' ; \n\
    UNI1K  = SS1 . &BCL1K . 'CHP1' ;  \n\
    RIG1K  = SS1 . &BCL1K . 'K'    ;  \n\
* \n\
* On calcule le produit des lambda_mj . Mj . lambda_mj (pour RIG0TOT)\n\
* (a chaque fois car les lambda changent dans la boucle sur k)\n\
* \n\
    PRD3 = 1. ;\n\
*    \n\
    REPE BCL1J N1S ;\n\
* \n\
      LAM0MJ = SS1 . &BCL1J . 'LAMB' ;\n\
      MAS11J = SS1 . &BCL1J . 'MAS1' ;\n\
      PRD3 = PRD3*(XTMX LAM0MJ MAS11J) ;\n\
* \n\
    FIN BCL1J ;\n\
* \n\
    RIG0TOT = PRD3*(XTMX PSI0 RIG1K)*MAS1KK/\n\
                   (XTMX LAM0MK MAS11K) ;\n\
* \n\
    REPE BCL1I N1S ;\n\
* \n\
      SI (&BCL1K NEG &BCL1I) ; \n\
* \n\
        LAM0MI = SS1 . &BCL1I . 'LAMB' ;\n\
        MAS11I = SS1 . &BCL1I . 'MAS1' ;\n\
        MAS1KI = SS1 . &BCL1I . 'MASK' ;  \n\
        RIG1I  = SS1 . &BCL1I . 'K'    ;     \n\
* \n\
        RIG0TOT = RIG0TOT ET \n\
       (PRD3*(XTMX PSI0 RIG1I)*\n\
             (XTMX LAM0MI MAS1KI)*MAS11K/\n\
            ((XTMX LAM0MI MAS11I)*\n\
             (XTMX LAM0MK MAS11K))) ;\n\
*  \n\
      FINSI ;\n\
*    \n\
    FIN BCL1I ;\n\
* \n\
* Second membre\n\
* \n\
    FOR0TOT = (FPSI0*PRD2/(YTMX UNI1K LAM0MK MAS11K))*MAS11K*UNI1K ;\n\
*   \n\
* Resolution du systeme donnant le champ lambda_n\n\
* \n\
    LAM0MK = NOMC 'T' (EXCO 'T' (RESO RIG0TOT FOR0TOT)) ; \n\
* \n\
* Mise à jour des produits pour ne pas tout recalculer\n\
* \n\
    PRD2 = PRD2*(YTMX UNI1K LAM0MK MAS11K)/\n\
                (YTMX UNI1K SS1 . &BCL1K . 'LAMB'  MAS11K) ;    \n\
* \n\
    PRD3 = PRD3*(XTMX LAM0MK MAS11K)/ \n\
                (XTMX SS1 . &BCL1K . 'LAMB'  MAS11K) ;\n\
* \n\
    SS1 . &BCL1K. 'LAMB' = LAM0MK ;\n\
*                   \n\
  FIN BCL1K ;\n\
* \n\
* Calcul de l'energie du mode pour test de convergence du point fixe \n\
* \n\
  PRD40 = 1. ;\n\
  REPE BCL1K N1S ;\n\
*  \n\
    LAM1P = SS1 . &BCL1K . 'LAMB'  ;      \n\
    PRD40 = PRD40*(XTMX LAM1P SS1 . &BCL1K . 'MAS1') ;\n\
* \n\
  FIN BCL1K ; \n\
* \n\
  ENE1 = 0. ;\n\
  REPE BCL1K N1S ;\n\
    LAM1P = SS1 . &BCL1K . 'LAMB'  ; \n\
    COE1 = (XTMX LAM1P SS1 . &BCL1K . 'MASK')/\n\
           (XTMX LAM1P SS1 . &BCL1K . 'MAS1') ;\n\
    ENE1 = ENE1+ \n\
        ((XTMX PSI0 SS1 . &BCL1K . 'K')*PRD40*COE1) ; \n\
  FIN BCL1K ;\n\
* \n\
  SI (&BCL1PF > 1) ;\n\
    SI ( ((ENE1-ENE10)/ENE10)  < EPS0 ) ;\n\
      MESS 'Convergence atteinte, iteration : ' &BCL1PF ;\n\
      PF1CONV = PF1CONV ET (PROG &BCL1PF) ; \n\
      MESS 'Energie a convergence : ' ENE1 ; \n\
      QUIT BCL1PF ;\n\
    FINSI ;\n\
  FINSI ;\n\
  ENE10 = ENE1 ;\n\
* \n\
FIN BCL1PF ;\n\
* \n\
*  Sauvegarde du couple dans la base à convergence\n\
* \n\
BAS1 . 0 . 'PSI' = PSI0 ;\n\
REPE BCL1I N1S ;  \n\
  BAS1 . 0 . 'LAM' . &BCL1I = SS1 . &BCL1I. 'LAMB' ;\n\
FIN BCL1I ;\n\
* \n\
* Trace du champ psi calculé\n\
* \n\
DEF1 = DEFO PSI0 MAI1 ;\n\
N0PSI = (((EXCO 'UX' PSI0)**2)+ \n\
        ((EXCO 'UY' PSI0)**2))**0.5 ;\n\
* \n\
* On construit d'autres couples que l'on ajoute dans la base\n\
* \n\
SI (N1COUPLE > 1) ;\n\
* \n\
REPE BCL1BAS (N1COUPLE-1) ;\n\
* \n\
* Initialisation des lambda\n\
* \n\
  REPE BCL1I N1S ;\n\
    SS1 . &BCL1I . 'LAMB' = SS1 . &BCL1I . 'LAM0' ; \n\
  FIN BCL1I ;\n\
* \n\
* Dimension de la base actuelle\n\
*   \n\
  N1C = DIME BAS1 ;\n\
* \n\
* Declaration des nouveaux champs dans la table\n\
*  \n\
  BAS1 . &BCL1BAS = TABLE ;\n\
  BAS1 . &BCL1BAS . 'LAM' = TABLE ;\n\
* \n\
  REPE BCL1PF N1PF ;\n\
* \n\
* --------> Calcul du champ Psi 0\n\
* \n\
* On calcule le produit des lambda_mj . Mj . lambda_mj (pour RIG0TOT)\n\
* On calcule le produit des lambda_mj . Mj . 1 (pour FOR0TOT)\n\
* \n\
    PRD1 = 1. ;\n\
    PRD2 = 1. ;\n\
* \n\
    REPE BCL1J N1S ;\n\
*    \n\
      LAM0MJ = SS1 . &BCL1J . 'LAMB' ;\n\
      MAS11J = SS1 . &BCL1J . 'MAS1' ;\n\
      UNI1J  = SS1 . &BCL1J . 'CHP1' ;\n\
* \n\
      PRD1 = PRD1*(XTMX LAM0MJ MAS11J) ;\n\
* \n\
      PRD2 = PRD2*(YTMX UNI1J LAM0MJ MAS11J) ;\n\
* \n\
    FIN BCL1J ; \n\
* \n\
* Assemblage de la rigidite\n\
* \n\
    RIG0TOT = CL1 . 'CU' ;\n\
* \n\
    REPE BCL1I N1S ;\n\
*   \n\
      LAM0MI = SS1 . &BCL1I . 'LAMB' ;\n\
      MAS11I = SS1 . &BCL1I . 'MAS1' ;\n\
      MAS1KI = SS1 . &BCL1I . 'MASK' ; \n\
      RIG1I  = SS1 . &BCL1I . 'K'    ;\n\
*   \n\
      RIG0TOT = RIG0TOT  ET\n\
    (PRD1*(XTMX LAM0MI MAS1KI)*RIG1I/(XTMX LAM0MI MAS11I)) ;\n\
* \n\
    FIN BCL1I ;\n\
* \n\
* Second membre\n\
* \n\
    FOR0TOT = (CL1 . 'CF')*PRD2 ;\n\
* \n\
    REPE BCL1P N1C ;  \n\
* \n\
* Calcul des produits lambda_pj Mj lambda_mj\n\
* \n\
      PRD4 = 1. ;\n\
      REPE BCL1J N1S ;\n\
        LAM0PJ = BAS1 . (&BCL1P-1) . 'LAM' . &BCL1J ;\n\
        LAM0MJ = SS1 . &BCL1J . 'LAMB'  ;\n\
        MAS11J = SS1 . &BCL1J . 'MAS1' ;\n\
        PRD4 = PRD4*(YTMX LAM0MJ LAM0PJ MAS11J) ;\n\
      FIN BCL1J ;\n\
* \n\
* Champ Psi_p\n\
* \n\
      PSI0P = BAS1 . (&BCL1P-1) . 'PSI' ;\n\
* \n\
      REPE BCL1I N1S ; \n\
* \n\
        LAM0PI = BAS1 . (&BCL1P-1) . 'LAM' . &BCL1I ;\n\
        LAM0MI = SS1 . &BCL1I . 'LAMB'  ;\n\
        MAS11I = SS1 . &BCL1I . 'MAS1' ;     \n\
        MAS1KI = SS1 . &BCL1I . 'MASK' ;          \n\
        RIG1I  = SS1 . &BCL1I . 'K'    ;  \n\
        FOR0TOT = FOR0TOT - \n\
     ((PRD4*(YTMX LAM0MI LAM0PI MAS1KI)/\n\
      (YTMX LAM0MI LAM0PI MAS11I))*RIG1I*PSI0P) ;\n\
* \n\
      FIN BCL1I ;         \n\
*     \n\
    FIN BCL1P ;    \n\
* \n\
* Resolution du système donnant le champ PSI\n\
* \n\
    PSI0 = ENLE (RESO RIG0TOT FOR0TOT) 'LX' ;\n\
    DEF1 = DEFO PSI0 MAI1 ;\n\
    N0PSI = (((EXCO 'UX' PSI0)**2)+ \n\
             ((EXCO 'UY' PSI0)**2))**0.5 ;\n\
* \n\
* Orthogonalisation / précédents PSI0 dans la base\n\
* \n\
    REPE BCL1P N1C ; \n\
* \n\
      PSI0P = BAS1 . (&BCL1P-1) . 'PSI' ;\n\
      PSI0 = PSI0 - ((XTY PSI0 PSI0P L1U L1U)*PSI0)  ; \n\
*     \n\
    FIN BCL1P ; \n\
* \n\
* --------> Calcul des champs Lambda_k\n\
* \n\
    FPSI0 = XTY CL1 . 'CF' PSI0 L1F L1U ;\n\
*     \n\
    REPE BCL1K N1S ;\n\
*     \n\
      LAM0MK = SS1 . &BCL1K . 'LAMB' ;\n\
      MAS11K = SS1 . &BCL1K . 'MAS1' ;\n\
      MAS1KK = SS1 . &BCL1K . 'MASK' ; \n\
      UNI1K  = SS1 . &BCL1K . 'CHP1' ;  \n\
      RIG1K  = SS1 . &BCL1K . 'K'    ; \n\
* \n\
      PRD3 = 1. ;\n\
      REPE BCL1J N1S ; \n\
        LAM0MJ = SS1 . &BCL1J . 'LAMB' ;\n\
        MAS11J = SS1 . &BCL1J . 'MAS1' ;\n\
        PRD3 = PRD3*(XTMX LAM0MJ MAS11J) ;\n\
      FIN BCL1J ;\n\
* \n\
      RIG0TOT = PRD3*(XTMX PSI0 RIG1K)*MAS1KK/\n\
                     (XTMX LAM0MK MAS11K) ;\n\
* \n\
      REPE BCL1I N1S ;\n\
* \n\
        SI (&BCL1K NEG &BCL1I) ; \n\
* \n\
          LAM0MI = SS1 . &BCL1I . 'LAMB' ;\n\
          MAS11I = SS1 . &BCL1I . 'MAS1' ;\n\
          MAS1KI = SS1 . &BCL1I . 'MASK' ;  \n\
          RIG1I  = SS1 . &BCL1I . 'K'    ;     \n\
* \n\
          RIG0TOT = RIG0TOT ET \n\
       (PRD3*(XTMX PSI0 RIG1I)*\n\
           (XTMX LAM0MI MAS1KI)*MAS11K/\n\
           ((XTMX LAM0MI MAS11I)*\n\
            (XTMX LAM0MK MAS11K))) ; \n\
* \n\
        FINSI ;\n\
*       \n\
      FIN BCL1I ;\n\
* \n\
* Second membre\n\
* \n\
      FOR0TOT = (FPSI0*PRD2/(YTMX UNI1K LAM0MK MAS11K))*\n\
                 MAS11K*UNI1K ;\n\
* \n\
      REPE BCL1P N1C ;       \n\
* \n\
* Calcul des produits lambda_pj Mj lambda_mj\n\
* (a chaque fois car les lambda changent dans la boucle sur k)\n\
* \n\
        PRD4 = 1. ;\n\
        REPE BCL1J N1S ;\n\
          LAM0PJ = BAS1 . (&BCL1P-1) . 'LAM' . &BCL1J ;\n\
          LAM0MJ = SS1 . &BCL1J . 'LAMB' ;\n\
          MAS11J = SS1 . &BCL1J . 'MAS1' ;\n\
          PRD4 = PRD4*(YTMX LAM0MJ LAM0PJ MAS11J) ;\n\
        FIN BCL1J ;\n\
* \n\
* Champ Psi_p\n\
* \n\
        PSI0P = BAS1 . (&BCL1P-1) . 'PSI' ;\n\
* \n\
* Champ Lambda_pk\n\
* \n\
        LAM0PK = BAS1 . (&BCL1P-1) . 'LAM' . &BCL1K ;        \n\
* \n\
        REPE BCL1I N1S ; \n\
* \n\
          SI (&BCL1I NEG &BCL1K) ;\n\
            LAM0PI = BAS1 . (&BCL1P-1) . 'LAM' . &BCL1I ;\n\
            LAM0MI = SS1 . &BCL1I . 'LAMB'  ;\n\
            MAS11I = SS1 . &BCL1I . 'MAS1' ;     \n\
            MAS1KI = SS1 . &BCL1I . 'MASK' ;            \n\
            RIG1I  = SS1 . &BCL1I . 'K'    ;  \n\
            FOR0TOT = FOR0TOT - \n\
        (PRD4*(YTMX PSI0 PSI0P RIG1I)*\n\
              (YTMX LAM0PI LAM0MI MAS1KI)/\n\
             ((YTMX LAM0PK LAM0MK MAS11K)*\n\
              (YTMX LAM0PI LAM0MI MAS11I))*MAS11K*LAM0PK) ;\n\
          FINSI ;       \n\
* \n\
        FIN BCL1I ;\n\
* \n\
        FOR0TOT = FOR0TOT -\n\
        ((PRD4*(YTMX PSI0 PSI0P RIG1K)/\n\
              (YTMX LAM0PK LAM0MK MAS11K))*MAS1KK*LAM0PK) ; \n\
*     \n\
      FIN BCL1P ;\n\
*   \n\
* Resolution du systeme donnant le champ lambda_k\n\
* \n\
      LAM0MK = NOMC 'T' (EXCO 'T' (RESO RIG0TOT FOR0TOT)) ;\n\
* \n\
* Mise à jour des produits pour ne pas tout recalculer\n\
* \n\
      PRD2 = PRD2*(YTMX UNI1K LAM0MK MAS11K)/\n\
                  (YTMX UNI1K SS1 . &BCL1K . 'LAMB'  MAS11K) ;\n\
*      \n\
* Stockage du lambda_k trouve a cette iteration du point fixe\n\
* \n\
      SS1 . &BCL1K . 'LAMB' = LAM0MK ;  \n\
*   \n\
    FIN BCL1K ;\n\
* \n\
* Calcul de l'energie du mode pour test de convergence du point fixe \n\
* \n\
    PRD40 = 1. ;\n\
    REPE BCL1K N1S ;\n\
*  \n\
      LAM1P = SS1 . &BCL1K . 'LAMB'  ;      \n\
      PRD40 = PRD40*(XTMX LAM1P SS1 . &BCL1K . 'MAS1') ;\n\
* \n\
    FIN BCL1K ; \n\
* \n\
    ENE1 = 0. ;\n\
    REPE BCL1K N1S ;\n\
      LAM1P = SS1 . &BCL1K . 'LAMB'  ; \n\
      COE1 = (XTMX LAM1P SS1 . &BCL1K . 'MASK')/\n\
             (XTMX LAM1P SS1 . &BCL1K . 'MAS1') ;\n\
      ENE1 = ENE1+ \n\
          ((XTMX PSI0 SS1 . &BCL1K . 'K')*PRD40*COE1) ; \n\
    FIN BCL1K ;\n\
* \n\
    SI (&BCL1PF > 1) ;\n\
      SI ( ((ENE1-ENE10)/ENE10)  < EPS0 ) ;\n\
        MESS 'Convergence atteinte, iteration : ' &BCL1PF ;\n\
        PF1CONV = PF1CONV ET (PROG &BCL1PF) ; \n\
        MESS 'Energie a convergence : ' ENE1 ; \n\
        QUIT BCL1PF ;\n\
      FINSI ;\n\
    FINSI ;\n\
    ENE10 = ENE1 ;\n\
* \n\
  FIN BCL1PF ;\n\
* \n\
*  Sauvegarde du couple dans la base à convergence\n\
* \n\
  BAS1 . &BCL1BAS . 'PSI' = PSI0 ;\n\
  REPE BCL1I N1S ;  \n\
    BAS1 . &BCL1BAS . 'LAM' . &BCL1I = SS1 . &BCL1I. 'LAMB' ;\n\
  FIN BCL1I ;\n\
* \n\
* \n\
FIN BCL1BAS ;\n\
* \n\
FINSI ; \n\
* \n\
TPS2 = (TEMPS 'NOEC')/1000.; \n\
* \n\
* =================================================================================\n\
*        IMPRESSION DES CHAMPS PGD (ESPACE + PARAMETRE) DANS UN FICHIER TEXTE         \n\
* ================================================================================= \n\
*  \n\
* \n\
* On change le type de maillage pour boucler sur les points \n\
* \n\
MAI0 = MAI1 CHAN 'POI1' ; \n\
* \n\
* On sort les modes pour traitement ensuite ailleurs\n\
* \n\
OPTI ECHO 0 ;\n\
OPTI IMPR 'Sortie_PGD_Treillis.txt' ;\n\
MESS 'DIM' (VALE DIME) ; \n\
* \n\
MESS 'N1C' N1COUPLE ;\n\
MESS 'N1S' N1S ;\n\
MESS 'N1P' (NBEL MAI0) ;\n\
* \n\
* On sort la correspondance noeuds - position (X,Y)  \n\
MESS 'POINTS' ;\n\
* \n\
REPE BCL1M (NBEL MAI0) ;\n\
* \n\
    X1 = COOR 1 (MAI0 POIN &BCL1M) ; \n\
    Y1 = COOR 1 (MAI0 POIN &BCL1M) ;\n\
    MESS &BCL1M X1 Y1 ;\n\
* \n\
FIN BCL1M ;\n\
MESS 'FINPOINTS' ;\n\
* \n\
MESS 'NBRANDOMS' ;\n\
* \n\
REPE BCL1S N1S ;\n\
  MESS SS1 . &BCL1S . 'NVAL' ;\n\
FIN BCL1S ;\n\
MESS 'FINNBRANDOMS' ;\n\
*   \n\
REPE BCL1C N1COUPLE ;\n\
* \n\
* On sort la fonction d'espace point par point \n\
  MESS 'PSI' ;\n\
* \n\
  REPE BCL1M (NBEL MAI0) ;\n\
    U10 = REDU BAS1 . (&BCL1C-1) . 'PSI' (MAI0 POIN &BCL1M) ;\n\
    U10X = MAXI (EXCO 'UX' U10) ; \n\
    U10Y = MAXI (EXCO 'UY' U10) ;\n\
    MESS U10X U10Y ;\n\
  FIN BCL1M ;\n\
  MESS 'FINPSI' ;\n\
* \n\
* On sort chaque fonction des paramètres point par point \n\
  MESS 'LAMBDA' ;\n\
* \n\
  REPE BCL1S N1S ; \n\
     LAM1 = BAS1 . (&BCL1C-1) . 'LAM' . &BCL1S ;\n\
     SUPP1 = SS1 . &BCL1S . 'SUPP' ;\n\
     REPE BCL1N (NBNO SS1 . &BCL1S . 'SUPP') ;\n\
       MESS (MAXI (REDU LAM1 (SUPP1 POIN &BCL1N))) ;\n\
     FIN BCL1N ;\n\
  FIN BCL1S ;\n\
  MESS 'FINLAMBDA' ;\n\
* \n\
FIN BCL1C ;\n\
* \n\
OPTI IMPR 'Temp.txt' ; \n\
* \n\
FIN ; \n\
FIN ; \n\
    ";
    
    
    // écriture dans le fichier .dgibi
    dgibi.write( texte.toLatin1(),texte.size() );
    dgibi.close();

    QString cmd = "cd ../castem-organ/castem/ ; castem15 " + dgibi_name;
    int exec1 = system( cmd.toLatin1().data() );
    
    
    //Copie du fichier resultat dans data.db
    QString adr = "../castem-organ/castem/Sortie_PGD_Treillis.txt"; // adresse du fichier côté SpinalCoreQT
    QString output_file = mp[ "_files_to_save[0]" ]; // adresse du path contenu dans la liste _files_to_save
    cmd = "cp " + adr + " " + output_file; // ligne de commande pour copier du fichier à l'adresse du path
    int exec2 = system( cmd.toLatin1().data() ); // execution de la ligne de commande
    QString output_file_name = "Sortie_PGD_Treillis.txt"; // nom du fichier
    mp[ "_files_to_save[0]" ][ "name" ] = output_file_name; // assignation du nom au Path    
    
    // message de fin du calcul
    add_message( mp, ET_Info, "Cast3m computation finished.");
    
    
    // ouverture en lecture du fichier resultat
    QFile output("../castem-organ/castem/Sortie_PGD_Treillis.txt");
    if (!output.open( QIODevice::ReadOnly )){
        add_message( mp, ET_Error, "Unable to open result file" );
        return false;   
    }
    QTextStream out( &output );
    
    // initialisation des parametres pour la lecture du fichier
    int num_line = 0;
    int mode = 0;
    QString s;
    int n, dim, n1c, n1s, n1p;     
    double x, y;
    int psi_line, lambda_line(1);
    
    // initialisation du stockage des valeurs de la fonction psi
    QList<QList<QList<double> > > psi;
    QList<QList<double> > psi_p;
    QList<double> psi_x;
    QList<double> psi_y;
    
    // initialisation du stockage des valeurs de la fonction lambda
    QList<QList<QList<double> > > lambda;
    QList<QList<double> > lambda_p;
    QList<double> lambda_1;
    QList<double> lambda_2;
    QList<double> lambda_3;
    
    while( !out.atEnd() ) {
        QString line = out.readLine();
        num_line++;
        QTextStream ls( &line );
        switch( mode ){
            
        case 0: // lecture de dim
            ls >> s >> n;
            dim = n;
            mode = 1;
            continue;
        case 1: // lecture de N1couples
            ls >> s >> n;
            n1c = n;
            mode = 2;
            continue;
        case 2: // lecture de N1structures
            ls >> s >> n;
            n1s = n;
            mode = 3;
            continue;
        case 3: // lecture de N1points
            ls >> s >> n;
            n1p = n;
            mode = 4;
            continue;
            
        case 4:
            if ( line == " POINTS" ) { mode = 5; continue; }
            if ( line == " NBRANDOMS" ) { mode = 6; continue; }
            if ( line == " PSI" ) { mode = 7; continue; }
            if ( line == " LAMBDA" ) { mode = 8; continue; }
            continue;         
            
        case 5: // lecture des coord des points
            if ( line == " FINPOINTS" ) { mode = 4; continue; }
            ls >> n >> x >> y;
            continue;
            
        case 6: // lecture des nombres de discrétisation du paramètre aleatoire (E)
            if ( line == " FINNBRANDOMS" ) { mode = 4; continue; }
            ls >> n;
            continue;
            
        case 7: // lecture des vecteurs psi
            if ( line == " FINPSI" ) { mode = 4; continue; }
            ls >> x >> y;
            psi_x.append(x);
            psi_y.append(y);
            psi_line++;
            if (psi_line == 4){
                psi_line = 0;
                psi_p.append(psi_x);
                psi_p.append(psi_y);
                psi.append(psi_p);
                psi_x.clear();
                psi_y.clear();
                psi_p.clear();
            }
            continue;
           
        case 8: // lecture des lambdas
            if ( line == " FINLAMBDA" ) { mode = 4; continue; }
            ls >> x;
            if (lambda_line <= nval1+1){
                lambda_1.append(x);
                lambda_line++;
            }
            else if (lambda_line <= nval1+nval2+2){
                lambda_2.append(x);
                lambda_line++;
            }
            else if (lambda_line <= nval1+nval2+nval3+3){
                lambda_3.append(x);
                lambda_line++;
            }
            if (lambda_line == nval1+nval2+nval3+4) {
                lambda_line = 1;
                lambda_p.append(lambda_1);
                lambda_p.append(lambda_2);
                lambda_p.append(lambda_3);
                lambda.append(lambda_p);
                lambda_1.clear();
                lambda_2.clear();
                lambda_3.clear();
                lambda_p.clear();
            }
      
            continue;
            
        }
    }
   
    // conversion de la QList psi en Lst et stockage dans l'attribut "_psi" du TrussItem
    truss[ "_psi" ].clear();
    for (int p=0; p<psi.length(); ++p){
        ModelPointer p_p = ModelPointer::new_lst();
        ModelPointer p_x = ModelPointer::new_lst();
        ModelPointer p_y = ModelPointer::new_lst();
        for (int i=0; i<psi[p][0].length(); ++i){
            p_x << psi[p][0][i];
            p_y << psi[p][1][i];
        }
        p_p << p_x;
        p_p << p_y;
        truss[ "_psi" ] << p_p;
    }   
    
    // conversion de la QList lambda en Lst et stockage dans l'attribut "_lambda" du TrussItem
    truss[ "_lambda" ].clear();
    for (int p=0; p<lambda.length(); ++p){
        ModelPointer l_p = ModelPointer::new_lst();
        ModelPointer l_1 = ModelPointer::new_lst();
        ModelPointer l_2 = ModelPointer::new_lst();
        ModelPointer l_3 = ModelPointer::new_lst();
        for (int i=0; i<lambda[p][0].length(); ++i){
            l_1 << lambda[p][0][i];
            l_2 << lambda[p][1][i];
            l_3 << lambda[p][2][i];
        }
        l_p << l_1;
        l_p << l_2;
        l_p << l_3;
        truss[ "_lambda" ] << l_p;
    }
        
//     mp[ "_output[0]" ][ "k" ][ "k1" ][ "val" ] = 1;
//     mp[ "_output[0]" ][ "k" ][ "k2" ][ "val" ] = 1;
//     mp[ "_output[0]" ][ "k" ][ "k3" ][ "val" ] = 1;
}
    
    
    
    // --------- MAILLAGE LIGNE -------------
//     TypedArray<int> *line_con = new TypedArray<int>;
//     line_con->_data << 0;  
//     line_con->_data << 3;  
//     line_con->_data << 1;  
//     line_con->_data << 3;  
//     line_con->_data << 2;  
//     line_con->_data << 3;  
//     line_con->_size.resize( 2 );
//     line_con->_size[ 0 ] = 2;
//     line_con->_size[ 1 ] = line_con->_data.size() / 2;
//     ModelPointer lines = ModelPointer::new_obj( "Element_LineList" );
//     lines[ "indices" ] = line_con;
//     mp[ "_children[1]" ][ "visualization.color_by.lst[ 0 ].data._mesh.points" ] << mp[ "_children[0]" ][ "_mesh.points" ];
//     mp[ "_children[1]" ][ "visualization.color_by.lst[ 0 ].data._mesh._elements" ] << lines;





// ModelPointer make_field( ModelPointer mp, /*Q*/String name ) {
//     for( int i = 0; ; ++i ) {
//         if ( i == mp[ "visualization.color_by.lst" ].size() ) {
//             ModelPointer disp = ModelPointer::new_obj( "InterpolatedField" );
//             disp[ "_data" ] = ModelPointer::new_lst();
// 
//             ModelPointer pd = ModelPointer::new_obj( "NamedParametrizedDrawable" );
//             pd[ "name" ] = name;
//             pd[ "data" ] = disp;
//             mp[ "visualization.color_by.lst" ] << pd;
//             return disp;
//         }
//         ModelPointer l = mp[ "visualization.color_by.lst" ][ i ];
//         if ( QString( l[ "name" ] ) == name ) {
//             l[ "data._data" ].clear();
//             return l[ "data" ];
//         }
//     }
// }
// 
// 
// void add_field_in_Interpolated( ModelPointer interpolated_field, ModelPointer mesh, ModelPointer data, double time, QString type_field ) {
//     ModelPointer field = ModelPointer::new_obj( type_field );
//     field[ "_mesh" ] = mesh;
//     field[ "_data" ] = data;
// 
//     // Interpolated field fill-in
//     ModelPointer disp = ModelPointer::new_obj();
//     disp[ "field" ] = field;
//     disp[ "pos" ] = ModelPointer::new_lst();
//     ModelPointer pos_v = ModelPointer::new_obj();
//     pos_v[ "axe_value" ] = time;
//     pos_v[ "axe_name" ] = "time";
//     disp[ "pos" ] << pos_v;
//     
// //     qDebug() << "disp[ 'pos' ] : " << disp[ "pos" ];
// 
//     interpolated_field[ "_data" ] << disp;
// }

