<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:func="http://exslt.org/functions" 
                xmlns:date="http://exslt.org/dates-and-times"
                extension-element-prefixes="func date">

<func:function name="func:gettext">
  <xsl:param name="str"/>
  <xsl:param name="PLANG"/>
  
<!-- For Debugging:
<xsl:message>PLANG=<xsl:value-of select="$PLANG"/> || str=<xsl:value-of select="$str"/> || gLang=<xsl:value-of select="$GLANG"/></xsl:message>
-->

  <!-- Default to English version when $LANG is undefined, the lang does not
       exist, or is improperly set.  Default to 'UNDEFINED STRING' when the
       requested text is unavailable.

       Used either the passed parameter (e.g. from metadoc.xsl)
       or the Global $GLANG that was initialized when loading a guide or a book
  -->
  <xsl:variable name="LANG">
    <xsl:choose>
      <xsl:when test="$PLANG"><xsl:value-of select="$PLANG"/></xsl:when>
      <xsl:when test="$GLANG"><xsl:value-of select="$GLANG"/></xsl:when>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="contains('|da|en|es|fi|fr|id|it|pl|pt_br|ro|ru|sv|zh_tw|',concat('|', $LANG,'|'))">
      <xsl:variable name="insert" select="document(concat('/doc/', $LANG, '/inserts-', $LANG, '.xml'))/inserts/insert[@name=$str]"/>
      <xsl:choose>
        <xsl:when test="$insert">
          <func:result select="$insert"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="insert-en" select="document('/doc/en/inserts-en.xml')/inserts/insert[@name=$str]"/>
          <xsl:choose>
            <xsl:when test="$insert-en">
              <func:result select="$insert-en"/>
            </xsl:when>
            <xsl:otherwise>
              <func:result select="'UNDEFINED STRING'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="insert-en" select="document('/doc/en/inserts-en.xml')/inserts/insert[@name=$str]"/>
      <xsl:choose>
        <xsl:when test="$insert-en">
          <func:result select="$insert-en" />
        </xsl:when>
        <xsl:otherwise>
          <func:result select="'UNDEFINED STRING'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</func:function>


<!-- D A T E   F O R M A T T I N G   R O U T I N E S -->

<func:function name="func:today">
  <func:result select="substring(date:date(),1,10)"/>
</func:function>

<func:function name="func:format-date">
  <xsl:param name="datum" />
  <xsl:param name="lingua" select="//*[1]/@lang"/>

  <xsl:variable name="mensis" select="document('/xsl/months.xml')"/>
  <xsl:variable name="NormlzD"><xsl:value-of select="normalize-space($datum)"/></xsl:variable>

  <xsl:choose>
    <xsl:when test="func:is-date($NormlzD)='YES'">
      <xsl:variable name="Y"><xsl:value-of select="number(substring($NormlzD,1,4))"/></xsl:variable>
      <xsl:variable name="M"><xsl:value-of select="number(substring($NormlzD,6,2))"/></xsl:variable>
      <xsl:variable name="D"><xsl:value-of select="number(substring($NormlzD,9,2))"/></xsl:variable>
      <xsl:choose>
        <!-- Formatting per language happens here -->

        <!-- For complex and/or repeated cases, better use a dedicated function -->

        <!-- English -->
        <xsl:when test="$lingua='en'">
          <func:result select="func:format-date-en($mensis, $Y, $M, $D)"/>
        </xsl:when>

        <!-- Danish / German / Finnish -->
        <xsl:when test="$lingua='da' or $lingua='de' or $lingua='fi'">
          <func:result select="concat($D, '. ', $mensis//months[@lang=$lingua]/month[position()=$M], ' ', $Y)"/>
        </xsl:when>

        <!-- Spanish -->
        <xsl:when test="$lingua='es'">
          <func:result select="concat($D, ' de ', $mensis//months[@lang=$lingua]/month[position()=$M], ', ', $Y)"/>
        </xsl:when>
        
        <!-- Brazilain Portuguese -->
        <xsl:when test="$lingua='pt_br'">
          <func:result select="concat($D, ' de ', $mensis//months[@lang=$lingua]/month[position()=$M], ' de ', $Y)"/>
        </xsl:when>
        
        <!-- Hungarian -->
        <xsl:when test="$lingua='hu'">
          <func:result select="concat($Y, '. ', $mensis//months[@lang=$lingua]/month[position()=$M], ' ', $D, '.')"/>
        </xsl:when>

        <!-- Chinese / Japanese -->
        <xsl:when test="$lingua='zh_cn' or $lingua='zh_tw' or $lingua='ja'">
          <func:result select="concat($Y, '年 ', $M, '月 ', $D, '日 ')"/>
        </xsl:when>

        <!-- Korean -->
        <xsl:when test="$lingua='ko'">
          <func:result select="concat($Y, '년 ', $M, '월 ', $D, '일')"/>
        </xsl:when>

        <!-- French -->
        <xsl:when test="$lingua='fr'">
          <func:result select="func:format-date-fr($mensis, $Y, $M, $D)" />
        </xsl:when>

        <!-- Dutch / Greek / Indonesian / Italian / Polish / Romanian / Russian / Swedish / Turkish / Vietnamese -->
        <xsl:when test="$lingua='nl' or $lingua='el' or $lingua='id' or $lingua='it' or $lingua='pl' or $lingua='ro' or $lingua='ru' or $lingua='sv' or $lingua='tr' or $lingua='vi'">
          <func:result select="concat($D, ' ', $mensis//months[@lang=$lingua]/month[position()=$M], ' ', $Y)"/>
        </xsl:when>

        <xsl:otherwise> <!-- Default to English -->
          <func:result select="func:format-date-en($mensis, $Y, $M, $D)" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <func:result select="$datum" />
    </xsl:otherwise>
  </xsl:choose>
</func:function>

<!-- Validate date, 1000<=YYYY<=9999, 01<=MM<=12, 01<=DD<={days in month} -->
<func:function name="func:is-date">
  <xsl:param name="YMD" />

  <func:result>
    <xsl:if test="string-length($YMD)=10 and substring($YMD,5,1)='-' and substring($YMD,8,1)='-' and contains('|01|02|03|04|05|06|07|08|09|10|11|12|',concat('|',substring($YMD,6,2),'|'))">
      <xsl:variable name="Y"><xsl:value-of select="number(substring($YMD,1,4))"/></xsl:variable>
      <xsl:variable name="M"><xsl:value-of select="number(substring($YMD,6,2))"/></xsl:variable>
      <xsl:variable name="D"><xsl:value-of select="number(substring($YMD,9,2))"/></xsl:variable>
      <xsl:if test="$Y &gt;= 1000 and $Y &lt;= 9999 and $D &gt;= 1 and $D &lt;= 31">
        <xsl:choose>
          <xsl:when test="$M=4 or $M=6 or $M=9 or $M=11">
            <xsl:if test="$D&lt;=30">YES</xsl:if>
          </xsl:when>
          <xsl:when test="$M=2 and ((($Y mod 4 = 0) and ($Y mod 100 != 0))  or  ($Y mod 400 = 0))">
            <xsl:if test="$D&lt;=29">YES</xsl:if>
          </xsl:when>
          <xsl:when test="$M=2">
            <xsl:if test="$D&lt;=28">YES</xsl:if>
          </xsl:when>
          <xsl:otherwise>YES</xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </xsl:if>
  </func:result>
</func:function>

<!-- Format date in  ENGLISH -->
<func:function name="func:format-date-en">
  <xsl:param name="mensis" />
  <xsl:param name="Y" />
  <xsl:param name="M" />
  <xsl:param name="D" />
  <func:result select="concat($mensis//months[@lang='en']/month[position()=$M], ' ', $D, ', ', $Y)" />
</func:function>

<!-- Format date in  FRENCH -->
<func:function name="func:format-date-fr">
  <xsl:param name="mensis" />
  <xsl:param name="Y" />
  <xsl:param name="M" />
  <xsl:param name="D" />
  <func:result>
    <xsl:value-of select="$D"/>
    <xsl:if test="$D=1">er</xsl:if>
    <xsl:value-of select="concat(' ', $mensis//months[@lang='fr']/month[position()=$M], ' ', $Y)"/>
  </func:result>
</func:function>




<!-- Define some globals that can be used throughout the stylesheets -->

<!-- Top element name e.g. "book" -->
<xsl:param name="TTOP"><xsl:value-of select="name(//*[1])" /></xsl:param>

<!-- Value of top element's link attribute e.g. "handbook.xml" -->
<xsl:param name="LINK"><xsl:value-of select="//*[1]/@link" /></xsl:param>

<!-- Value of top element's lang attribute e.g. "handbook.xml" -->
<xsl:param name="GLANG"><xsl:value-of select="//*[1]/@lang" /></xsl:param>


<xsl:template match="/">
  <!-- For Debugging:
   <xsl:message>TTOP: <xsl:value-of select="$TTOP" /> </xsl:message>
   <xsl:message>LANG: <xsl:value-of select="$LANG" /> </xsl:message>
   <xsl:message>LINK: <xsl:value-of select="$LINK" /> </xsl:message>
  -->
  <xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>
