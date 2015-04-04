<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Thu Feb 12 10:36:17 CET 2015 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:output method="xml" indent="yes"/>
    <!-- Note du prof de td: Important de définir le template pour la racine ci dessous car il y a des
        templates prédéfinis en interne -->

    <xsl:template match="/">
        <xsl:copy>
            <xsl:apply-templates select="//clubs"/>
        </xsl:copy>
    </xsl:template>

    <!-- regle pour les balises clubs -->
    <xsl:template match="//clubs">
        <xsl:copy-of select="."/>
    </xsl:template>
</xsl:stylesheet>
