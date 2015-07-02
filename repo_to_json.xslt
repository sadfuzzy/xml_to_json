<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>
 
  <xsl:variable name="quote"><![CDATA[\\"]]></xsl:variable>

  <xsl:template match="REPOSITORY">
    <xsl:apply-templates select="PROJECT"/>
  </xsl:template>

  <xsl:template match="PROJECT">
    {
      <xsl:apply-templates select="child::*[child::*]" mode="root">
        <xsl:sort select="local-name()"/>
      </xsl:apply-templates>
    }
  </xsl:template>

  <xsl:template match="*" mode="root">
    "<xsl:value-of select="./NAME"/>":
    {
      "PROJECT_NAME": "<xsl:value-of select="../NAME"/>"<xsl:if test="count(child::*)&gt;0">,</xsl:if>
      <xsl:apply-templates select="." mode="object"/>
    }
  </xsl:template>

  <xsl:template match="*" mode="object">
    <xsl:for-each select="*[count(child::*)=0 and local-name() != 'NAME' and local-name() != 'UPDATED' and local-name() != 'UPDATED_BY' and local-name() != 'CREATED' and local-name() != 'CREATED_BY' and local-name() != 'OBJECT_LOCKED_DATE' and local-name() != 'OBJECT_LANGUAGE_LOCKED' and local-name() != 'OBJECT_LOCKED' and local-name() != 'OBJECT_LOCKED_BY_NAME']">
      <xsl:apply-templates select="." mode="attrib"/>
      <xsl:if test="position() != last() or count(../child::*[count(child::*)&gt;0])&gt;0">,</xsl:if>
    </xsl:for-each>

    <xsl:for-each-group select="*[count(child::*)&gt;0]" group-by="local-name()">
      "<xsl:value-of select="current-grouping-key()"/>":
      {
        <xsl:for-each select="current-group()">
          <xsl:apply-templates select="." mode="child"/>
          <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
      }
      <xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each-group>
  </xsl:template>

  <xsl:template match="*" mode="attrib">
    "<xsl:value-of select="local-name()"/>": "<xsl:value-of disable-output-escaping="yes" select="replace(., '&quot;', $quote)"/>"
  </xsl:template>

  <xsl:template match="*" mode="child">
    "<xsl:value-of select="./NAME"/>":
    {
      <xsl:apply-templates select="." mode="object"/>
    }
  </xsl:template>
</xsl:stylesheet>