<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
	xmlns="http://purl.org/rss/1.0/"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:admin="http://webns.net/mvcb/"
	xmlns:dc="http://purl.org/dc/elements/1.1/">
<xsl:output encoding="UTF-8" method="xml" indent="yes" cdata-section-elements="description" />

<xsl:template match="/rdffeed">

<rdf:RDF>
	<channel>
		<xsl:attribute name="rdf:about"><xsl:value-of select="link" /></xsl:attribute>
		<title><xsl:value-of select="title" /></title>
		<link><xsl:value-of select="link" /></link>
		<description><xsl:value-of select="description" /></description>
		<dc:creator>www@gentoo.gr.jp</dc:creator>
		<dc:language>ja</dc:language>
		<admin:errorReportsTo rdf:resource="mailto:www@gentoo.gr.jp" />
		<items>
			<rdf:Seq>
				<xsl:for-each select="document('/jpnews/org/news-index.xml')/uris/uri[position()&lt;11]/text()">
					<xsl:sort select="position()" order="ascending" /> 
					<rdf:li>
						<xsl:attribute name="rdf:resource">http://www.gentoo.jp<xsl:value-of select="concat(substring-before(., 'xml'), 'html')" /></xsl:attribute>
					</rdf:li>
				</xsl:for-each>
			</rdf:Seq>
		</items>
	</channel>

	<xsl:for-each select="document('/jpnews/org/news-index.xml')/uris/uri[position()&lt;11]/text()">
	<item>
		<xsl:attribute name="rdf:about">http://www.gentoo.jp<xsl:value-of select="concat(substring-before(., 'xml'), 'html')" /></xsl:attribute>
		<title><xsl:value-of select="document(.)/news/title" /></title> 
		<link>http://www.gentoo.jp<xsl:value-of select="concat(substring-before(., 'xml'), 'html')" /></link>
		<dc:subject><xsl:value-of select="document(.)/news/@category" /></dc:subject>
		<dc:creator><xsl:value-of select="document(.)/news/poster" /></dc:creator>
		<!-- <dc:date><xsl:value-of select="document(.)/news/date" /></dc:date> -->
		<description><xsl:value-of select="normalize-space(document(.)/news/body)" /></description>
	</item>
	</xsl:for-each>
</rdf:RDF>

</xsl:template>
</xsl:stylesheet>
