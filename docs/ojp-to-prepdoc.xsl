<!--

XSLT stylesheet to convert the XSDs describing OJP to an intermediate XML
format in preparation to generate the documentation.

-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:data="my:data"
	exclude-result-prefixes="data xs">

	<xsl:import href="ojp-base.xsl"/>
	
	<xsl:output method="xml" indent="no"/>

	<!-- *** Helper stuff *** -->

	<xsl:variable name="max-depth" select="2"/>

	<data:letters>
		<letter>a</letter>
		<letter>b</letter>
		<letter>c</letter>
		<letter>d</letter>
		<letter>e</letter>
		<letter>f</letter>
		<letter>g</letter>
		<letter>h</letter>
		<letter>i</letter>
		<letter>j</letter>
		<letter>k</letter>
		<letter>l</letter>
		<letter>m</letter>
		<letter>n</letter>
		<letter>o</letter>
		<letter>p</letter>
		<letter>q</letter>
		<letter>r</letter>
		<letter>s</letter>
		<letter>t</letter>
		<letter>u</letter>
		<letter>v</letter>
		<letter>w</letter>
		<letter>x</letter>
		<letter>y</letter>
		<letter>z</letter>
	</data:letters>
	<xsl:variable name="abc" select="document('')/xsl:stylesheet/data:letters"/>
	

	<!-- Output cardinality as 0:1, 1:1, 1:* etc.-->
	<xsl:template name="output-cardinality">
		<xsl:variable name="min">
			<xsl:choose>
				<xsl:when test="@minOccurs"><xsl:value-of select="@minOccurs"/></xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="max">
			<xsl:choose>
				<xsl:when test="@maxOccurs = 'unbounded'">*</xsl:when>
				<xsl:when test="@maxOccurs"><xsl:value-of select="@maxOccurs"/></xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<cardinality>
			<xsl:if test="$min = 1">
				<!-- If mandatory, make it bold. -->
				<xsl:attribute name="class">bold</xsl:attribute>
			</xsl:if>
			<xsl:if test="ancestor::xs:choice[1]">
				<xsl:text>-</xsl:text>
			</xsl:if>
			<xsl:value-of select="$min"/>
			<xsl:text>:</xsl:text>
			<xsl:value-of select="$max"/>
		</cardinality>
	</xsl:template>

	<xsl:template match="xs:element|xs:attribute" mode="type">
		<xsl:param name="referenced"/>
		<!--xsl:variable name="eff-type" select="@type"/-->
		<!--
		<xsl:message><xsl:value-of select="name()"/>: <xsl:value-of select="@type"/>|<xsl:value-of select="@ref"/></xsl:message>
		-->
		<xsl:choose>
			<xsl:when test="@type">
				<type>
					<xsl:copy-of select="@substitutionGroup"/>
					<xsl:call-template name="output-name-ref">
						<xsl:with-param name="name" select="@type"/>
						<xsl:with-param name="referenced" select="$referenced"/>
						<xsl:with-param name="remove-suffix" select="'Structure'"/>
					</xsl:call-template>
				</type>
			</xsl:when>
			<xsl:when test="self::xs:element/@ref">
				<xsl:variable name="ref-name" select="@ref"/>
				<xsl:variable name="referenced-element" select="//xs:element[@name = $ref-name]"/>
				<!--
					<xsl:message>@ref <xsl:value-of select="name()"/>: <xsl:value-of select="$ref-name"/></xsl:message>
				-->
				<!--
				<xsl:apply-templates select="$referenced-element" mode="type">
					<xsl:with-param name="referenced">true</xsl:with-param>
				</xsl:apply-templates>
				-->
				<type>
					<xsl:call-template name="output-name-ref">
						<xsl:with-param name="name" select="$ref-name"/>
						<xsl:with-param name="referenced">true</xsl:with-param>
					</xsl:call-template>
				</type>
				
			</xsl:when>
			<xsl:when test="self::xs:element">
				<!-- root element inline type -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:message terminate="yes">Unhandled case for <xsl:call-template name="output-context"/></xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="xs:complexType" mode="type">
		<xsl:variable name="eff-type" select="(xs:simpleType/xs:restriction/@base|xs:complexContent/xs:extension/@base|xs:simpleContent/xs:extension/@base)[1]"/>
		<!--
		<xsl:message><xsl:value-of select="name()"/>: <xsl:value-of select="@ref"/></xsl:message>
		-->
		<xsl:choose>
			<xsl:when test="$eff-type">
				<type>
					<xsl:call-template name="output-name-ref">
						<xsl:with-param name="name" select="$eff-type"/>
					</xsl:call-template>
				</type>
			</xsl:when>
			<xsl:otherwise>
				<!--xsl:message terminate="yes">Unhandled case for <xsl:value-of select="name()"/>: <xsl:call-template name="output-context"/></xsl:message-->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*" mode="type">
		<xsl:message terminate="yes">Unhandled case for mode 'type' on <xsl:value-of select="name()"/>: <xsl:call-template name="output-context"/></xsl:message>
	</xsl:template>
		
	<xsl:template match="xs:element|xs:attribute|xs:group|xs:simpleType" mode="documentation">
		<xsl:if test="@fixed">
			<p>
				<xsl:text>Fixed value: "</xsl:text>
				<xsl:value-of select="@fixed"/>
				<xsl:text>"</xsl:text>
			</p>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="xs:annotation">
				<xsl:apply-templates select="xs:annotation"/>
			</xsl:when>
			<xsl:when test="@ref">
				<xsl:variable name="ref-name" select="@ref"/>
				<xsl:variable name="referenced-element" select="//xs:element[@name = $ref-name]"/>
				<xsl:apply-templates select="$referenced-element" mode="documentation"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="*" mode="documentation">
		<xsl:message terminate="yes">Unhandled case for mode 'documentation' on <xsl:value-of select="name()"/>: <xsl:call-template name="output-context"/></xsl:message>
	</xsl:template>
	
	
	<xsl:template name="output-name-ref">
		<xsl:param name="name" select="(@name|'[MISSING]')[1]"/>
		<xsl:param name="remove-suffix"/>
		<xsl:param name="referenced"/>
		<xsl:if test="string-length($name) = 0">
			<xsl:message>output-name-ref: name is empty! <xsl:call-template name="output-context"/></xsl:message>
		</xsl:if>
		<xsl:variable name="title">
			<xsl:choose>
				<xsl:when test="$remove-suffix and contains($name, $remove-suffix)">
					<xsl:value-of select="substring-before($name, $remove-suffix)"/>
				</xsl:when>
				<xsl:when test="contains($name, 'Structure')">
					<xsl:value-of select="substring-before($name, 'Structure')"/>
				</xsl:when>
				<xsl:when test="contains($name, 'Enumeration')">
					<xsl:value-of select="substring-before($name, 'Enumeration')"/>
				</xsl:when>
				<xsl:when test="contains($name, 'Type')">
					<xsl:value-of select="substring-before($name, 'T')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$name"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="referenced-complexType" select="//xs:complexType[@name = $name]"/>
		<!--xsl:variable name="referenced-simpleType" select="//xs:simpleType[@name = $name]"/-->
		<xsl:choose>
			<xsl:when test="$referenced = 'true'">
				<xsl:text>→&#x200D;</xsl:text>
			</xsl:when>
			<xsl:when test="$referenced-complexType">
				<xsl:text>+</xsl:text>
			</xsl:when>
		</xsl:choose>
		
		
		<xsl:choose>
			<xsl:when test="starts-with($name, 'siri:')">
				<xsl:value-of select="$name"/>
			</xsl:when>
			<xsl:when test="starts-with($name, 'xs:')">
				<xsl:value-of select="$name"/>
			</xsl:when>
			<xsl:otherwise>
				<xref ref="{$name}">
					<xsl:value-of select="$title"/>
				</xref>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="output-name-or-ref">
		<xsl:param name="bold" select="'false'"/>
		<xsl:choose>
			<xsl:when test="@name">
				<span>
					<xsl:if test="$bold = 'true'">
						<xsl:attribute name="class">bold</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="@name"/>
				</span>
			</xsl:when>
			<xsl:when test="@ref">
				<!--xsl:text>→&#x200D;</xsl:text-->
				<span>
					<xsl:if test="$bold = 'true'">
						<xsl:attribute name="class">bold</xsl:attribute>
					</xsl:if>
					<xsl:call-template name="output-name-ref">
						<xsl:with-param name="name" select="@ref"/>
						<xsl:with-param name="referenced">true</xsl:with-param>
					</xsl:call-template>
				</span>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="output-id-and-ref-text">
		<xsl:attribute name="id">
			<xsl:apply-templates select="." mode="id"/>
		</xsl:attribute>
		<xsl:variable name="reference-text">
			<xsl:apply-templates select="." mode="reference-text"/>
		</xsl:variable>
		<xsl:if test="string-length($reference-text) &gt; 0">
			<xsl:attribute name="reference-text">
				<xsl:value-of select="$reference-text"/>
			</xsl:attribute>
		</xsl:if>
	</xsl:template>

	<xsl:template name="add-group">
		<xsl:variable name="group" select="ancestor::xs:group[1]"/>
		<xsl:if test="$group">
			<group>
				<xsl:call-template name="output-name-ref">
					<xsl:with-param name="name" select="$group/@name"/>
					<xsl:with-param name="remove-suffix" select="'Group'"/>
				</xsl:call-template>
			</group>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="add-option">
		<xsl:param name="option" select="0"/>
		<xsl:if test="number($option) &gt; 0">
			<option>
				<xsl:value-of select="$abc/letter[number($option)]"/>
			</option>
		</xsl:if>
	</xsl:template>
	
	<!-- *** schema collections, just a container *** -->
	
	<xsl:template match="/schema-collection">
		<schema-documentation>
			<xsl:apply-templates/>
		</schema-documentation>
	</xsl:template>
	
	
	<!-- *** conversion templates *** -->


	<!-- All documentation on the schema itself is suppressed, as it is used as the section title -->
	<xsl:template match="xs:schema/xs:annotation"/>

	<!-- All (other) documentation is printed verbatim -->
	<xsl:template match="xs:annotation">
		<p>
			<xsl:value-of select="xs:documentation"/>
		</p>
	</xsl:template>


	<!-- Top level element: Print as own subsection in Asciidoc. -->
	<xsl:template match="xs:schema/xs:element" mode="chapter">
		<chapter>
			<xsl:call-template name="output-id-and-ref-text"/>
			<xsl:attribute name="role">element</xsl:attribute>
			<xsl:copy-of select="@type"/>
			<title>
				<xsl:text>The toplevel element </xsl:text>
				<code><xsl:value-of select="@name"/></code>
			</title>
			<table>
				<type-description>
					<name><xsl:value-of select="@name"/></name>
					<!--
					<xsl:if test="@type">
						<xsl:apply-templates select="." mode="type"/>
					</xsl:if>
					-->
					<xsl:apply-templates select="." mode="type"/>
					<documentation>
						<xsl:apply-templates select="." mode="documentation"/>
					</documentation>
				</type-description>
				
				<xsl:apply-templates select="xs:complexType|xs:simpleType"/>
			</table>
		</chapter>
	</xsl:template>


	<!-- Every other "element" node: Will be printed on one line,
	type is read from attribute or from restriction base if it's a simple type. -->
	<xsl:template match="xs:element">
		<xsl:param name="depth" select="0"/>
		<xsl:param name="option" select="0"/>
		
		<xsl:variable name="min">
			<xsl:choose>
				<xsl:when test="@minOccurs"><xsl:value-of select="@minOccurs"/></xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="eff-option">
			<xsl:choose>
				<xsl:when test="parent::xs:choice">
					<xsl:value-of select="position()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$option"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<row depth="{$depth}" role="element">
			<xsl:call-template name="add-group"/>
			
			<xsl:call-template name="add-option">
				<xsl:with-param name="option" select="$eff-option"/>
			</xsl:call-template>
			<name>
				<xsl:call-template name="output-name-or-ref">
					<xsl:with-param name="bold" select="number($min) &gt; 0"/>
				</xsl:call-template>
			</name>
			<xsl:call-template name="output-cardinality"/>
			<xsl:apply-templates select="." mode="type"/>
			<documentation>
				<xsl:apply-templates select="." mode="documentation"/>
			</documentation>
		</row>

		<xsl:apply-templates select="*[not(self::xs:annotation)]">
			<xsl:with-param name="depth" select="$depth + 1"/>
		</xsl:apply-templates>
	</xsl:template>


	<!-- Sequence with more than one element:
	Elements are printed as list one level deeper. -->
	<xsl:template match="xs:sequence">
		<xsl:param name="depth" select="0"/>
		<xsl:param name="option" select="0"/>
		
		<xsl:if test="xs:annotation/xs:documentation">
			<xsl:message terminate="no">Documentation is not allowed on xs:sequence! Context: <xsl:call-template name="output-context"/></xsl:message>
		</xsl:if>
		
		<line depth="{$depth}">
			<xsl:text>The element contains </xsl:text>
			<xsl:choose>
				<xsl:when test="count(*[not(self::xs:annotation)]) = 1">
					<xsl:text>only one element:</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>a </xsl:text>
					<em>sequence</em>
					<xsl:text> of the following elements:</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</line>

		<xsl:apply-templates select="*[not(self::xs:annotation)]">
			<xsl:with-param name="depth" select="$depth + 1"/>
			<xsl:with-param name="option" select="$option"/>
		</xsl:apply-templates>
	</xsl:template>


	<!-- Choice with one element: Print that element directly.
	Note that we have to handle the case if we are at top level. -->
	<xsl:template match="xs:choice[count(*)=1]">
		<xsl:param name="depth" select="0"/>

		<xsl:message>xs:choice with just one child! Context: <xsl:call-template name="output-context"/></xsl:message>

		<xsl:choose>
			<xsl:when test="$depth > 0">
				<xsl:apply-templates>
					<xsl:with-param name="depth" select="$depth"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<line depth="{$depth}">
					<xsl:text>The element contains only one element:</xsl:text>
				</line>
				<xsl:apply-templates>
					<xsl:with-param name="depth" select="$depth"/>
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	

	<!-- Choice with more than one element: Print subelements as list.
	Also here, we handle the toplevel case separately. -->
	<xsl:template match="xs:choice">
		<xsl:param name="depth" select="0"/>
		<xsl:param name="option" select="0"/>
		
		<xsl:if test="xs:annotation/xs:documentation">
			<xsl:message terminate="no">Documentation is not allowed on xs:choice! Context: <xsl:call-template name="output-context"/></xsl:message>
		</xsl:if>

		<line depth="{$depth}">
			<xsl:choose>
				<xsl:when test="$depth = 0">The element contains <em>one of</em> the following elements:</xsl:when>
				<xsl:otherwise>Then, the element contains <em>one of</em> the following elements:</xsl:otherwise>
			</xsl:choose>
		</line>

		<xsl:apply-templates select="*[not(self::xs:annotation)]">
			<xsl:with-param name="depth" select="$depth"/>
			<xsl:with-param name="option" select="$option"/>
			<xsl:sort select="@name"/>
		</xsl:apply-templates>
	</xsl:template>

	<!-- Top level groups: They are own subsections.
	Sequences or choices below are handled by the templates above. -->
	<xsl:template match="xs:schema/xs:group" mode="chapter">
		<chapter>
			<xsl:call-template name="output-id-and-ref-text"/>
			<xsl:attribute name="role">group</xsl:attribute>
			<xsl:copy-of select="@type"/>
			<title>
				<xsl:text>The </xsl:text>
				<code><xsl:value-of select="@name"/></code>
				<xsl:text> group</xsl:text>
			</title>
			<table>
				<type-description>
					<name><xsl:value-of select="@name"/></name>
					<documentation>
						<xsl:apply-templates select="xs:annotation"/>
					</documentation>
				</type-description>
				
				<xsl:apply-templates select="xs:sequence|xs:choice"/>
			</table>
		</chapter>
	</xsl:template>


	<!-- Any other groups: They are handled as references and only their reference is printed. -->
	<xsl:template match="xs:group">
		<xsl:param name="depth" select="0"/>
		<xsl:param name="option" select="0"/>
		
		<xsl:choose>
			<xsl:when test="@ref">
				<xsl:variable name="eff-option">
					<xsl:choose>
						<xsl:when test="parent::xs:choice">
							<xsl:value-of select="position()"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$option"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				
				
				<xsl:variable name="group-name" select="@ref"/>
			  <!-- Resolve/expand the group reference --> 
				<xsl:variable name="resolved" select="//xs:group[@name = $group-name]"/>
				<xsl:choose>
					<xsl:when test="$resolved">
					  <xsl:comment>Group <xsl:value-of select="$group-name"/><!-- (o<xsl:value-of select="$eff-option"/>)--> ──────┐</xsl:comment>
						<xsl:apply-templates select="$resolved" mode="resolved">
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="option" select="$eff-option"/>
						</xsl:apply-templates>
					  <xsl:comment>Group <xsl:value-of select="$group-name"/> ──────┘</xsl:comment>
					</xsl:when>
					<xsl:otherwise>
					  <xsl:message>Group could not be resolved: →<xsl:value-of select="$group-name"/></xsl:message>
					  <xsl:comment>Group could not be resolved: →<xsl:value-of select="$group-name"/></xsl:comment>
					  <row depth="{$depth}" role="unresolved-group-ref">
					    <name>
					      <xsl:call-template name="output-name-or-ref"/>
					    </name>
					  	<documentation>
					  		<xsl:apply-templates select="." mode="documentation"/>
					  	</documentation>
					  </row>
					</xsl:otherwise>
				</xsl:choose>
				
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="." mode="resolved">
					<xsl:with-param name="depth" select="$depth"/>
					<xsl:with-param name="option" select="$option"/>
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template match="xs:group" mode="resolved">
		<xsl:param name="depth" select="0"/>
		<xsl:param name="option" select="0"/>
		
		<xsl:apply-templates select="*[not(self::xs:annotation)]">
			<xsl:with-param name="depth" select="$depth"/>
			<xsl:with-param name="option" select="$option"/>
		</xsl:apply-templates>
	</xsl:template>


	<xsl:template match="xs:group/xs:sequence">
		<xsl:param name="depth" select="0"/>
		<xsl:param name="option" select="0"/>
		<xsl:apply-templates>
			<xsl:with-param name="depth" select="$depth"/>
			<xsl:with-param name="option" select="$option"/>
		</xsl:apply-templates>
	</xsl:template>


	<xsl:template match="xs:complexType[not(@name)]">
		<xsl:param name="depth" select="0"/>
		<xsl:if test="ancestor::xs:complexType">
			<xsl:message terminate="no">Unnamed complexTypes are not allowed inside complexTypes! Context: <xsl:call-template name="output-context"/></xsl:message>
		</xsl:if>
		
		<xsl:apply-templates select="xs:annotation"/>
		<xsl:apply-templates select="xs:attribute">
			<xsl:with-param name="depth" select="$depth"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="xs:sequence|xs:choice|xs:complexContent">
			<xsl:with-param name="depth" select="$depth"/>
		</xsl:apply-templates>
	</xsl:template>


	<!-- ComplexTypes are subsections. Their content is printed by some of the templates above. -->
	<xsl:template match="xs:schema/xs:complexType[@name]" mode="chapter">
		<chapter>
			<xsl:call-template name="output-id-and-ref-text"/>
			<xsl:attribute name="role">complexType</xsl:attribute>
			<xsl:attribute name="name">
				<xsl:text>The complex type `</xsl:text>
				<xsl:value-of select="@name"/>
				<xsl:text>`</xsl:text>
			</xsl:attribute>
			<xsl:copy-of select="@type"/>
			<xsl:if test="xs:complexContent/xs:extension">
				<xsl:attribute name="extensionBase">
					<xsl:value-of select="xs:complexContent/xs:extension/@base"/>
				</xsl:attribute>
			</xsl:if>
		  <xsl:if test="xs:simpleContent/xs:extension">
		    <xsl:attribute name="extensionBase">
		      <xsl:value-of select="xs:simpleContent/xs:extension/@base"/>
		    </xsl:attribute>
		  </xsl:if>
		  <title>
		    <xsl:text>The complex type </xsl:text>
		    <code><xsl:value-of select="@name"/></code>
		  </title>
		  
			<table>
				<type-description>
					<name><xsl:value-of select="@name"/></name>
					<xsl:apply-templates select="." mode="type"/>
					<documentation>
						<xsl:apply-templates select="xs:annotation"/>
					</documentation>
				</type-description>
				<xsl:apply-templates select="xs:attribute"/>
				<xsl:apply-templates select="xs:sequence|xs:choice|xs:complexContent"/>
			</table>
		</chapter>
	</xsl:template>


	<!-- SimpleTypes are printed in a list. Each simpleType is one element of this list.
	The call structure below guarantees that they are evaluated in the moment. -->
	<xsl:template match="xs:schema/xs:simpleType[xs:restriction]">
		<simple-type name="{@name}">
			<definition>
				<xsl:choose>
					<xsl:when test="(xs:restriction/@base = 'xs:string' or xs:restriction/@base = 'xs:NMTOKEN') and xs:restriction/xs:enumeration">
						<xsl:for-each select="xs:restriction/xs:enumeration">
							<enum>
								<xsl:value-of select="@value"/>
							</enum>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="xs:restriction/@base"/>
					</xsl:otherwise>
				</xsl:choose>
			</definition>
			<documentation>
				<xsl:apply-templates select="." mode="documentation"/>
			</documentation>
			
			<!-- TODO Check me -->
			<xsl:apply-templates select="xs:restriction/xs:enumeration[boolean(xs:annotation/xs:documentation)]"/>
		</simple-type>
	</xsl:template>


	<xsl:template match="xs:simpleType[@name]" priority="-1">
		<xsl:message terminate="yes">Proper documentation rules for simpleType <xsl:value-of select="@name"/> not in place, yet!</xsl:message>
	</xsl:template>


	<xsl:template match="xs:enumeration">
		<xsl:text>| | `</xsl:text>
		<xsl:value-of select="@value"/>
		<xsl:text>`&#xa;</xsl:text>
		<xsl:text>| </xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#xa;&#xa;</xsl:text>
	</xsl:template>



	<xsl:template match="xs:attribute">
		<xsl:param name="depth" select="0"/>

		<xsl:variable name="use">
			<xsl:choose>
				<xsl:when test="@use = 'optional'">0</xsl:when>
				<xsl:when test="@use = 'prohibited'">-1</xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<row depth="{$depth}" use="{$use}" role="attribute">
			<name>
				<xsl:text>@</xsl:text>
				<xsl:call-template name="output-name-or-ref">
					<xsl:with-param name="bold" select="number($use) &gt; 0"/>
				</xsl:call-template>
			</name>
			<xsl:call-template name="output-cardinality"/>
			<xsl:apply-templates select="." mode="type"/>
			<documentation>
				<xsl:apply-templates select="." mode="documentation"/>
			</documentation>
		</row>
	</xsl:template>


	<!-- Toplevel evaluation method. This will match as first template and will finally convert the whole document. -->
	<xsl:template match="xs:schema">
		<xsl:comment>============================================================= Schema file <xsl:value-of select="@id"/> ===</xsl:comment>
		<schema>
			<xsl:attribute name="id">
				<xsl:apply-templates select="." mode="id"/>
			</xsl:attribute>
			<xsl:attribute name="reference-text">
				<xsl:apply-templates select="." mode="reference-text"/>
			</xsl:attribute>
			<title>
				<!-- All documentation on the schema itself is suppressed, as it is used as the section title -->
				<xsl:value-of select="xs:annotation/xs:documentation"/>
			</title>
			
			<!-- First subsection are all simpleTypes, if they exist. -->
			<xsl:if test="count(xs:simpleType) &gt; 0">
				<simple-type-definitions>
					<xsl:apply-templates select="xs:simpleType">
						<xsl:sort select="@name"/>
					</xsl:apply-templates>
				</simple-type-definitions>
			</xsl:if>
			
			<!-- Then, everything but the simpleTypes are evaluated in order of appearance. -->
			<xsl:apply-templates select="*[not(self::xs:simpleType)]" mode="chapter"/>
		</schema>
	</xsl:template>

	<xsl:template match="*" mode="chapter">
		<!-- ignore anything not especially handled in chapter mode. -->
	</xsl:template>

</xsl:stylesheet>

<!-- end of file -->
