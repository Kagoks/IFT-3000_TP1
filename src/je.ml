(***************************************************************************)
(* Jeu d'essai - TP1 - ÉTÉ 2018                                            *)
(***************************************************************************)

(* Pour changer ou obtenir le répertoire courant
Sys.getcwd ();;
Sys.chdir;;
*)

(* Pour afficher les listes avec plus de «profondeurs»:
#print_depth 1000;;
#print_length 1000;;
*)

(* On charge le fichier ml du Tp après avoir implanté
les fonctions demandées pour realiser les tests  *)

#use "TP1-E2018.ml";;

(* Résultat:
module type SYSSMATCHS =
  sig
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
      pays_organisateur : string;
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
    val retourner_resultats_equipe_cm :
      string -> string -> smatchs_coupe_monde
    val retourner_resultats_equipe_cms : string -> smatchs_coupe_monde
    val lancer_systeme_smatchs : string -> unit
  end
module PaireCles :
  sig
    type t = string * string
    val compare : String.t * String.t -> String.t * String.t -> int
  end
module SMatchsMap :
  sig
    type key = PaireCles.t
    type 'a t = 'a Map.Make(PaireCles).t
    val empty : 'a t
    val is_empty : 'a t -> bool
    val mem : key -> 'a t -> bool
    val add : key -> 'a -> 'a t -> 'a t
    val singleton : key -> 'a -> 'a t
    val remove : key -> 'a t -> 'a t
    val merge :
      (key -> 'a option -> 'b option -> 'c option) -> 'a t -> 'b t -> 'c t
    val compare : ('a -> 'a -> int) -> 'a t -> 'a t -> int
    val equal : ('a -> 'a -> bool) -> 'a t -> 'a t -> bool
    val iter : (key -> 'a -> unit) -> 'a t -> unit
    val fold : (key -> 'a -> 'b -> 'b) -> 'a t -> 'b -> 'b
    val for_all : (key -> 'a -> bool) -> 'a t -> bool
    val exists : (key -> 'a -> bool) -> 'a t -> bool
    val filter : (key -> 'a -> bool) -> 'a t -> 'a t
    val partition : (key -> 'a -> bool) -> 'a t -> 'a t * 'a t
    val cardinal : 'a t -> int
    val bindings : 'a t -> (key * 'a) list
    val min_binding : 'a t -> key * 'a
    val max_binding : 'a t -> key * 'a
    val choose : 'a t -> key * 'a
    val split : key -> 'a t -> 'a t * 'a option * 'a t
    val find : key -> 'a t -> 'a
    val map : ('a -> 'b) -> 'a t -> 'b t
    val mapi : (key -> 'a -> 'b) -> 'a t -> 'b t
  end
module SysSMatchs : SYSSMATCHS
*)

(* On ouvre le module disposant de fonctions pertinentes pour nos tests *)
open SysSMatchs;;

(* On exécute maintenant les fonctions une à une *)

let match1 = creer_smatch ["2010 FIFA World Cup South Africa™";
                         "300061454";"South Africa";"Mexico";
                         "1";"1";"1";"1";"11/06/2010";"";
                         "Johannesburg Soccer City Stadium";"";"";"2010";"South Africa"];;
(* Résultat:
val match1 : SysSMatchs.smatch =
  {annee_coupe_monde = "2010"; id_smatch = "300061454";
   equipe1 = "South Africa"; equipe2 = "Mexico"; score_equipe1 = 1;
   score_equipe2 = 1; numero_smatch = 1; date_smatch = "11/06/2010";
   stade_smatch = "Johannesburg Soccer City Stadium";
   pays_organisateur = "South Africa"}
*)

let match2 = creer_smatch ["1998 FIFA World Cup France ™";"4000";
                             "Brazil";"Scotland";"2";"1";"1";"1";"10 June 1998"
                             ;"17:30";"Saint-Denis/Stade de France";
                             "80000"; "Group matches";"1998"; "France"];;
(* Résultat:
val match2 : SysSMatchs.smatch =
  {annee_coupe_monde = "1998"; id_smatch = "4000"; equipe1 = "Brazil";
   equipe2 = "Scotland"; score_equipe1 = 2; score_equipe2 = 1;
   numero_smatch = 1; date_smatch = "10 June 1998";
   stade_smatch = "Saint-Denis/Stade de France";
   pays_organisateur = "France"}
*)

let _ = charger_donnees "data.csv";;

(* Résultat:
- : unit = ()
*)

let mt = retourner_smatch ("2014","81572545");;

(* Résultat:
val mt : SysSMatchs.smatch =
  {annee_coupe_monde = "2014"; id_smatch = "81572545"; equipe1 = "Colombia";
   equipe2 = "Cote d'Ivoire"; score_equipe1 = "2"; score_equipe2 = "1";
   numero_smatch = "21"; date_smatch = "19/06/2014";
   stade_smatch = "Estadio Nacional Mane Garrincha";
   pays_organisateur = "Brazil"}
*)

let _ = supprimer_smatch ("1998","8752");;

(* Résultat:
- : unit = ()
*)

let _ = supprimer_liste_smatchs [("1990","159");("1978","2388")];;

(* Résultat:
- : unit = ()
*)

afficher_smatch match1;;

(* Résultat:
Code du match: 300061454.
Coupe du monde: South Africa 2010.
Equipes et resultats: South Africa 1 - 1 Mexico.
Date: 11/06/2010.
Stade: Johannesburg Soccer City Stadium.
- : unit = ()
*)

afficher_smatchs_coupe_monde [match1;match2];;

(* Résultat:
Code du match: 300061454.
Coupe du monde: South Africa 2010.
Equipes et resultats: South Africa 1 - 1 Mexico.
Date: 11/06/2010.
Stade: Johannesburg Soccer City Stadium.

Code du match: 4000.
Coupe du monde: France 1998.
Equipes et resultats: Brazil 2 - 1 Scotland.
Date: 10 June 1998.
Stade: Saint-Denis/Stade de France.

- : unit = ()
*)

let lmcp = retourner_smatchs_coupe_monde "2018";;

(* Résultat:
let lmcp = retourner_smatchs_coupe_monde "2018";;
val lmcp : SysSMatchs.smatchs_coupe_monde =
  [{annee_coupe_monde = "2018"; id_smatch = "37195411"; equipe1 = "Russia";
    equipe2 = "Saudi Arabia"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "1"; date_smatch = "14/06/2018";
    stade_smatch = "Luzhniki Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195412"; equipe1 = "Egypt";
    equipe2 = "Uruguay"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "2"; date_smatch = "15/06/2018";
    stade_smatch = "Ekaterinburg Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195413"; equipe1 = "Morocco";
    equipe2 = "Iran"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "3"; date_smatch = "15/06/2018";
    stade_smatch = "Saint Petersburg Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195414"; equipe1 = "Portugal";
    equipe2 = "Spain"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "4"; date_smatch = "15/06/2018";
    stade_smatch = "Fisht Stadium Sochi"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195415"; equipe1 = "France";
    equipe2 = "Australia"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "5"; date_smatch = "16/06/2018";
    stade_smatch = "Kazan Arena"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195416";
    equipe1 = "Argentina"; equipe2 = "Iceland"; score_equipe1 = "";
    score_equipe2 = ""; numero_smatch = "6"; date_smatch = "16/06/2018";
    stade_smatch = "Otkrytiye Arena Moscow"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195417"; equipe1 = "Peru";
    equipe2 = "Denmark"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "7"; date_smatch = "16/06/2018";
    stade_smatch = "Saransk Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195418"; equipe1 = "Croatia";
    equipe2 = "Nigeria"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "8"; date_smatch = "16/06/2018";
    stade_smatch = "Kaliningrad Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195419";
    equipe1 = "Costa Rica"; equipe2 = "Serbia"; score_equipe1 = "";
    score_equipe2 = ""; numero_smatch = "9"; date_smatch = "17/06/2018";
    stade_smatch = "Samara Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195420"; equipe1 = "Germany";
    equipe2 = "Mexico"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "10"; date_smatch = "17/06/2018";
    stade_smatch = "Luzhniki Stadium Moscow"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195421"; equipe1 = "Brazil";
    equipe2 = "Switzerland"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "11"; date_smatch = "17/06/2018";
    stade_smatch = "Rostov-on-Don Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195422"; equipe1 = "Sweden";
    equipe2 = "Korea Republic"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "12"; date_smatch = "18/06/2018";
    stade_smatch = "Nizhny Novgorod Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195423"; equipe1 = "Belgium";
    equipe2 = "Panama"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "13"; date_smatch = "18/06/2018";
    stade_smatch = "Fisht Stadium Sochi"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195424"; equipe1 = "Tunisia";
    equipe2 = "England"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "14"; date_smatch = "18/06/2018";
    stade_smatch = "Volgograd Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195425"; equipe1 = "Colombia";
    equipe2 = "Japan"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "15"; date_smatch = "19/06/2018";
    stade_smatch = "Saransk Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195426"; equipe1 = "Poland";
    equipe2 = "Senegal"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "16"; date_smatch = "19/06/2018";
    stade_smatch = "Otkrytiye Arena Moscow"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195427"; equipe1 = "Russia";
    equipe2 = "Egypt"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "17"; date_smatch = "19/06/2018";
    stade_smatch = "Saint Petersburg Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195428"; equipe1 = "Portugal";
    equipe2 = "Morocco"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "18"; date_smatch = "20/06/2018";
    stade_smatch = "Luzhniki Stadium Moscow"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195429"; equipe1 = "Uruguay";
    equipe2 = "Saudi Arabia"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "19"; date_smatch = "20/06/2018";
    stade_smatch = "Rostov-on-Don Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195430"; equipe1 = "Iran";
    equipe2 = "Spain"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "20"; date_smatch = "20/06/2018";
    stade_smatch = "Kazan Arena"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195431"; equipe1 = "Denmark";
    equipe2 = "Australia"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "21"; date_smatch = "21/06/2018";
    stade_smatch = "Samara Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195432"; equipe1 = "France";
    equipe2 = "Peru"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "22"; date_smatch = "21/06/2018";
    stade_smatch = "Ekaterinburg Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195433";
    equipe1 = "Argentina"; equipe2 = "Croatia"; score_equipe1 = "";
    score_equipe2 = ""; numero_smatch = "23"; date_smatch = "21/06/2018";
    stade_smatch = "Nizhny Novgorod Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195434"; equipe1 = "Brazil";
    equipe2 = "Costa Rica"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "24"; date_smatch = "22/06/2018";
    stade_smatch = "Saint Petersburg Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195435"; equipe1 = "Nigeria";
    equipe2 = "Iceland"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "25"; date_smatch = "22/06/2018";
    stade_smatch = "Volgograd Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195436"; equipe1 = "Serbia";
    equipe2 = "Switzerland"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "26"; date_smatch = "22/06/2018";
    stade_smatch = "Kaliningrad Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195437"; equipe1 = "Belgium";
    equipe2 = "Tunisia"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "27"; date_smatch = "23/06/2018";
    stade_smatch = "Otkrytiye Arena Moscow"; pays_organisateur = "Russia"};
   {annee_coupe_monde = ...; id_smatch = ...; equipe1 = ...; equipe2 = ...;
    score_equipe1 = ...; score_equipe2 = ...; numero_smatch = ...;
    date_smatch = ...; stade_smatch = ...; pays_organisateur = ...};
   ...]
*)

let lmcp = retourner_resultats_equipe_cm "Canada" "1986";;

(* Résultat:
val lmcp : SysSMatchs.smatchs_coupe_monde =
  [{annee_coupe_monde = "1986"; id_smatch = "468"; equipe1 = "Canada";
    equipe2 = "France"; score_equipe1 = "0"; score_equipe2 = "1";
    numero_smatch = "2"; date_smatch = "01 June 1986";
    stade_smatch = "Leon  / Nou Camp - Estadio Leon";
    pays_organisateur = "Mexico"};
   {annee_coupe_monde = "1986"; id_smatch = "475"; equipe1 = "Hungary";
    equipe2 = "Canada"; score_equipe1 = "2"; score_equipe2 = "0";
    numero_smatch = "16"; date_smatch = "06 June 1986";
    stade_smatch = "Irapuato  / Estadio Irapuato";
    pays_organisateur = "Mexico"};
   {annee_coupe_monde = "1986"; id_smatch = "476"; equipe1 = "Soviet Union";
    equipe2 = "Canada"; score_equipe1 = "2"; score_equipe2 = "0";
    numero_smatch = "26"; date_smatch = "09 June 1986";
    stade_smatch = "Irapuato  / Estadio Irapuato";
    pays_organisateur = "Mexico"}]
*)

let lmcp = retourner_resultats_equipe_cms "Tunisia";;

(* Résultat:
val lmcp : SysSMatchs.smatchs_coupe_monde =
  [{annee_coupe_monde = "1978"; id_smatch = "2352"; equipe1 = "Germany FR";
    equipe2 = "Tunisia"; score_equipe1 = "0"; score_equipe2 = "0";
    numero_smatch = "20"; date_smatch = "10 June 1978";
    stade_smatch = "Cordoba  / Estadio Olimpico Chateau Carreras";
    pays_organisateur = "Argentina"};
   {annee_coupe_monde = "1978"; id_smatch = "2433"; equipe1 = "Tunisia";
    equipe2 = "Mexico"; score_equipe1 = "3"; score_equipe2 = "1";
    numero_smatch = "4"; date_smatch = "02 June 1978";
    stade_smatch = "Rosario  / Arroyito - Estadio Dr. Lisandro de la Torre";
    pays_organisateur = "Argentina"};
   {annee_coupe_monde = "1978"; id_smatch = "2454"; equipe1 = "Poland";
    equipe2 = "Tunisia"; score_equipe1 = "1"; score_equipe2 = "0";
    numero_smatch = "11"; date_smatch = "06 June 1978";
    stade_smatch = "Rosario  / Arroyito - Estadio Dr. Lisandro de la Torre";
    pays_organisateur = "Argentina"};
   {annee_coupe_monde = "1998"; id_smatch = "8740"; equipe1 = "England";
    equipe2 = "Tunisia"; score_equipe1 = "2"; score_equipe2 = "0";
    numero_smatch = "16"; date_smatch = "15 June 1998";
    stade_smatch = "Marseilles  / Stade Velodrome";
    pays_organisateur = "France"};
   {annee_coupe_monde = "1998"; id_smatch = "8755"; equipe1 = "Colombia";
    equipe2 = "Tunisia"; score_equipe1 = "1"; score_equipe2 = "0";
    numero_smatch = "31"; date_smatch = "22 June 1998";
    stade_smatch = "Montpellier  / La Mosson"; pays_organisateur = "France"};
   {annee_coupe_monde = "1998"; id_smatch = "8769"; equipe1 = "Romania";
    equipe2 = "Tunisia"; score_equipe1 = "1"; score_equipe2 = "1";
    numero_smatch = "45"; date_smatch = "26 June 1998";
    stade_smatch = "Saint-Denis  / Stade de France";
    pays_organisateur = "France"};
   {annee_coupe_monde = "2002"; id_smatch = "43950015"; equipe1 = "Russia";
    equipe2 = "Tunisia"; score_equipe1 = "2"; score_equipe2 = "0";
    numero_smatch = "15"; date_smatch = "05 June 2002";
    stade_smatch = "Kobe  / Kobe Wing Stadium";
    pays_organisateur = "Korea/Japan"};
   {annee_coupe_monde = "2002"; id_smatch = "43950031"; equipe1 = "Tunisia";
    equipe2 = "Belgium"; score_equipe1 = "1"; score_equipe2 = "1";
    numero_smatch = "31"; date_smatch = "10 June 2002";
    stade_smatch = "Oita  / Oita Stadium Big Eye";
    pays_organisateur = "Korea/Japan"};
   {annee_coupe_monde = "2002"; id_smatch = "43950045"; equipe1 = "Tunisia";
    equipe2 = "Japan"; score_equipe1 = "0"; score_equipe2 = "2";
    numero_smatch = "45"; date_smatch = "14 June 2002";
    stade_smatch = "Osaka  / Osaka Nagai Stadium";
    pays_organisateur = "Korea/Japan"};
   {annee_coupe_monde = "2006"; id_smatch = "97410016"; equipe1 = "Tunisia";
    equipe2 = "Saudi Arabia"; score_equipe1 = "2"; score_equipe2 = "2";
    numero_smatch = "16"; date_smatch = "14 June 2006";
    stade_smatch = "Munich  / Allianz Arena"; pays_organisateur = "Germany"};
   {annee_coupe_monde = "2006"; id_smatch = "97410031"; equipe1 = "Spain";
    equipe2 = "Tunisia"; score_equipe1 = "3"; score_equipe2 = "1";
    numero_smatch = "31"; date_smatch = "19 June 2006";
    stade_smatch = "Stuttgart  / Gottlieb-Daimler-Stadion";
    pays_organisateur = "Germany"};
   {annee_coupe_monde = "2006"; id_smatch = "97410048"; equipe1 = "Ukraine";
    equipe2 = "Tunisia"; score_equipe1 = "1"; score_equipe2 = "0";
    numero_smatch = "48"; date_smatch = "23 June 2006";
    stade_smatch = "Berlin  / Olympiastadion"; pays_organisateur = "Germany"};
   {annee_coupe_monde = "2018"; id_smatch = "37195424"; equipe1 = "Tunisia";
    equipe2 = "England"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "14"; date_smatch = "18/06/2018";
    stade_smatch = "Volgograd Stadium"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195437"; equipe1 = "Belgium";
    equipe2 = "Tunisia"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "27"; date_smatch = "23/06/2018";
    stade_smatch = "Otkrytiye Arena Moscow"; pays_organisateur = "Russia"};
   {annee_coupe_monde = "2018"; id_smatch = "37195457"; equipe1 = "Panama";
    equipe2 = "Tunisia"; score_equipe1 = ""; score_equipe2 = "";
    numero_smatch = "47"; date_smatch = "28/06/2018";
    stade_smatch = "Saransk Stadium"; pays_organisateur = "Russia"}]
*)

let _ = lancer_systeme_smatchs "data.csv";;

(* Résultat:
Outil de recherche de matchs de soccer de coupe du monde
Chargement des donnees en cours ...
Chargement termine dans un temps de: 0.0880045890808 secondes
Veuillez entrer le nom de l'equipe qui vous interesse:
Brazil
;;
Entrer 1 si vous voulez afficher les resultats d'une coupe du monde ou 2 pour toutes les coupes du monde ?:
1
;;
Veuillez entrer l'annee de la coupe du monde qui vous interessee:
2002
;;
Nombre de matchs trouves = 7

Code du match: 43950010.
Coupe du monde: Korea/Japan 2002.
Equipes et resultats: Brazil 2 - 1 Turkey.
Date: 03 June 2002.
Stade: Ulsan  / Munsu Football Stadium.

Code du match: 43950026.
Coupe du monde: Korea/Japan 2002.
Equipes et resultats: Brazil 4 - 0 China PR.
Date: 08 June 2002.
Stade: Jeju  / Jeju World Cup Stadium.

Code du match: 43950041.
Coupe du monde: Korea/Japan 2002.
Equipes et resultats: Costa Rica 2 - 5 Brazil.
Date: 13 June 2002.
Stade: Suwon  / Suwon World Cup Stadium.

Code du match: 43950054.
Coupe du monde: Korea/Japan 2002.
Equipes et resultats: Brazil 2 - 0 Belgium.
Date: 17 June 2002.
Stade: Kobe  / Home's Stadium.

Code du match: 43950057.
Coupe du monde: Korea/Japan 2002.
Equipes et resultats: England 1 - 2 Brazil.
Date: 21 June 2002.
Stade: Shizuoka  / Shizuoka Stadium Ecopa.

Code du match: 43950062.
Coupe du monde: Korea/Japan 2002.
Equipes et resultats: Brazil 1 - 0 Turkey.
Date: 26 June 2002.
Stade: Saitama  / Saitama Stadium 2002.

Code du match: 43950064.
Coupe du monde: Korea/Japan 2002.
Equipes et resultats: Germany 0 - 2 Brazil.
Date: 30 June 2002.
Stade: Yokohama  / International Stadium Yokohama.


Merci est au revoir!- : unit = ()
*)

(************************************************)
(* Verification de certains  messages d'erreurs *)
(************************************************)

try
  ignore (creer_smatch [""])
with
  Err s -> print_endline s;;

(* Résultat:
La longueur de la liste est incorrecte
- : unit = ()
*)

try
  ignore (charger_donnees "existe_pas.cvs")
with
  Err s -> print_endline s;;

(* Résultat:
Fichier inacessible
- : unit = ()
*)

try
  ignore (retourner_smatch ("",""))
with
  Not_found -> print_endline "Le match n'existe pas";;

(* Résultat:
Le match n'existe pas
- : unit = ()
*)
