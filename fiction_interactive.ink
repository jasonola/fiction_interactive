VAR peur = 0
VAR sante = 100
VAR souffle = 100
VAR intro = true

La grange abandonnée

Il est minuit, après une soirée un peu arrosée vous décidez de rentrer à pied en passant par la forêt. 
Après une heure de marche vous vous rendez compte que vous êtes perdus et vous finissez par tomber sur une énorme grange au milieu de nullepart. La grange vous semble abandonnée et vous décidez d'aller y jeter un coup d'oeil.

-> place_grange

=== place_grange ===

{intro:
    Vous êtes sur la place de la grange et vous avez besoin d'aller aux petit coin.
    * Vous allez dans l'écurie
        -> ecurie
    * Vous allez à la porte d'entrée de la grange
        -> else_header
    * Vous allez vers un buisson
        -> else_header

  - else:
    Vous êtes juste sur la grange et choix... #TODO
}

=== ecurie ===


    
=== else_header ===
    -> END
