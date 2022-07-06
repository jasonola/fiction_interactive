VAR peur = 0
VAR batterie_tel = 5
VAR lumiere_ecurie = false
VAR cle = false
VAR code = false
VAR alarme = false
VAR essai = 0 

La grange abandonnée

Il est minuit, après une soirée un peu arrosée vous décidez de rentrer à pied en passant par la forêt. 
Après une heure de marche vous vous rendez compte que vous êtes perdus et vous finissez par tomber sur une énorme grange au milieu de nulle part. La grange vous semble abandonnée et vous décidez d'aller y jeter un coup d'oeil.

-> place_grange

=== place_grange ===

{
    -alarme == false :
    Vous êtes sur la place de la grange, la grange est grande, une écurie sur la droite et une serre plus loin sur la gauche
    + Vous allez dans l'écurie
        -> ecurie
    + Vous allez à la porte d'entrée de la grange
        -> porte_grange
    + Vous allez en direction de la serre
        -> porte_serre
    + Vous ne vous occupez pas de la grange et rebroussez chemin.
        -> fin
    + Montrez les variables vitales
    {show_stats()}
        ->place_grange
    -alarme == true : 
    Vous êtes sur la place de la grange, l'alarme retenti toujours, vous vous sentez observé. 
        + Vous allez dans l'écurie
        -> ecurie
    + Vous allez à la porte d'entrée de la grange
        -> porte_grange
    + Vous allez en direction de la serre
        Plusieurs personnes armées sont aux aguets, ils vous reperent et vous arrêtent.
        -> fin_capture
    + Vous ne vous occupez pas de la grange et rebroussez chemin.
        Une personne vous attend à la sortie, elle vous menace avec son arme et vous capture.
        -> fin_capture
    + Montrez les variables vitales
    {show_stats()}
        ->place_grange
}
        
=== porte_grange ===
    Vous arrivez à la porte d'entrée, c'est une porte sobre avec des vitres, à droite au sol il y a un pot.
    + Vous essayez d'entrer
    {
        -cle == true:
        vous utilisez la clé pour entrer 
        -> entree_grange
        -else:
        la porte est verrouillée
        * Vous défoncez la porte
        ~alarme = true
            Une alarme retentit
            ~peur += 10
            ++ Vous entrez
                -> entree_grange
            ++ Vous rebroussez chemin
                -> place_grange
        -> entree_grange
        + Vous continuez d'inspecter
        -> porte_grange
    }
    + Vous regardez par la fenêtre
    {
        -TURNS_SINCE(-> ecurie_illum) >= 6 || alarme == true :
        Il y a 2 personnes à l'interieur du lobby de la grange, elles sont armés.
        ~peur += 10
        -else : 
        Il n'y a personne dans le lobby.
    }
        -> porte_grange
    * Vous inspectez le pot
        La plante dans le pot est sechée, on distingue mal le type de plante mais l'odeur est particulière. Vous le soulevez et vous remarquez une clé. Vous la prenez.
        ~cle = true
        -> porte_grange
    + Vous retournez à la place de la grange
        -> place_grange
    
    
=== entree_grange ===
{
    -TURNS_SINCE(-> ecurie_illum) >= 6 || alarme == true :    
    Il y a 2 personnes armées qui vous regardent. Elles vous pointent l'arme dessus 
     -> fin_capture
    
    -else : 
    Le lobby est vide, une porte sur la gauche et une porte sur la droite. 
    + Vous entrez par la porte de droite
        -> cuisine
    + Vous entrez par la porte de gauche
        -> repere_squat
    + Vous ressortez de la grange
        -> place_grange
 }

=== ecurie ===
Vous entrez dans l'écurie, il fait sombre, vous entendez des bruits de mouvements.
{
    -lumiere_ecurie == true:
    Vous allumez la lumiere 
    -> ecurie_illum
    -batterie_tel > 0 && lumiere_ecurie == false:
     + Vous voulez éclairer
        Vous sortez votre telephone, il a {batterie_tel}% de batterie et vous allumez la lampe frontale. C'est une petite écurie, il y a 4 chevaux à l'interieur, une boite metalique à votre droite, des palettes, une porte menant à l'interieur de la grange.
    ~batterie_tel -=1 
        -> ecurie_illum
     + Vous n'éclairez pas
        ++ Entrez quand même
        -> ecurie_sombre
        ++ Rebrousser chemin
        -> place_grange
        - else :
    * Vous n'avez plus de batterie
        ++ Entrez quand même
        -> ecurie_sombre
        ++ Retournez à la place de la grange
        -> place_grange
        ++ Montrez les variables vitales
        {show_stats()}
        ->ecurie
}

=== ecurie_illum ===
 {
 -lumiere_ecurie == true : 
    + Il y a une porte au fond de l'écurie qui est maintenant visible.
        ++ Ouvrir la porte
         la porte mêne à une cuisine
        -> cuisine
        ++ Vous rebroussez chemin
        -> ecurie_illum
    }
    * Vous vous approchez des cheveaux 
        Les cheveaux vous fixent avec un regard d'une froideur à faire frissoner des pingouins, leurs yeux sont dilatés. Votre rythme cardiaque prend l'ascenseur.
        ~peur += 10
        -> ecurie_illum
    * Vous inspectez les palettes
        Vous ouvrez une pallette, sur le couvercle il y a une inscription : "420 Gang". Il y a des cadavres de corbeau à l'interieur, ils ont l'air fraichement abattus, ça vous fout la trouille vous refermez la boite en vitesse.
        ~peur += 5
        ~code = true 
        -> ecurie_illum
    + Vous inspectez la boite métalique
        Dans la boite il y a un interupteur, vous l'actionnez ?
        ++ Oui
        ~lumiere_ecurie = true
        ->ecurie_illum
        ++ Non
        ->ecurie_illum
        
   
    + Vous ressortez
        -> place_grange
        
=== ecurie_sombre ===
Il y a du bruit vers le fond de l'écurie. 
    + Longez le mur en tatonnant
        En touchant le mur vous sentez une inscription gravée dans le bois. c'est écrit "420 gang"
         ~code = true 
        -> ecurie_sombre
    + Aller vers le bruit
    Vous vous approchez du bruit, d'un coup vous prennez un coup de sabot dans le visage et vous vous évanouissez. Au reveil, quelqu'un se trouve au dessus de vous et vous êtes ligotés.
    -> fin_capture
    + Sortir de l'écurie
    -> place_grange

=== cuisine ===
Vous entrez dans la cuisine, il y a une porte qui amène au lobby, une porte qui amene à l'écurie, une table avec des choses dessus.
    + Vous allez au lobby
    -> entree_grange
    + Vous allez dans l'écurie
    -> ecurie
    + Vous inspectez la table
        En y regardant de plus près, vous distinguez de grandes quantités de cannabis, c'est beaucoup trop, il faudrait appeler la police. Vous savez que l'information que vous détenez est comprométante. Être vivant dans ce lobby sans vous faire remarquer est très improbable. Que faites-vous ?
    ~peur += 40 
{
    -batterie_tel > 2:
        **Appelez la police !
        Vous donnez les informations à la police. Ils vous disent de vous cacher et d'attendre les secours.
        ~batterie_tel -=2 
        -> fin_police
}
        ++  Vous retournez à la place de la grange.
        +++ passez par l'écurie
        -> ecurie
        +++ passez par le lobby
        -> entree_grange
        
        

=== porte_serre
Vous arrivez vers une serre, une odeur forte s'y dégage. Il y a une porte, elle est fermée mais à coté de la porte, il y a un dispositif nécessitant un code. Peut être sert-il à ouvrir la porte.
{
-code == true :
    *Vous entrez 420 
        la porte s'ouvre
        -> serre
}
+ Vous entrez un code au hasard
    ~essai +=1
    {
    -essai == 3 :
    ~alarme = true 
    une alarme retentit, vous retournez sur la place de la grange
    -> place_grange
    }
-> porte_serre
+ Vous retournez à la place de la grange
-> place_grange

=== serre ===
C'est donc ça l'odeur, c'est une plantation massive de cannabis. Tout s'explique, c'est bien illégal tout ça, il faudrait appeler la police. Vous savez que l'information que vous détenez est comprométante. Être vivant dans cette serre sans vous faire remarquer est très improbable. Que faites-vous ?
    ~peur += 40 
{
    -batterie_tel > 2:
    * Appelez la police !
    Vous donnez les informations à la police. Ils vous disent de vous cacher et d'attendre les secours.
    ~batterie_tel -=2 
    -> fin_police
}
+  Vous retournez à la place de la grange.
    -> place_grange


=== repere_squat ===
Vous débarquez dans une salle, il y a des gens armés qui vous tombent dessus, ils vous ligotent
-> fin_capture

=== function show_stats ===
    Batterie de tel : {batterie_tel}%
    Stats Peur : {peur}

=== fin ===
Stats Peur : {peur} 
{
    -peur == 0 :
    Vous quittez la grange sans être plus curieux que ça, dommage ça aurait pu être drôle. Peut être seriez vous plus courageux la prochaine fois ;)
    -> END
    -peur >= 20 :
    Vous avez eu une sacrée frousse, mais vous vous en êtes bien sorti. 
    -> END
    -peur >= 50 :
    Vous avez eu la frousse de votre vie. Bien joué de vous en être sorti.
    -> END
}

=== fin_capture ===
Vous vous êtes fait capturer, GAME OVER
-> END

=== fin_police ===
La police arrive, vous avez contribué à démanteler un réseau important de trafic de drogue. Bravo à vous.
-> END