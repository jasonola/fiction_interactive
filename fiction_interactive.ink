VAR peur = 0
VAR batterie_tel = 5

// champ de canabis, grange squattée pour des dealeurs de canabis

La grange abandonnée

Il est minuit, après une soirée un peu arrosée vous décidez de rentrer à pied en passant par la forêt. 
Après une heure de marche vous vous rendez compte que vous êtes perdus et vous finissez par tomber sur une énorme grange au milieu de nulle part. La grange vous semble abandonnée et vous décidez d'aller y jeter un coup d'oeil.

-> place_grange

=== place_grange ===


    Vous êtes sur la place de la grange
    + Vous allez dans l'écurie
        -> ecurie
    + Vous allez à la porte d'entrée de la grange
        -> else_header
    + Vous allez vers un buisson isolé sur la gauche
        -> else_header

=== ecurie ===
Vous entrez dans l'écurie, il fait sombre, vous entendez des bruits de mouvements.
{batterie_tel > 0:
    Vous sortez votre telephone, il a {batterie_tel}% de batterie et vous allumez la lampe frontale. C'est une petite écurie, il y a 4 chevaux à l'interieur, une boite et des palettes.
    ~batterie_tel -=1 
    * Vous vous approchez des cheveaux 
        Les cheveaux vous fixent avec un regard d'une froideur à faire frissoner des pingouins, leurs yeux sont dilatés
        -> ecurie
    * Vous inspectez les boites
        Vous ouvrez la boite, il y a des cadavres de corbeau à l'interieur, ils ont l'air fraichement abattus, ça vous fout la trouille vous refermez la boite en vitesse.
        ~peur += 5
        -> ecurie
    + Vous ressortez
        -> place_grange
    - else :
    * Vous n'avez plus de batterie
        ** Entrez quand même
            *** 
            -> ecurie
        ** Retournez à la place de la grange
        -> place_grange

}

=== else_header ===
 the end
    -> END
