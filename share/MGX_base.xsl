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

    <!-- MGX global database pool -->
    <xsl:element name="jdbc-connection-pool">
      <xsl:attribute name="datasource-classname">org.postgresql.ds.PGPoolingDataSource</xsl:attribute>
      <xsl:attribute name="steady-pool-size">0</xsl:attribute>
      <xsl:attribute name="name">MGXGlobalPool</xsl:attribute>
      <xsl:element name="property">
        <xsl:attribute name="name">user</xsl:attribute>
        <xsl:attribute name="value">mgx_global</xsl:attribute>
      </xsl:element>
      <xsl:element name="property">
        <xsl:attribute name="name">databaseName</xsl:attribute>
        <xsl:attribute name="value">MGX2_global</xsl:attribute>
      </xsl:element>
      <xsl:element name="property">
        <xsl:attribute name="name">serverName</xsl:attribute>
<<<<<<< HEAD
        <xsl:attribute name="value">postgresql-15.intra</xsl:attribute>
      </xsl:element>
      <xsl:element name="property">
        <xsl:attribute name="name">password</xsl:attribute>
        <xsl:attribute name="value">password-for-db-access</xsl:attribute>
=======
        <xsl:attribute name="value">postgresql.database.host</xsl:attribute>
      </xsl:element>
      <xsl:element name="property">
        <xsl:attribute name="name">password</xsl:attribute>
        <xsl:attribute name="value">secret</xsl:attribute>
>>>>>>> ad383145ea3c075ab8602cc29dc1276ad874e43d
      </xsl:element>
    </xsl:element>

    <xsl:element name="jdbc-resource">
      <xsl:attribute name="pool-name">MGXGlobalPool</xsl:attribute>
      <xsl:attribute name="jndi-name">jdbc/MGXGlobal</xsl:attribute>
    </xsl:element>

    <xsl:apply-templates/>

  </xsl:copy>
</xsl:template>

<xsl:template match="servers/server">
  <xsl:copy>

    <xsl:copy-of select="@*"/>

    <xsl:element name="resource-ref">
      <xsl:attribute name="ref">jdbc/MGXGlobal</xsl:attribute>
    </xsl:element>

    <xsl:apply-templates/>

  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
