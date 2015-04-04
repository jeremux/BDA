*******************************
******  Jérémy FONTAINE  ******
******  MS2 info         ******
******  TP2 LABD         ******
******  22/01/2015       ******
*******************************


******************
*** Exercice 1 ***
******************

----Question 1----
Voir exo1/q1.xml

Dans la requête //livre[titre="edition"] le predicat sera vrai si la valeur de l'élément titre vaut "edition".
Dans la requête //livre[titre=edition] le predicat sera vrai si les éléments titre et edition ont la même valeur.


----Question 2——
Voir exo1/q2.xml

1./item/livre[@titre="labd" and position()=last()]

Retourne le dernier livre si son attribut titre vaut labd.

2./item/livre[@titre="labd"] [position()=last()]

Retourne le dernier livre avec l’attribut titre ayant pour valeur labd.

3./item/livre[position()=last()] [@titre="labd"]

Idem 1

----Question 3----
Voir exo1/q3.xml

/descendant::livre[1] : On selectionne le premier element livre qu'on rencontre dans le parcours du document. (Note: /descendant:: "applatit" l'arbre)
//livre[1] :  On selectionne les premiers éléments livre parmi ceux se trouvant à un même niveau. ("les premiers fils livre")


******************
*** Exercice 2 ***
******************

----Question 1----
1. Producteurs de fruits

//producteur 

ou sans doublon

//producteur[not( . = following::producteur/.)]

2. Légumes d'Espagne

//legume[origine='Espagne']/@type

3. Origines clémentines bio de calibre 1

//.[@type='clementine' and @calibre=1 and bio]/origine

4. Producteurs bretons

//.[@region='Bretagne']/../producteur

******************
*** Exercice 3 ***
******************

----Question 1----

----Question 2-----

1. Éléments titres des recettes
**recette1.xml et recette2.xml**
//recette/titre 

2. Nom des ingrédients
**recette1.xml**
//nom_ing/text()

**recette2.xml**
id(//ingredient)

3. Élément titre de la seconde recette
**recette1.xml et recette2.xml**
//recette[2]/titre

4. Dernière étape de chaque recette
**recette1.xml et recette2.xml**
//etape[last()]

5. Nombre de recette
**recette1.xml et recette2.xml**
count(//recette)

6. Les éléments recettes avec strictement moins de 7 ingrédients
**recette1.xml**
//recette[count(ingredients/ingredient) < 7]

**recette2.xml**
//recette[count(ingredients/ing-recette) < 7]

7. Les titres des recettes avec strictement moins de 7 ingrédients
**recette1.xml**
//recette[count(ingredients/ingredient) < 7]/titre/text() 

**recette2.xml**
//recette[count(ingredients/ing-recette) < 7]/titre/text()
	
8. Les recettes avec de la farine
**recette1.xml**
//recette[descendant::nom_ing/text()[contains(.,'farine')]]

**recette2.xml**
//recette[ingredients/ing-recette/@ingredient='farine']

9. Les recettes d'entrée
**recette1.xml**
//recette[categorie[contains(lower-case(.),'entrée')]]

**recette2.xml**
//recette[@categ[contains(lower-case(.),'entree')]]




******************
*** Exercice 4 ***
******************

----Question 1----


1. Le nombre de morceaux (tracks hors PlayLists) de la bibliothèque.
count
(

//dict[preceding-sibling::key[1]="Tracks"]/dict/key[text()="Track ID"]/following-sibling::integer[1]

except

//array[preceding-sibling::key[1]="Playlist Items"]/dict/integer

)

2. Tous les noms d’albums.
distinct-values(//dict/string/.[preceding-sibling::key[1]="Album"]/text())

3. Tous les genres de musique (Jazz, Rock, . . .).
//dict/string/.[preceding-sibling::key[1]="Genre"]

4. Le nombre de morceaux de Jazz.
count(//dict/string/.[preceding-sibling::key[1]="Genre" and text()="Jazz"])

5. Tous les genres sans doublon
distinct-values(//dict/string/.[preceding-sibling::key[1]="Genre"])

6. Le titre (Name) des morceaux écoutés au moins 1 fois.
//dict[key="Play Count"]/string[preceding-sibling::key[1]="Name"]             

7. Le titre des morceaux qui n’ont jamais été écoutés
//dict[not(key="Play Count")]/string[preceding-sibling::key[1]="Name"]             

8. Le titre du morceaux les plus anciens de la bibliothèque.
//date[preceding-sibling::key[1]="Date Added"]

[not(text() > //date[preceding-sibling::key[1]="Date Added"]/text()) ]

/preceding-sibling::string[preceding-sibling::key[1]="Name"]



