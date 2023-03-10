<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- xmlns="http://www.w3.org/TR/REC-html40"> -->

<xsl:output method="xml"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="security-service">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:attribute name="default-realm">GPMSRealm</xsl:attribute>

    <xsl:element name="auth-realm">

      <xsl:attribute name="name">GPMSRealm</xsl:attribute>
      <xsl:attribute name="classname">de.cebitec.gpms.appserv.GPMSGlassfishRealm</xsl:attribute>

      <xsl:element name="property">
        <xsl:attribute name="name">jaas-context</xsl:attribute>
        <xsl:attribute name="value">GPMSRealm</xsl:attribute>
      </xsl:element>
      <xsl:element name="property">
        <xsl:attribute name="name">pool-size</xsl:attribute>
        <xsl:attribute name="value">10</xsl:attribute>
      </xsl:element>
      <xsl:element name="property">
        <xsl:attribute name="name">assign-groups</xsl:attribute>
        <xsl:attribute name="value">gpmsuser</xsl:attribute>
      </xsl:element>
      <xsl:element name="property">
        <xsl:attribute name="name">directory</xsl:attribute>
        <xsl:attribute name="value">ldap://infra.internal.computational.bio.uni-giessen.de:389</xsl:attribute>
      </xsl:element>
      <xsl:element name="property">
        <xsl:attribute name="name">base-dn</xsl:attribute>
        <xsl:attribute name="value">ou=users,dc=computational,dc=bio,dc=uni-giessen,dc=de</xsl:attribute>
      </xsl:element>

      <xsl:element name="property">
        <xsl:attribute name="name">search-filter</xsl:attribute>
        <xsl:attribute name="value">(|(&amp;(objectClass=gpmsExternalUser)(cn=%s))(&amp;(objectClass=gpmsInternalUser)(uid=%s)))</xsl:attribute>
      </xsl:element>

    </xsl:element> 

    <xsl:apply-templates/>

  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
