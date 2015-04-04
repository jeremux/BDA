<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Thu Feb 12 11:24:01 CET 2015 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" indent="yes"/>


    <xsl:template match="/">
        <clubs>
            <!-- on applique la regle club -->
            <xsl:apply-templates select="//club"/>
        </clubs>
    </xsl:template>

    <!-- definition de la regle club -->
    <xsl:template match="club">
        <club>
            <!-- attribut id pour l'element club qu'on vient de créer -->
            <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <nom>
                <xsl:value-of select="nom"/>
            </nom>
            <ville>
                <xsl:value-of select="ville"/>
            </ville>

            <rencontres>
                <!-- on traite les rencontres à domicile -->
                <domicile>
                    <xsl:apply-templates select="//rencontre" mode="domicile">
                        <xsl:with-param name="idClub" select="@id"/>
                    </xsl:apply-templates>
                </domicile>

                <!-- on traite les rencontres à l'extérieur -->
                <exterieur>
                    <xsl:apply-templates select="//rencontre" mode="exterieur">
                        <xsl:with-param name="idClub" select="@id"/>
                    </xsl:apply-templates>
                </exterieur>

            </rencontres>
        </club>
    </xsl:template>

    <!--- definition du template rencontre avec le mode DOMICILE -->
    <xsl:template match="rencontre" mode="domicile">
        <xsl:param name="idClub"/>
        <!-- si id du club c'est le receveur alors c'est bien une rencontre à domicile
             on peut alors travailler sur le contenu de la rencontre -->
        <xsl:if test="$idClub = receveur/text()">
            <rencontre>
                <!-- attribut numéro de journéee -->
                <xsl:attribute name="num">
                    <xsl:apply-templates select="//journee" mode="getAtt">
                        <xsl:with-param name="idI" select="invite"/>
                        <xsl:with-param name="idR" select="receveur"/>
                    </xsl:apply-templates>
                </xsl:attribute>
                <!-- le receveur -->
                <club>
                    <xsl:apply-templates select="//club" mode="domicile">
                        <xsl:with-param name="idInvite" select="invite"/>
                    </xsl:apply-templates>
                </club>
                <!-- le score -->
                <score>
                    <xsl:value-of select="score"/>
                </score>
            </rencontre>
        </xsl:if>
    </xsl:template>

    <xsl:template match="club" mode="domicile">
        <xsl:param name="idInvite"/>
        <xsl:if test="$idInvite = @id">
            <xsl:value-of select="nom"/>
        </xsl:if>
    </xsl:template>

    <!-- De manière équivalente on définit le template
         avec le mode EXTERIEUR -->
    <xsl:template match="rencontre" mode="exterieur">
        <xsl:param name="idClub"/>
        <xsl:if test="$idClub = invite/text()">
            <rencontre>
                <xsl:attribute name="num" mode="getAtt">
                    <xsl:apply-templates select="//journee" mode="getAtt">
                        <xsl:with-param name="idI" select="invite"/>
                        <xsl:with-param name="idR" select="receveur"/>
                    </xsl:apply-templates>
                </xsl:attribute>
                <club>
                    <xsl:apply-templates select="//club" mode="exterieur">
                        <xsl:with-param name="idReceveur" select="receveur/text()"/>
                    </xsl:apply-templates>
                </club>
                <score>
                    <xsl:value-of select="score"/>
                </score>
            </rencontre>
        </xsl:if>
    </xsl:template>

    <xsl:template match="club" mode="exterieur">
        <xsl:param name="idReceveur"/>
        <xsl:if test="$idReceveur = @id">
            <xsl:value-of select="nom"/>
        </xsl:if>
    </xsl:template>

    <!-- pour recupérer le numéro de journéee -->
    <xsl:template match="journee" mode="getAtt">
        <xsl:param name="idI"/>
        <xsl:param name="idR"/>
        <xsl:if test="rencontre[receveur=$idR and invite=$idI]">
            <xsl:value-of select="@num"/>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>


