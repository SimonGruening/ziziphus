<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:rightsSet" priority="40">
        <xsl:param name="vraTableId"/>
        <xsl:variable name="setTableId" select="if($vraTableId) then ($vraTableId) else ($setname)"/>
        <div class="simple" id="{$setTableId}">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Type</th>
                        <th>Holder</th>
                        <th/>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="vra:rights">
                        <tr>
                            <td>
                                <xsl:value-of select="@type"/>
                            </td>
                            <td>
                                <xsl:value-of select="vra:rightsHolder"/>
                            </td>
                            <td>
                                <xsl:value-of select="vra:text"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </div>
    </xsl:template>
</xsl:stylesheet>