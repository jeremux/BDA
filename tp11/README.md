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
SELECT ?z WHERE 
{
	?x humans:age ?y
	FILTER (xsd:integer(?y) > 20 )
	?x humans:name  ?z
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
SELECT ?x ?z WHERE 
{
	?x rdf:type humans:Person
	OPTIONAL {?x humans:shoesize ?z}
}
```

*  3

Personnes et évntuellement leur pointure si celle-ci est supérieur à 8:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?x ?z WHERE 
{
	?x rdf:type humans:Person
	OPTIONAL {
		?x humans:shoesize ?z 
		FILTER (xsd:integer(?z) > 8) 
	}
}
```

*  4

Personnes avec pointure supérieur à 8 ou avec taille de chemise supérieur à 40:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT DISTINCT ?x  WHERE 
{
	{
		?x humans:shoesize ?y 
		FILTER (xsd:integer(?y) > 8) 
	} 
	UNION
	{
		?x humans:shirtsize ?z
		FILTER (xsd:integer(?z) > 12)
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
SELECT ?x ?y WHERE 
{
	?x humans:hasChild ?y
}
```

*  2

Personnes avec au moins un enfant

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?x WHERE 
{
	?x humans:hasChild ?y
}
```

*  3

La requête précédente retourne 5 réponses dont un doublon.

*  4

Pour éviter les doublons on ajoute la clause DISTINCT:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT DISTINCT  ?x WHERE 
{
	?x humans:hasChild ?y
}

```

*  5

Les hommes qui n'ont pas d'enfant:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT DISTINCT  ?x WHERE 
{
	?x a humans:Man
	OPTIONAL
	{
		?x humans:hasChild ?y
	}
	FILTER(!bound(?y))
}
```

*  6

Femmes mariées avec éventuellement leurs enfants:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?x ?z WHERE 
{
	?x a humans:Woman
	{?y humans:hasSpouse ?x} UNION {?x humans:hasSpouse ?y}
	OPTIONAL {?x humans:hasChild ?z}
}
```

###Q7:

```sparql

```

###Q8:

```sparql

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

