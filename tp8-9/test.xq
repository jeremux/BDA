xquery version "3.0";

declare variable $varFile := "variables.xml";

let $e := doc($varFile)
return $e//variables/X/text()
