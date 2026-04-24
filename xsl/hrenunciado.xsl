<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0 ">
    <xsl:output encoding="UTF-8" method="html" doctype-public="" />
    <xsl:template match="/">
        <table border="1">
            <tr>
                <th>Posición</th>
                <th>Nombre</th>
                <th>Salario</th>
                <th>Departamento</th>
            </tr>
            <xsl:apply-templates select="//employee" mode="tabla" />
        </table>
    </xsl:template>
    <xsl:template match="employee" mode="tabla">
        <tr>
            <td>
                <xsl:value-of select="position()" />
            </td>
            <td>
                <xsl:value-of select="concat(first_name,' ', last_name)" />
            </td>
            <td>
                <xsl:value-of select="salary" />
            </td>
            <td>
                <xsl:value-of
                    select="//department[department_id=current()/department_id]/department_name" />
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
