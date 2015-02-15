<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:rss="http://purl.org/rss/1.0/"
>

	<xsl:include href="metadoc.xsl" />
<!-- <xsl:include href="inserts.xsl" /> -->

	<!-- 各種設定 -->
	<!-- トップニュースの個数 -->
	<xsl:variable name="number_of_jpnews" select="5"/>
	<xsl:variable name="number_of_orgnews" select="5"/>
	<xsl:variable name="number_of_ebuild_uploader" select="10"/>
	<xsl:variable name="number_of_news_list" select="20"/>
	<!-- ここまで設定 -->

	<xsl:output encoding="UTF-8" method="html" media-type="text/html" indent="yes" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
	<xsl:preserve-space elements="pre"/>
	<xsl:strip-space elements="*"/>
	<xsl:template match="img">
		<img src="{@src}"/>
	</xsl:template>

	<xsl:template match="/mainpage | /news | /guide | /move">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja">
			<head>
				<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
				<meta http-equiv="Content-style-type" content="text/css; charset=UTF-8" />
				<meta http-equiv="Content-script-type" content="text/javascript; charset=UTF-8" />
				
				<title>
					Gentoo Linux Users Group Japan
					<xsl:if test="not(/mainpage)">
						--
						<xsl:value-of select="title"/>
					</xsl:if>
				</title>

				<link title="new" rel="stylesheet" href="/css/main.css" type="text/css"/>
				<link title="new" rel="stylesheet" href="/css/gentoojp.css" type="text/css"/>
				<link rev="Made" href="mailto:www@gentoo.gr.jp" />
				<link rel="alternate" type="application/rss+xml" title="GentooJP News" href="/gentoojp-news.xml"/>
			</head>

			<body>
					<div class="logo"><p>日本語：
							[ <a href="http://www.gentoo.jp/">GentooJP</a> ]
							[ <a href="http://wiki.gentoo.gr.jp/">Wiki</a> ]
							</p><p>英語：
							[ <a href="http://www.gentoo.org/">Gentoo.org</a> ]
							[ <a href="http://packages.gentoo.org/">Packages</a> ]
							[ <a href="http://forums.gentoo.org/">Forums</a> ]
              [ <a href="http://bugs.gentoo.org/">Bugzilla</a> ]
              [ <a href="http://wiki.gentoo.org/">Wiki</a> ]</p>
          </div>

				<xsl:if test="not(/mainpage)">
				<table class="all" width="99%">
					<tr>
						<td>
							<div class="navi" align="center">
								<span><a href="/">トップに戻る</a></span>
							</div>
						</td>
					</tr>
				</table>
				</xsl:if>

				<!--
				<br clear="all" />
				<table class="all" width="100%" bgcolor="#FFDBA4">
					<tr>
							<td>
							<div class="navi">
										<span><a href="/">トップ</a></span>
										|
										<span><a href="/jpmain/about-gentoojp.html">GentooJPについて</a></span>
										|
										<span><a href="/jpmain/arukikata.html">Gentooの歩き方</a></span>
										|
										<span><a href="/jpmain/docs-list.html">各種ドキュメント</a></span>
								</div>
						</td>
					</tr>
				</table>
				-->

				<table border="0" style="margin:0em ! important;" cellspacing="5" width="100%">
				<tr>
				<td class="sidebar" valign="top" rowspan="2">
					<h4>はじめに</h4>
					<ul>
						<li><a href="/jpmain/about-gentoojp.html">GentooJPについて</a></li>
						<li><a href="/jpmain/arukikata.html">Gentooの歩き方</a></li>
						<li><a href="/jpmain/contribution.html">Gentooへの貢献</a></li>
						<li><a href="/jpmain/docs-list.html">各種ドキュメント</a></li>
					</ul>
					<h4><a href="http://www.gentoo.org/doc/ja/handbook/handbook-x86.xml">ハンドブック</a></h4>
					<ul>
						<li><a href="http://www.gentoo.org/doc/ja/handbook/handbook-x86.xml?part=1&amp;chap=0">Gentooをインストールする</a></li>
						<li><a href="http://www.gentoo.org/doc/ja/handbook/handbook-x86.xml?part=2&amp;chap=0">Gentooを使いこなす</a></li>
						<li><a href="http://www.gentoo.org/doc/ja/handbook/handbook-x86.xml?part=3&amp;chap=0">Portageを使いこなす</a></li>
					</ul>
					<h4><a href="http://www.gentoo.org/doc/ja/index.xml">翻訳ドキュメント</a></h4>
					<ul>
						<li><a href="http://www.gentoo.org/doc/ja/index.xml?catid=faq">FAQ (よくある質問)</a></li>
						<li><a href="http://www.gentoo.org/doc/ja/index.xml?catid=install">インストール関連ドキュメント</a></li>
						<li><a href="http://www.gentoo.org/doc/ja/index.xml?catid=desktop">Gentooデスクトップドキュメント</a></li>
						<li><a href="http://www.gentoo.org/doc/ja/index.xml?catid=gentoo">Gentooシステムドキュメント</a></li>
						<li><a href="http://www.gentoo.org/doc/ja/index.xml?catid=sysadmin">システム管理ドキュメント</a></li>
						<li><a href="http://www.gentoo.org/doc/ja/index.xml?catid=gentoodev">Gentoo開発ドキュメント</a></li>
						<li><a href="http://www.gentoo.org/doc/ja/index.xml?catid=project">プロジェクト関連ドキュメント</a></li>
						<li><a href="http://www.gentoo.org/doc/ja/index.xml?catid=other">その他のドキュメント</a></li>
					</ul>
					<h4>クイックリンク</h4>
					<ul>
						<!-- <a href="http://www.gentoo.org/doc/ja/desktop.xml">デスクトップ構築ガイド</a><br/> -->
						<li><a href="http://www.gentoo.org/news/ja/gmn/">GMN日本語</a></li>
						<li><a href="http://www.gentoo.org/doc/ja/printing-howto.xml">印刷環境構築ガイド</a></li>
						<li><a href="http://www.gentoo.org/doc/ja/xorg-config.xml">X サーバー設定ガイド</a></li>
						<li><a href="http://www.gentoo.org/doc/ja/gentoo-security.xml">セキュリティガイド</a></li>
						<li><a href="http://www.gentoo.org/doc/ja/faq.xml">FAQ</a></li>
						<li><a href="/jpmain/tips.html">TIPS集</a></li>
						<li><a href="/jpmain/docs-list.html">ドキュメント一覧</a></li>
					</ul>
					<h4>プロジェクト</h4>
					<ul>
						<li><a href="/jpmain/original-doc.html">オリジナルドキュメント</a></li>
                        <li><a href="/jpmain/translation.html">翻訳</a> <a href="http://www.gentoo.org/doc/ja/overview.xml">[状況]</a></li>
						<li><a href="/jpmain/project-gwn.html">GWN翻訳</a></li>
					</ul>
					<h4>その他</h4>
					<ul>
						<li><a href="http://wiki.gentoo.gr.jp/">GentooJP Wiki</a></li>
						<li><a href="/jpmain/about-gentoojp.html#doc_chap4">メーリングリスト</a></li>
						<li><a href="/jpmain/about-gentoojp.html#doc_chap5">IRC</a></li>
						<li><a href="/jpmain/sponsors.html">スポンサー</a></li>
					</ul>
				</td>
				<td valign="top">
				<div class="day">
				<div class="body">
				<div class="section">
				<xsl:choose>
					<xsl:when test="/mainpage/@id='news'">
							<table cellspacing="0">
							<tr>
								<td>
									<table class="main">
										<tr>
											<th colspan="2"><a href="/jpnews/main/"></a>ニュース <font size="-2"><a href="/jpmain/news-submit.html"><nobr>[投稿について]</nobr></a><a href="/jpnews/"><nobr>[過去のニュース一覧]</nobr></a></font><a href="gentoojp-news.xml"><img src="/images/rss.png" border="0"></img></a>
</th>
										</tr>
										<tr valign="top">
											<td colspan="2">
													<table border="0" valign="middle" style="vertical-align:middle; margin:3px 3px 7px 1.5em ! important; width:97%;">
														<xsl:for-each select="document(document('/jpnews/allnews.xml')/news_indexes/file)/uris/uri/text()">
														<xsl:sort select="substring-after(substring-after(substring-after(., '/'), '/'), '/')" order="descending" />
														<xsl:choose>
														<xsl:when test="position() &lt;= 5">
														<xsl:variable name="newsuri" select="concat(substring-before(., 'xml'), 'html')"/>
														<tr valign="middle" style="vertical-align: middle;">
														<!-- <td valign="middle" style="vertical-align: middle; width: 60px;"> -->
														<td valign="middle" style="width: 1%;">
														<xsl:choose>
															<xsl:when test="document(.)/news/@category='gentoojp'">
																<img src="/images/icon-gentoojp.png" width="50" alt="GentooJP"/>
															</xsl:when>
															<xsl:when test="document(.)/news/@category='alpha'">
																<img src="/images/icon-alpha.png" width="50" alt="AlphaServer GS160"/>
															</xsl:when>
															<xsl:when test="document(.)/news/@category='kde'">
																<img src="/images/icon-kde.png" width="50" alt="KDE"/>
															</xsl:when>
															<xsl:when test="document(.)/news/@category='gentoo'">
																<img src="/images/icon-gentoo.png" width="50" alt="gentoo"/>
															</xsl:when>
															<xsl:when test="document(.)/news/@category='main'">
																<img src="/images/icon-stick.png" width="50" alt="stick man"/>
															</xsl:when>
															<xsl:when test="document(.)/news/@category='ibm'">
																<img src="/images/icon-ibm.png" width="50" alt="IBM"/>
															</xsl:when>
															<xsl:when test="document(.)/news/@category='linux'">
																<img src="/images/icon-penguin.png" width="50" alt="tux"/>
															</xsl:when>
															<xsl:when test="document(.)/news/@category='moo'">
																<img src="/images/icon-cow.png" width="50" alt="larry"/>
															</xsl:when>
															<xsl:when test="document(.)/news/@category='plans'">
																<img src="/images/icon-clock.png" width="50" alt="Clock"/>
															</xsl:when>
															<xsl:when test="document(.)/news/@category='nvidia'">
																<img src="/images/icon-nvidia.png" width="50" alt="nvidia"/>
															</xsl:when>
														</xsl:choose>
														</td>
															<td valign="middle" style="vertical-align: middle;">
																<h3>
																<a href="{$newsuri}">■</a>
																	<xsl:variable name="ymd" select="substring(substring-after(substring-after(substring-after(..,'/'),'/'),'/'),1,8)"/>
    		                          [<xsl:value-of select="substring($ymd,1,4)" />/<xsl:value-of select="substring($ymd,5,2)" />/<xsl:value-of select="substring($ymd,7,2)" />]
																	<xsl:value-of select="document(.)/news/title"/>
																</h3>
															</td>
														</tr>

														<!--
														<xsl:if test="position() &lt;= ">
														-->
														<tr>
															<td colspan="2">
																<div class="news_summary">
																	<xsl:variable name="tmp_news" select="document(.)/news/body/p"/>
																	<xsl:choose>
																		<xsl:when test="count(document(.)/news/body/p) &gt;=3">
																			<xsl:apply-templates select="document(.)/news/body/p[1]"/>
																			<p><a href="{$newsuri}"> - 続きを読む - </a></p>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:apply-templates select="document(.)/news/body"/>
																		</xsl:otherwise>
																	</xsl:choose>
																</div>
															</td>
														</tr>
														<!--
														</xsl:if>
														-->

														</xsl:when>
														</xsl:choose>
													</xsl:for-each>
												</table>
											</td>
										</tr>

<tr>
	<td colspan="2" align="right"><a href="/jpnews/">[過去のニュース一覧]</a>
	</td>
</tr>
									</table>

								</td>
							</tr>
						</table>
					</xsl:when>

					<xsl:when test="/news">
							<table cellpadding="7" cellspacing="0" width="100%" border="0" style="margin-top: 0em;">
							<tr>
									<!-- <td colspan="2" bgcolor="#7a5ada"> -->
											<td colspan="2" bgcolor="#8C5000" style="border-color: #FFDBA4; border-style: double; border-width: 3px 0em;">
									<font color="#ffffff">
										<b>
											<xsl:value-of select="title"/>
										</b>
										<br/>
										<font size="-3">Posted on <xsl:value-of select="date"/> by <xsl:value-of select="poster"/></font>
									</font>
								</td>
							</tr>
							<tr>
								<td width="100" align="center" valign="top">
									<xsl:choose>
										<xsl:when test="@category='gentoojp'">
											<img src="/images/icon-gentoojp.png" alt="GentooJP"/>
										</xsl:when>
										<xsl:when test="@category='alpha'">
											<img src="/images/icon-alpha.gif" alt="AlphaServer GS160"/>
										</xsl:when>
										<xsl:when test="@category='kde'">
											<img src="/images/icon-kde.png" alt="KDE"/>
										</xsl:when>
										<xsl:when test="@category='gentoo'">
											<img src="/images/icon-gentoo.png" alt="gentoo"/>
										</xsl:when>
										<xsl:when test="@category='main'">
											<img src="/images/icon-stick.png" alt="stick man"/>
										</xsl:when>
										<xsl:when test="@category='ibm'">
											<img src="/images/icon-ibm.gif" alt="IBM"/>
										</xsl:when>
										<xsl:when test="@category='linux'">
											<img src="/images/icon-penguin.png" alt="tux"/>
										</xsl:when>
										<xsl:when test="@category='moo'">
											<img src="/images/icon-cow.png" alt="larry"/>
										</xsl:when>
										<xsl:when test="@category='plans'">
											<img src="/images/icon-clock.png" alt="Clock"/>
										</xsl:when>
										<xsl:when test="@category='nvidia'">
											<img src="/images/icon-nvidia.png" alt="nvidia"/>
										</xsl:when>
									</xsl:choose>
								</td>
								<td valign="top">
									<xsl:choose>
										<xsl:when test="body">
											<xsl:apply-templates select="body"/>
										</xsl:when>
										<xsl:when test="section">
											<xsl:apply-templates select="section"/>
										</xsl:when>
									</xsl:choose>
								</td>
							</tr>
						</table>
					</xsl:when>

					<xsl:when test="/mainpage/@id='news_list'">
								<table>
										<tr>
											<td>
												<dl>
													<xsl:for-each select="document(document('/jpnews/allnews.xml')/news_indexes/file)/uris/uri/text()">
													<xsl:sort select="substring-after(substring-after(substring-after(., '/'), '/'), '/')" order="descending" />

<!--													<xsl:for-each select="document(concat('/jpnews/', @news_category,'/news-index.xml'))/uris/uri[position()&lt;=$number_of_news_list]/text()"> -->
														<dt>
																<table border="0" style="margin: 1px ! important;">
																<tr>
																<td style="width: 60px;">
																<xsl:choose>
																	<xsl:when test="document(.)/news/@category='gentoojp'">
																		<img src="/images/icon-gentoojp.png" width="50" alt="GentooJP"/>
																	</xsl:when>
																	<xsl:when test="document(.)/news/@category='alpha'">
																		<img src="/images/icon-alpha.png" width="50" alt="AlphaServer GS160"/>
																	</xsl:when>
																	<xsl:when test="document(.)/news/@category='kde'">
																		<img src="/images/icon-kde.png" width="50" alt="KDE"/>
																	</xsl:when>
																	<xsl:when test="document(.)/news/@category='gentoo'">
																		<img src="/images/icon-gentoo.png" width="50" alt="gentoo"/>
																	</xsl:when>
																	<xsl:when test="document(.)/news/@category='main'">
																		<img src="/images/icon-stick.png" width="50" alt="stick man"/>
																	</xsl:when>
																	<xsl:when test="document(.)/news/@category='ibm'">
																		<img src="/images/icon-ibm.png" width="50" alt="IBM"/>
																	</xsl:when>
																	<xsl:when test="document(.)/news/@category='linux'">
																		<img src="/images/icon-penguin.png" width="50" alt="tux"/>
																	</xsl:when>
																	<xsl:when test="document(.)/news/@category='moo'">
																		<img src="/images/icon-cow.png" width="50" alt="larry"/>
																	</xsl:when>
																	<xsl:when test="document(.)/news/@category='plans'">
																		<img src="/images/icon-clock.png" width="50" alt="Clock"/>
																	</xsl:when>
																	<xsl:when test="document(.)/news/@category='nvidia'">
																		<img src="/images/icon-nvidia.png" width="50" alt="nvidia"/>
																	</xsl:when>
															</xsl:choose>
															</td>
															<xsl:variable name="newsuri" select="concat(substring-before(., 'xml'), 'html')"/>
															<td valign="middle" style="vertical-align: middle;">
															<a href="{$newsuri}">
																<xsl:value-of select="document(.)/news/title"/>
																Posted on <xsl:value-of select="document(.)/news/date"/>
																by <xsl:value-of select="document(.)/news/poster"/>
															</a>
															</td>
															</tr>
															</table>
														</dt>
														<dd>
<!--															<xsl:apply-templates select="document(.)/news/body"/> -->
														</dd>
													</xsl:for-each>
												</dl>
											</td>
										</tr>
									</table>

					</xsl:when>

					<xsl:when test="/guide">

						<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0em;">
							<tr>
								<td valign="top" align="right" colspan="1" bgcolor="#ffffff">
									<table border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-top: 0em;">
										<tr>
											<td width="99%" class="content" valign="top" align="left">
												<br/>
												<!-- <p class="dochead"> -->
												<h1>
													<xsl:choose>
														<xsl:when test="/guide/subtitle"><xsl:value-of select="/guide/title"/>: <xsl:value-of select="/guide/subtitle"/></xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="/guide/title"/>
														</xsl:otherwise>
													</xsl:choose>
												</h1>
												<table width="80%" border="0" style="border: #FF7711 3px dotted;">
														<tr><td>&#160;<xsl:apply-templates select="abstract"/></td></tr>
												</table>
												<xsl:if test="not(contains(/guide/author, 'GentooJP'))">
													<table border="0" style="border: #dddddd 3px dotted;">
														<tr><td>このドキュメントの著作権はAuthorの方に帰属します。<br/>詳しくは<a href="/jpmain/original-doc.html">オリジナルドキュメントプロジェクト</a>を参照してください。</td></tr>
													</table>
												</xsl:if>
												<br/><br/>
													<!-- </p> -->
												<table border="0" width="100%">
												<tr>
													<td>
														<b>Contents</b>:<br/>
														<xsl:for-each select="chapter"><xsl:variable name="chapid">doc_chap<xsl:number/></xsl:variable>
															<xsl:number/>. <a href="#{$chapid}"><xsl:value-of select="title"/></a><br/>
														</xsl:for-each>
												</td>
												<td align="right" valign="top" style="padding-right: 1.0em;">
														<xsl:apply-templates select="/guide/author"/><br/>
														Updated <xsl:value-of select="/guide/date"/>
												</td>
												</tr>
												</table>

												<br/><br/>
												<!-- <div style="margin:0.5em; padding:0.5em;"> -->
													<xsl:apply-templates select="chapter"/>
													<!-- </div> -->
											</td>
											<!-- <td width="1%" bgcolor="#dddaec" valign="top"> -->
													<!--
											<td width="1%" bgcolor="#FFDBA4" valign="top">
												<table border="0" cellspacing="5" cellpadding="0" style="margin-top: 0em;">
													<tr>
														<td>
															<img src="/images/line.gif" alt="line"/>
														</td>
													</tr>
													<tr>
														<td align="center" class="alttext">
															Updated <xsl:value-of select="/guide/date"/>
														</td>
													</tr>
													<tr>
														<td>
															<img src="/images/line.gif" alt="line"/>
														</td>
													</tr>
													<tr>
														<td class="alttext">
															<xsl:apply-templates select="/guide/author"/>
														</td>
													</tr>
													<tr>
														<td>
															<img src="/images/line.gif" alt="line"/>
														</td>
													</tr>
													<tr>
														<td class="alttext"><b>Summary:</b>&#160;<xsl:apply-templates select="abstract"/></td>
													</tr>
													<tr>
														<td>
															<img src="/images/line.gif" alt="line"/>
														</td>
													</tr>
												</table>
											</td>
											-->
										</tr>
									</table>
								</td>
							</tr>
						</table>

					</xsl:when>

					<xsl:when test="/move">
					  <xsl:variable name="moveuri" select="uri"/>
<h2>このドキュメントは<a href="{$moveuri}">
<xsl:value-of select="uri"/>
</a>へ移動しました。</h2>
					</xsl:when>
				</xsl:choose>
				</div>
				</div>
				</div>
				</td>
				</tr>
				<tr height="1.3em" valign="bottom">
				<td height="1.3em" valign="bottom">
				<div class="footer">[ <a href="http://ml.gentoo.gr.jp/users/">users ML</a> ]
					  [ <a href="http://ml.gentoo.gr.jp/docs/">docs ML</a> ]
					  [ <a href="http://ml.gentoo.gr.jp/dev/">dev ML</a> ]
					  [ <a href="http://ml.gentoo.gr.jp/misc/">misc ML</a> ]
						[ <a href="/jpmain/about-gentoojp.html#doc_chap5">IRC</a> ]</div>
				</td>
				</tr>
				</table>

				<div align="center" class="copy">
					Copyright<xsl:text disable-output-escaping="yes">&amp;copy;</xsl:text> 2002-2014 Gentoo Linux Users Group Japan. All rights reserved.<br/>
					このサイトはGentooJPが運営するGentoo.org非公式コミュニティサイトです。ご質問、ご意見などはこちらまで。 Email: <a href="mailto:www@gentoo.gr.jp">www@gentoo.gr.jp</a>
				</div>
			</body>
		</html>

	</xsl:template>

<!-- START: ebuild uploader -->
<xsl:template match="rdf:RDF" mode="ebuild_uploader">
	<table border="0" valign="middle" style="vertical-align: middle; margin:3px 3px 7px 1.5em ! important;">
		<xsl:for-each select="rss:item[position()&lt;=$number_of_ebuild_uploader]">
			<tr valign="middle" style="vertical-align: middle;">
				<xsl:apply-templates select="." mode="ebuild_uploader" />
			</tr>
		</xsl:for-each>
	</table>
</xsl:template>

<xsl:template match="rss:item" mode="ebuild_uploader">
	<td valign="middle" style="vertical-align: middle;">
	</td>
	<td valign="middle" style="vertical-align: middle;">
<!--		<xsl:variable name="ymd" select="translate(substring(dc:date, 1, 10),'-','/')" /> -->

		<xsl:variable name="uri" select="rss:link" />
		<a href="{$uri}">
<!--			<xsl:value-of select="concat('[',$ymd,']')"/> -->
			<xsl:value-of select="rss:title"/>
		</a>
	</td>
</xsl:template>
<!-- END: ebuild uploader -->

<!-- START: gmn -->
<xsl:template match="rdf:RDF" mode="gmn">
	<table border="0" valign="middle" style="vertical-align: middle; margin:3px 3px 7px 1.5em ! important;">
		<xsl:for-each select="rss:item">
			<tr valign="middle" style="vertical-align: middle;">
				<xsl:apply-templates select="." mode="gmn" />
			</tr>
		</xsl:for-each>
	</table>
</xsl:template>

<xsl:template match="rss:item" mode="gmn">
	<td valign="middle" style="vertical-align: middle;">
	</td>
	<td valign="middle" style="vertical-align: middle;">
<!--		<xsl:variable name="ymd" select="translate(substring(dc:date, 1, 10),'-','/')" /> -->

		<xsl:variable name="uri" select="rss:link" />
		<a href="{$uri}">
<!--			<xsl:value-of select="concat('[',$ymd,']')"/> -->
			<xsl:value-of select="rss:title"/>
		</a>
	</td>
</xsl:template>
<!-- END: gmn -->


  <!--  ここから下は本家形式のXMLドキュメント用 -->

	<xsl:template match="newsitems">
		<xsl:apply-templates select="news"/>
	</xsl:template>
	<xsl:template match="news">
		<table width="100%" border="0" cellspacing="5" cellpadding="0">
			<tr>
				<td colspan="2" class="ncontent" bgcolor="#bbffbb">
					<p class="note">
						<font color="#7a5ada">
							<b>
								<xsl:value-of select="title"/>
							</b>
						</font>
					</p>
				</td>
			</tr>
			<tr>
				<xsl:choose>
					<xsl:when test="@align='left'">
						<td rowspan="2" valign="top" width="1">
							<img src="{@graphic}"/>
						</td>
						<td class="alttext">
							<font color="#808080">Posted by <xsl:value-of select="poster"/> on <xsl:value-of select="date"/></font>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="alttext">
							<font color="#808080">Posted by <xsl:value-of select="poster"/> on <xsl:value-of select="date"/></font>
						</td>
						<td rowspan="2" valign="top" width="1">
							<img src="{@graphic}"/>
						</td>
					</xsl:otherwise>
				</xsl:choose>
			</tr>
			<tr>
				<td class="content" valign="top">
					<xsl:apply-templates select="body"/>
				</td>
			</tr>
		</table>
		<br/>
		<table width="100%">
			<tr>
				<td height="1" bgcolor="#c0c0c0"/>
			</tr>
		</table>
		<br/>
	</xsl:template>
	<xsl:template match="mail">
		<a href="mailto:{@link}">
			<xsl:value-of select="."/>
		</a>
	</xsl:template>
	<xsl:template match="author/mail">
		<b>
			<a class="altlink" href="mailto:{@link}">
				<xsl:value-of select="."/>
			</a>
		</b>
	</xsl:template>
	<xsl:template match="author">
		<span style="white-space:nowrap;">
		<xsl:if test="@title">
				<!--		<br/> -->
			<i>
				<xsl:value-of select="@title"/>
			</i>
		</xsl:if>
		:
		<xsl:apply-templates/>
		</span><br/>
		<!--	<br/>
		<br/> -->
	</xsl:template>
	<xsl:template match="chapter">
		<xsl:variable name="chid"><xsl:number/></xsl:variable>
		<xsl:choose>
			<xsl:when test="title">
					<h2>
							<!--	<p class="chaphead">
									<font class="chapnum"> -->
						<a name="doc_chap{$chid}"><xsl:number/>.</a>
						<!--	</font> -->
					<xsl:value-of select="title"/>
					<!-- </p> -->
		</h2>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="/guide">
					<p class="chaphead">
						<font class="chapnum">
							<a name="doc_chap{$chid}"><xsl:number/>.</a>
						</font>
					</p>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="body">
			<xsl:with-param name="chid" select="$chid"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="section">
			<xsl:with-param name="chid" select="$chid"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="section">
		<xsl:param name="chid"/>
		<xsl:if test="title">
			<xsl:variable name="sectid">doc_chap<xsl:value-of select="$chid"/>_sect<xsl:number/></xsl:variable>
			<p class="secthead" style="color: #6A3000 ! important;">
				<a name="{$sectid}"><xsl:value-of select="title"/>&#160;</a>
			</p>
		</xsl:if>
		<xsl:apply-templates select="body">
			<xsl:with-param name="chid" select="$chid"/>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="fig">
		<center>
			<xsl:choose>
				<xsl:when test="@linkto">
					<a href="{@linkto}">
						<img src="{@link}" alt="{@short}"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<img src="{@link}" alt="{@short}"/>
				</xsl:otherwise>
			</xsl:choose>
		</center>
	</xsl:template>

	<xsl:template match="br">
		<br/>
	</xsl:template>
	<xsl:template match="note">
		<table class="ncontent" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td bgcolor="#bbffbb">
					<p class="note">
						<b>Note: </b>
						<xsl:apply-templates/>
					</p>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="impo">
		<table class="ncontent" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td bgcolor="#ffffbb">
					<p class="note">
						<b>Important: </b>
						<xsl:apply-templates/>
					</p>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="warn">
		<table class="ncontent" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td bgcolor="#ffbbbb">
					<p class="note">
						<b>Warning: </b>
						<xsl:apply-templates/>
					</p>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="codenote">
		<font class="comment">// <xsl:value-of select="."/></font>
	</xsl:template>
	<xsl:template match="comment">
		<font class="comment">
			<xsl:apply-templates/>
		</font>
	</xsl:template>
	<xsl:template match="i">
		<font class="input" color="blue">
			<xsl:apply-templates/>
		</font>
	</xsl:template>
	<xsl:template match="b">
		<b>
			<xsl:apply-templates/>
		</b>
	</xsl:template>
	<xsl:template match="brite">
		<font color="#ff0000">
			<b>
				<xsl:apply-templates/>
			</b>
		</font>
	</xsl:template>

	<xsl:template match="body">
		<xsl:param name="chid"/>
		<xsl:apply-templates>
			<xsl:with-param name="chid" select="$chid"/>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="c">
		<font class="code">
			<xsl:apply-templates/>
		</font>
	</xsl:template>
	<xsl:template match="box">
		<p class="infotext">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	
	<xsl:template match="pre">
		<xsl:param name="chid"/>
		<xsl:variable name="prenum">
			<xsl:number level="any" from="chapter" count="pre"/>
		</xsl:variable>
		<xsl:variable name="preid">doc_chap<xsl:value-of select="$chid"/>_pre<xsl:value-of select="$prenum"/></xsl:variable>
		<a name="{$preid}"/>
		<table class="ntable" width="100%" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td bgcolor="#8C5000" class="infohead" style="color: #FFFFFF ! important;">

						<!-- <p class="caption"> -->
					<font color="#FFFFFF">
						<xsl:choose>
							<xsl:when test="@caption">
								Code listing <xsl:value-of select="$chid"/>.<xsl:value-of select="$prenum"/>: <xsl:value-of select="@caption"/>
							</xsl:when>
							<xsl:otherwise>
								Code listing <xsl:value-of select="$chid"/>.<xsl:value-of select="$prenum"/>
							</xsl:otherwise>
						</xsl:choose>
					</font>
					<!-- </p> -->
				</td>
			</tr>
			<tr>
				<td bgcolor="#FFE9C8">
						<pre>
								<xsl:apply-templates/>
						</pre>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="path">
		<font class="path">
			<xsl:value-of select="."/>
		</font>
	</xsl:template>
	<xsl:template match="uri">
		<xsl:choose>
			<xsl:when test="@link">
				<a href="{@link}">
					<xsl:apply-templates/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="loc" select="."/>
				<a href="{$loc}">
					<xsl:apply-templates/>
				</a>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="p">
		<xsl:param name="chid"/>
		<xsl:choose>
			<xsl:when test="@class">
				<p class="{@class}">
					<xsl:apply-templates>
						<xsl:with-param name="chid" select="$chid"/>
					</xsl:apply-templates>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p>
					<xsl:apply-templates>
						<xsl:with-param name="chid" select="$chid"/>
					</xsl:apply-templates>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="e">
		<font class="emphasis">
			<xsl:apply-templates/>
		</font>
	</xsl:template>
	<xsl:template match="mail">
		<a href="mailto:{@link}">
			<xsl:value-of select="."/>
		</a>
	</xsl:template>
	<xsl:template match="table">
		<table class="ntable">
			<xsl:apply-templates/>
		</table>
	</xsl:template>
	<xsl:template match="tr">
		<tr>
			<xsl:apply-templates/>
		</tr>
	</xsl:template>
	<xsl:template match="ti">
			<!-- <td bgcolor="#ddddff" class="tableinfo"> -->
		<td bgcolor="#FFDBA4" class="tableinfo" style="background: #FFDBA4 ! important;">
			<xsl:apply-templates/>
		</td>
	</xsl:template>
	<xsl:template match="th">
			<!-- <td bgcolor="#7a5ada" class="infohead"> -->
		<td bgcolor="#8C5000" class="infohead" style="color: #FFFFFF ! important;">
			<font color="#FFFFFF">
			<b>
				<xsl:apply-templates/>
			</b>
			</font>
		</td>
	</xsl:template>
	<xsl:template match="ul">
		<ul>
			<xsl:apply-templates/>
		</ul>
	</xsl:template>
	<xsl:template match="ol">
		<ol>
			<xsl:apply-templates/>
		</ol>
	</xsl:template>
	<xsl:template match="li">
		<li>
			<xsl:apply-templates/>
		</li>
	</xsl:template>

</xsl:stylesheet>
