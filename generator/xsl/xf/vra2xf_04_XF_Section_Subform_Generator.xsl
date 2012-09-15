<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:functx="http://www.functx.com"
                xmlns:xf="http://www.w3.org/2002/xforms"
                xpath-default-namespace="http://www.w3.org/2002/xforms" exclude-result-prefixes="functx">

    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:strip-space elements="*"/>

    <!--
        ########################################################################################
            EXTERNAL PARAMETERS
        ########################################################################################
    -->
    <xsl:param name="debug" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>
    <xsl:param name="path_2_vra_types_schema" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>
    <xsl:param name="path_2_xf_instance" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>
    <xsl:param name="vraSection" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>
    <xsl:variable name="vraSectionNode" select="functx:lowercase-first($vraSection)"/>



    <!--
        ########################################################################################
            GLOBAL VARIABLES
        ########################################################################################
    -->

    <xsl:variable name="debugEnabled" as="xsd:boolean">
        <xsl:choose>
            <xsl:when test="$debug eq 'true' or $debug eq 'true()' or number($debug) gt 0">true</xsl:when>
            <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="vraTypes" select="doc($path_2_vra_types_schema)"/>
    <xsl:variable name="vraInstance" select="doc($path_2_xf_instance)"/>


<!--
    ########################################################################################
        TEMPLATE RULES
    ########################################################################################
-->
    <xsl:template match="xf:bind[@nodeset='vra:vra']">
        <!-- Check if referenced resources are available -->

        <xsl:if test="not(exists($vraInstance))">
            <xsl:message terminate="yes">XSD with schema redefinition rules is missing</xsl:message>
        </xsl:if>
        <xsl:variable name="result">
        <html>
            <head>
                <title>Ziziphus_Image_DB</title>
            </head>
            <body>
                <div id="xforms">
                    <div style="display:none">
                        <xf:model id="child-model" schema="../resources/xsd/vra-types.xsd">
                            <xf:instance id="i-{$vraSectionNode}">
                                    <xsl:apply-templates select="$vraInstance/vra:vra/vra:work/*[local-name(.)=$vraSectionNode]" mode="instance">
                                        <xsl:with-param name="path" select="'instance()'"/>
                                    </xsl:apply-templates>
                            </xf:instance>

                            <xf:bind nodeset="instance()">
                                <xsl:apply-templates select="xf:bind[@nodeset='vra:work']/xf:bind[@nodeset=concat('vra:',$vraSectionNode)]/*" mode="bind">
                                    <xsl:with-param name="path" select="'instance()'"/>
                                </xsl:apply-templates>
                            </xf:bind>
                        </xf:model>
                    </div>

                    <xsl:apply-templates select="xf:bind[@nodeset='vra:work']/xf:bind[@nodeset=concat('vra:',$vraSectionNode)]" mode="ui">
                        <xsl:with-param name="path" select="'instance()'"/>
                    </xsl:apply-templates>

                </div>
            </body>
        </html>
        </xsl:variable>

        <xsl:copy-of select="$result"/>

        
        
    </xsl:template>



    <!--
        ########################################################################################
            MODE: INSTANCE - CREATION OF XFORMS BINDS
        ########################################################################################
    -->
    <xsl:template match="*" mode="instance">
        <xsl:param name="path" select="''"/>
        <xsl:variable name="vraNodeName" select="local-name(.)"/>
        <xsl:variable name="currentPath" select="concat($path,'/vra:',$vraNodeName)"/>

        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates mode="instance">
                <xsl:with-param name="path" select="$currentPath"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>



    <!--
        ########################################################################################
            MODE: BIND - CREATION OF XFORMS BINDS
        ########################################################################################
    -->

    <xsl:template match="xf:bind[@nodeset=concat('vra:',$vraSectionNode)]" mode="bind" priority="40">
        <xsl:param name="path" select="''"/>

        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="concat($path,'/',$vraNodeName)"/>
        
        <xf:bind>
            <xsl:attribute name="nodeset" select="$vraNodeName"/>
            <xsl:apply-templates mode="bind" select="*[not(starts-with(@nodeset,'@'))]">
                <xsl:with-param name="path" select="$currentPath"/>
            </xsl:apply-templates>
        </xf:bind>
    </xsl:template>

    <xsl:template match="xf:bind[@xfType = 'complexType']" mode="bind" priority="20">
        <xsl:param name="path" select="''"/>
        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="concat($path,'/',$vraNodeName)"/>

        <xsl:variable name="nodesetValue" select="@nodeset"/>
        <xf:bind>
            <xsl:attribute name="nodeset" select="$nodesetValue"/>
            <xsl:if test="exists(@type) and not(@type = 'xsd:string')">
                <xsl:attribute name="type" select="@type"/>
            </xsl:if>
            <xsl:apply-templates mode="bind">
                <xsl:with-param name="path" select="$currentPath"/>
            </xsl:apply-templates>
        </xf:bind>
    </xsl:template>

    <xsl:template match="xf:bind" mode="bind" >
        <xsl:param name="path" select="''"/>

        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="concat($path,'/',$vraNodeName)"/>

        <xf:bind>
            <xsl:attribute name="nodeset" select="$vraNodeName"/>
            <xsl:if test="exists(@type) and not(@type = 'xsd:string')">
                <xsl:attribute name="type" select="@type"/>
            </xsl:if>
            <xsl:apply-templates mode="bind">
                <xsl:with-param name="path" select="$currentPath"/>
            </xsl:apply-templates>
        </xf:bind>
    </xsl:template>    




    <!--
        ########################################################################################
            MODE: UI - CREATION OF XFORMS UI CONTROLS
        ########################################################################################
    -->
    
    <xsl:template match="xf:bind[@nodeset=concat('vra:',$vraSectionNode)]" mode="ui" priority="40">
        <xsl:param name="path" select="''"/>
        
        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="concat($path,'/',$vraNodeName)"/>
        
        <xf:group ref="instance()" appearance="minimal" class="vraRecord" model="child-model">
            <xf:label><xsl:value-of select="functx:capitalize-first($vraNodeName)"/></xf:label>
            <xsl:apply-templates mode="ui" select="*[not(starts-with(@nodeset,'@'))]">
                <xsl:with-param name="path" select="$currentPath"/>
            </xsl:apply-templates>
        </xf:group>
    </xsl:template>
    
    <xsl:template match="xf:bind[@xfType = 'complexType']" mode="ui" priority="20">
        <xsl:param name="path" select="''" />
        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="concat($path,'/',$vraNodeName)"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>create xf:group for '<xsl:value-of select="$vraNodeName"/>' xpath is: '<xsl:value-of select="$currentPath"/>'</xsl:message>
        </xsl:if>
        <xf:group ref="{$vraNodeName}" appearance="minimal" class="vraComplex" model="child-model">
            <xf:label><xsl:value-of select="functx:capitalize-first($vraNodeName)"/></xf:label>
            <xsl:apply-templates mode="ui">
                <xsl:with-param name="path" select="$vraNodeName"/>
            </xsl:apply-templates>
        </xf:group>

    </xsl:template>



    <xsl:template match="xf:bind[not(exists(xf:bind/xf:bind)) and not(starts-with(@nodeset,'@'))]" mode="ui" priority="10">
        <xsl:param name="path" select="''" />
        <xsl:variable name="vraNodeName" select="@nodeset"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>create xf:control for '<xsl:value-of select="$vraNodeName"/>' xpath is: '<xsl:value-of select="$path"/>'</xsl:message>
        </xsl:if>
        <xf:input ref="{$vraNodeName}" type="nodeValue" model="child-model">
            <xf:label>
                <xsl:value-of select="functx:capitalize-first($vraNodeName)"/>
            </xf:label>
        </xf:input>

        <div class="agentSet-{substring-after($vraNodeName,'vra:')}-attributes hiddenAttributes" style="display:none;">
            <xsl:apply-templates mode="ui">
                <xsl:with-param name="path" select="$vraNodeName"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>

    <xsl:template match="xf:bind[starts-with(@nodeset,'@')]" mode="ui" priority="10">
        <xsl:param name="path" select="''" />
        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="concat($path,'/',$vraNodeName)"/>
        <xsl:if test="$debugEnabled">
            <xsl:message>create xf:control for '<xsl:value-of select="$vraNodeName"/>' attribute,  xpath is: '<xsl:value-of select="$currentPath"/>'</xsl:message>
        </xsl:if>
                
        <xf:input ref="{$currentPath}" type="attributeValue" model="child-model">
            <xf:label><xsl:value-of select="substring-after($vraNodeName,'@')"/></xf:label>
        </xf:input>
        
        <xsl:apply-templates mode="ui">
            <xsl:with-param name="path" select="$currentPath"/>
        </xsl:apply-templates>
    </xsl:template>


    <xsl:template match="xf:bind" mode="ui">
        <xsl:message>Matched xf:bind with nodeset='<xsl:value-of select="@nodeset"/>'</xsl:message>
        <xsl:message terminate="yes">This rule must never be matched</xsl:message>
    </xsl:template>





<!--
    ########################################################################################
        HELPER TEMPLATE RULES (simply copying nodes and comments)
    ########################################################################################
-->

    <xsl:template match="*">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="@*|text()">
        <xsl:copy/>
    </xsl:template>

    <xsl:template match="comment()" priority="20">
        <xsl:copy/>
    </xsl:template>


    <xsl:function name="functx:capitalize-first" as="xsd:string?">
        <xsl:param name="arg" as="xsd:string?"/>
        <xsl:variable name="string2capitalize">
            <xsl:choose>
                <xsl:when test="starts-with($arg, 'vra')"><xsl:value-of select="substring-after($arg, 'vra:')"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="$arg"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="concat(upper-case(substring($string2capitalize,1,1)),substring($string2capitalize,2))"/>
    </xsl:function>

    <xsl:function name="functx:lowercase-first" as="xsd:string?">
        <xsl:param name="arg" as="xsd:string?"/>
        <xsl:variable name="string2lowercase">
            <xsl:choose>
                <xsl:when test="starts-with($arg, 'vra')"><xsl:value-of select="substring-after($arg, 'vra:')"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="$arg"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="concat(lower-case(substring($string2lowercase,1,1)),substring($string2lowercase,2))"/>
    </xsl:function>

</xsl:stylesheet>
