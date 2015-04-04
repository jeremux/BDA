declare default element namespace "http://www.w3.org/1999/xhtml";

declare function local:superficie($maison)
{
    (:on récupère dans s, toutes les surfaces qui n'ont pas d'ancêtre avec
        un attribut surface-m2:)
    let $s := $maison//*[count(ancestor::*/@surface-m2)=0]/@surface-m2
        return sum($s)
};

<html>
    <body>
        <table border="1">
            <!-- en tête du tableau -->
            <thead>
                <tr>
                    <th>Maisons</th>
                    <th>Surfaces (m2)</th>
                </tr>
            </thead>
            <!-- contenu de la table -->
            <tbody>
                {
                    for $m in doc("maisons.xml")//*[name(.)="maison"]
                        return
                            <tr>
                                <td>Maison {data($m/@id)}</td>
                                <td>{local:superficie($m)}</td>
                            </tr>
                }
            </tbody>
        </table>
    </body>
</html>
