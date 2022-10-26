<!--
  
  XSLT stylesheet to convert the pre-processed XSD documentation describing OJP
  to HTML.
  
-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:common="http://exslt.org/common"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:data="my:data"
	exclude-result-prefixes="data xs"
	extension-element-prefixes="common">

	<xsl:output omit-xml-declaration="yes" method="xml" indent="yes"/>

	<xsl:param name="debug" select="0"/>

	<!-- *** Helper stuff *** -->

	<!-- Writes context information about the place where a problem occurs -->
	<xsl:template name="output-context">
		<xsl:apply-templates select="ancestor-or-self::*[@context][1]/@context" mode="reference-text"/>
		<xsl:text>:&#x20;</xsl:text>
		<xsl:for-each select="ancestor-or-self::*[@name]">/<xsl:value-of select="@name"/></xsl:for-each>
	</xsl:template>


	<xsl:template name="output-id-and-ref-text">
		<xsl:variable name="reference-text">
			<xsl:apply-templates select="." mode="reference-text"/>
		</xsl:variable>
	</xsl:template>

	
	<!-- *** schema *** -->
	
	<xsl:template match="/schema-documentation">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
		<html xml:lang="en" lang="en">
			<head>
				<title>OJP - Open API for distributed Journey Planning</title>
				<meta charset="UTF-8"/>
				<meta http-equiv="content-type" content="text/html;charset=UTF-8"/>
				<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
				<script type="text/javascript"><xsl:text disable-output-escaping='yes'>
					<![CDATA[
					document.addEventListener('DOMContentLoaded', function() {
						var headers = ['h2', 'h3', 'h4', 'h5', 'h6'];
						for (var i = 0; i < headers.length; i++) {
							var headerElements = document.getElementsByTagName(headers[i]);
							for (var j = 0; j < headerElements.length; j++) {
								var header = headerElements[j];
								header.innerHTML += '<a class="header-link" href="#' + header.parentNode.id + '"><span class="link-icon"></span></a>';
							}
						}
					});
					]]>
				</xsl:text></script>
				<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,300italic,400,400italic,600,600italic%7CNoto+Serif:400,400italic,700,700italic%7CDroid+Sans+Mono:400,700"/>
				<link rel="stylesheet" href="asciidoc.css"/>
				<style><xsl:text disable-output-escaping='yes'>
					<![CDATA[
					.header-link {
						position: relative;
						font-size: 0.65em;
						left: 0.5em;
						opacity: 0;

						-webkit-transition: opacity 0.2s ease-in-out 0.1s;
						-moz-transition: opacity 0.2s ease-in-out 0.1s;
						-ms-transition: opacity 0.2s ease-in-out 0.1s;
					}

					h2:hover .header-link,
					h3:hover .header-link,
					h4:hover .header-link,
					h5:hover .header-link,
					h6:hover .header-link {
						opacity: 1;
					}

					.link-icon {
						width: 22px;
						height: 18px;
						display: inline-block;
						background: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 640 512'%3e%3c!--! Font Awesome Pro 6.2.0 by %40fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2022 Fonticons%2c Inc.--%3e%3cpath d='M579.8 267.7c56.5-56.5 56.5-148 0-204.5-50-50-128.8-56.5-186.3-15.4l-1.6 1.1c-14.4 10.3-17.7 30.3-7.4 44.6s30.3 17.7 44.6 7.4l1.6-1.1c32.1-22.9 76-19.3 103.8 8.6 31.5 31.5 31.5 82.5 0 114L422.3 334.8c-31.5 31.5-82.5 31.5-114 0-27.9-27.9-31.5-71.8-8.6-103.8l1.1-1.6c10.3-14.4 6.9-34.4-7.4-44.6s-34.4-6.9-44.6 7.4l-1.1 1.6C206.5 251.2 213 330 263 380c56.5 56.5 148 56.5 204.5 0l112.3-112.3zM60.2 244.3c-56.5 56.5-56.5 148 0 204.5 50 50 128.8 56.5 186.3 15.4l1.6-1.1c14.4-10.3 17.7-30.3 7.4-44.6s-30.3-17.7-44.6-7.4l-1.6 1.1c-32.1 22.9-76 19.3-103.8-8.6C74 372 74 321 105.5 289.5l112.2-112.3c31.5-31.5 82.5-31.5 114 0 27.9 27.9 31.5 71.8 8.6 103.9l-1.1 1.6c-10.3 14.4-6.9 34.4 7.4 44.6s34.4 6.9 44.6-7.4l1.1-1.6C433.5 260.8 427 182 377 132c-56.5-56.5-148-56.5-204.5 0L60.2 244.3z'/%3e%3c/svg%3e") no-repeat;
					}
					]]>
				</xsl:text></style>
			</head>
			<body class="article">
				<xsl:call-template name="pre-content"/>
				<div id="content">
					<xsl:apply-templates/>
				</div>
				<xsl:call-template name="post-content"/>
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template name="pre-content">
		<!-- override me, for example for a table of contents -->
	</xsl:template>
	
	<xsl:template name="post-content">
		<!-- override me -->
	</xsl:template>


	<xsl:template match="schema|chapter" mode="title">
		<xsl:apply-templates select="title"/>
	</xsl:template>

	<xsl:template match="simple-type-definitions" mode="title">
		<xsl:text>Simple type definitions</xsl:text>
	</xsl:template>
	

	<xsl:template match="*" mode="title">
		<xsl:message terminate="yes">Invalid element for mode='title': <xsl:call-template name="output-context"></xsl:call-template></xsl:message>
	</xsl:template>
		
	<xsl:template name="css-stylesheet">
		<xsl:variable name="css">
			<xi:include xmlns:xi="http://www.w3.org/2001/XInclude"
				parse="text" encoding="UTF-8"
				href="asciidoc.css"/>
		</xsl:variable>
		<style>
			<xsl:copy-of select="$css"/>
		</style>
	</xsl:template>
	
	<xsl:template match="schema">
	  <xsl:comment>========================================================= schema <xsl:value-of select="@id"/></xsl:comment>
	  <div class="sect1" id="{@id}">
			<xsl:call-template name="output-id-and-ref-text"/>
			<h2>
				<xsl:apply-templates select="." mode="chapter-number"/><xsl:text> </xsl:text>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="title"/>
			</h2>
			<div class="sectionbody">
				<xsl:apply-templates select="*[not(self::title)]"/>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="schema|chapter" mode="id">
		<xsl:value-of select="@id"/>
	</xsl:template>
	
	<xsl:template match="schema|chapter" mode="reference-text">
		<xsl:value-of select="@reference-text"/>
	</xsl:template>
	
	
	<!-- *** Simple Types *** -->

	<xsl:template match="simple-type-definitions">
		<div id="{../@id}_std" class="simple-type-definitions">
			<h3>
				<xsl:apply-templates select="." mode="title"/>
			</h3>
			<div class="sectionbody">
				<table class="tableblock frame-all grid-all spread">
					<colgroup>
						<col style="width:28%"/>
						<col style="width:28%"/>
						<col style="width:44%"/>
					</colgroup>
					<tbody>
						<xsl:apply-templates/>
					</tbody>
				</table>
			</div>
		</div>
	</xsl:template>
	
	
	<xsl:template match="simple-type">
		<tr>
			<td class="tableblock halign-left valign-top">
				<p class="tableblock" id="{@name}">
					<code><xsl:value-of select="@name"/></code>
				</p>
			</td>
			<td class="tableblock halign-left valign-top">
				<p class="tableblock">
					<xsl:apply-templates select="definition"/>
					<xsl:choose>
						<xsl:when test="(xs:restriction/@base = 'xs:string' or xs:restriction/@base = 'xs:NMTOKEN') and xs:restriction/xs:enumeration">
							<xsl:for-each select="xs:restriction/xs:enumeration">
								<xsl:if test="position() &gt; 1">
									<xsl:text> | </xsl:text>
								</xsl:if>
								<xsl:value-of select="@value"/>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="xs:restriction/@base"/>
						</xsl:otherwise>
					</xsl:choose>
				</p>
			</td>
			<td class="tableblock halign-left valign-top">
				<p class="tableblock">
					<xsl:apply-templates select="documentation"/>
				</p>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="simple-type/definition">
		<xsl:choose>
			<xsl:when test="enum">
				<xsl:for-each select="enum">
					<xsl:if test="position() &gt; 1">
						<xsl:text> |&#160;</xsl:text>
					</xsl:if>
					<xsl:value-of select="."/>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- *** chapters *** -->
	
	<xsl:template match="chapter">
	  <xsl:comment>======================================= chapter <xsl:value-of select="@id"/></xsl:comment>
		<div id="{@id}" class="sect2">
			<xsl:call-template name="output-id-and-ref-text"/>
			<h3>
				<xsl:apply-templates select="." mode="title"/>
			</h3>
			<div class="sectionbody">
				<xsl:apply-templates select="*[not(self::title)]"/>
			</div>
		</div>
	</xsl:template>
	
	<!-- *** main table *** -->
	
	<xsl:template match="table">
		<table class="tableblock frame-all grid-all spread">
			<colgroup>
				<col style="width:{10 div 84 * 100}%"/> <!-- group -->
				<col style="width:{1 div 84 * 100}%"/> <!-- option -->
				<col style="width:{10 div 84 * 100}%"/> <!-- element name -->
				<col style="width:{1 div 84 * 100}%"/> <!-- min/max -->
				<col style="width:{20 div 84 * 100}%"/> <!-- type -->
				<col style="width:{30 div 84 * 100}%"/> <!-- description -->
			</colgroup>
			<tbody>
				<xsl:apply-templates/>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template match="type-description">
		<xsl:comment>======= type-description</xsl:comment>
		<tr>
			<td class="tableblock halign-left valign-top" colspan="4">
				<p class="tableblock">
					<xsl:apply-templates select="name" mode="code"/>
				</p>
			</td>
			<td class="tableblock halign-left valign-top" colspan="1">
				<p class="tableblock">
					<xsl:if test="type">
	  					<xsl:apply-templates select="type" mode="italic"/>
						<xsl:if test="type/@substitutionGroup">
							<xsl:text> (</xsl:text>
							<em>
								<xsl:value-of select="concat('↔&#160;', type/@substitutionGroup)"/>
							</em>
							<xsl:text>)</xsl:text>
						</xsl:if>
					</xsl:if>
				</p>
			</td>
			<td class="tableblock halign-left valign-top">
				<p class="tableblock">
					<xsl:apply-templates select="documentation"/>
				</p>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="table/line">
		<xsl:comment>======= line</xsl:comment>
		<tr>
			<td class="tableblock halign-left valign-top" colspan="6">
				<p class="tableblock">
					<xsl:apply-templates select="node()"/>
				</p>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="table/row">
		<xsl:comment>======= row</xsl:comment>
		<tr>
			<xsl:variable name="group-ref" select="group/xref/@ref"/>
			<xsl:if test="group and not(preceding-sibling::row[1][group/xref/@ref = $group-ref])">
				<!-- Create row-spanned cell on first row with a group -->
				<td class="tableblock halign-left valign-top">

					<xsl:attribute name="rowspan">
						<xsl:variable name="first-of-next-group" select="following-sibling::*[not(group) or group/xref/@ref != $group-ref][1]"/>
						<xsl:variable name="first-of-next-group-position">
							<xsl:choose>
								<xsl:when test="$first-of-next-group">
									<xsl:value-of select="count($first-of-next-group/preceding-sibling::*)"/>
								</xsl:when>
								<xsl:otherwise>
									<!-- this is the last group with no rows following this group, so just count the remaining rows in the group -->
									<xsl:value-of select="count(preceding-sibling::*) + count(following-sibling::*) + 1"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="rowspan" select="$first-of-next-group-position - count(preceding-sibling::*)"/>
						<xsl:value-of select="$rowspan"/>
						<xsl:if test="$debug &gt; 0 and ancestor::chapter/@id = 'StopCallStatusGroup'">
							<xsl:message>rowspan: <xsl:value-of select="$group-ref"/>: <xsl:value-of select="$rowspan"/> <xsl:call-template name="output-context"></xsl:call-template></xsl:message>
							<xsl:message>
								<xsl:value-of select="count(following-sibling::*[group/xref/@ref != $group-ref])"/>
								<xsl:text>-</xsl:text>
								<xsl:value-of select="$rowspan"/>
								<xsl:text>-</xsl:text>
								<xsl:value-of select="$first-of-next-group"/>
								
							</xsl:message>
						</xsl:if>
					</xsl:attribute>
					<xsl:apply-templates select="group/node()"/>
				</td>	
			</xsl:if>
			<xsl:if test="not(group)">
				<!-- Create empty cell when there's no group -->
				<td class="tableblock halign-left valign-top">
					<!-- empty cell -->
					<p class="tableblock"/>
				</td> 
			</xsl:if>
			<xsl:if test="option">
				<td class="tableblock halign-left valign-top">
					<p class="tableblock">
						<xsl:apply-templates select="option" mode="italic"/>
					</p>
				</td>
			</xsl:if>
			<td class="tableblock halign-left valign-top">
				<xsl:attribute name="colspan">
					<xsl:choose>
						<xsl:when test="option">
							<!--xsl:value-of select="1 + ($max-depth - $depth - 1)"/-->
							<xsl:value-of select="1"/>
						</xsl:when>
						<xsl:otherwise>
							<!--xsl:value-of select="2 + ($max-depth - $depth - 1)"/-->
							<xsl:value-of select="2"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<p class="tableblock">
					<xsl:apply-templates select="name" mode="code"/>
				</p>
			</td>
			<td class="tableblock halign-left valign-top">
				<p class="tableblock">
					<xsl:apply-templates select="cardinality"/>
				</p>
			</td>
			<td class="tableblock halign-left valign-top">
				<p class="tableblock">
					<xsl:apply-templates select="type" mode="italic"/>
				</p>
			</td>
			<td class="tableblock halign-left valign-top">
				<p class="tableblock">
					<xsl:apply-templates select="documentation"/>
				</p>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="cardinality">
		<xsl:choose>
			<xsl:when test="@class = 'bold'">
				<strong>
					<xsl:call-template name="explain-cardinality"/>
					<xsl:value-of select="."/>
				</strong>
			</xsl:when>
			<xsl:otherwise>
				<span>
					<xsl:call-template name="explain-cardinality"/>
					<xsl:value-of select="."/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<data:explained-cardinalities>
		<data:case name="0:1">optional, single</data:case>
		<data:case name="0:*">optional, multiple</data:case>
		<data:case name="1:1">mandatory, single</data:case>
		<data:case name="1:*">mandatory, at least one</data:case>
		<data:case name="-0:1">optional, single, part of a choice</data:case>
		<data:case name="-0:*">optional, multiple, part of a choice</data:case>
		<data:case name="-1:1">mandatory, single, part of a choice</data:case>
		<data:case name="-1:*">mandatory, at least one, part of a choice</data:case>
	</data:explained-cardinalities>
	<xsl:variable name="explained-cardinalities" select="document('')/xsl:stylesheet/data:explained-cardinalities"/>

	<xsl:template name="explain-cardinality">
		<xsl:param name="cardinality" select="."/>
		<xsl:variable name="explanation" select="$explained-cardinalities/data:case[@name = $cardinality]"/>
		<xsl:if test="$explanation">
			<xsl:attribute name="title">
				<xsl:value-of select="string($explanation)"/>
			</xsl:attribute>
		</xsl:if>
	</xsl:template>

	<!-- *** various *** -->
	
	<xsl:template match="name|title">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="code">
		<xsl:apply-templates select="." mode="code"/>
	</xsl:template>
	
	<xsl:template match="span[@class='bold']">
		<xsl:apply-templates  select="." mode="bold"/>
	</xsl:template>
	
	<xsl:template match="span">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xref">
	  <a href="#{@ref}" title="{@ref}">
	    <xsl:apply-templates/>
	  </a>
	</xsl:template>

	<!-- *** formatting *** -->

	<xsl:template match="*" mode="code">
		<code>
			<xsl:apply-templates/>
		</code>
	</xsl:template>
	
	<xsl:template match="text()" mode="code">
		<code>
			<xsl:value-of select="."/>
		</code>
	</xsl:template>
	
	<xsl:template match="*" mode="bold">
		<strong>
			<xsl:apply-templates/>
		</strong>
	</xsl:template>
	
	<xsl:template match="text()" mode="bold">
		<strong>
			<xsl:value-of select="."/>
		</strong>
	</xsl:template>
	
	<xsl:template match="*" mode="italic">
		<em>
			<xsl:apply-templates/>
		</em>
	</xsl:template>
	
	<xsl:template match="text()" mode="italic">
		<em>
			<xsl:value-of select="."/>
		</em>
	</xsl:template>
	
	<xsl:template match="em|strong|code">
		<xsl:copy>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	
	<!-- *** catch-all *** -->
	
	<xsl:template match="documentation">
		<xsl:value-of select="."/>
	</xsl:template>
	
	<xsl:template match="comment()">
		<xsl:copy-of select="."/>
	</xsl:template>
	
	<xsl:template match="*">
		<!-- ignore anything not especially handled in chapter mode. -->
		<xsl:message>Element not implemented, yet: <xsl:value-of select="name()"/></xsl:message>
	</xsl:template>

</xsl:stylesheet>
<!-- end of file -->
