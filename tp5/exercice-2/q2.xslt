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
        <!-- Pour chaque artiste on ne copie que les parties intéressantes: nom,prénom,...,période -->
        <artiste>
            <xsl:copy-of select="nom" copy-namespaces="no"/>
            <xsl:copy-of select="prénom" copy-namespaces="no"/>
            <xsl:copy-of select="naissance" copy-namespaces="no"/>
            <xsl:copy-of select="décès" copy-namespaces="no"/>
            <xsl:copy-of select="nom" copy-namespaces="no"/>
            <xsl:copy-of select="période" copy-namespaces="no"/>
            <xsl:apply-templates select="." mode="Oeuvre">
                <xsl:with-param name="nom" select="nom/text()"/>
                <xsl:with-param name="prenom" select="prénom/text()"/>
            </xsl:apply-templates>
        </artiste>
    </xsl:template>

    <xsl:template match="artiste" mode="Oeuvre">
        <xsl:param name="nom"/>
        <xsl:param name="prenom"/>
        <!-- on ne travaille que sur les oeuvres de l'artiste courant -->
        <xsl:apply-templates select="document('catalogue-1.xml')//oeuvre[auteur/nom=$nom and auteur/prénom=$prenom]">
            <!-- on trie les oeuvre par date -->
            <xsl:sort select="date"/>
        </xsl:apply-templates>
    </xsl:template>

    <!-- definition du template pour le document catalogue-1.xml -->
    <xsl:template match="oeuvre">
        <oeuvre>
            <xsl:copy-of select="titre" copy-namespaces="no"/>
            <xsl:copy-of select="date" copy-namespaces="no"/>
        </oeuvre>
    </xsl:template>



</xsl:stylesheet>
