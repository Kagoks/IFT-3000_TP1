(*********************************************************************)
(* Langages de Programmation: IFT 3000 NRC 54909                     *)
(* TP1 ÉTÉ 2018. Date limite: mercredi 13 juin à 17h                 *)
(* Implanter un système de recherche des matchs des                  *)
(* coupes du monde de soccer en utilisant des données ouvertes       *)
(*********************************************************************)
(*********************************************************************)
(* Étudiant(e):                                                      *)
(* NOM: LEVESQUE____________ PRÉNOM: KEVIN_______________________ *)
(* MATRICULE: 111 165 605___ PROGRAMME: BACCALAURÉAT EN INFORMATIQUE *)
(*                                                                   *)
(*********************************************************************)

#load "str.cma";;  (* Charger le module Str *)
#load "unix.cma";; (* Charger le module Unix *)

(* Charger la signature du système de matchs des coupes du monde de soccer*)
#use "TP1-SIG-E2018.mli";;

(********************************************************************)
(* Implantation du système en utilisant un map,                     *)
(* les listes et les enregistrements                     	    *)
(********************************************************************)

(* Module permettant d'utiliser un map dont les clés sont des paires de chaînes de caractères *)
module PaireCles =
    struct
       type t = string * string
       (* Les clés dans le map doivent être ordonnées (donc comparables) *)
       let compare (x0,y0) (x1,y1) =
           match String.compare x0 x1 with
             | 0 -> String.compare y0 y1
             | c -> c
     end

(* Map utilisant un arbre binaire de recherche *)
module SMatchsMap = Map.Make(PaireCles);;

(* Module du TP *)

module SysSMatchs: SYSSMATCHS = struct

  open List
  open Str

(* *****************************************************************)
(* Déclarations d'exceptions et de types *)
(* *****************************************************************)

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

(******************************************************************)
(* Fonctions fournies (vous pouvez en ajouter au besoin ...)      *)
(* ****************************************************************)

(* Fonctions manipulant les listes, les chaînes de caractères et/ou les fichiers *)

  (* appartient : 'a -> 'a list -> bool                   *)
  (* Retourner si un élément existe ou non dans une liste *)

  let appartient e l = exists (fun x -> x = e) l

  (* enlever : 'a -> 'a list -> 'a list *)
  (* Enlever un élément dans une liste  *)

  let enlever e l =
    let (l1, l2) = partition (fun x -> x = e) l
    in l2

  (* remplacer : 'a -> 'a -> 'a list -> 'a list       *)
  (* Remplacer un élément par un autre dans une liste *)

  let remplacer e e' l =
    map (fun x -> (if (x = e) then e' else x)) l

  (* uniques : string list -> string list                         *)
  (* Retourner une liste ne contenant que des éléments uniques    *)
  (* Les chaînes vides sont également enlevées de la liste        *)
  (* ainsi que les espaces inutiles avant et/ou après les chaînes *)

  let uniques liste =
    let res = ref [] in
    let rec fct l = match l with
     | [] -> !res
     | x::xs -> if (not (mem x !res) && (x <> "")) then res := (!res)@[String.trim x]; fct xs
    in fct liste

  (* decouper_chaine : string -> string -> string list                          *)
  (* Retourner une liste en découpant une chaîne selon un séparateur (p.ex ",") *)

  let decouper_chaine chaine separateur = split (regexp separateur) chaine

  (* timeRun : ('a -> 'b) -> 'a -> 'b * float                                     *)
  (* Permet  d'estimer la durée d'exécution d'une fonction passée en argument;    *)
  (* Elle prend en argument la fonction à évaluer et un paramètre, et retourne le *)
  (* résultat de cette application ainsi que la durée de cette application        *)


  let timeRun f x =
    let	time1 = Unix.gettimeofday() in
    let r = f x in
    let time2 = Unix.gettimeofday() in
    (r,time2 -. time1)



  (* read_line : in_channel -> string                        *)
  (* Permet de lire une ligne dans un fichier                *)
  (* Elle retourne une chaîne vide si le fichier est terminé *)

   let lire_ligne ic =
     try
       input_line ic (* Lire une ligne *)
     with End_of_file -> ""

   (* lire_fichier : in_channel -> string -> string list list                     *)
   (* Lire un fichier CSV et retourne une lite de listes de chaînes de caractères *)
   (* en spécifiant le séparateur qu'il faut utiliser pour délimiter les chaînes  *)

   let rec lire_fichier (flux:in_channel) (separateur:string) =
       let ligne =lire_ligne flux in
       match ligne with
	 | "" -> []
	 | s -> (decouper_chaine (String.trim s) separateur)::(lire_fichier flux separateur)

(* Fonctions manipulant les matchs de soccer du système dans un map *)

  (* creer_smatch : string list ->smatch                                     *)
  (* Retourner un match de soccer selon une liste de chaînes de caractères   *)

  let creer_smatch (lch:string list) =
     if (length lch) < 15 then raise (Err "La longueur de la liste est incorrecte") else
     {
      annee_coupe_monde = String.sub (nth lch 0) 0 4;
      id_smatch = nth lch 1;
      equipe1 = nth lch 2;
      equipe2 = nth lch 3;
      score_equipe1 = nth lch 4;
      score_equipe2 = nth lch 5;
      numero_smatch = nth lch 6;
      date_smatch = nth lch 8;
      stade_smatch = nth lch 10;
      pays_organisateur = nth lch 14;
     }

   (* Permettant d'instancier un map (une référence) ainsi que les types de ses données *)
   (* Chaque clè (annee_coupe_monde * id_smatch) va être associée à un match de soccer *)

   let m = ref (SMatchsMap.empty)
   let _ = m := SMatchsMap.add ("","") (creer_smatch ["2018";"";"";"";"";"";"";"";"";"";"";"";"";"";""]) !m;
          m := SMatchsMap.remove ("","") !m

   (* ajouter_smatch : string list -> unit              *)
   (* Permet d'ajouter un match de soccer dans le map   *)
   (* en utilisant une liste de chaînes de caractères   *)

   let ajouter_smatch (lch: string list) =
       m := SMatchsMap.add (String.sub (nth lch 0) 0 4,nth lch 1) (creer_smatch lch) !m

   (* ajouter_liste_smatchs : string list list -> unit          *)
   (* Permet d'ajouter une liste de matchs de soccer            *)
   (* en utilisant une liste de listes de chaînes de caractères *)

   let ajouter_liste_smatchs (llch: string list list) =
       iter (fun lch -> ajouter_smatch lch) llch

   (* charger_donnees : string -> unit          *)
   (* Permet de charger les données dans le map *)

   let charger_donnees (fichier:string) =
       let ic =  try open_in fichier with _ -> raise (Err "Fichier inacessible") in
       let _ = input_line ic in (* ignorer la première ligne *)
       let liste_lignes = lire_fichier ic "," in
       close_in ic; m := SMatchsMap.empty; ajouter_liste_smatchs liste_lignes

   (* retourner_donnees : unit -> smatchs_coupe_monde list *)
   (* Permet de retourner les données sous la forme de listes à partir du map *)

   let retourner_donnees (): smatchs_coupe_monde list =
       let li = SMatchsMap.bindings !m in
       let lp = uniques(map (fun (k,i) -> fst k) li) in
       map (fun p -> SMatchsMap.fold (fun _ i acc -> i::acc)
           (SMatchsMap.filter (fun (x,y) ind -> x = p) !m) []) lp

   (* smatch_existe : smatch -> bool         *)
   (* Retourner si un match de soccer existe dans le map  *)

   let smatch_existe (ind:smatch)  =
       SMatchsMap.exists (fun k d -> d = ind) !m

   (* retourner_nbr_smatchs : unit -> int *)
   (* Retourner le nombre de matchs de soccer dans le map *)

   let retourner_nbr_smatchs () =
       SMatchsMap.cardinal !m

(******************************************************************)
(* Fonctions à implanter				          *)
(* ****************************************************************)

   (* retourner_smatch : string * string -> smatch *)
   (* Permet de retourner un match de soccer se trouvant dans le map *)
   (* lance l'exeption Notfound si le match n'existe pas *)
   let retourner_smatch (cle:string*string) = 
      SMatchsMap.find cle !m

   (* supprimer_smatch : string * string -> unit *)
   (* Permet de supprimer un match de soccer dans le map (ne doit rien faire si le match n'existe pas) *)
   let supprimer_smatch (cle:string*string) =
      m := SMatchsMap.remove cle !m

   (* supprimer_liste_smatchs : (string * string) list -> unit *)
   (* Permet de supprimer une liste des matchs de soccer dans le map *)
   let supprimer_liste_smatchs (lcles:(string*string) list) =
      iter (fun cle -> supprimer_smatch cle) lcles
      

   (* afficher_smatch : smatch -> unit                     *)
   (* Permet d'afficher un match de soccer selon un certain formatage   *)
   let afficher_smatch (sm:smatch) =
      print_string ("Code du match: " ^ sm.id_smatch ^ ".");
      print_newline ();
      print_string ("Coupe du monde: " ^ sm.pays_organisateur ^ " " ^ sm.annee_coupe_monde ^ ".");
      print_newline ();
      print_string ("Equipes et resultats: " ^ sm.equipe1 ^ " " ^ sm.score_equipe1 ^ " - " ^ sm.score_equipe2 ^ " " ^ sm.equipe2 ^ ".");
      print_newline ();
      print_string ("Date: " ^ sm.date_smatch ^ ".");
      print_newline ();
      print_string ("Stade: " ^ sm.stade_smatch ^ ".");
      print_newline ();
      print_newline ()
      

   (* val afficher_smatchs_coupe_monde : smatchs_coupe_monde -> unit *)
   (* Permet d'afficher une liste de matches de soccer d'une coupe du monde *)
   let afficher_smatchs_coupe_monde (mcp:smatchs_coupe_monde) =
      iter (fun smatch -> afficher_smatch smatch) mcp

   (* retourner_smatchs_coupe_monde : string -> smatchs_coupe_monde  *)
   (* Permet de retourner les données d'une coupe du monde spécifique   *)
   (* sous la forme de liste de smatch à partir du map      *)
   let retourner_smatchs_coupe_monde (acp:string) : smatchs_coupe_monde =
    rev (SMatchsMap.fold 
          (fun (_,i) acc -> i::acc) 
          (SMatchsMap.filter (fun (x,y) smatch -> smatch.annee_coupe_monde = acp) !m) 
          [])

   (* retourner_resultats_equipe_cm : string -> string -> smatchs_coupe_monde  *)
   (* Permet de retourner les résultat d'une équipe dans une coupe du monde   *)
   (* sous la forme de liste de smatch à partir du map      *)
   let retourner_resultats_equipe_cm (eq:string) (acm:string) : smatchs_coupe_monde =
    rev (SMatchsMap.fold 
          (fun _ i acc -> i::acc) 
          (SMatchsMap.filter (fun (x,y) smatch ->  smatch.annee_coupe_monde = acm && (smatch.equipe1 = eq || smatch.equipe2 = eq)) !m) 
          [])

   (* retourner_resultats_equipe_cms : string -> smatchs_coupe_monde  *)
   (* Permet de retourner les résultat d'une équipe dans toutes les coupes du monde   *)
   (* sous la forme de liste de smatch à partir du map      *)
   let retourner_resultats_equipe_cms (eq:string) : smatchs_coupe_monde =
    rev (SMatchsMap.fold 
        (fun _ i acc -> i::acc) 
        (SMatchsMap.filter (fun (x,y) smatch -> smatch.equipe1 = eq || smatch.equipe2 = eq) !m) 
        [])

   (* lancer_systeme_smatchs : string -> unit                                     *)
   (* Lancer le système de matchs afin de trouver les matchs qui nous intéressent *)
   let lancer_systeme_smatchs (fichier:string) =
    print_newline (); 
    print_newline (); 
    print_string "---------------------------------------------";
    print_newline (); 
    print_string "Outil de recherche de matchs de soccer de coupe du monde";
    print_newline ();    
    print_string "Chargement des donnees en cours ...";
    print_newline ();    

    let temps = timeRun charger_donnees fichier in
    print_string ("Chargement termine dans un temps de: " ^ (fun (_,y) -> string_of_float y) temps ^ " secondes. \n");
    
    print_string "Veuillez entrer le nom de l'equipe qui vous interesse: \n";

    let equipe = read_line () in     
    let () = print_newline () in
    let () = print_string "Entrer 1 si vous voulez afficher les resultats d'une coupe du monde ou 2 pour toutes les coupes du monde ? : \n" in
    let choix = read_int () in
    let () = print_newline () in
    let matchs = (match choix with 
                  | 1 -> let () = print_string "Veuillez entrer l'annee de la coupe du monde qui vous interessee: \n" in
                         let annee = read_line () in    
                         retourner_resultats_equipe_cm equipe annee
                  | 2 -> retourner_resultats_equipe_cms equipe
                  | _ -> raise (Err "Choix invalide")) in
    let () = print_string ("Nombre de matchs trouves = " ^ string_of_int (length matchs) ^ "\n\n") in
    afficher_smatchs_coupe_monde matchs;

    print_string "Merci est au revoir!";
    print_newline ();
    print_string "---------------------------------------------";
    print_newline ();
    print_newline ()

end
