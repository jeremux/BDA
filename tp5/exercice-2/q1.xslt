<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Thu Feb 19 11:27:51 CET 2015 -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://labd/art"
                xpath-default-namespace="http://labd/art" >

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <artistes>
            <xsl:apply-templates select="//artiste"/>
        </artistes>
    </xsl:template>

    <xsl:template match="artiste">
        <artiste>
            <nom>
                <xsl:value-of select="nom"/>
            </nom>
            <prénom>
                <xsl:value-of select="prénom"/>
            </prénom>
            <xsl:apply-templates select="." mode="nbOeuvre">
                <xsl:with-param name="nom" select="nom/text()"/>
                <xsl:with-param name="prenom" select="prénom/text()"/>
            </xsl:apply-templates>
        </artiste>
    </xsl:template>

    <!-- le nombre d'oeuvre -->
    <xsl:template match="artiste" mode="nbOeuvre">
        <xsl:param name="nom"/>
        <xsl:param name="prenom"/>
        <nb-oeuvre>
            <xsl:value-of select="count(document('catalogue-1.xml')//auteur[nom=$nom and prénom=$prenom])"/>
        </nb-oeuvre>
    </xsl:template>


</xsl:stylesheet>
