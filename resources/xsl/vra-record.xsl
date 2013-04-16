<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ev="http://www.w3.org/2001/xml-events" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:vra="http://www.vraweb.org/vracore4.htm" xmlns:bfc="http://betterform.sourceforge.net/xforms/controls" xmlns:xf="http://www.w3.org/2002/xforms" xmlns:bfn="http://www.betterform.de/XSL/Functions" version="2.0" xpath-default-namespace="http://www.w3.org/2002/xforms" exclude-result-prefixes="bfn">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:strip-space elements="*"/>

    <!--
        VIEW GENERATION - includes embed actions for switching to forms
    -->

    <!--<xsl:variable name="rootPath" select="'vraSets'"/>-->

    <!-- include transforms for sections in VRA dataset -->
    <xsl:include href="../../view/AgentSet.xsl"/>
    <xsl:include href="../../view/CulturalContextSet.xsl"/>
    <xsl:include href="../../view/DateSet.xsl"/>
    <xsl:include href="../../view/DescriptionSet.xsl"/>
    <xsl:include href="../../view/InscriptionSet.xsl"/>
    <xsl:include href="../../view/LocationSet.xsl"/>
    <xsl:include href="../../view/MaterialSet.xsl"/>
    <xsl:include href="../../view/MeasurementsSet.xsl"/>
    <xsl:include href="../../view/RelationSet.xsl"/>
    <xsl:include href="../../view/RightsSet.xsl"/>
    <xsl:include href="../../view/SourceSet.xsl"/>
    <xsl:include href="../../view/StateEditionSet.xsl"/>
    <xsl:include href="../../view/StylePeriodSet.xsl"/>
    <xsl:include href="../../view/SubjectSet.xsl"/>
    <xsl:include href="../../view/TechniqueSet.xsl"/>
    <xsl:include href="../../view/TextrefSet.xsl"/>
    <xsl:include href="../../view/TitleSet.xsl"/>
    <xsl:include href="../../view/WorktypeSet.xsl"/>
    <!-- 'work' or 'image' -->
    <xsl:param name="recordType" select="'GIVEN BY CALLER'"/>
    <!-- UUID of Record e.g w_****** -->
    <xsl:param name="recordId" select="'GIVEN BY CALLER'"/>
    <!--<xsl:variable name="root_id" select="if($type='work') then 'workrecord' else 'imagerecord'"/>-->
    <xsl:variable name="title" select="if($recordType='work') then 'Work Record' else 'Image Record'"/>
    <xsl:variable name="id_pref" select="if($recordType='work') then 'w_' else 'i_'"/>

    <!-- parameter is only used if a single section is rendered -->
    <!--<xsl:param name="setname" select="''"/>-->

    <!-- top level - entry template - handles a work or an image record -->
    <xsl:template match="/vra:work |/vra:image">
        <xsl:variable name="side" select="if(local-name(.)='work') then 'leftPanel' else 'rightPanel'"/>
        <div class="columntitle">
            <xsl:value-of select="$title"/>
        </div>
        <div id="{$side}" class="sidePanel ui-layout-content">
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'AgentSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:agentSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'CulturalContextSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:culturalContextSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'DateSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:dateSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'DescriptionSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:descriptionSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'InscriptionSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:inscriptionSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'LocationSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:locationSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'MaterialSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:materialSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'MeasurementsSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:measurementsSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'RelationSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:relationSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'RightsSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:rightsSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'SourceSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:sourceSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'StateEditionSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:stateEditionSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'StylePeriodSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:stylePeriodSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'SubjectSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:subjectSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'TechniqueSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:techniqueSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'TextrefSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:textrefSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'TitleSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:titleSet"/>
            </xsl:call-template>
            <xsl:call-template name="titlePane">
                <xsl:with-param name="vraSetName" select="'WorktypeSet'"/>
                <xsl:with-param name="vraSetNode" select="vra:worktypeSet"/>
            </xsl:call-template>
<!--
            </div>
-->
        </div>
    </xsl:template>
    <xsl:template match="vra:work/vra:image" mode="titlePane" priority="40"/>

    <!--
        single section - expandable section in view. Uses a XForms switch to toggle between VIEW and EDIT mode
    -->
    <xsl:template name="titlePane">
        <xsl:param name="vraSetName"/>
        <xsl:param name="vraSetNode" as="node()?"/>
        <xsl:variable name="title" select="bfn:sectionTitle($vraSetName)"/>
        <xsl:variable name="id" select="concat($id_pref,$title)"/>
        <!--<xsl:variable name="formName" select="$vraSetName"/>-->
        <xsl:variable name="sectionWithData" select="if(string-length(string-join($vraSetNode//*/text(),'')) != 0) then 'true' else 'false'"/>
        <div id="{$id}" class="{$vraSetName}" data-dojo-type="dijit.TitlePane" data-dojo-props="title: '{$title}',open:{$sectionWithData}">
            <xsl:variable name="mountPoint" select="concat($id,'_MountPoint')"/>
            <xsl:variable name="caseId" select="concat('c-',$id)"/>
            <xsl:variable name="tableId" select="concat('table-',$id)"/>
            <div class="t-edit">
                <xf:trigger class="-icon -icon-edit">
                    <xf:label/>
                    <xf:action>
                        <xf:dispatch name="unload-subform" targetid="controlCenter"/>
                        <xf:setvalue model="m-main" ref="instance('i-control-center')/currentform" value="'{$id}'"/>
                        <xf:setvalue model="m-main" ref="instance('i-control-center')/uuid" value="'{$recordId}'"/>
                        <!--<xf:setvalue model="m-main" ref="instance('i-control-center')/recordType" value="'{$recordType}'"/>-->
                        <xf:load show="embed" targetid="{$mountPoint}">
                            <xf:resource value="'exist:/db/apps/ziziphus/forms/{$vraSetName}.xhtml#xforms'"/>
                            <!-- new extension for load to be added -> if returnUI="false" this means that the subform is embedded and initialized on the server
                            but no UI transformation takes place and therefore no UI is returned via the embed event. -->
                            <xf:extension includeCSS="true" includeScript="false" returnUI="false"/>
                        </xf:load>
                        <!--
                        This is not used for the time being. It was a test to use xquery to generate the
                        forms which might get interesting later again when it comes to optimization e.g.
                        the data instances can probably be inlined within the forms when requesting the form
                        thus avoiding additional submissions to load the data. This *might* improve overall
                        performance.

                         <xf:load show="embed" targetid="{$mountPoint}">
                            <xf:resource value="'modules/forms/{$vraSetName}.xql#xforms?recordId={$recordId}'"/>
                            <xf:extension includeCSS="false" includeScript="false"/>
                        </xf:load>
                        -->
                        <xf:toggle case="{$caseId}-edit"/>
                    </xf:action>
                </xf:trigger>
                <span>
                    <button type="button" onclick="toggleDetail(this, '{$tableId}');" class="icon icon-zoom-in"/>
                </span>
            </div>
            <xf:switch>
                <!-- ############ VIEW CASE ######### -->
                <!-- ############ VIEW CASE ######### -->
                <!-- ############ VIEW CASE ######### -->
                <xf:case id="{$caseId}-view" selected="true">
                    <div class="vraSection" id="{concat($id,'_HtmlContent')}" data-bf-form="/db/apps/ziziphus/forms/{$vraSetName}.xhtml">
                        <!-- all markup within this div must be generated by the specific Subforms stylesheets, e.q. AgentSet.xsl -->
                        <xsl:choose>
                            <xsl:when test="exists($vraSetNode/vra:display/text())">
                                <xsl:apply-templates select="$vraSetNode/vra:display"/>
                            </xsl:when>
                            <xsl:otherwise>
                                    <!-- drill down into single stylesheets (the ones include at top of this file.-->
                                <xsl:apply-templates select="$vraSetNode">
                                    <xsl:with-param name="vraTableId" select="$tableId"/>
                                </xsl:apply-templates>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:apply-templates select="$vraSetNode/vra:notes"/>
                    </div>
                </xf:case>
                <!-- ############ EDIT CASE ############### -->
                <!-- ############ EDIT CASE ############### -->
                <!-- ############ EDIT CASE ############### -->
                <xf:case id="{$caseId}-edit">
<!--
                    <xf:group appearance="minimal" class="dialogControls">
                        <xf:trigger>
                            <xf:label>Save changes</xf:label>
                            <xf:action>
                                <xf:toggle case="{$caseId}-view"/>
                                &lt;!&ndash;todo: not enough - form must be unloaded &ndash;&gt;
                                <xf:setvalue ref="instance('i-control-center')/currentform" model="m-main"/>
                            </xf:action>
                        </xf:trigger>
                        <xf:trigger appearance="minimal">
                            <xf:label>Close</xf:label>
                            <xf:toggle case="{$caseId}-view"/>

                            &lt;!&ndash;todo: not enough - form must be unloaded &ndash;&gt;
                            <xf:setvalue ref="instance('i-control-center')/currentform" model="m-main"/>
                        </xf:trigger>
                    </xf:group>
-->
                    <div id="{$mountPoint}"/>
                </xf:case>
            </xf:switch>
        </div>
    </xsl:template>

    <!--    <xsl:template match="*[exists(*)]"  priority="20">
            <xsl:variable name="nodeName" select="local-name(.)"/>
            <div class="{$nodeName}">
                <div class="{$nodeName}Label complexLabel">
                    <xsl:value-of select="bfn:upperCase($nodeName)"/>:</div>
                <div class="attrEntry">
                    <xsl:apply-templates select="@*" />
                </div>
                <xsl:apply-templates select="*" />
            </div>
        </xsl:template>
    -->
    <xsl:template match="*[not(exists(*))]" priority="10">
        <xsl:choose>
            <xsl:when test="string-length(.) gt 0">
                <xsl:variable name="nodeName" select="local-name(.)"/>
                <div class="nodeEntry">
                    <span class="{$nodeName}Label simpleLabel">
                        <xsl:value-of select="bfn:upperCase($nodeName)"/>:</span>
                    <span class="{$nodeName}Value simpleValue">
                        <xsl:value-of select="normalize-space(.)"/>
                    </span>
                    <div class="attrEntry">
                        <xsl:apply-templates select="@*"/>
                    </div>
                </div>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@*">
        <xsl:choose>
            <xsl:when test="string-length(.) gt 0">
                <xsl:variable name="attrName" select="local-name(.)"/>
                <span class="{$attrName}Label attrLabel">
                    <xsl:value-of select="$attrName"/>:</span>
                <span class="{$attrName}Value attrValue">
                    <xsl:value-of select="normalize-space(.)"/>
                </span>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="*"/>
    <xsl:template match="@*|text()" priority="5"/>
    <xsl:template match="comment()" priority="5"/>
    <xsl:function name="bfn:sectionTitle" as="xsd:string?">
        <xsl:param name="arg" as="xsd:string?"/>
        <xsl:sequence select="substring-before(bfn:upperCase($arg),'Set')"/>
    </xsl:function>
    <xsl:function name="bfn:upperCase" as="xsd:string?">
        <xsl:param name="arg" as="xsd:string?"/>
        <xsl:sequence select="concat(upper-case(substring($arg,1,1)),substring($arg,2))"/>
    </xsl:function>
    <xsl:template name="renderVraAttr">
        <xsl:param name="attrName"/>
        <xsl:param name="mode">inline</xsl:param>
        <xsl:param name="ifAbsent"/>
        <xsl:choose>
            <xsl:when test="@*[name()=$attrName]">
                <xsl:choose>
                    <xsl:when test="'inline'=$mode">
                        <span class="vraAttr">
                            <span class="vraAttrName">
                                <xsl:value-of select="$attrName"/>
                            </span>
                            <span class="vraAttrValue">
                                <xsl:value-of select="@*[name()=$attrName]"/>
                            </span>
                        </span>
                    </xsl:when>
                    <xsl:when test="'simple'=$mode">
                        <xsl:value-of select="@*[name()=$attrName]"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$ifAbsent"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="vra:display" priority="40">
        <xsl:if test="text()">
            <div class="display-container" property="{name()}">
                <xsl:value-of select="text()"/>
            </div>
        </xsl:if>
    </xsl:template>
    <xsl:template match="vra:notes" priority="40">
        <xsl:if test="text()">
            <div class="notes-container detail">
                <span class="notes" property="{name()}">
                    <xsl:value-of select="text()"/>
                </span>
            </div>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>