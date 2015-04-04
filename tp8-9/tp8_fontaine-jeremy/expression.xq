(:~
 : Ce module sert à
 : manipuler les fichiers de type expression.
 : @author Jérémy FONTAINE
 : @version 1.0
 :)

xquery version "3.0";
module namespace exp = "http://www.expression.org";
declare default element namespace "http://www.expression.org";

declare option saxon:output "omit-xml-declaration=yes";


(:~
 : Affiche l'expression parenthésée du
 : fichier de type expression passé en paramètre
 :
 : @param $name fichier xml contenant l'expression à afficher
 : @return l'écriture infixe paranthésée de l'expression
:)
declare function exp:print($name as xs:string) as xs:string
{
    let $expr := doc($name)//expr/*
    return exp:print-rec($expr)
};

(:~
 : Affiche l'expression parenthésée du noeud
 : passé en paramètre
 :
 : @param $e noeud à afficher
 : @return l'écriture infixe paranthésée de l'expression
 :           définie dans $e
:)
declare function exp:print-rec($e as node()) as xs:string
{
(: si noeud courant est op :)
    if(fn:local-name($e)="op")
    then
    (: on recupère la partie gauche et droite :)
        let $g := exp:print-rec($e/*[1])
        let $d := exp:print-rec($e/*[2])
        (: on retourne l'opération assoié entre les parties gauches et droites :)
        return fn:concat("(",$g,$e/@val,$d,")")
    else (: noeud cons ou var :)
    (:contenu du noeud:)
        data($e)
};

(:~
 : Evalue l'expression parenthésée du
 : fichier de type expression passé en paramètre
 :
 : @param $name fichier xml contenant l'expression à évaluer
 : @return la valeur de l'expression
:)
declare function exp:eval($name as xs:string) as xs:integer
{
    let $expr := doc($name)//expr/*
    return exp:eval-rec($expr)
};

(:~
 : Evalue l'expression du noeud
 : passé en paramètre
 :
 : @param $e noeud à évaluer
 : @return la valeur de l'expression
 :           définie dans $e
 : @error si une opérande est une variable
:)
declare function exp:eval-rec($e as node()) as xs:integer
{
(: si c'est une opération :)
    if(fn:local-name($e)="op")
    then
        let $valG := exp:eval-rec($e/*[1])
        let $valD := exp:eval-rec($e/*[2])
        (: calcul de l'ensemble: $valG op $valD :)
        return exp:process($valG,$valD,$e/@val)
    else
    (: si c'est une constante :)
        if(fn:local-name($e)="cons")
        then
            xs:integer(fn:number($e))
        else (: si variable :)
            fn:error(xs:QName("ERROR"), "integer excepted...")
};

(:~
 : Effectue l'opération entre les entiers passé
 : en paramètre et selon l'operateur en paramètre
 :
 : @param $x operande gauche
 : @param $y operande droite
 : @param $op operateur
 : @return le calcul: $x $op $y
 : @error si l'opérateur est différent de +,-,* ou /
:)
declare function exp:process($x as xs:integer,$y as xs:integer,$op as xs:string) as xs:integer
{
    switch ($op)
        case "+" return $x + $y
        case "-" return $x - $y
        case "*" return $x * $y
        case "/" return xs:integer($x div $y)
        default return fn:error(xs:QName("ERROR"), "bad operator...")

};

(:~
 : Evalue l'expression parenthésée du
 : fichier de type expression passé en paramètre
 : selon les variables définies définies
 : dans un fichier xml.
 :
 : @param $name fichier xml contenant l'expression à évaluer
 : @param $variables fichier xml contenant la valeur des variables
 : @return la valeur de l'expression
:)
declare function exp:eval-var($name as xs:string,$variables as xs:string) as xs:integer
{
    let $expr := doc($name)//expr/*
    return exp:eval-var-rec($expr,$variables)
};

(:~
 : Evalue l'expression du noeud passé en paramètre
 : selon les variables définies définies
 : dans un fichier xml.
 :
 : @param $e noeud à évaluer
 : @param $variables fichier xml contenant la valeur des variables
 : @return la valeur de l'expression
:)
declare function exp:eval-var-rec($e as node(),$variables as xs:string) as xs:integer
{
(: si opération :)
    if(fn:local-name($e)="op")
    then
        let $valG := exp:eval-var-rec($e/*[1],$variables)
        let $valD := exp:eval-var-rec($e/*[2],$variables)
        (:calcul des deux parties :)
        return exp:process($valG,$valD,$e/@val)
    else  (: si constante ou variable :)
        exp:getVal($e,$variables)

};

(:~
 : Récupère la valeur d'une constante
 : ou d'une variable
 :
 : @param $e noeud dont on souhaite récupérer la valeur
 : @param $variables fichier xml contenant la valeur des variables
 : @return la valeur que contient le noeud
:)
declare function exp:getVal($e as node(),$variables as xs:string) as xs:integer
{
    if(fn:local-name($e)="cons")
    then
        xs:integer(fn:number($e))
    else
        exp:getValFromVar($e,$variables)
};

(:~
 : Récupère la valeur d'une variable
 :
 : @param $e noeud dont on souhaite récupérer la valeur
 : @param $variables fichier xml contenant la valeur des variables
 : @return la valeur que contient le noeud
 : @error si la variable dont on souhaite récupérer la valeur
 :         apparait 0 ou plus d'une fois dans le document
 :         ($variables) définissant les variables.
:)
declare function exp:getValFromVar($e as node(),$variables as xs:string) as xs:integer
{
    let $vars := doc($variables)
    (: valeur texte du noeud e: X,Y...:)
    let $v := $e/text()

    (: Etant donnée l'espace de nom par défaut, on récupère tous dans l'expression
     : xpath puis on filtre
     :)

    (:nombre de variable :)
    let $nVar := count($vars//*[fn:local-name(.)="variables"]/*[name(.)=$v])
    return
    (: si 0 ou plus d'une variable :)
        if( $nVar != 1)
        then
            fn:error(xs:QName("ERROR"), fn:concat($nVar," var found for ",$v," one and only one required"))
        else
        (: on recupère la valeur :)
            let $val := $vars//*[fn:local-name(.)="variables"]/*[name(.)=$v]/text()
            return xs:integer($val)
};

(:~
 : Simplifie le fichier de type expression passé en paramètre
 : selon les variables définies définies
 : dans un fichier xml. Dans le sens où lorsqu'une
 : sous expression sera calculable la partie dans le
 : document correspondant à cette sous expression sera
 : remplacée par sa valeur: <cons>...</cons>
 :
 : @param $name fichier xml contenant l'expression à simplifier
 : @param $variables fichier xml contenant la valeur des variables
 : @return l'élément simplifié
:)
declare function exp:simplifie($name as xs:string, $variables as xs:string) as element()
{
    let $expr := doc($name)//expr/*
    (: on récupère aussi les attributs de la racine :)
    return <expr>{doc($name)//expr/@*} {exp:simplifie-rec($expr,$variables)}</expr>
};


(:~
 : Simplifie le noeud de type expression passé en paramètre
 : selon les variables définies définies
 : dans un fichier xml. Dans le sens où lorsqu'une
 : sous expression sera calculable la partie dans le
 : document correspondant à cette sous expression sera
 : évaluée par sa valeur: <cons>...</cons>
 :
 : @param $e noeud à simplifier
 : @param $variables fichier xml contenant la valeur des variables
 : @return l'élément simplifié
:)
declare function exp:simplifie-rec($e as node(),$variables as xs:string) as element()
{
(: si on peut simplifier le noeud $e :)
    if(exp:canCalculate($e,$variables))
    then
        <cons>{exp:eval-var-rec($e,$variables)}</cons>
    else
        let $partG := $e/*[1]
        let $partD := $e/*[2]
        return
        (: si on peut simplifier le fils gauche du noeud $e:)
            if(exp:canCalculate($partG,$variables))
            then
                (: on récupère la valeur du fils gauche :)
                let $g := <cons>{exp:eval-var-rec($partG,$variables)}</cons>
                return
                    (: si le fils droit n'a pas de fils :)
                    if(count($partD/*)=0)
                    then
                        element op {
                            attribute val {$e/@val},
                            $g,
                            $partD
                        }
                    else
                        element op {
                            attribute val {$e/@val},
                            $g,
                            (: appel recursif sur le fils droit :)
                            exp:simplifie-rec($partD,$variables)

                        }
            else
            (: si on peut simplifier le fils droit du noeud $e :)
                if(exp:canCalculate($partD,$variables))
                then
                    let $d := <cons>{exp:eval-var-rec($partD,$variables)}</cons>
                    return
                        if(count($partG/*)=0)
                        then
                            element op {
                                attribute val {$e/@val},
                                $partG,
                                $d
                            }
                        else
                            element op {
                                attribute val {$e/@val},
                                exp:simplifie-rec($partG,$variables),
                                $d
                            }

                else (: on ne peut rien simplifier :)
                    element op {
                        attribute val {$e/@val},
                        (exp:simplifie-rec($partG,$variables), exp:simplifie-rec($partD,$variables))

                    }
};

(:~
 : Indique si le noeud passé en paramètre
 : est calculable, et donc simplifiable
 : dans notre contexte
 :
 : @param $e noeud à tester
 : @param $variables fichier xml contenant la valeur des variables
 : @return true si le noeud est simplifiable
:)
declare function exp:canCalculate($e as node(),$variables as xs:string) as xs:boolean
{
(: si c'est une opération :)
    if(fn:local-name($e)="op")
    then
    (: on regarde si le fils gauche ET le sils droit sont simplifiables :)
        exp:canCalculate($e/*[1],$variables) and exp:canCalculate($e/*[2],$variables)

    else
    (: si c'est une constante :)
        if(fn:local-name($e)="cons")
        then
            fn:true()
        else (: var :)
            try {
                string(number(exp:getValFromVar($e,$variables))) != 'NaN'
            } catch * {
            (: variable non défini ou apparaissant plus d'une fois :)
            fn:false()
            }
};




