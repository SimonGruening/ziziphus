<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:template match="vra:agentSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:agent">
                  <tr>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(vra:name) != 0">
                              <div id="d3e512-Name" data-bf-type="input" data-bf-bind="vra:name" tabindex="0"
                                   title="Name">
                                 <xsl:value-of select="vra:name"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="input" data-bf-bind="vra:name" tabindex="0"><a href="#" title="Click to add element: Name"
                                    style="font-style: italic;font-size: 0.8em;">(Name)</a></div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(vra:name/@type) != 0">
                              <div id="d6e36-Type" data-bf-type="select1" data-bf-bind="vra:name/@type"
                                   tabindex="0"
                                   title="Type">
                                 <xsl:value-of select="vra:name/@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="select1" data-bf-bind="vra:name/@type"
                                   tabindex="0"><a href="#" title="Click to add element: Type"
                                    style="font-style: italic;font-size: 0.8em;">(Type)</a></div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(vra:attribution) != 0">
                              <div id="d3e504-Attribution" data-bf-type="input" data-bf-bind="vra:attribution"
                                   tabindex="0"
                                   title="Attribution">
                                 <xsl:value-of select="vra:attribution"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="input" data-bf-bind="vra:attribution" tabindex="0"><a href="#" title="Click to add element: Attribution"
                                    style="font-style: italic;font-size: 0.8em;">(Attribution)</a></div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(vra:culture) != 0">
                              <div id="d3e505-Culture" data-bf-type="input" data-bf-bind="vra:culture"
                                   tabindex="0"
                                   title="Culture">
                                 <xsl:value-of select="vra:culture"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="input" data-bf-bind="vra:culture" tabindex="0"><a href="#" title="Click to add element: Culture"
                                    style="font-style: italic;font-size: 0.8em;">(Culture)</a></div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(vra:dates/@type) != 0">
                              <div id="d6e31-Type" data-bf-type="select1" data-bf-bind="vra:dates/@type"
                                   tabindex="0"
                                   title="Type">
                                 <xsl:value-of select="vra:dates/@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="select1" data-bf-bind="vra:dates/@type"
                                   tabindex="0"><a href="#" title="Click to add element: Type"
                                    style="font-style: italic;font-size: 0.8em;">(Type)</a></div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(vra:dates/vra:earliestDate) != 0">
                              <div id="d3e508-EarliestDate" data-bf-type="input"
                                   data-bf-bind="vra:dates/vra:earliestDate"
                                   tabindex="0"
                                   title="EarliestDate">
                                 <xsl:value-of select="vra:dates/vra:earliestDate"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="input" data-bf-bind="vra:dates/vra:earliestDate"
                                   tabindex="0"><a href="#" title="Click to add element: EarliestDate"
                                    style="font-style: italic;font-size: 0.8em;">(EarliestDate)</a></div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(vra:dates/vra:earliestDate/@circa) != 0">
                              <div id="" data-bf-type="input" data-bf-bind="vra:dates/vra:earliestDate/@circa"
                                   tabindex="0"
                                   title="circa">
                                 <xsl:value-of select="vra:dates/vra:earliestDate/@circa"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="input"
                                   data-bf-bind="vra:dates/vra:earliestDate/@circa"
                                   tabindex="0"><a href="#" title="Click to add element: circa"
                                    style="font-style: italic;font-size: 0.8em;">(circa)</a></div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(vra:dates/vra:latestDate) != 0">
                              <div id="d3e510-LatestDate" data-bf-type="input"
                                   data-bf-bind="vra:dates/vra:latestDate"
                                   tabindex="0"
                                   title="LatestDate">
                                 <xsl:value-of select="vra:dates/vra:latestDate"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="input" data-bf-bind="vra:dates/vra:latestDate"
                                   tabindex="0"><a href="#" title="Click to add element: LatestDate"
                                    style="font-style: italic;font-size: 0.8em;">(LatestDate)</a></div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(vra:dates/vra:latestDate/@circa) != 0">
                              <div id="" data-bf-type="input" data-bf-bind="vra:dates/vra:latestDate/@circa"
                                   tabindex="0"
                                   title="circa">
                                 <xsl:value-of select="vra:dates/vra:latestDate/@circa"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="input"
                                   data-bf-bind="vra:dates/vra:latestDate/@circa"
                                   tabindex="0"><a href="#" title="Click to add element: circa"
                                    style="font-style: italic;font-size: 0.8em;">(circa)</a></div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(vra:role) != 0">
                              <div id="d3e514-Role" data-bf-type="input" data-bf-bind="vra:role" tabindex="0"
                                   title="Role">
                                 <xsl:value-of select="vra:role"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="input" data-bf-bind="vra:role" tabindex="0"><a href="#" title="Click to add element: Role"
                                    style="font-style: italic;font-size: 0.8em;">(Role)</a></div>
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