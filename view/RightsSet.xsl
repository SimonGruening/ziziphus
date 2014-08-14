<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:preserve-space elements="vra:text"></xsl:preserve-space>
   <xsl:template match="vra:rightsSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:rights">
                  <tr>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(@type,'')) != 0">
                              <div class="  keepWhitespace" data-bf-type="select1" data-bf-bind="@type"
                                   tabindex="0"
                                   title="Type"
                                   id="b-d2e1173">
                                 <xsl:value-of select="@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata keepWhitespace" data-bf-type="select1" data-bf-bind="@type"
                                   tabindex="0">
                                 <p>(Type)</p>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:rightsHolder,'')) != 0">
                              <div class="keepWhitespace" data-bf-type="input" data-bf-bind="vra:rightsHolder"
                                   tabindex="0"
                                   title="RightsHolder"
                                   id="b-d2e1117">
                                 <xsl:value-of select="vra:rightsHolder"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata keepWhitespace" data-bf-type="input"
                                   data-bf-bind="vra:rightsHolder"
                                   tabindex="0">
                                 <p>(RightsHolder)</p>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:text,'')) != 0">
                              <div class="keepWhitespace" data-bf-type="textarea" data-bf-bind="vra:text"
                                   tabindex="0"
                                   title="Text"
                                   id="b-d2e1138">
                                 <xsl:value-of select="vra:text"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata keepWhitespace" data-bf-type="textarea" data-bf-bind="vra:text"
                                   tabindex="0">
                                 <p>(Text)</p>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                  </tr>
               </xsl:for-each>
            </tbody>
         </table>
      </div>
   </xsl:template>
</xsl:stylesheet>