<!--

XSLT Stylesheet to check the design and documentation conventions for the XSDs defining OJP.

-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:data="my:data">

	<xsl:import href="ojp-base.xsl"/>
	
	<!-- We're not producing XML output -->
	<xsl:output omit-xml-declaration="yes" method="text" indent="no"/>
	<xsl:strip-space elements="*"/>


	<xsl:template match="schema-collection">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- *** convention checking templates *** -->

	<xsl:template match="xs:schema[1]">
		<!-- Skipping OJP.xsd because of references to Siri XSDs. -->
		<xsl:message>Skipping... <xsl:apply-templates select="." mode="reference-text"/></xsl:message>
	</xsl:template>
	
	<xsl:template match="xs:schema">
		<xsl:message>Checking... <xsl:apply-templates select="." mode="reference-text"/></xsl:message>
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="xs:choice">
		<xsl:if test="count(*)=1">
			<xsl:message>\033[1;33m[WARN] xs:choice with just one child! Context: <xsl:call-template name="output-context"/>\033[0m</xsl:message>
		</xsl:if>
		<xsl:if test="xs:annotation/xs:documentation">
			<xsl:message>\033[0;31m[ERROR] Documentation is not allowed on xs:choice! Context: <xsl:call-template name="output-context"/>\033[0m</xsl:message>
		</xsl:if>

		<xsl:apply-templates/>
	</xsl:template>


	<xsl:template match="xs:group">
		<xsl:if test="@ref">
			<xsl:variable name="group-name" select="@ref"/>
			<!-- Resolve/expand the group reference --> 
			<xsl:variable name="resolved" select="//xs:group[@name = $group-name]"/>
			<xsl:if test="not($resolved) and not(starts-with($group-name, 'siri:'))">
				<xsl:message>\033[0;31m[ERROR] Group could not be resolved: <xsl:value-of select="@ref"/></xsl:message>
			</xsl:if>
			
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="xs:complexType">
		<xsl:if test="ancestor::xs:complexType and not(@name)">
			<xsl:message>\033[0;31m[ERROR] Unnamed complexTypes are not allowed inside complexTypes! Context: <xsl:call-template name="output-context"/>\033[0m</xsl:message>
		</xsl:if>
		
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xs:element">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="xs:sequence">
		<xsl:if test="xs:annotation/xs:documentation">
			<xsl:message>\033[0;31m[ERROR] Documentation is not allowed on xs:sequence! Context: <xsl:call-template name="output-context"/>\033[0m</xsl:message>
		</xsl:if>
		
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="xs:complexContent|xs:restriction|xs:extension">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xs:import|xs:include|xs:attribute|xs:simpleType|xs:simpleContent|xs:annotation">
		<!-- no further checks. -->
	</xsl:template>
	
	
	<xsl:template match="*">
		<xsl:message>\033[1;33m[WARN] Not implemented: <xsl:value-of select="name()"/>\033[0m</xsl:message>
	</xsl:template>

</xsl:stylesheet>
<!-- end of file -->
