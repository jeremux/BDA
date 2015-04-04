declare variable $f := "plant_families.xml";
declare variable $c := "plant_catalog.xml";

<CATALOG>
    {
        for $p in doc($c)//PLANT
            for $fam in doc($f)//FAMILY
            where some $fb in $fam/SPECIES satisfies ($fb=$p/BOTANICAL)
            return
                <PLANT>
                    {$p/COMMON}
                    {$p/BOTANICAL}
                    {$p/ZONE}
                    {$p/LIGHT}
                    {$p/PRICE}
                    {$p/AVAILABILITY}
                    <FAMILY>{$fam/NAME/text()}</FAMILY>
                </PLANT>
    }
</CATALOG>