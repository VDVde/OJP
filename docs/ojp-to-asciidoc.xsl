<!--

Style sheet to convert the XSDs describing OJP to Asciidoc for the documentation.

The XSL process is orchestrated by a script which calls this XSLT stylesheet
on the different schema files of the OJP specification and generates
a single Asciidoc document from them.

Note that XSLT is a functionally driven process: This stylesheet defines a number
of transforming templates which match specific portions of the input document.
The XSLT processor always applies the rule which fits best to the current
view on the input document. For more information, refer to

https://stackoverflow.com/questions/1531664/in-what-order-do-templates-in-an-xslt-document-execute-and-do-they-match-on-the

and

http://lenzconsulting.com/how-xslt-works/

The Asciidoc conversion needs to know how deep we are in the stack of
scheme entities. This is recorded via the "depth" parameter which is
passed to all "apply-templates" calls during the document traversal.

The templates in this stylesheet are ordered in a way that it can be read
from top to bottom. Note, however, that for the actual operation,
*order does not matter*!

(C) cantamen/Dirk Hillbrecht 2017

-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:common="http://exslt.org/common"
	xmlns:data="my:data"
	extension-element-prefixes="common">

	<xsl:import href="ojp-base.xsl"/>
	
	<!-- We're not producing XML output -->
	<xsl:output omit-xml-declaration="yes" method="text" indent="no"/>
	<xsl:strip-space elements="*"/>

	<!-- *** Helper stuff *** -->

	<xsl:variable name="nl">
		<xsl:text>&#xa;</xsl:text>
	</xsl:variable>
	<xsl:variable name="colon">
		<xsl:text>:</xsl:text>
	</xsl:variable>
	<xsl:variable name="asterisk">
		<xsl:text>|</xsl:text>
	</xsl:variable>

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
	

	<!-- Function "chars": Repeats the given "char" the given number of times. -->
	<xsl:template name="chars">
		<xsl:param name="char"/>
		<xsl:param name="n"/>
		<xsl:if test="$n > 0">
			<xsl:call-template name="chars">
				<xsl:with-param name="n" select="$n - 1"/>
				<xsl:with-param name="char" select="$char"/>
			</xsl:call-template>
			<xsl:value-of select="$char"/>
		</xsl:if>
	</xsl:template>

	<!-- Function "asterisks": Print given number of "*" characters. -->
	<xsl:template name="asterisks">
		<xsl:param name="n"/>
		<xsl:call-template name="asterisks">
			<xsl:with-param name="n" select="$n"/>
		</xsl:call-template>
	</xsl:template>

	<!-- Handles the indentation based on the depth on the detail table. -->
	<xsl:template name="indent">
		<xsl:param name="depth" select="0"/>
		<xsl:param name="group"/>
		<xsl:param name="span" select="1"/>
		<xsl:param name="option"/>
		<xsl:if test="$depth &gt; $max-depth">
			<xsl:message>Depth too high: <xsl:value-of select="$depth"/> on <xsl:value-of select="name()"/> (<xsl:call-template name="output-context"/>)</xsl:message>
		</xsl:if>
		
		<xsl:variable name="cap-depth">
			<xsl:choose>
				<xsl:when test="$depth &gt; $max-depth">
					<xsl:value-of select="$max-depth"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$depth"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="option-adjust">
			<xsl:choose>
				<xsl:when test="number($option) &gt; 0">0</xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		
		<xsl:call-template name="chars">
			<xsl:with-param name="char" select="$asterisk"/>
			<xsl:with-param name="n" select="$cap-depth"/>
		</xsl:call-template>
		
		<xsl:choose>
			<xsl:when test="$group and position() &gt; 1">
				<!-- skip cell -->
			</xsl:when>
			<xsl:when test="$group and position() = 1">
			  <!-- row span for group -->
				<xsl:text>&#xa;.</xsl:text>
				<xsl:value-of select="count(following-sibling::*) + 1"/>
				<xsl:text>+|</xsl:text>
				<xsl:call-template name="output-name-ref">
					<xsl:with-param name="name" select="$group"/>
					<xsl:with-param name="remove-suffix" select="'Group'"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>|</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>&#x20;</xsl:text>
		
		<xsl:if test="number($option) &gt; 0">
			<xsl:text> | _</xsl:text>
			<xsl:value-of select="$abc/letter[number($option)]"/>
			<xsl:text>_ </xsl:text>
		</xsl:if>
		<xsl:variable name="eff-span" select="$max-depth + $option-adjust + $span - $cap-depth"/>
		<xsl:if test="$eff-span &gt; 1">
			<xsl:text>&#xa;</xsl:text>
			<xsl:value-of select="$eff-span"/>
			<xsl:text>+</xsl:text>
		</xsl:if>
		<xsl:text>| </xsl:text>
	</xsl:template>

	<xsl:template name="output-base-table">
		<xsl:text>[%noheader,cols="1,1,1,1,10,20,20,30"]&#xa;</xsl:text>
		<xsl:text>|===&#xa;</xsl:text>
	</xsl:template>
	
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
		<xsl:if test="$min = 1">
			<!-- If mandatory, make it bold. -->
			<xsl:text>*</xsl:text>
		</xsl:if>
		<xsl:value-of select="$min"/>
		<xsl:text>:</xsl:text>
		<xsl:value-of select="$max"/>
		<xsl:if test="$min = 1">
			<xsl:text>*</xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template name="output-type">
		<xsl:choose>
			<xsl:when test="@type">
				<xsl:text>_</xsl:text>
				<xsl:call-template name="output-name-ref">
					<xsl:with-param name="name" select="@type"/>
				</xsl:call-template>
				<xsl:text>_</xsl:text>
			</xsl:when>
			<xsl:when test="xs:simpleType/xs:restriction/@base">
				<xsl:text>_</xsl:text>
				<xsl:call-template name="output-name-ref">
					<xsl:with-param name="name" select="xs:simpleType/xs:restriction/@base"/>
				</xsl:call-template>
				<xsl:text>_</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="output-name-ref">
		<xsl:param name="name" select="'[MISSING]'"/>
		<xsl:param name="remove-suffix"/>
		<xsl:variable name="title">
			<xsl:choose>
				<xsl:when test="$remove-suffix">
					<xsl:value-of select="substring-before($name, $remove-suffix)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$name"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:choose>
			<xsl:when test="starts-with($name, 'siri:')">
				<xsl:value-of select="$name"/>
			</xsl:when>
			<xsl:when test="starts-with($name, 'xs:')">
				<xsl:value-of select="$name"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>xref:#</xsl:text>
				<xsl:value-of select="$name"/>
				<xsl:text>[</xsl:text>
				<xsl:value-of select="$title"/>
				<xsl:text>]</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="output-name-or-ref">
		<xsl:param name="bold" select="'false'"/>
		<xsl:choose>
			<xsl:when test="@name">
				<xsl:text>`</xsl:text>
				<xsl:if test="$bold = 'true'">
					<xsl:text>*</xsl:text>
				</xsl:if>
				<xsl:value-of select="@name"/>
				<xsl:if test="$bold = 'true'">
					<xsl:text>*</xsl:text>
				</xsl:if>
				<xsl:text>`</xsl:text>
			</xsl:when>
			<xsl:when test="@ref">
				<xsl:text>→TODO#138`</xsl:text>
				<xsl:if test="$bold = 'true'">
					<xsl:text>*</xsl:text>
				</xsl:if>
				<xsl:call-template name="output-name-ref">
					<xsl:with-param name="name" select="@ref"/>
				</xsl:call-template>
				<xsl:if test="$bold = 'true'">
					<xsl:text>*</xsl:text>
				</xsl:if>
				<xsl:text>`</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="output-id-and-ref-text">
		<xsl:variable name="reference-text">
			<xsl:apply-templates select="." mode="reference-text"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="string-length($reference-text) &gt; 0">
				<xsl:text>[#</xsl:text>
				<xsl:apply-templates select="." mode="id"/>
				<xsl:text>,reftext=</xsl:text>
				<xsl:apply-templates select="." mode="reference-text"/>
				<xsl:text>]&#xa;</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>[[</xsl:text>
				<xsl:apply-templates select="." mode="id"/>
				<xsl:text>]]&#xa;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- *** schema collections, just a container *** -->
	
	<xsl:template match="schema-collection">
		<xsl:apply-templates/>
	</xsl:template>
	

	<!-- *** conversion templates *** -->


	<!-- All documentation on the schema itself is suppressed, as it is used as the section title -->
	<xsl:template match="xs:schema/xs:annotation"/>

	<!-- All (other) documentation is printed verbatim -->
	<xsl:template match="xs:annotation">
		<xsl:value-of select="xs:documentation"/>
	</xsl:template>

	<!-- Top level element: Print as own subsection in Asciidoc. -->
	<xsl:template match="xs:schema/xs:element" mode="chapter">
		<xsl:call-template name="output-id-and-ref-text"/>
		<xsl:text>=== The toplevel element `</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>`&#xa;&#xa;</xsl:text>

		<xsl:call-template name="output-base-table"/>
		<xsl:text>5+| `</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>`&#xa;</xsl:text>
		<xsl:choose>
			<xsl:when test="@type">
				<xsl:text>|</xsl:text>
				<xsl:text> _→</xsl:text>
				<xsl:value-of select="@type"/>
				<xsl:text>_ </xsl:text>
			</xsl:when>
			<xsl:otherwise>2+</xsl:otherwise>
		</xsl:choose>
		<xsl:text>| </xsl:text>
		<xsl:apply-templates select="xs:annotation"/>
		<xsl:text>&#xa;&#xa;</xsl:text>
		<xsl:apply-templates select="xs:complexType|xs:simpleType"/>
		<xsl:text>&#xa;</xsl:text>
		<xsl:text>|===&#xa;&#xa;</xsl:text>
	</xsl:template>


	<!-- Every other "element" node: Will be printed on one line,
	type is read from attribute or from restriction base if it's a simple type. -->
	<xsl:template match="xs:element">
		<xsl:param name="depth" select="0"/>

		<xsl:variable name="min">
			<xsl:choose>
				<xsl:when test="@minOccurs"><xsl:value-of select="@minOccurs"/></xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="option">
			<xsl:if test="parent::xs:choice">
				<xsl:value-of select="position()"/>
			</xsl:if>
		</xsl:variable>
		
		<!--
		<xsl:text>// grp </xsl:text>
		<xsl:value-of select="ancestor::xs:group[1]/@name"/>
		<xsl:text>&#xa;</xsl:text>
		-->
		
		<xsl:call-template name="indent">
			<xsl:with-param name="depth" select="$depth"/>
			<xsl:with-param name="group" select="ancestor::xs:group[1]/@name"/>
			<xsl:with-param name="option" select="$option"/>
		</xsl:call-template>
		<xsl:call-template name="output-name-or-ref">
			<xsl:with-param name="bold" select="number($min) &gt; 0"/>
		</xsl:call-template>
		<xsl:text>&#xa;| </xsl:text>
		<xsl:call-template name="output-cardinality"/>
		<xsl:text> | </xsl:text>
		<xsl:call-template name="output-type"/>
		<xsl:text>&#xa;| </xsl:text>
		<xsl:apply-templates select="xs:annotation">
			<xsl:with-param name="depth" select="$depth + 1"/>
		</xsl:apply-templates>
		<xsl:text>&#xa;&#xa;</xsl:text>

		<xsl:apply-templates select="*[not(self::xs:annotation)]">
			<xsl:with-param name="depth" select="$depth + 1"/>
		</xsl:apply-templates>
	</xsl:template>

	<!-- Sequence with more than one element:
	Elements are printed as list one level deeper. -->
	<xsl:template match="xs:sequence">
		<xsl:param name="depth" select="0"/>

		<xsl:if test="xs:annotation/xs:documentation">
			<xsl:message terminate="no">Documentation is not allowed on xs:sequence! Context: <xsl:call-template name="output-context"/></xsl:message>
		</xsl:if>
		
		<xsl:call-template name="indent">
			<xsl:with-param name="depth" select="$depth"/>
			<xsl:with-param name="span" select="4"/>
		</xsl:call-template>
		<xsl:text>The element contains </xsl:text>
		<xsl:choose>
			<xsl:when test="count(*[not(self::xs:annotation)]) = 1">
				<xsl:text>only one element:</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>a _sequence_ of the following elements:</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>&#xa;&#xa;</xsl:text>

		<xsl:apply-templates select="*[not(self::xs:annotation)]">
			<xsl:with-param name="depth" select="$depth + 1"/>
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
				<xsl:text>&#xa;&#xa;The element contains only one element:&#xa;&#xa;</xsl:text>
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

		<xsl:if test="xs:annotation/xs:documentation">
			<xsl:message terminate="no">Documentation is not allowed on xs:choice! Context: <xsl:call-template name="output-context"/></xsl:message>
		</xsl:if>

		<xsl:call-template name="indent">
			<xsl:with-param name="depth" select="$depth"/>
			<xsl:with-param name="span" select="4"/>
		</xsl:call-template>
		<xsl:choose>
			<xsl:when test="$depth = 0">The element contains _one of_ the following elements:</xsl:when>
			<xsl:otherwise>Then, the element contains _one of_ the following elements:</xsl:otherwise>
		</xsl:choose>
		<xsl:text>&#xa;&#xa;</xsl:text>

		<xsl:apply-templates select="*[not(self::xs:annotation)]">
			<xsl:with-param name="depth" select="$depth"/>
			<xsl:sort select="@name"/>
		</xsl:apply-templates>
	</xsl:template>

	<!-- Top level groups: They are own subsections.
	Sequences or choices below are handled by the templates above. -->
	<xsl:template match="xs:schema/xs:group" mode="chapter">
		<xsl:call-template name="output-id-and-ref-text"/>
		<xsl:text>=== The `</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>` group&#xa;&#xa;</xsl:text>

		<xsl:call-template name="output-base-table"/>
		<xsl:text>5+| `</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>`&#xa;2+| </xsl:text>
		<!--xsl:text> | </xsl:text-->
		<xsl:apply-templates select="xs:annotation"/>
		<xsl:text>&#xa;&#xa;</xsl:text>
		<xsl:apply-templates select="xs:sequence|xs:choice"/>
		<xsl:text>|===&#xa;&#xa;</xsl:text>
	</xsl:template>


	<!-- Any other groups: They are handled as references and only their reference is printed. -->
	<xsl:template match="xs:group">
		<xsl:param name="depth" select="0"/>
		
		<xsl:choose>
			<xsl:when test="@ref">
				<xsl:variable name="group-name" select="@ref"/>
			  <!-- Resolve/expand the group reference --> 
				<xsl:variable name="resolved" select="//xs:group[@name = $group-name]"/>
				<xsl:choose>
					<xsl:when test="$resolved">
						<xsl:text>&#xa;// Group </xsl:text>
					  <xsl:call-template name="output-name-or-ref"/>
					  <xsl:value-of select="$group-name"/>
						<xsl:text>──────┐&#xa;&#xa;</xsl:text>
						<xsl:apply-templates select="$resolved" mode="resolved">
							<xsl:with-param name="depth" select="$depth"/>
						</xsl:apply-templates>
						<xsl:text>&#xa;// Group </xsl:text>
						<xsl:value-of select="$group-name"/>
						<xsl:text>──────┘&#xa;&#xa;</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:message>Group could not be resolved: <xsl:value-of select="$group-name"/></xsl:message>
						<xsl:text>&#xa;// Group </xsl:text>
						<xsl:value-of select="$group-name"/>
						<xsl:text> not resolved!&#xa;&#xa;</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="." mode="resolved">
					<xsl:with-param name="depth" select="$depth"/>
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="xs:group" mode="resolved">
		<xsl:param name="depth" select="0"/>
		
		<xsl:if test="true()">
			<xsl:variable name="min">
				<xsl:choose>
					<xsl:when test="@minOccurs"><xsl:value-of select="@minOccurs"/></xsl:when>
					<xsl:otherwise>1</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="option">
				<xsl:if test="parent::xs:choice">
					<xsl:value-of select="position()"/>
				</xsl:if>
			</xsl:variable>
			
			<xsl:call-template name="indent">
				<xsl:with-param name="depth" select="$depth"/>
				<xsl:with-param name="option" select="$option"/>
			</xsl:call-template>
			<xsl:call-template name="output-name-or-ref">
				<xsl:with-param name="bold" select="number($min) &gt; 0"/>
			</xsl:call-template>
			<xsl:text>&#xa;| </xsl:text>
			<xsl:call-template name="output-cardinality"/>
			<xsl:text> | </xsl:text>
			<xsl:text>&#xa;| </xsl:text>
			<xsl:apply-templates select="xs:annotation"/>
			<xsl:text>&#xa;&#xa;</xsl:text>
		</xsl:if>
		
		<xsl:apply-templates select="*[not(self::xs:annotation)]">
			<xsl:with-param name="depth" select="$depth"/>
		</xsl:apply-templates>
	</xsl:template>


	<xsl:template match="xs:complexType[not(@name)]">
		<xsl:param name="depth" select="0"/>
		<xsl:message terminate="no">Unnamed complexTypes are not allowed inside complexTypes! Context: <xsl:call-template name="output-context"/></xsl:message>
		
		<xsl:apply-templates select="xs:annotation"/>
		<xsl:text>&#xa;&#xa;</xsl:text>
		<xsl:apply-templates select="xs:attribute">
			<xsl:with-param name="depth" select="$depth"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="xs:sequence|xs:choice|xs:complexContent">
			<xsl:with-param name="depth" select="$depth"/>
		</xsl:apply-templates>
	</xsl:template>

	<!-- ComplexTypes are subsections. Their content is printed by some of the templates above. -->
	<xsl:template match="xs:schema/xs:complexType[@name]" mode="chapter">
		<xsl:text>&#xa;</xsl:text>
		<xsl:call-template name="output-id-and-ref-text"/>
		<xsl:text>=== The complex type `</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>`&#xa;&#xa;</xsl:text>

		<xsl:call-template name="output-base-table"/>
		<xsl:text>5+| `</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>`&#xa;</xsl:text>
		<xsl:choose>
			<xsl:when test="xs:complexContent/xs:extension">
				<xsl:text>| _←&lt;&lt;</xsl:text>
				<xsl:value-of select="xs:complexContent/xs:extension/@base"/>
				<xsl:text>&gt;&gt;_ | </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>2+| </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="xs:annotation"/>
		<xsl:text>&#xa;&#xa;</xsl:text>
		<xsl:apply-templates select="xs:attribute"/>
		<xsl:apply-templates select="xs:sequence|xs:choice|xs:complexContent"/>
		<xsl:text>|===&#xa;&#xa;</xsl:text>
	</xsl:template>

	<!-- SimpleTypes are printed in a list. Each simpleType is one element of this list.
	The call structure below guarantees that they are evaluated in the moment. -->
	<xsl:template match="xs:schema/xs:simpleType[xs:restriction]">
		<xsl:text>| </xsl:text>
		<xsl:text>[[</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>]] </xsl:text>
		<xsl:text>`</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>` | _</xsl:text>
		<xsl:choose>
			<xsl:when test="(xs:restriction/@base = 'xs:string' or xs:restriction/@base = 'xs:NMTOKEN') and xs:restriction/xs:enumeration">
				<xsl:for-each select="xs:restriction/xs:enumeration">
					<xsl:if test="position() &gt; 1">
						<xsl:text> \| </xsl:text>
					</xsl:if>
					<xsl:value-of select="@value"/>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="xs:restriction/@base"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>_ | </xsl:text>
		<xsl:apply-templates select="xs:annotation"/>
		<xsl:text>&#xa;&#xa;</xsl:text>

		<xsl:apply-templates select="xs:restriction/xs:enumeration[boolean(xs:annotation/xs:documentation)]"/>
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
		
		<xsl:call-template name="indent">
			<xsl:with-param name="depth" select="$depth"/>
		</xsl:call-template>
		<xsl:text>@</xsl:text>
		<xsl:call-template name="output-name-or-ref">
			<xsl:with-param name="bold" select="number($use) &gt; 0"/>
		</xsl:call-template>
		<xsl:text>&#xa;| </xsl:text>
		<xsl:call-template name="output-cardinality"/>
		<xsl:text> | </xsl:text>
		<xsl:call-template name="output-type"/>
		<xsl:text>&#xa;| </xsl:text>
		<xsl:if test="@fixed">
			<xsl:text>Fixed value: "</xsl:text>
			<xsl:value-of select="@fixed"/>
			<xsl:text>"&#xa;</xsl:text>
		</xsl:if>
		<xsl:apply-templates select="xs:annotation">
			<xsl:with-param name="depth" select="$depth + 1"/>
		</xsl:apply-templates>
		<xsl:text>&#xa;&#xa;</xsl:text>
	</xsl:template>

	<!-- Toplevel evaluation method. This will match as first template and will finally convert the whole document. -->
	<xsl:template match="xs:schema">
		<!-- An XSD file is transferred to an Asciidoc subsection -->
		<xsl:call-template name="output-id-and-ref-text"/>
		<xsl:text>== </xsl:text>
		<xsl:value-of select="xs:annotation/xs:documentation"/>
		<xsl:text>&#xa;&#xa;</xsl:text>

		<!-- First subsection are all simpleTypes, if they exist. -->
		<xsl:if test="count(xs:simpleType) &gt; 0">
			<xsl:text>=== Simple type definitions&#xa;&#xa;</xsl:text>
			<xsl:text>[%noheader,cols="20,20,30"]&#xa;</xsl:text>
			<xsl:text>|===&#xa;</xsl:text>

			<xsl:apply-templates select="xs:simpleType">
				<xsl:sort select="@name"/>
			</xsl:apply-templates>
			<xsl:text>|===&#xa;</xsl:text>
		</xsl:if>

		<!-- Then, everything but the simpleTypes are evaluated in order of appearance. -->
		<xsl:apply-templates select="*[not(self::xs:simpleType)]" mode="chapter"/>
	</xsl:template>

	<xsl:template match="*" mode="chapter">
		<!-- ignore anything not especially handled in chapter mode. -->
	</xsl:template>

	<xsl:template match="/schema-collection">
		<xsl:apply-templates/>
	</xsl:template>

</xsl:stylesheet>

<!-- end of file -->
