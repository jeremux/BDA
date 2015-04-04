declare variable $c := "plant_catalog.xml";
declare variable $o := "plant_order.xml";


declare function local:price-by-plants($order) {
    let $catalog := doc($c)
    let $plants := $order//PLANT
    for $p in $plants
    return number(substring($catalog//PLANT[COMMON = $p/COMMON]/PRICE, 2)) * $p/QUANTITY
};
declare function local:price($order) {
    let $price-by-plant := local:price-by-plants($order)
    (: round-half-to-even pour arrondir :)
    return round-half-to-even(sum($price-by-plant), 1)
};

let $order := doc($o)
return <PRICE>{local:price($order)}</PRICE>