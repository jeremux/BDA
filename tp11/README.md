TP 11 LABD
==========

# Auteur
Jeremy FONTAINE

02 avril 2015

## Exo 1
###Q1:

```sparql

SELECT ?x ?t WHERE
{
 ?x rdf:type ?t
 FILTER regex(?x,"John")
}

```
Cette requête récupère tous les types définis dans les triplets RDFs:
on obtient 33 réponses.

```sparql

SELECT ?x ?t WHERE
{
 ?x rdf:type ?t
 FILTER regex(?x,"John")
}

```
Le type de John est Person.

###Q2:

```sparql

PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT * WHERE 
{
	?x humans:hasSpouse ?y
}

```
Cette requête retourne tous les couples, il y en a 6.

###Q3:

La propriété utilisée pour donner l'âge est : <http://www.inria.fr/2007/09/11/humans.rdfs#age>

Personnes ayant plus de 20 ans:

```sparql

PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?nom WHERE 
{
	?person humans:age ?age
	FILTER (xsd:integer(?age) > 20 )
	?person humans:name  ?nom
}

```
###Q4:

La propriété utilisée pour la taille des chaussures:
<http://www.inria.fr/2007/09/11/humans.rdfs#shoesize>

*  1

Personnes avec leur pointure:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?person ?pointure WHERE 
{
	?person humans:shoesize ?pointure
}
```

*  2

Personnes et évntuellement leur pointure:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?person ?tailleChaussure WHERE 
{
	?person rdf:type humans:Person
	OPTIONAL {?person humans:shoesize ?tailleChaussure}
}
```

*  3

Personnes et évntuellement leur pointure si celle-ci est supérieur à 8:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?person ?tailleChaussure WHERE 
{
	?person rdf:type humans:Person
	OPTIONAL {
		?person humans:shoesize ?tailleChaussure 
		FILTER (xsd:integer(?tailleChaussure) > 8) 
	}
}
```

*  4

Personnes avec pointure supérieur à 8 ou avec taille de chemise supérieur à 40:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT DISTINCT ?person  WHERE 
{
	{
		?person humans:shoesize ?tailleChaussure 
		FILTER (xsd:integer(?tailleChaussure) > 8) 
	} 
	UNION
	{
		?person humans:shirtsize ?tailleShirt
		FILTER (xsd:integer(?tailleShirt) > 12)
	}
}
```

###Q5:
*  1

Toutes les proriétés de John:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT DISTINCT ?ppty WHERE 
{
	?x ?ppty ?z
	FILTER regex(?x,"John")
}
```

*  2

Description de John:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
DESCRIBE ?x WHERE 
{
	?x ?ppty ?z
	FILTER regex(?x,"John")
}
```

Voir Q5-2.png pour le graphe.

###Q6:
*  1

Tous les couples (parent,enfant)

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?parent ?enfant WHERE 
{
	{?parent humans:hasChild ?enfant}
	UNION
	{?enfant humans:hasParent ?parent}
}
```

*  2

Personnes avec au moins un enfant

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?parent WHERE 
{
	{?parent humans:hasChild ?enfant}
	UNION
	{?enfant humans:hasParent ?parent}
}
```

*  3

La requête précédente retourne 6 réponses dont un doublon.

*  4

Pour éviter les doublons on ajoute la clause DISTINCT:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT DISTINCT ?parent WHERE 
{
	{?parent humans:hasChild ?enfant}
	UNION
	{?enfant humans:hasParent ?parent}
}

```

*  5

Les hommes qui n'ont pas d'enfant:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT DISTINCT  ?homme WHERE 
{
	?homme a humans:Man
	OPTIONAL
	{
		?homme humans:hasChild ?enfant
	}
	FILTER(!bound(?enfant))
}
```

*  6

Femmes mariées avec éventuellement leurs enfants:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?femme ?enfant WHERE 
{
	?femme a humans:Woman
	{?y humans:hasSpouse ?femme} UNION {?femme humans:hasSpouse ?y}
	OPTIONAL {?femme humans:hasChild ?enfant}
	OPTIONAL {?enfant humans:hasParent ?femme}
}
```

###Q7:

Couples de personnes avec la même taille de chemise:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?personne1 ?personne2
WHERE 
{
	?personne1 humans:shirtsize ?taille1
	?personne2 humans:shirtsize ?taille2
	FILTER (xsd:integer(?taille1) = xsd:integer(?taille2))
	FILTER (xsd:string(?personne1) < xsd:string(?personne2))
 }
```

###Q8:

Clôture symétrique de la relation hasFriend:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
CONSTRUCT { ?ami1 humans:hasFriend ?ami2 }
WHERE { ?ami2 humans:hasFriend ?ami1  }
```

###Q9:

```sparql

```

##Exo 2:
###Q1:

```sparql

```

###Q2:

```sparql

```

###Q3:

```sparql

```

###Q4:

```sparql

```

###Q5:

```sparql

```

###Q6:

```sparql

```

##Exo 3:
###Q1:
*  1

```sparql

```

*  2

```sparql

```

###Q2:
*  1

```sparql

```

*  2

```sparql

```

###Q3:

```sparql

```

###Q4:

```sparql

```

