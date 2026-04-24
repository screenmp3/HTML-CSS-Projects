<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes" encoding="UTF-8" />

    <xsl:template match="/">
        <html>
            <head>
                <title>Museos</title>
            </head>
            <body>
                <h1>Museos</h1>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Ciudad</th>
                            <th>País</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="museos/museo" />
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="museo">
        <tr>
            <td>
                <xsl:value-of select="nombre" />
            </td>
            <td>
                <xsl:value-of select="ciudad" />
            </td>
            <td>
                <xsl:value-of select="pais" />
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
