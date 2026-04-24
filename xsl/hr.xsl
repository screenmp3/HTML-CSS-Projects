<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Departments</title>
            </head>
            <body>
                <h1>Departments</h1>
                <xsl:apply-templates select="hr/employees/employee[not(department_id = preceding-sibling::employee/department_id) and department_id]">
                    <xsl:sort select="department_id" data-type="number"/>
                </xsl:apply-templates>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="employee">
        <xsl:variable name="dept" select="department_id"/>
        <h2>Department <xsl:value-of select="$dept"/></h2>
        
        <h3>Managers</h3>
        <table border="1">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Salary</th>
                </tr>
            </thead>
            <tbody>
                <xsl:apply-templates select="//employee[department_id = $dept and (not(manager_id) or not(manager_id = //employee[department_id = $dept]/employee_id))]" mode="employee-row"/>
            </tbody>
        </table>
        
        <h3>Employees</h3>
        <table border="1">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Salary</th>
                </tr>
            </thead>
            <tbody>
                <xsl:apply-templates select="//employee[department_id = $dept]" mode="employee-row"/>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template match="employee" mode="employee-row">
        <tr>
            <td><xsl:value-of select="concat(first_name, ' ', last_name)"/></td>
            <td><xsl:value-of select="salary"/></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>