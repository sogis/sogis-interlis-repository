<?xml version="1.0"?>
<xsl:stylesheet xmlns:ili="http://www.interlis.ch/INTERLIS2.3" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="html"/>
	<xsl:template match="/">
        <html>
        <head>
        <title>INTERLIS-Modellablage • Kanton Solothurn</title>
        <meta name="description" content="Modellablage für INTELIS-Datenmodelle der Geodaten des des Kantons Solothurn."/>
        <meta name="keywords" content="INTERLIS, Modellablage, Geodaten, Datenmodell, Solothurn, AGI, SOGIS"/>
        <meta name="author" content="Stefan Ziegler" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta http-equiv="cache-control" content="no-cache"/>

        <link type="text/css" rel="stylesheet" href="fonts.css" />
        <link type="text/css" rel="stylesheet" href="ilimodels.css" />
        <link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />

        </head>
        <body>
        <div id="container">
            <div class="logo">
                <div>
                    <img src="Logo.png" alt="Logo Kanton Solothurn" style="max-width: 100%; min-width:200px;"/>
                </div>
            </div>

            <div >
                <i style="line-height:40px; vertical-align: middle;" class="material-icons md-18">home</i>
                <span class="breadcrumb link">&#160;&#160;<a href="https://agi.so.ch">Home</a></span>
                <span class="breadcrumb active">&#160;&gt;&#160;Datenmodelle</span>
            </div>

            <div id="title">
                Datenmodelle Kanton Solothurn
            </div>


        <p>The content of the body element is displayed in the browser window.</p>
        <p>The content of the title element is displayed in the browser tab, in favorites and in search-engine results.</p>

        <xsl:apply-templates select="ili:TRANSFER/ili:DATASECTION/ili:IliRepository09.RepositoryIndex" />


        </div>

        </body>
        </html>

	</xsl:template>

    <xsl:template match="ili:IliRepository09.RepositoryIndex">
        <xsl:for-each select="ili:IliRepository09.RepositoryIndex.ModelMetadata">
            <xsl:sort select="substring(ili:File,1,3)" data-type="text"/>
            <xsl:sort select="ili:Name" data-type="text"/>
            <p><xsl:value-of select="ili:Name"/></p>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>