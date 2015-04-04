*******************************
******  Jeremy FONTAINE  ******
******  M1S2 info        ******
******  TP8 LABD         ******
******  19/03/2015       ******
*******************************




---- Question 1 ----
Afficher l'expression.

declare function exp:print($name as xs:string) as xs:string

---- Question 2 ----
Evaluation de l'expression.

declare function exp:eval($name as xs:string) as xs:integer

---- Question 3 ----
Evaluation de l'expression avec valeur des variables

declare function exp:eval-var($name as xs:string,$variables as xs:string) as xs:integer

---- Question 4 ----
Simplifie le plus possible l'expression

declare function exp:simplifie($name as xs:string, $variables as xs:string) as element()