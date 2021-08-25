<!--

XSLT Stylesheet extending ojp-prep-to-html.xsl and adding a table of contents.

-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:data="my:data">

	<xsl:import href="ojp-prep-to-html.xsl"/>


	<xsl:template name="pre-content">
		<div id="header">
			<h1>OJP - <strong>O</strong>pen API for distributed <strong>J</strong>ourney <strong>P</strong>lanning</h1>
			<div id="toc" class="toc">
				<div id="toctitle">Table of Contents</div>
				<ul class="sectlevel1">
					<xsl:apply-templates mode="toc"/>
				</ul>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="schema" mode="toc">
		<li><a href="#{@id}"><xsl:apply-templates select="." mode="chapter-number"/><xsl:text> </xsl:text><xsl:value-of select="title"/></a>
			<ul class="sectlevel2">
				<xsl:apply-templates mode="toc"/>
			</ul>
		</li>
	</xsl:template>

	<xsl:template match="chapter" mode="toc">
		<li><a href="#{@id}"><xsl:apply-templates select="." mode="chapter-number"/><xsl:text> </xsl:text><xsl:apply-templates select="title"/></a></li>
	</xsl:template>

	<xsl:template match="simple-type-definitions" mode="toc">
		<li><a href="#{../@id}_std"><xsl:apply-templates select="." mode="chapter-number"/> Simple type definitions</a></li>
	</xsl:template>
	
	<xsl:template match="schema" mode="chapter-number">
		<xsl:value-of select="count(preceding-sibling::schema) + 1"/>
		<xsl:text>.</xsl:text>
	</xsl:template>
	
	<xsl:template match="chapter|simple-type-definitions" mode="chapter-number">
		<xsl:apply-templates select=".." mode="chapter-number"/>
		<xsl:value-of select="count(preceding-sibling::*[self::chapter|self::simple-type-definitions]) + 1"/>
		<xsl:text>.</xsl:text>
	</xsl:template>
	
	<xsl:template match="*" mode="toc">
		<!-- ignore -->
	</xsl:template>

	<!-- title mode -->

	<xsl:template match="schema" mode="title">
		<xsl:apply-templates select="." mode="chapter-number"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="title"/>
	</xsl:template>
	
	<xsl:template match="chapter" mode="title">
		<xsl:apply-templates select="." mode="chapter-number"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="title"/>
	</xsl:template>
	
	<xsl:template match="simple-type-definitions" mode="title">
		<xsl:apply-templates select="." mode="chapter-number"/>
		<xsl:text> </xsl:text>
		<xsl:text>Simple type definitions</xsl:text>
	</xsl:template>
	
</xsl:stylesheet>
<!-- end of file -->
