<!--

XSLT Stylesheet with basic helpers for all XSLT Stylesheets here.

-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:data="my:data">


	<!-- *** Helper stuff *** -->


	<xsl:template name="output-context">
		<xsl:apply-templates select="ancestor-or-self::xs:schema[1]" mode="reference-text"/>
		<xsl:text>:&#x20;</xsl:text>
		<xsl:for-each select="ancestor-or-self::*[@name]">/<xsl:value-of select="@name"/></xsl:for-each>
	</xsl:template>

	<xsl:template match="*" mode="id">
		<xsl:if test="not(@name)">
			<xsl:message terminate="yes">Element <xsl:value-of select="name()"/> has no 'name' attribute!</xsl:message>
		</xsl:if>
		<xsl:value-of select="@name"/>
	</xsl:template>

	<xsl:template name="schema-filename">
		<xsl:variable name="path" select="substring-before(xs:annotation/xs:documentation, '.xsd')"/>
		<xsl:choose>
			<xsl:when test="contains($path, '/')">
				<xsl:value-of select="substring-after($path, '/')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$path"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="xs:schema" mode="id">
		<xsl:variable name="filename">
			<xsl:call-template name="schema-filename"/>
		</xsl:variable>
		<xsl:value-of select="concat('schema_', $filename)"/>
	</xsl:template>
	
	<xsl:template match="*" mode="reference-text">
		<xsl:if test="not(@name)">
			<xsl:message terminate="yes">Element <xsl:value-of select="name()"/> has no 'name' attribute!</xsl:message>
		</xsl:if>
		<xsl:value-of select="@name"/>
	</xsl:template>

	<xsl:template match="xs:schema" mode="reference-text">
		<xsl:call-template name="schema-filename"/>
		<xsl:text>.xsd</xsl:text>
	</xsl:template>

</xsl:stylesheet>
<!-- end of file -->
