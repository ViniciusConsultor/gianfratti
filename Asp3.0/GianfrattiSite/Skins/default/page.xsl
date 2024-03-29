<?xml version="1.0" encoding="iso-8859-1"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxml="urn:schemas-microsoft-com:xslt" xmlns:game="urn:schemas-cagle-com:game" version="1.0" exclude-result-prefixes="msxml game" xml:space="preserve">
	<!-- include of personnalized skin -->
	<xsl:import href="skin.xsl"/>
	
	<xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="no" encoding="ISO-8859-1"/>
			
	<!-- Include : variables et add-on  :: DO NOT TOUCH -->
	<xsl:include href="../common/macros.xsl"/>	
	<xsl:include href="../default/skin.xsl"/>
	<!-- end include -->
	
	<!-- General skin values -->	
	<xsl:param name="general_font">Verdana</xsl:param>
	<xsl:param name="body_background">#FFFFFF</xsl:param>
	<xsl:param name="body_color">#000000</xsl:param>
	
	<!-- Toolbar skin values -->
	<xsl:param name="toolbar_color">#FFFFFF</xsl:param>
	<xsl:param name="toolbar_background">#01518C</xsl:param>
	<xsl:param name="toolbar_border">#000000</xsl:param>
	
	<!-- Margins skin values -->
	<xsl:param name="margin_background">#f0f0f0</xsl:param>
	<xsl:param name="margin_color">#01518C</xsl:param>
	
	<!-- Newsgroups skin values -->
	<xsl:param name="forum.header.bgcolor">#01518C</xsl:param>
	<xsl:param name="forum.header.color">#FFFFFF</xsl:param>

	<xsl:param name="forum.normal.row.bgcolor">#f0f0f0</xsl:param>
	<xsl:param name="forum.highlight.row.bgcolor">#CCCCCC</xsl:param>

	<xsl:param name="forum.new.thread.bgcolor">#f0f0f0</xsl:param>
	<xsl:param name="forum.new.thread.color">#01518C</xsl:param>
	<xsl:param name="forum.new.thread.bordercolor">#01518C</xsl:param>

	<!-- Event calendar skin values -->
   	<xsl:param name="calendar_tableborder">#CCCCCC</xsl:param>
   	<xsl:param name="calendar_background">#FFFFFF</xsl:param>
   	<xsl:param name="calendar_weekdaybg">#CCCCCC</xsl:param>
   	<xsl:param name="calendar_currentdaybg">#f0f0f0</xsl:param>

	<!--	
		THIS IS THE BASE TEMPLATE 
		========================
		ALL XSL:TEMPLATE WITH "_design" extension in their name can be changed in the skin.xsl file which can be found in the same directory
	-->
			
	<xsl:template match="/">
	
		<HTML dir="{$textdirection}" xmlns="http://www.w3.org/1999/xhtml">
			<HEAD>
				<META http-equiv="Content-Type" content="text/html; charset={/siteinfo/data/encoding}"/>
				<META name="Copyright" 	content="{/siteinfo/data/copyright}"/>
				<META name="Keywords" 	content="{/siteinfo/data/keywords}"/>
				<META name="Description" 	content="{/siteinfo/data/description}"/>
				<META name="GENERATOR" content="Fullxml 2.4 - http://www.fxmods.com"/>
				<TITLE><xsl:value-of select="/siteinfo/data/title" disable-output-escaping="yes"/></TITLE>
				<LINK rel="SHORTCUT ICON" href="media/favicon.ico"/>

				<!-- if user is in a chatroom  -->
				<xsl:if test="$channel and $ACT=93 and $chatview='ctrl'">
					<META http-equiv="refresh" content="15"/>
				</xsl:if>
				
				<!-- Fullxml stylesheet -->
				<style>
					BODY {FONT-SIZE: 10px; FONT-FAMILY: <xsl:value-of select="$general_font"/>; margin: 2px; color: <xsl:value-of select="$body_color"/>;}

					TD {FONT-SIZE: 10px; FONT-FAMILY: <xsl:value-of select="$general_font"/>; }
					
					A {FONT-WEIGHT: normal; FONT-SIZE: 10px; COLOR: #0850A0}
					A:hover {COLOR: #ff6600; TEXT-DECORATION: none	}
					
					A.newsgroup {	FONT-WEIGHT: bold; FONT-SIZE: 10px; COLOR: #0850A0; TEXT-DECORATION: none}
					A.newsgroup:hover {COLOR: #ff6600; TEXT-DECORATION: none	}
															
					A.toolbar{FONT-WEIGHT: bold; COLOR: <xsl:value-of select="$toolbar_color"/>; TEXT-DECORATION: none }
					A.toolbar:Hover { FONT-WEIGHT: bold; COLOR: #ff6600; TEXT-DECORATION: none}
															
					A.menu {FONT-WEIGHT: bold; <xsl:value-of select="$margin_color"/>: #201460; TEXT-DECORATION: none}
					A.menu:hover {	FONT-WEIGHT: bold; COLOR: #ff6600; TEXT-DECORATION: none}
					
					A.gateway {FONT-WEIGHT: bold; COLOR: #000000; TEXT-DECORATION: none}
					A.gateway:hover {FONT-WEIGHT: bold; COLOR: #ff6600; TEXT-DECORATION: none}
					
					A.link:Hover { COLOR:#800000; font-size: 8pt; font-family: Arial; text-decoration:none}
					A.link	{color:black; font-size: 8pt; font-family: Arial; text-decoration:none }
					
					<!-- for the directory add-on-->
					A.cat {font-size: 18px; font-weight: bold; font-family: Tahoma}
					A.subcat {font-size: 12px; font-weight: normal; font-family: Tahoma}	
					A.trail {font-size: 12px; font-weight: normal; font-family: Tahoma}

					input.mini {font-size: 10px; font-family: <xsl:value-of select="$general_font"/>; vspace:5; hspace:5 }

					<!-- Here you can customize the size of the eframe -->
					iframe.external{width: 100%; height: 600px;}
				</style>
			</HEAD>
		
		<xsl:choose>
			<xsl:when test="string-length(/siteinfo/data/gateway)&gt;0 and $gateway=1 and $ACT=0">
				<xsl:call-template name="gateway_design"></xsl:call-template>
			</xsl:when>
			<xsl:when test="$channel and $channel!='new' and $ACT=93">
				<xsl:call-template name="pagebody_macro"/>
			</xsl:when>
			<xsl:when test="$ACT=4 and $content='easylink' or $layout='printer'">
				<body  margin="0" bgcolor="{$body_background}">
					<xsl:call-template name="pagebody_macro"/>
				</body>
			</xsl:when>
			<xsl:otherwise>
		
				<!-- Start edit here -->
				<body  margin="0" bgcolor="{$body_background}">
													
					<!-- START OF THE HEADER -->
					<table border="0" width="100%" cellspacing="0" cellpadding="0" bgcolor="#f0f0f0">
						<tr>
							<td><xsl:call-template name="titlebloc_macro"/></td>
							<td align="right"><xsl:call-template name="advertisement_macro"/></td>
						</tr>
					</table>
					<!-- END OF THE HEADER -->
					
					<!-- Design for the toolbar-->
					<xsl:call-template name="toolbar_global_design"/>
					
					<!--MENU bar-->
					<xsl:call-template name="menubar_macro"/>
							
					<!-- Design of the main table -->
					<table border="0" cellpadding="0" cellspacing="1" width="100%" align="center" height="500" bgcolor="#EEEAD6">
						<tr valign="top"  bgcolor="#FFFFFF">
							<br/>
					    	
					    	<xsl:choose>
								
								<!-- LEFT MARGIN --><!-- ADD-ON  -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=1 or string-length(/siteinfo/pages/page[id=$id]/margintype)=0">									
									<td width="140">
										<img src="skins/default/media/dot.gif" width="140" height="1"/><br/>
										<xsl:call-template name="fullmargin_macro"/>
									</td>
									<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td width="100%" bgcolor="#FFFFFF"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    </xsl:when>
							    
								<!-- RIGHT MARGIN -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=2">									
									<td width="100%" bgcolor="#FFFFFF"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    		<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    		<td width="140" bgcolor="#f0f0f0">
							    			<img src="skins/default/media/dot.gif" width="140" height="1"/><br/>
							    			<xsl:call-template name="fullmargin_macro"/>
							    		</td>
								</xsl:when>								
								
								<!-- BOTH MARGIN -->
								<xsl:otherwise>									
									<td width="140">
										<img src="skins/default/media/dot.gif" width="140" height="1"/><br/>
										<xsl:call-template name="leftmargin_macro"/>
									</td>
							    	<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    	<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td width="140">
							    		<img src="skins/default/media/dot.gif" width="140" height="1"/><br/>
							    		<xsl:call-template name="rightmargin_macro"/>
							    	</td>
								</xsl:otherwise>
							</xsl:choose>					    		
					    		
					    </tr>
					 </table>	
				<!-- End of the main table -->	
				
				
				<!-- Footer -->	
				<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" style="border-top: 1px solid black; border-bottom: 1px solid black;">
					<TR height="16"><TD bgColor="#01518C" align="center"><font color="#FFFFFF"><xsl:call-template name="copyright_macro"/></font></TD></TR>
				</TABLE>	
				</body>
		
			</xsl:otherwise>
		</xsl:choose>
		
		</HTML>		

	</xsl:template>
</xsl:stylesheet>
