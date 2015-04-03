TP 11 LABD
==========

# Auteur
Jeremy FONTAINE

02 avril 2015

## Exo 1
###Q1:

Récupère tous les types définis dans les triplets RDFs:

```sparql

SELECT ?x ?t WHERE
{
 ?x rdf:type ?t
 FILTER regex(?x,"John")
}

```
On obtient 33 réponses.

Le type de John est Person.

###Q2:

```sparql

PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT * WHERE {
?x humans:hasSpouse ?y
}

```
Cette requête retourne tous les couples, il y en a 6.

###Q3:

La propriété utilisée pour donner l'âge est : <http://www.inria.fr/2007/09/11/humans.rdfs#age>

Personnes ayant plus de 20 ans:

```sparql

PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?z WHERE {
?x humans:age ?y
FILTER (xsd:integer(?y) > 20 )
?x humans:name  ?z
}

```
###Q4:
*  1

*  2

*  3

*  4

###Q5:
*  1

*  2

###Q6:
*  1

*  2

*  3

*  4

*  5

*  6

###Q7:

###Q8:

###Q9:

##Exo 2:
###Q1:

###Q2:

###Q3:

###Q4:

###Q5:

###Q6:

##Exo 3:
###Q1:
*  1

*  2

###Q2:
*  1

*  2

###Q3:

###Q4:

