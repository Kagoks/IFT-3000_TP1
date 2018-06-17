(*********************************************************************)
(* Langages de Programmation: IFT 3000 NRC 51158                     *)
(* TP1 ÉTÉ 2018. Date limite: mercredi 13 juin à 17h                 *)
(* Implanter un système de recherche de matchs de                    *)
(* soccer de la coupe du monde en utilisant des données ouvertes     *)
(*********************************************************************)
(*********************************************************************)
(* Signature du système de match de soccer                           *)
(*********************************************************************)

module type SYSSMATCHS = sig

    exception Err of string

    type smatch = {
        annee_coupe_monde : string;
        id_smatch : string;
        equipe1 : string;
        equipe2 : string;
        score_equipe1 : string;
        score_equipe2 : string;
        numero_smatch : string;
        date_smatch : string;
        stade_smatch : string;
        pays_organisateur: string;
     }

    type smatchs_coupe_monde = smatch list


    val creer_smatch : string list -> smatch

    val ajouter_smatch : string list -> unit

    val ajouter_liste_smatchs : string list list -> unit

    val charger_donnees : string -> unit

    val retourner_donnees : unit -> smatchs_coupe_monde list

    val smatch_existe : smatch -> bool

    val retourner_nbr_smatchs : unit -> int

    val retourner_smatch : string * string -> smatch

    val supprimer_smatch : string * string -> unit

    val supprimer_liste_smatchs : (string * string) list -> unit

    val afficher_smatch : smatch -> unit

    val afficher_smatchs_coupe_monde : smatchs_coupe_monde -> unit

    val retourner_smatchs_coupe_monde : string -> smatchs_coupe_monde

    val retourner_resultats_equipe_cm : string -> string -> smatchs_coupe_monde

    val retourner_resultats_equipe_cms : string -> smatchs_coupe_monde

    val lancer_systeme_smatchs : string -> unit

end
