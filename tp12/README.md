TP 12 LABD
==========

# Auteur
Jeremy FONTAINE

16 avril 2015

## Exo 1
###Q1:

Liste de toutes les classes:

```sparql
SELECT ?classe WHERE
{
	?classe a rdfs:Class
}
```

###Q2:

Propriétés avec domaine sport:

```sparql
PREFIX sport: <http://www.labd.org/2015/sport/schema#>

SELECT ?pptyAvecDomainSport WHERE
{
	?pptyAvecDomainSport a rdf:Property
	?pptyAvecDomainSport rdfs:domain sport:Sport
}
```

###Q3:

Propriétés qui ont pour sujet des instances de Sport:

```sparql
PREFIX sport: <http://www.labd.org/2015/sport/schema#>

SELECT DISTINCT ?pptyAvecSujetSport WHERE
{
	?x ?pptyAvecSujetSport ?z
	?x a sport:Sport
}
```

###Q4:

Ressource avec le mot sport en commentaire:

```sparql
PREFIX sport: <http://www.labd.org/2015/sport/schema#>

SELECT ?x WHERE 
{
	?x rdfs:comment ?c
	filter(regex(?c,"sport","i"))
}
```

###Q5:

Sports sans matériel:

```sparql
PREFIX sport: <http://www.labd.org/2015/sport/schema#>

SELECT ?sportSansMateriel WHERE 
{
	?sportSansMateriel a sport:Sport
	FILTER NOT EXISTS {?sportSansMateriel 	sport:utiliseMateriel ?tmp}
}
```

###Q6:

Personnes pratiquant plusieurs sports:

* Avec GROUPBY

```sparql
PREFIX sport: <http://www.labd.org/2015/sport/schema#>

SELECT ?personne  WHERE 
{
	?personne sport:pratique ?sport
}
GROUP BY ?personne
HAVING(COUNT(?sport) > 1)
```

* Sans GROUPBY

```sparql
PREFIX sport: <http://www.labd.org/2015/sport/schema#>

SELECT DISTINCT ?personne  WHERE 
{
	?personne sport:pratique ?sport
	?personne sport:pratique ?sport2
	FILTER(?sport != ?sport2)
}
```

###Q7:

Personnes pratiquant un seul sport:

* Avec GROUPBY

```sparql
PREFIX sport: <http://www.labd.org/2015/sport/schema#>

SELECT ?personne  WHERE 
{
	?personne sport:pratique ?sport
}
GROUP BY ?personne
HAVING(COUNT(?sport) = 1)
```

* Sans GROUPBY

```sparql
PREFIX sport: <http://www.labd.org/2015/sport/schema#>

SELECT DISTINCT ?personne  WHERE 
{
	?personne sport:pratique ?sport
	OPTIONAL 
	{
		?personne sport:pratique ?sport2
		FILTER(?sport2 != ?sport)
	}
	FILTER(!bound(?sport2))
}
```

###Q8:

Liste des personnes avec le nombre de sport pratiqué:

```sparql
PREFIX sport: <http://www.labd.org/2015/sport/schema#>
PREFIX pers: <http://www.inria.fr/2007/09/11/humans.rdfs#>

SELECT ?personne (COUNT(?sport) AS ?nbSport) WHERE 
{
	?personne a pers:Person
	OPTIONAL { ?personne sport:pratique ?sport}
}
GROUP BY ?personne
```

###Q9:

Durée d'un match de basket:

```sparql
PREFIX sport: <http://www.labd.org/2015/sport/schema#>

SELECT ?member  WHERE 
{
	?s sport:match/rdfs:label ?m
	?s sport:match/sport:duree ?d
	?d rdfs:member ?member
	FILTER(regex(?m,"basket" ,"i"))
}
```

###Q10:

Durée d'un match de basket NBA:

```sparql
PREFIX sport: <http://www.labd.org/2015/sport/schema#>

SELECT ?member  WHERE 
{
	?s sport:match/rdfs:label ?m
	?s sport:match/sport:duree ?d
	?d rdfs:member ?member
	FILTER(regex(?m,"basket" ,"i"))
	FILTER(regex(?member,"NBA","i"))
}

```

###Q11:

Sports collectifs et leur durée:

```sparql
PREFIX sport: <http://www.labd.org/2015/sport/schema#>

SELECT ?s  ?d WHERE 
{
	{
	?s a sport:SportCollectif
	?s sport:match/sport:duree ?d
	FILTER NOT EXISTS{?d rdfs:member ?tmp}
	}
	UNION
	{
	?s a sport:SportCollectif
	?s sport:match/sport:duree ?tmp
	?tmp rdfs:member ?d
	}
}
```

## Exo 2
###Q1:

Connaissances immédiates de James Bond et éventuellement leur page personnelle.

```sparql

```

###Q2:

Connaissances immédiates de James Bond et éventuellement leur page Web.

```sparql

```

###Q3:

Connaissances proches et lointaines de James Bond

```sparql

```

###Q4:

Connaissances immédiates de James Bond qui n'ont pas de téléphone.

```sparql

```

###Q5:

Toutes les personnes et leur nombre de connaissances immédiates.

```sparql

```


