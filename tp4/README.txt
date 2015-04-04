*******************************
******  Jeremy FONTAINE  ******
******  M1S2 info        ******
******  TP4 LABD         ******
******  02/02/2015       ******
*******************************


******************
**  Exercice 1  **
******************

Voir exo1/championnat.xsd (ligne 59).

******************
**  Exercice 2  **
******************

---- Question 1 ----

Voir exo2/examen-1.xsd et exo2/examen-2.xsd

******************
**  Exercice 3  **
******************

---- Question 1 ----

Voir exo3/a.xsd et exo3/b.xsd

******************
**  Exercice 4  **
******************

---- Question 1 ----

Voir personnes.xsd

---- Question 2 ----

La requête //nom retourne une liste vide puisqu'aucun élément
se nomme "nom" dans le document personnes.xml, il en est de même
avec les autres éléments. Il faudrait préciser l'espace de nom
http://www.fil.univ-lille1.fr/labd pour la requête.

La requête //* retourne tous les éléments de touts espaces de nom
confondus.

---- Question 3 ----

XPath 2.0:

declare namespace labd = "http://www.fil.univ-lille1.fr/labd" ;

//labd:personne[labd:sexe="M"]/labd:naissance/labd:date


******************
**  Exercice 5  **
******************

---- Question 1 ----

Voir livret.xsd