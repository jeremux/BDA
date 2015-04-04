declare variable $c := "plant_catalog.xml";

<CATALOG>
    {
        for $l in distinct-values(doc($c)//LIGHT)
        return
            <LIGHT>
                <EXPOSURE>{$l}</EXPOSURE>
                {
                    for $p in doc($c)//PLANT[LIGHT=$l]
                        return $p
                }
            </LIGHT>
    }
</CATALOG>