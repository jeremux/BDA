TP 11 LABD
==========

https://github.com/jeremux/BDA/tree/master/tp11

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

Les personnes de types Person mais pas de type Man.

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>

SELECT DISTINCT ?personneNonHomme 
WHERE 
{
	?personneNonHomme a humans:Person 
	FILTER(NOT EXISTS { ?personneNonHomme a humans:Man } )
}
```

On constate qu'on récupère, malgré tous, des personnes qui sont des homme. Ceci est dû au fait que dans le fichier rdf il existe des hommes n'ayant pas le type Man clairement indiqué. 
(PS: même après avoir chargé le schéma des hommes persistent, étant donné que leur type n'hérite pas de Man)

##Exo 2:
###Q1:

L'espace de nom associé à l'ontologie décrite est:
<http://www.inria.fr/2007/09/11/humans.rdfs>

La propriété age <http://www.inria.fr/2007/09/11/humans.rdfs#age> peut porter sur n'importe quelle Classe. Le domaine et le co-domaine ne sont pas préciser. 

###Q2:

Les classes définies dans l'ontologie étudiée:

```sparql
SELECT DISTINCT ?classe
WHERE
{
	?classe a rdfs:Class
	
}
```

###Q3:

Les liens subClassOf de l'ontologie

```sparql
SELECT DISTINCT ?lien
WHERE
{
	?x rdfs:subClassOf ?lien
	
}
```

###Q4:

Définition et traduction de shoesize

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>

SELECT DISTINCT ?definition ?traduction
WHERE 
{
	humans:shoesize rdfs:comment ?definition
	humans:shoesize rdfs:label ?traduction
	FILTER langMatches(lang(?definition),"FR")
	FILTER langMatches(lang(?traduction),"FR")
	
}
```



###Q5:

 Synonymes du terme "personne" 

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>

SELECT DISTINCT ?synonyme
WHERE 
{
	humans:Person rdfs:label ?synonyme
	FILTER langMatches(lang(?synonyme),"FR")	
}
```

On obtient:

*	homme
*  humain
*  personne
*  être humain

###Q6:

```sparql

```

##Exo 3:
###Q1:
*  1 (Instances chargées seules)

Les ressources de types Animal :

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?ressourceAnimal
WHERE 
{
	?ressourceAnimal a humans:Animal
}
```
On obtient aucune réponse.

Les ressources de types Person :

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?ressourcePerson
WHERE 
{
	?ressourcePerson a humans:Person
}
```

On obtient 7 réponses.

*  2 (Schéma et instances chargés)

Après avoir chargé le schéma, on obtient 17 ressources de types Animal et Person. On obtient plus de triplets car on a chargé le shéma en plus des instances, par inférence de nouveaux triplets sont donc créés.

###Q2:
*  1

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?male ?epouse
WHERE 
{
	{?male a humans:Male}
	{
	{?male humans:hasSpouse ?epouse}
	UNION
	{?epouse humans:hasSpouse ?male}
	}
}
```

On obient 3 résultats, ce qui est incomplet il manque au moins William et Laura. Ce qui est normal vu que William n'est pas de type Male.

*  2

En modifiant la partie concernant Lucas:

```xml
<Man rdf:ID="Lucas">
	<shoesize>7</shoesize>
	<trouserssize>28</trouserssize>
	<age>12</age>
	<shirtsize>8</shirtsize>
	<name>Lucas</name>
	<hasMother rdf:resource="#Catherine"/>
	<hasFather rdf:resource="#Karl"/>
</Man>
```

Et en relançant la requête précedente, on a cette fois ci le resulat
Karl et Catherine en plus.

Ceci est dû aux règles d'inférences domaine/co-domaine (règle 6 du cours).

(Lucas hasFather Karl) and (hasFather rdfs:range Male) => Karl rdf:type Male



###Q3:

Les professeurs (Lecturer) et leur type:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?prof ?type
WHERE 
{
	?prof a humans:Lecturer
	?prof a ?type
}
```

On obtient 7 résultats.


###Q4:

Les instances de la relation hasAncestor:

```sparql
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>

SELECT DISTINCT ?descendant ?ancetre
WHERE 
{
	?descendant humans:hasAncestor ?ancetre
}
```

La propriété hasAncestor n'est certes pas utilisée dans le fichier d'instance mais celle ci est définie dans le fichier du schéma associé comme étant sur-propriété de hasParent.

Ansi pour tous les couples (x,y) tel que l'instance "x hasParent y" est définie alors par inférence on aura "x hasAncestor y" .

Règle 2 d'inférence du cours:

(x,p,y) and (p,rdf:subPropertyOf,p') => (x,p',y)
