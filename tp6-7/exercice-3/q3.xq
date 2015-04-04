declare variable $f := "plant_families.xml";
declare variable $c := "plant_catalog.xml";

declare function local:get-family-name($plant) {
    let $family := doc($f)//FAMILY[SPECIES/text() = $plant/BOTANICAL/text()]/NAME
    return $family/text()
};

declare function local:get-plants-by-light($light) {
    for $p in doc($c)//PLANT[LIGHT = $light]
    order by $p/COMMON
    return
        <PLANT>
            {$p/COMMON}
            {$p/BOTANICAL}
            {$p/ZONE}
            {$p/PRICE}
            {$p/AVAILABILITY}
            <FAMILY>{local:get-family-name($p)}</FAMILY>
        </PLANT>
};

<CATALOG>
    {
        for $light in distinct-values(doc($c)//LIGHT)
        order by $light
        return
            <LIGHT>
                <EXPOSURE>{$light}</EXPOSURE>
                {local:get-plants-by-light($light)}
            </LIGHT>
    }
</CATALOG>