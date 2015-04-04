<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Thu Feb 12 11:24:01 CET 2015 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" indent="yes"/>


    <xsl:template match="/">
        <xsl:apply-templates select="//journee">
            <!-- declaration de la variable n -->
            <xsl:with-param name="n" select="18"/>
        </xsl:apply-templates>

    </xsl:template>

    <!-- regle pour la balise journee -->
    <xsl:template match="//journee">
        <!-- utilisation de la variable n -->
        <xsl:param name="n"/>
        <!-- si le numero de journee est egale à n alors on copie la journee -->
        <xsl:if test="$n = @num">
            <xsl:copy-of select="."/>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>


