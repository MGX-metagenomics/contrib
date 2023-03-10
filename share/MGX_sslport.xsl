<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="network-config/network-listeners/network-listener[@port='8080']">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:attribute name="port">80</xsl:attribute>
  </xsl:copy>
</xsl:template>

<xsl:template match="network-config/network-listeners/network-listener[@port='8181']">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:attribute name="port">443</xsl:attribute>
  </xsl:copy>
</xsl:template>

<xsl:template match="network-config/protocols/protocol[@name='http-listener-2']/ssl">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:attribute name="ssl3-enabled">true</xsl:attribute>
    <xsl:attribute name="tls13-enabled">true</xsl:attribute>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
