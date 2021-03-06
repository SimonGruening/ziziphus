<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
        xmlns="http://www.w3.org/1999/xhtml"
        xmlns:html="http://www.w3.org/1999/xhtml"
        xmlns:xf="http://www.w3.org/2002/xforms"
        xmlns:bf="http://betterform.sourceforge.net/xforms"
        xmlns:transform="http://betterform.de/transform"
        xmlns:diff="http://betterform.de/ziziphus/diff"
        exclude-result-prefixes="xf bf transform">

    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:namespace-alias stylesheet-prefix="transform" result-prefix="xsl"/>

    <xsl:strip-space elements="*"/>

    <!--
    	generates a stylesheet for transforming a single Set Element (e.g. AgentSet) during diff presentation.
    	The resulting stylesheet will be found in folder 'view-diff'.
    -->
    <!--? ATTENTION - FIRST INSTANCE MUST BE DEFAULT INSTANCE IN THE GENERATED FORM USED TO FEED THIS TRANSFORM -->
    <xsl:variable name="rootNodeName" select="name(//xf:instance[1]/*[1])"/>
    <xsl:variable name="rootMatch" select="concat('vra:',$rootNodeName)"/>

    <xsl:template match="/">

        <transform:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:vra="http://www.vraweb.org/vracore4.htm">
            <transform:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

            <transform:template match="{$rootMatch}">
                <transform:param name="vraTableId"/>
                <xsl:apply-templates/>
            </transform:template>

        </transform:stylesheet>

    </xsl:template>

    <xsl:template match="html:title"/>

    <xsl:template match="html:body">
        <xsl:param name="vraTableId"/>
        <div class="simple" id="{{$vraTableId}}">
            <table class="vraSetView table table-striped">
                <xsl:apply-templates select=".//html:tbody[exists(@xf:repeat-nodeset)]"/>
            </table>
        </div>
    </xsl:template>

    <xsl:template match="html:tbody">
        <tbody>
            <transform:for-each select="{@xf:repeat-nodeset}">
                <tr>
                	<transform:call-template name="diff:insert-element-diff-class" />
                    <xsl:for-each select="//xf:group[@id='outerGroup']/html:table//html:td[@class='contentCol']/*">
                        <td>
                            <xsl:apply-templates select="."/>
                        </td>
                    </xsl:for-each>
                </tr>
            </transform:for-each>
        </tbody>
    </xsl:template>

    <xsl:template match="html:td">
        <xsl:element name="td">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="xf:group[@appearance='minimal']">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- ##### start ignores #####-->
    <xsl:template match="html:td[@class='globalAttrs']" priority="10"/>
    <xsl:template match="xf:trigger[@class='vraAttributeTrigger']" priority="10"/>

    <!-- ##### end ignores ##### -->

    <xsl:template match="xf:group">
        <xsl:for-each select="xf:*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>

	<xsl:template name="oneEntryBlock">
		<xsl:param name="path" as="xs:string" required="yes"/>
		<xsl:param name="class" as="xs:string?"/>

		<transform:choose>
			<transform:when test="string-length(string-join({$path},'')) != 0">
				<div title="{xf:label}">
					<xsl:if test="$class">
						<xsl:attribute name="class" select="$class"/>
					</xsl:if>
					<xsl:copy-of select="@*[not(name()='ref')]" />
					<transform:apply-templates select="{$path}" />
				</div>
			</transform:when>
			<transform:otherwise>
				<div class="{'nodata',$class}">(<xsl:value-of select="xf:label" />)</div>
			</transform:otherwise>
		</transform:choose>
	</xsl:template>

	<xsl:template match="xf:input | xf:select1 | xf:textarea">
		<xsl:variable name="path">
			<xsl:call-template name="buildPath" />
		</xsl:variable>
		<xsl:variable name="isDetail"
			select="if(@class='detail') then true() else false()" />

		<xsl:choose>
			<xsl:when test="contains(@ref,'@')">
				<!-- atribute - handle changed attributes -->
				<xsl:variable name="attr-path-before" select="replace(@ref,'@','@diff:attr-before-')"/>
				<xsl:variable name="attr-path-after" select="replace(@ref,'@','@diff:attr-after-')"/>
				<transform:choose>
					<transform:when test="{$attr-path-before} or {$attr-path-after}">
						<!--  there were changes -->
						<xsl:call-template name="oneEntryBlock">
							<xsl:with-param name="path" select="$attr-path-before"/>
							<xsl:with-param name="class" select="'diffs-attr-before'"/>
						</xsl:call-template>
						<xsl:call-template name="oneEntryBlock">
							<xsl:with-param name="path" select="$attr-path-after"/>
							<xsl:with-param name="class" select="'diffs-attr-after'"/>
						</xsl:call-template>
					</transform:when>
					<transform:otherwise>
						<!--  no changes -->
						<xsl:call-template name="oneEntryBlock">
							<xsl:with-param name="path" select="@ref"/>
						</xsl:call-template>
					</transform:otherwise>
				</transform:choose>
			</xsl:when>
			<xsl:otherwise>
				<!-- element - only default behaviour -->
				<xsl:call-template name="oneEntryBlock">
					<xsl:with-param name="path" select="@ref"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

    <xsl:template name="buildPath">
        <xsl:variable name="tmp">
            /<xsl:value-of select="$rootMatch"/>
            <xsl:for-each select="ancestor-or-self::*">
                <xsl:choose>
                    <xsl:when test="exists(@ref) and starts-with(@ref,'instance')"/>
                    <xsl:when test="exists(@ref)"><xsl:if test="position() != 1">/</xsl:if><xsl:value-of select="@ref"/></xsl:when>
                    <xsl:when test="exists(@xf:repeat-nodeset)">/<xsl:value-of select="@xf:repeat-nodeset"/></xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="normalize-space($tmp)"/>
    </xsl:template>

    <xsl:template match="xf:hint"/>
    <xsl:template match="xf:label"/>
</xsl:stylesheet>