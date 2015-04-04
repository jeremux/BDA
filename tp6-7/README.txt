*******************************
******  Jeremy FONTAINE  ******
******  M1S2 info        ******
******  TP7 LABD         ******
******  26/02/2015       ******
*******************************


******************
**  Exercice 1  **
******************

---- Question 1 ----

/!\  /!\
Il faut modifier les variables $bib pour chaque fichier query_bib?.xq:
let $bib := "biblio.xml"
/!\  /!\

Explications et anticipation des requêtes:

**query_bib1.xq:

La requête va récupérer tous les éléments titres (t) et l'attribut année (yyyy) des livres d'Addison-Wesley publié à partir de 1992.

Le résultat sera sous forme:
<bib>
    <book year="yyyy">
        <title>titre</title>
    </book>
    ...
</bib>

**query_bib2.xq:

On va recupérer pour chaque élément book, pour chaque élément titre d'un book et pour chaque élément auteur d'un élément titre d'un book
L'ensemble des auteurs d'un titre.

Par exemple pour un élément book bi avec le  titre t avec l'ensemble des auteurs
A = {a1,...,an}

<results>
    <!-- result pour bi -->
    <result>
        <!-- contenu de t -->
        <!-- contenu de a1 -->
        ...
        <!-- contenu de an -->
    </result>
    ...
</results>


**query_bib3.xq:

On va recupérer chaque nom, prénom de chaque auteur dans l'ordre croissant. Puis pour chaque
livre on va vérifier s'il existe un auteur correspondant à l'auteur courant, si un tel livre existe
alors on met à la suite l'élément title.

<results>
    <!-- auteur 1 -->
    <result>
        <author>
            <last>nom</last>
            <first>prénom</first>
        </author>
        <title>
            <!--contenu de title-->
        </title>
        <!-- si plusieurs livres -->
        <title>
        ...
    </result>
    <!-- auteur 2 -->
    ...
</results>

**query_bib4.xq:

On obtiendra la même chose que précédemment on a juste utiliser une fonction
définie en local pour récupérer les titres des libres des auteurs.

**query_bib5.xq:

Dans cette requete on va pour chaque livre avec au moins 1 auteur:
    Afficher son titre, puis afficher le premier auteur et le second si ce dernier existe.
    Enfin si il y a strictement plus de deux auteurs (count($b/author) > 2) on produit
    l'élément <et-al/>

<bib>
    <book>
        <title>...</title>
        <author>
            <!--contenu de author-->
        </author>
        <!-- si plus d'un auteur : -->
        <author> ..</author>
        <!-- si plus de deux auteurs -->
        <et-al/>
    </book>
    <book>
    ...
</bib>

**query_bib6.xq:

Cette requête est triviale lorqu'on a compris la requête définie dans query_lib4.xq. Dans celle ci
on recupère le nombre de titre par auteur.

<results>
    <!-- auteur 1 -->
    <result>
        <author>
            <last>nom</last>
            <first>prénom</first>
        </author>
        <number><!--Nombre de livre--></number>
    </result>
    <!-- auteur 2 -->
    ...
</results>

**query_bib7.xq:

La requête va calculer le prix moyen des livres par rapport à l'année de publication.

<data>
    <year value="valeur" avgprice="prixmoyen" />
    ...
</data>

Pour le document biblio.xml ce n'est pas vraiment parlant car toutes les années sont distinctes.

******************
**  Exercice 2  **
******************

---- Question 1 ----
Voir exercice-2/q1.xq

******************
**  Exercice 3  **
******************

---- Question 1 ----
Voir exercice-3/q1.xq

---- Question 2 ----
Voir exercice-3/q2.xq

---- Question 3 ----
Voir exercice-3/q3.xq

---- Question 4 ----
Voir exercice-3/q4.xq