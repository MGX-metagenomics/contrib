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

<xsl:template match="domain/resources">
  <xsl:copy>

    <xsl:copy-of select="@*"/>

    <!-- GPMS connection pool -->

    <xsl:element name="jdbc-connection-pool">
      <xsl:attribute name="datasource-classname">com.mysql.jdbc.jdbc2.optional.MysqlDataSource</xsl:attribute>
      <xsl:attribute name="steady-pool-size">0</xsl:attribute>
      <xsl:attribute name="name">GPMSPool</xsl:attribute>
      <xsl:element name="property">
        <xsl:attribute name="name">user</xsl:attribute>
        <xsl:attribute name="value">gpms_anon</xsl:attribute>
      </xsl:element>
      <xsl:element name="property">
        <xsl:attribute name="name">databaseName</xsl:attribute>
        <xsl:attribute name="value">gpmsdb_test</xsl:attribute>
      </xsl:element>
      <xsl:element name="property">
        <xsl:attribute name="name">serverName</xsl:attribute>
        <xsl:attribute name="value">dbhost</xsl:attribute>
      </xsl:element>
      <xsl:element name="property">
        <xsl:attribute name="name">password</xsl:attribute>
        <xsl:attribute name="value"></xsl:attribute>
      </xsl:element>
    </xsl:element>

    <xsl:element name="jdbc-resource">
      <xsl:attribute name="pool-name">GPMSPool</xsl:attribute>
      <xsl:attribute name="jndi-name">jdbc/GPMS</xsl:attribute>
    </xsl:element>

    <xsl:apply-templates/>

  </xsl:copy>
</xsl:template>

<xsl:template match="servers/server">
  <xsl:copy>

    <xsl:copy-of select="@*"/>

    <xsl:element name="resource-ref">
      <xsl:attribute name="ref">jdbc/GPMS</xsl:attribute>
    </xsl:element>

    <xsl:apply-templates/>

  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
