<?xml version="1.0" encoding="UTF-8"?>

<!-- New document created with EditiX at Thu Feb 12 10:55:25 CET 2015 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="html" indent="yes" encoding="UTF-8"
                omit-xml-declaration="no"/>

    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <body>

                <h2>Les clubs de Ligue 1 <br/> saison
                    <xsl:value-of select="(/championnat/@annee)-1"/>-
                    <xsl:value-of select="/championnat/@annee"/> :</h2>
                <table border="1">
                    <!-- en tête du tableau -->
                    <thead>
                        <tr>
                            <th>ville</th>
                            <th>club</th>
                        </tr>
                    </thead>
                    <!-- contenu de la table -->
                    <tbody>

                        <xsl:apply-templates select="/championnat/clubs/club">
                            <!-- tri sur les villes -->
                            <xsl:sort select="ville"/>
                        </xsl:apply-templates>

                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="/championnat/clubs/club">
        <!-- chaque club définit une ligne -->
        <tr>
            <!-- première colonne la ville -->
            <td>
                <xsl:value-of select="ville"/>
            </td>
            <!-- seconde colonne le nom de l'équipe -->
            <td>
                <xsl:value-of select="nom"/>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>


