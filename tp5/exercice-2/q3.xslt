<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Thu Feb 19 11:27:51 CET 2015 -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://labd/art"
                xpath-default-namespace="http://labd/art" >

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <art>
            <artistes>
                <xsl:apply-templates select="//artiste"/>
            </artistes>
            <xsl:copy-of select="//mouvements" copy-namespaces="no"/>
        </art>
    </xsl:template>

    <xsl:template match="artiste">
        <artiste>
            <!-- clef de l'artiste: ici les clefs sont des entiers de 1 à nombre d'artiste -->
            <xsl:attribute name="num">
                <xsl:value-of select="count(preceding-sibling::artiste)+1"/>
            </xsl:attribute>
            <xsl:copy-of select="nom" copy-namespaces="no"/>
            <xsl:copy-of select="prénom" copy-namespaces="no"/>
            <xsl:copy-of select="naissance" copy-namespaces="no"/>
            <xsl:copy-of select="décès" copy-namespaces="no"/>
            <xsl:copy-of select="nom" copy-namespaces="no"/>
            <xsl:copy-of select="période" copy-namespaces="no"/>
        </artiste>
    </xsl:template>


</xsl:stylesheet>