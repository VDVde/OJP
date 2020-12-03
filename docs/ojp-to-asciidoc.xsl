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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">

	<!-- We're not producing XML output -->
	<xsl:output omit-xml-declaration="yes" method="text" indent="no"/>
	<xsl:strip-space elements="*"/>

	<!-- *** Helper stuff *** -->

	<xsl:variable name='nl'>
		<xsl:text>&#xa;</xsl:text>
	</xsl:variable>
	<xsl:variable name='colon'>
		<xsl:text>:</xsl:text>
	</xsl:variable>
	<xsl:variable name='asterisk'>
		<xsl:text>|</xsl:text>
	</xsl:variable>

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

	<!-- *** conversion templates *** -->

	<!-- All documentation on the schema itself is suppressed, as it is used as the section title -->
	<xsl:template match="/xs:schema/xs:annotation"/>

	<!-- All (other) documentation is printed verbatim -->
	<xsl:template match="xs:annotation">
		<xsl:value-of select="xs:documentation"/>
	</xsl:template>

	<!-- Top level element: Print as own subsection in Asciidoc. -->
	<xsl:template match="/xs:schema/xs:element">
		<xsl:text>=== The toplevel element `</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>`&#xa;`</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>` </xsl:text>
		<xsl:if test="@type">
			<xsl:text>| _</xsl:text><xsl:value-of select="@type"/><xsl:text>_ </xsl:text>
		</xsl:if>
		<xsl:text>| &#xa;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#xa;</xsl:text>
	</xsl:template>

	<!-- Every other "element" node: Will be printed on one line,
	type is read from attribute or from restriction base if it's a simple type. -->
	<xsl:template match="xs:element">
		<xsl:param name="depth" select="0"/>
		<xsl:call-template name="chars">
			<xsl:with-param name="char" select="$asterisk"/>
			<xsl:with-param name="n" select="$depth"/>
		</xsl:call-template>
		<xsl:choose>
			<xsl:when test="@name">
				<xsl:text> `</xsl:text>
				<xsl:value-of select="@name"/>
				<xsl:text>`</xsl:text>
			</xsl:when>
			<xsl:when test="@ref">
				<xsl:text> `</xsl:text>
				<xsl:value-of select="@ref"/>
				<xsl:text>`</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="@type">
				<xsl:text> | _</xsl:text><xsl:value-of select="@type"/>
				<xsl:text>_</xsl:text>
			</xsl:when>
			<xsl:when test="xs:simpleType/xs:restriction/@base">
				<xsl:text> | _</xsl:text><xsl:value-of select="xs:simpleType/xs:restriction/@base"/>
				<xsl:text>_</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:text> | </xsl:text>
		<xsl:apply-templates/>
		<xsl:if test="@maxOccurs='unbounded'">
			<xsl:text> 0:n_</xsl:text>
		</xsl:if>
		<xsl:text>&#xa;</xsl:text>
	</xsl:template>

	<!-- Sequence with one element: Print the element at the same depth. -->
	<xsl:template match="xs:sequence[count(*)=1]">
		<xsl:param name="depth" select="0"/>
		<xsl:choose>
			<xsl:when test="xs:choice">
				<!-- Special case: If the one element is a choice, just print that one. -->
				<xsl:apply-templates>
					<xsl:with-param name="depth" select="$depth"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<!-- Otherwise: Make it a "one element list". -->
				<xsl:text>&#xa;&#xa;The element contains only one element:&#xa;&#xa;</xsl:text>
				<xsl:apply-templates>
					<xsl:with-param name="depth" select="$depth + 1"/>
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Sequence with more than one element:
	Elements are printed as list one level deeper. -->
	<xsl:template match="xs:sequence">
		<xsl:param name="depth" select="0"/>
		<xsl:if test="$depth > 0">
			<xsl:call-template name="chars">
				<xsl:with-param name="char" select="$asterisk"/>
				<xsl:with-param name="n" select="$depth"/>
			</xsl:call-template>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="$depth = 0">
			<xsl:text>&#xa;</xsl:text>
		</xsl:if>
		<xsl:text>The element contains a _sequence_ of the following elements:&#xa;&#xa;|===&#xa;</xsl:text>
		<xsl:apply-templates>
			<xsl:with-param name="depth" select="$depth + 1"/>
		</xsl:apply-templates>
		<xsl:text>|===</xsl:text>
	</xsl:template>

	<!-- Choice with one element: Print that element directly.
	Note that we have to handle the case if we are at top level. -->
	<xsl:template match="xs:choice[count(*)=1]">
		<xsl:param name="depth" select="0"/>
		<xsl:choose>
			<xsl:when test="$depth > 0">
				<xsl:apply-templates>
					<xsl:with-param name="depth" select="$depth"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>&#xa;&#xa;The element contains only one element:&#xa;&#xa;</xsl:text>
				<xsl:apply-templates>
					<xsl:with-param name="depth" select="$depth + 1"/>
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Choice with more than one element: Print subelements as list.
	Also here, we handle the toplevel case separately. -->
	<xsl:template match="xs:choice">
		<xsl:param name="depth" select="0"/>
		<xsl:choose>
			<xsl:when test="$depth = 0">
				<xsl:text>&#xa;&#xa;The element contains _one of_ the following elements:&#xa;&#xa;</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="chars">
					<xsl:with-param name="char" select="$asterisk"/>
					<xsl:with-param name="n" select="$depth"/>
				</xsl:call-template>
				<xsl:text> Then, the element contains _one of_ the following elements:&#xa;&#xa;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates>
			<xsl:with-param name="depth" select="$depth + 1"/>
			<xsl:sort select="@name"/>
		</xsl:apply-templates>
	</xsl:template>

	<!-- Top level groups: They are own subsections.
	Sequences or choices below are handled by the templates above. -->
	<xsl:template match="/xs:schema/xs:group">
		<xsl:text>=== The `</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>` group&#xa;&#xa;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#xa;&#xa;</xsl:text>
	</xsl:template>

	<!-- Any other groups: They are handled as references and only their reference is printed. -->
	<xsl:template match="xs:group">
		<xsl:param name="depth" select="0"/>
		<xsl:call-template name="chars">
			<xsl:with-param name="char" select="$asterisk"/>
			<xsl:with-param name="n" select="$depth"/>
		</xsl:call-template>
		<xsl:text> `</xsl:text>
		<xsl:value-of select="@ref"/>
		<xsl:text>`&#xa;</xsl:text>
	</xsl:template>

	<!-- ComplexTypes are subsections. Their content is printed by some of the templates above. -->
	<xsl:template match="/xs:schema/xs:complexType">
		<xsl:text>&#xa;</xsl:text>
		<xsl:text>=== The complex type `</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>`&#xa;&#xa;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#xa;&#xa;</xsl:text>
	</xsl:template>

	<!-- SimpleTypes are printed in a list. Each simpleType is one element of this list.
	The call structure below guarantees that they are evaluated in the moment. -->
	<xsl:template match="xs:schema/xs:simpleType">
		<xsl:text>| `</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>`| _</xsl:text>
		<xsl:value-of select="xs:restriction/@base"/>
		<xsl:text>_ | </xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#xa;</xsl:text>
	</xsl:template>

	<!-- Toplevel evaluation method. This will match as first template and will finally convert the whole document. -->
	<xsl:template match="/xs:schema">
		<!-- An XSD file is transferred to an Asciidoc subsection -->
		<xsl:text>== </xsl:text>
		<xsl:value-of select="xs:annotation/xs:documentation"/>
		<xsl:text>&#xa;&#xa;</xsl:text>

		<!-- First subsection are all simpleTypes, if they exist. -->
		<xsl:if test="count(xs:simpleType) &gt; 0">
			<xsl:text>=== Simple type definitions&#xa;&#xa;|===&#xa;</xsl:text>
			<xsl:apply-templates select="xs:simpleType">
				<xsl:sort select="@name"/>
			</xsl:apply-templates>
			<xsl:text>|===&#xa;</xsl:text>
		</xsl:if>

		<!-- Then, everything but the simpleTypes are evaluated in order of appearance. -->
		<xsl:apply-templates select="*[not(self::xs:simpleType)]"/>

	</xsl:template>

</xsl:stylesheet>

<!-- end of file -->
