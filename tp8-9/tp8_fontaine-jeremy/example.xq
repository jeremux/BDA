xquery version "3.0";

import module namespace exp = "http://www.expression.org" at "expression.xq";

declare variable $expFile := "expression.xml";
declare variable $varFile := "variables.xml";

exp:simplifie($expFile,$varFile)

