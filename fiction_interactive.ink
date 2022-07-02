VAR peur = 0
VAR batterie_tel = 5
VAR lumiere_ecurie = false
VAR lumiere_serre = false
// champ de canabis, grange squattée pour des dealeurs de canabis

La grange abandonnée

Il est minuit, après une soirée un peu arrosée vous décidez de rentrer à pied en passant par la forêt. 
Après une heure de marche vous vous rendez compte que vous êtes perdus et vous finissez par tomber sur une énorme grange au milieu de nulle part. La grange vous semble abandonnée et vous décidez d'aller y jeter un coup d'oeil.

-> place_grange

=== place_grange ===


    Vous êtes sur la place de la grange, la grange est grande, 2 étages à première vue, une écurie sur la droite et une serre plus loin sur la gauche
    + Vous allez dans l'écurie
        -> ecurie
    + Vous allez à la porte d'entrée de la grange
        -> else_header
    + Vous allez en direction de la serre
        -> else_header
    + Montrez les variables vitales
    {show_stats()}
        ->place_grange

=== ecurie ===
Vous entrez dans l'écurie, il fait sombre, vous entendez des bruits de mouvements.
{
    -lumiere_ecurie == true:
    Vous allumez la lumiere 
    -> ecurie_illum
    -batterie_tel > 0 && lumiere_ecurie == false:
    Vous sortez votre telephone, il a {batterie_tel}% de batterie et vous allumez la lampe frontale. C'est une petite écurie, il y a 4 chevaux à l'interieur, une boite metalique à votre droite, des palettes, une porte menant à l'interieur de la grange.
    ~batterie_tel -=1 
    -> ecurie_illum
    - else :
    * Vous n'avez plus de batterie
        ** Entrez quand même
            *** boom
            -> ecurie
        ** Retournez à la place de la grange
        -> place_grange
}

=== ecurie_illum ===
    * Vous vous approchez des cheveaux 
        Les cheveaux vous fixent avec un regard d'une froideur à faire frissoner des pingouins, leurs yeux sont dilatés. Votre rythme cardiaque prend l'ascenseur.
        ~peur += 10
        -> ecurie
    * Vous inspectez les palette
        Vous ouvrez une pallette, il y a des cadavres de corbeau à l'interieur, ils ont l'air fraichement abattus, ça vous fout la trouille vous refermez la boite en vitesse.
        ~peur += 5
        -> ecurie
    * Vous inspectez la boite métalique
        Dans la boite il y a un interupteur, vous l'actionnez ?
        ** Oui
        ~lumiere_ecurie = true
        ->ecurie
        ** Non
        ->ecurie
        
    + Vous ressortez
        -> place_grange


=== function show_stats ===
    Batterie de tel : {batterie_tel}%
    Peur : {peur}/100
=== else_header ===
 the end
    -> END
