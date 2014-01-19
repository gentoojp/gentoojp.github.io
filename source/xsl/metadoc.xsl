<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:func="http://exslt.org/functions"
                xmlns:exslt="http://exslt.org/common"
                extension-element-prefixes="func exslt" >

<xsl:output encoding="UTF-8" method="xml" doctype-system="/dtd/guide.dtd"/>

<!-- Include inserts stylesheet -->
<xsl:include href="inserts.xsl" />

<!-- Selection parameter -->
<xsl:param name="catid">0</xsl:param>

<xsl:template match="dynamic">
  <xsl:variable name="metadoc"  select="document(@metadoc)"/>
  <xsl:variable name="pmetadoc">
    <xsl:if test="exslt:node-set($metadoc)/metadoc/@parent">
      <xsl:copy-of select="document(exslt:node-set($metadoc)/metadoc/@parent)"/>
    </xsl:if>
  </xsl:variable>
  <xsl:variable name="lang" select="exslt:node-set($metadoc)/metadoc/@lang"/>
<mainpage id="docs" lang="{$lang}">
  <title><xsl:value-of select="title"/></title>
  <author title="Author">Gentoo Documentation Project</author>
  <version>Dynamically</version>
  <date><xsl:value-of select="func:today()"/></date>

  <xsl:if test="intro">
  <chapter>
    <title><xsl:value-of select="title"/></title>
    <xsl:apply-templates match="intro"/>
  </chapter>
  </xsl:if>

  <xsl:choose>
    <xsl:when test="catid and not($catid = 0)">
      <!-- ID selected -->
      <xsl:apply-templates select="catid[text() = $catid]">
        <xsl:with-param name="metadoc"  select="$metadoc"/>
        <xsl:with-param name="pmetadoc" select="$pmetadoc"/>
        <xsl:with-param name="lang"     select="$lang"/>
        <xsl:with-param name="unfold">yes</xsl:with-param>
      </xsl:apply-templates>
    </xsl:when>
    <xsl:when test="catid">
      <!-- No ID selected, but we're still checking for catid -->
      <chapter>
      <title><xsl:value-of select="func:gettext('GLinuxDoc', $lang)"/></title>
      <section>
      <body>

      <ul>
      <xsl:apply-templates select="catid">
        <xsl:with-param name="metadoc"  select="$metadoc"/>
        <xsl:with-param name="pmetadoc" select="$pmetadoc"/>
        <xsl:with-param name="lang"     select="$lang"/>
        <xsl:with-param name="unfold">no</xsl:with-param>
      </xsl:apply-templates>
      </ul>

      </body>
      </section>
      </chapter>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates>
        <xsl:with-param name="metadoc"  select="$metadoc"/>
        <xsl:with-param name="pmetadoc" select="$pmetadoc"/>
        <xsl:with-param name="lang"     select="$lang"/>
      </xsl:apply-templates>
    </xsl:otherwise>
  </xsl:choose>
</mainpage>
</xsl:template>

<xsl:template match="catid">
  <xsl:param name="metadoc"/>
  <xsl:param name="pmetadoc"/>
  <xsl:param name="lang"/>
  <xsl:param name="unfold"/>
  <xsl:variable name="categorie"><xsl:value-of select="text()"/></xsl:variable>
  <xsl:choose>
    <xsl:when test="$unfold = 'yes'">
      <chapter>
        <title><xsl:value-of select="exslt:node-set($metadoc)/metadoc/categories/cat[@id = $categorie]"/></title>
        <xsl:call-template name="categories">
          <xsl:with-param name="metadoc"   select="$metadoc"/>
          <xsl:with-param name="pmetadoc"  select="$pmetadoc"/>
          <xsl:with-param name="lang"      select="$lang"/>
          <xsl:with-param name="categorie" select="$categorie"/>
        </xsl:call-template>
        <section><body>
        <xsl:if test="exslt:node-set($pmetadoc)/metadoc">
          <br/><p>¹ <xsl:value-of select="func:gettext('untranslated', $lang)"/></p>
        </xsl:if>
        </body></section>
      </chapter>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="cat_id" select="text()"/>
      <li><uri link="?catid={$cat_id}"><xsl:value-of select="exslt:node-set($metadoc)/metadoc/categories/cat[@id = $categorie]"/></uri></li>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="intro">
<xsl:copy-of select="@*|node()"/>
</xsl:template>

<xsl:template name="categories">
  <xsl:param name="metadoc"/>
  <xsl:param name="pmetadoc"/>
  <xsl:param name="lang"/>
  <xsl:param name="categorie"/>
  <!-- Non parental categories -->
  <xsl:if test="exslt:node-set($metadoc)/metadoc/docs/doc[memberof = $categorie]">
  <section>
  <body>
 
    <xsl:for-each select="exslt:node-set($metadoc)/metadoc/docs/doc[memberof = $categorie]">
      <xsl:choose>
        <xsl:when test="bugs/bug[@stopper = 'yes']">
          <!-- Ignore showstopper -->
        </xsl:when>
        <xsl:otherwise>
          <p><b>
          <xsl:call-template name="documentname">
            <xsl:with-param name="metadoc"  select="$metadoc"/>
            <xsl:with-param name="pmetadoc" select="$pmetadoc"/>
            <xsl:with-param name="lang"     select="$lang"/>
            <xsl:with-param name="fileid"   select="fileid/text()"/>
            <xsl:with-param name="vpart"    select="fileid/@vpart"/>
            <xsl:with-param name="vchap"    select="fileid/@vchap"/>
            <xsl:with-param name="docid"    select="@id"/>
          </xsl:call-template>
          </b><xsl:value-of select="func:gettext('SpaceBeforeColon', $lang)"/>: <xsl:call-template name="documentabstract">
            <xsl:with-param name="metadoc"  select="$metadoc"/>
            <xsl:with-param name="pmetadoc" select="$pmetadoc"/>
            <xsl:with-param name="lang"     select="$lang"/>
            <xsl:with-param name="fileid"   select="fileid/text()"/>
            <xsl:with-param name="vpart"    select="fileid/@vpart"/>
            <xsl:with-param name="vchap"    select="fileid/@vchap"/>
            <xsl:with-param name="docid"    select="@id"/>
          </xsl:call-template>
          </p>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  
  </body>
  </section>
  </xsl:if>

  <!-- Parental categories -->
  <xsl:for-each select="exslt:node-set($metadoc)/metadoc/categories/cat[@parent = $categorie]">
    <xsl:variable name="currentcat"><xsl:value-of select="@id"/></xsl:variable>
    <section>
      <title><xsl:value-of select="text()"/></title>
      <body>

        <xsl:for-each select="exslt:node-set($metadoc)/metadoc/docs/doc[memberof = $currentcat]">
          <xsl:choose>
            <xsl:when test="bugs/bug[@stopper = 'yes']">

            </xsl:when>
            <xsl:otherwise>
              <p><b>
              <xsl:call-template name="documentname">
                <xsl:with-param name="metadoc"  select="$metadoc"/>
                <xsl:with-param name="pmetadoc" select="$pmetadoc"/>
                <xsl:with-param name="lang"     select="$lang"/>
                <xsl:with-param name="fileid"   select="fileid/text()"/>
                <xsl:with-param name="vpart"    select="fileid/@vpart"/>
                <xsl:with-param name="vchap"    select="fileid/@vchap"/>
                <xsl:with-param name="docid"    select="@id"/>
              </xsl:call-template>
              </b><xsl:value-of select="func:gettext('SpaceBeforeColon', $lang)"/>: <xsl:call-template name="documentabstract">
                <xsl:with-param name="metadoc"  select="$metadoc"/>
                <xsl:with-param name="pmetadoc" select="$pmetadoc"/>
                <xsl:with-param name="lang"     select="$lang"/>
                <xsl:with-param name="fileid"   select="fileid/text()"/>
                <xsl:with-param name="vpart"    select="fileid/@vpart"/>
                <xsl:with-param name="vchap"    select="fileid/@vchap"/>
                <xsl:with-param name="docid"    select="@id"/>
              </xsl:call-template>
              </p>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      
      </body>
    </section>
  </xsl:for-each>
</xsl:template>

<xsl:template name="documentname">
  <xsl:param name="metadoc"/>
  <xsl:param name="pmetadoc"/>
  <xsl:param name="lang"/>
  <xsl:param name="fileid"/>
  <xsl:param name="vpart"/>
  <xsl:param name="vchap"/>
  <xsl:param name="docid"/>
  <xsl:variable name="link"><xsl:value-of select="exslt:node-set($metadoc)/metadoc/files/file[@id = $fileid]/text()"/></xsl:variable>
  <xsl:variable name="dlink" select="document($link)"/>
  <xsl:variable name="footnote">
    <xsl:variable name="parentfile" select="exslt:node-set($pmetadoc)/metadoc/files/file[@id = $fileid]"/>
    <xsl:if test="$link = $parentfile">&#160;¹</xsl:if>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$vpart">
      <xsl:choose>
        <xsl:when test="$vchap">
          <uri link="{$link}?part={$vpart}&amp;chap={$vchap}"><xsl:value-of select="exslt:node-set($dlink)/book/part[position()=$vpart]/chapter[position()=$vchap]/title"/></uri>
        </xsl:when>
        <xsl:otherwise>
          <uri link="{$link}?part={$vpart}"><xsl:value-of select="exslt:node-set($dlink)/book/part[position() = $vpart]/title"/></uri>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <uri link="{$link}"><xsl:value-of select="exslt:node-set($dlink)//title[1]"/></uri>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:copy-of select="$footnote"/>
</xsl:template>

<xsl:template name="documentabstract">
  <xsl:param name="metadoc"/>
  <xsl:param name="pmetadoc"/>
  <xsl:param name="lang"/>
  <xsl:param name="fileid"/>
  <xsl:param name="vpart"/>
  <xsl:param name="vchap"/>
  <xsl:param name="docid"/>
  <xsl:variable name="link"><xsl:value-of select="exslt:node-set($metadoc)/metadoc/files/file[@id = $fileid]/text()"/></xsl:variable>

  <xsl:choose>
    <xsl:when test="$vpart">
      <xsl:choose>
        <xsl:when test="$vchap">
          <xsl:value-of select="document($link)/book/part[position()=$vpart]/chapter[position()=$vchap]/abstract"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="document($link)/book/part[position() = $vpart]/abstract"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="document($link)/guide/abstract|document($link)/book/abstract"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="listing">
  <xsl:param name="metadoc"/>
  <xsl:param name="pmetadoc"/>
  <xsl:param name="lang"/>
  <chapter>
  <title><xsl:value-of select="func:gettext('GLinuxDoc', $lang)"/></title>
  <section>
  <body>

  <xsl:for-each select="list">
    <xsl:call-template name="list">
      <xsl:with-param name="metadoc"  select="$metadoc"/>
      <xsl:with-param name="pmetadoc" select="$pmetadoc"/>
      <xsl:with-param name="lang"     select="$lang"/>
      <xsl:with-param name="catid"    select="text()"/>
    </xsl:call-template>
  </xsl:for-each>

  <xsl:if test="exslt:node-set($pmetadoc)/metadoc">
    <br/><p>¹ <xsl:value-of select="func:gettext('untranslated', $lang)"/></p>
  </xsl:if>
  
  </body>
  </section>
  </chapter>
</xsl:template>

<xsl:template match="list" name="list">
  <xsl:param name="metadoc"/>
  <xsl:param name="pmetadoc"/>
  <xsl:param name="lang"/>
  <xsl:param name="catid" select="text()"/>
  <ul><b><xsl:value-of select="exslt:node-set($metadoc)/metadoc/categories/cat[@id = $catid]"/></b>
    <xsl:for-each select="exslt:node-set($metadoc)/metadoc/docs/doc[memberof = $catid]">
      <xsl:choose>
        <xsl:when test="bugs/bug[@stopper = 'yes']">
          <!-- Ignore showstopper case -->
        </xsl:when>
        <xsl:otherwise>
          <li>
          <xsl:call-template name="documentname">
            <xsl:with-param name="metadoc"  select="$metadoc"/>
            <xsl:with-param name="pmetadoc" select="$pmetadoc"/>
            <xsl:with-param name="lang"     select="$lang"/>
            <xsl:with-param name="fileid"   select="fileid"/>
            <xsl:with-param name="vpart"    select="fileid/@vpart"/>
            <xsl:with-param name="vchap"    select="fileid/@vchap"/>
            <xsl:with-param name="docid"    select="@id"/>
          </xsl:call-template>
          </li>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:for-each select="exslt:node-set($metadoc)/metadoc/categories/cat[@parent = $catid]">
      <xsl:call-template name="list">
        <xsl:with-param name="metadoc"  select="$metadoc"/>
        <xsl:with-param name="pmetadoc" select="$pmetadoc"/>
        <xsl:with-param name="lang"     select="$lang"/>
        <xsl:with-param name="catid"    select="@id"/>
      </xsl:call-template>
    </xsl:for-each>
  </ul>
</xsl:template>

<xsl:template match="overview">
  <xsl:param name="metadoc"/>
  <xsl:param name="pmetadoc"/>
  <xsl:param name="lang"/>

  <xsl:variable name="userfile" select="document('/proj/en/devrel/roll-call/userinfo.xml')"/>

  <chapter id="members">
  <title><xsl:value-of select="func:gettext('members', $lang)"/></title>
  <section>
  <body>
  
  <table>
    <tr>
      <th><xsl:value-of select="func:gettext('name', $lang)"/></th>
      <th><xsl:value-of select="func:gettext('nick', $lang)"/></th>
      <th><xsl:value-of select="func:gettext('email', $lang)"/></th>
      <th><xsl:value-of select="func:gettext('position', $lang)"/></th>
    </tr>
    <xsl:for-each select="exslt:node-set($metadoc)/metadoc/members/lead">
      <xsl:variable name="nickname" select="text()"/>
      <xsl:variable name="fullname" select="concat(exslt:node-set($userfile)/userlist/user[@username = $nickname]/realname/firstname, ' ', exslt:node-set($userfile)/userlist/user[@username = $nickname]/realname/familyname)"/>
      <xsl:variable name="email"    select="exslt:node-set($userfile)/userlist/user[@username = $nickname]/email"/>
      <tr>
        <ti><xsl:value-of select="$fullname"/></ti>
        <ti><xsl:value-of select="$nickname"/></ti>
        <ti><xsl:value-of select="$email"/></ti>
        <ti><xsl:value-of select="func:gettext('lead', $lang)"/></ti>
      </tr>
    </xsl:for-each>
    <xsl:for-each select="exslt:node-set($metadoc)/metadoc/members/member">
      <xsl:variable name="nickname" select="text()"/>
      <xsl:variable name="fullname">
        <xsl:choose>
          <xsl:when test="@fullname"><xsl:value-of select="@fullname"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="concat(exslt:node-set($userfile)/userlist/user[@username = $nickname]/realname/firstname, ' ', exslt:node-set($userfile)/userlist/user[@username = $nickname]/realname/familyname)"/></xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="email">
        <xsl:choose>
          <xsl:when test="@mail"><xsl:value-of select="@mail"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="exslt:node-set($userfile)/userlist/user[@username = $nickname]/email"/></xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <tr>
        <ti><xsl:value-of select="$fullname"/></ti>
        <ti><xsl:value-of select="$nickname"/></ti>
        <ti><xsl:value-of select="$email"/></ti>
        <ti><xsl:value-of select="func:gettext('member', $lang)"/></ti>
      </tr>
    </xsl:for-each>
  </table>
  
  </body>
  </section>
  </chapter>
  
  <chapter id="files">
  <title><xsl:value-of select="func:gettext('files', $lang)"/></title>
  <section>
  <body>

  <table>
  <tr>
    <th><xsl:value-of select="func:gettext('filename', $lang)"/></th>
    <th><xsl:value-of select="func:gettext('version', $lang)"/></th>
    <xsl:if test="exslt:node-set($pmetadoc)/metadoc">
      <th><xsl:value-of select="func:gettext('original', $lang)"/></th>
    </xsl:if>
    <th><xsl:value-of select="func:gettext('editing', $lang)"/></th>
  </tr>
  <xsl:for-each select="exslt:node-set($metadoc)/metadoc/files/file">
  <xsl:sort select="text()"/>
  <xsl:variable name="fileurl"    select="text()"/>
  <xsl:variable name="dfile"      select="document($fileurl)"/>
  <xsl:variable name="fileid"     select="@id"/>
  <xsl:variable name="parentfile" select="exslt:node-set($pmetadoc)/metadoc/files/file[@id = $fileid]"/>
  <tr>
  <!-- Add ?passthru=1 to handbook files, i.e. those with <sections> as a root element
       because they can't be rendered as-is; at the moment, they give an Err 500.
       Of course, we could update guide.xsl to make them "renderable" -->
  <ti>
  <xsl:choose>
    <xsl:when test="exslt:node-set($dfile)/sections">
      <uri link="{$fileurl}?passthru=1"><xsl:value-of select="$fileurl"/></uri>
    </xsl:when>
    <xsl:otherwise>
      <uri link="{$fileurl}"><xsl:value-of select="$fileurl"/></uri>
    </xsl:otherwise>
  </xsl:choose>
  <!-- Untranslated file -->
  <xsl:if test="$parentfile and $parentfile = $fileurl">&#160;¹</xsl:if>
  </ti>
    <xsl:variable name="version"><xsl:value-of select="translate(exslt:node-set($dfile)//version[1],'$-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz,', '')"/></xsl:variable>
    <ti><xsl:value-of select="$version"/></ti>
    <!-- Original version column:
         display only when current metadoc has a master metadoc (parent attribute)
         When metadoc has no master defined, it is the master and column is not displayed -->
    <xsl:if test="exslt:node-set($pmetadoc)/metadoc">
      <ti>
        <xsl:choose>
          <xsl:when test="$parentfile and $parentfile != $fileurl">
            <!-- 2 different filenames, it is a translation -->
            <xsl:variable name="parentversion"><xsl:value-of select="document($parentfile)//version[1]"/></xsl:variable>
            <xsl:choose>
              <xsl:when test="$parentversion=$version">
                <xsl:value-of select="$parentversion"/>
              </xsl:when>
              <xsl:otherwise>
                <brite><xsl:value-of select="$parentversion"/></brite>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="func:gettext('N/A', $lang)"/>
          </xsl:otherwise>
        </xsl:choose>
      </ti>
    </xsl:if>
    <ti></ti>
  </tr>
  </xsl:for-each>
  </table>

  </body>
  </section>
  </chapter>

  <chapter id="bugs">
  <title><xsl:value-of select="func:gettext('bugs', $lang)"/></title>
  <section id="showstoppers">
  <title><xsl:value-of select="func:gettext('showstoppers', $lang)"/></title>
  <body>

  <table>
  <tr>
    <th><xsl:value-of select="func:gettext('document', $lang)"/></th>
    <th><xsl:value-of select="func:gettext('bugid', $lang)"/></th>
  </tr>
  <xsl:for-each select="exslt:node-set($metadoc)/metadoc/docs/doc[bugs/bug/@stopper = 'yes']">
    <tr>
      <ti>
        <xsl:call-template name="documentname">
          <xsl:with-param name="metadoc"  select="$metadoc"/>
          <xsl:with-param name="pmetadoc" select="$pmetadoc"/>
          <xsl:with-param name="lang"     select="$lang"/>
          <xsl:with-param name="fileid"   select="fileid/text()"/>
          <xsl:with-param name="vpart"    select="fileid/@vpart"/>
          <xsl:with-param name="vchap"    select="fileid/@vchap"/>
          <xsl:with-param name="docid"    select="@id"/>
        </xsl:call-template>
      </ti>
      <ti>
        <xsl:for-each select="bugs/bug[@stopper = 'yes']">
          <xsl:variable name="bugid" select="text()"/>
          <uri link="http://bugs.gentoo.org/show_bug.cgi?id={$bugid}">
            <xsl:value-of select="$bugid"/>
          </uri>
          <xsl:if test="not(position() = last())">, </xsl:if>
        </xsl:for-each>
      </ti>
    </tr>
  </xsl:for-each>
  </table>

  </body>
  </section>
  <section id="normalbugs">
  <title><xsl:value-of select="func:gettext('normalbugs', $lang)"/></title>
  <body>

  <table>
  <tr>
    <th><xsl:value-of select="func:gettext('document', $lang)"/></th>
    <th><xsl:value-of select="func:gettext('bugid', $lang)"/></th>
  </tr>
  <xsl:for-each select="exslt:node-set($metadoc)/metadoc/docs/doc[bugs/bug[not(@stopper = 'yes')]]">
    <tr>
      <ti>
        <xsl:call-template name="documentname">
          <xsl:with-param name="metadoc"  select="$metadoc"/>
          <xsl:with-param name="pmetadoc" select="$pmetadoc"/>
          <xsl:with-param name="lang"     select="$lang"/>
          <xsl:with-param name="fileid"   select="fileid/text()"/>
          <xsl:with-param name="vpart"    select="fileid/@vpart"/>
          <xsl:with-param name="vchap"    select="fileid/@vchap"/>
          <xsl:with-param name="docid"    select="@id"/>
        </xsl:call-template>
      </ti>
      <ti>
        <xsl:for-each select="bugs/bug[not(@stopper = 'yes')]">
          <xsl:variable name="bugid" select="text()"/>
          <uri link="http://bugs.gentoo.org/show_bug.cgi?id={$bugid}">
            <xsl:value-of select="$bugid"/>
          </uri>
          <xsl:if test="not(position() = last())">, </xsl:if>
        </xsl:for-each>
      </ti>
    </tr>
  </xsl:for-each>
  </table>

  <xsl:if test="exslt:node-set($pmetadoc)/metadoc">
    <br/><p>¹ <xsl:value-of select="func:gettext('untranslated', $lang)"/></p>
  </xsl:if>

  </body>
  </section>
  </chapter>
</xsl:template>

</xsl:stylesheet>
