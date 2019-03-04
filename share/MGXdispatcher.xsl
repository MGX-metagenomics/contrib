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

<!-- change listener port to 4444 -->

<xsl:template match="configs/config/network-config/network-listeners/network-listener">
  <xsl:copy>

    <xsl:choose>
      <xsl:when test="@port = 8080">
        <xsl:attribute name="port">4444</xsl:attribute>
        <xsl:attribute name="protocol">http-listener-1</xsl:attribute>
        <xsl:attribute name="transport">tcp</xsl:attribute>
        <xsl:attribute name="name">http-listener-1</xsl:attribute>
        <xsl:attribute name="thread-pool">http-thread-pool</xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="@*"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:apply-templates/>

  </xsl:copy>
</xsl:template>


</xsl:stylesheet>
