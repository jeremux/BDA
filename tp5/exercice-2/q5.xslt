<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Thu Feb 19 11:27:51 CET 2015 -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://labd/art"
                xpath-default-namespace="http://labd/art" >

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <art>
            <xsl:copy-of select="//artistes" copy-namespaces="no"/>
            <xsl:copy-of select="//mouvements" copy-namespaces="no"/>
            <oeuvres>
                <!-- on applique le template definit pour fichier de catalogues.xml -->
                <xsl:apply-templates select="document('catalogues.xml')//fichier"/>
            </oeuvres>
        </art>
    </xsl:template>


    <xsl:template match="fichier">
        <xsl:apply-templates select="." mode="apply">
            <!-- on recupère l'adresse des catalogues dans la variable pathCata -->
            <xsl:with-param name="pathCata" select="@uri"/>
        </xsl:apply-templates>
    </xsl:template>


    <xsl:template match="fichier" mode="apply">
        <xsl:param name="pathCata"/>
        <xsl:apply-templates select="document($pathCata)//oeuvre"/>
    </xsl:template>

    <xsl:template match="oeuvre">
        <oeuvre>
            <xsl:apply-templates select="document('artistes-avec-clefs.xml')//artistes">
                <xsl:with-param name="nom" select="auteur/nom/text()"/>
                <xsl:with-param name="prénom" select="auteur/prénom/text()"/>
            </xsl:apply-templates>
            <xsl:copy-of select="titre" copy-namespaces="no"/>
            <xsl:copy-of select="date" copy-namespaces="no" />
        </oeuvre>
    </xsl:template>

    <xsl:template match="artistes">
        <xsl:param name="nom"/>
        <xsl:param name="prénom"/>
        <xsl:attribute name="auteur" select="artiste[nom/text()=$nom and prénom/text()=$prénom]/@num"/>
    </xsl:template>

</xsl:stylesheet>
