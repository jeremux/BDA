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
                <xsl:apply-templates select="document('catalogue-1.xml')//oeuvre">
                </xsl:apply-templates>
            </oeuvres>
        </art>
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
        <!-- pour l'attribut auteur de l'oeuvre
        on recupère la bonne clef définit dans artistes-avec-clefs.xml (fichier resultant de q3.xslt -->
        <xsl:attribute name="auteur" select="artiste[nom/text()=$nom and prénom/text()=$prénom]/@num"/>
    </xsl:template>

</xsl:stylesheet>
