<!--#include file="../include/admentor2.asp"-->
<!--#include file="../include/admentorsecurity.asp"-->
<!--#include file="menu.inc"-->
<%
'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com
If Session("admin") <> True Then
	Session.Abandon
	Response.Redirect "login.asp?reason=noauth"
End If

    Set oConn = AdMentor_DBOpenConnection2("0")
    Set oRS = oConn.Execute("select  * from users")
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Administrate Farms</title>
<style type="text/css">
<!--
     body {  font-family: Arial, Geneva, Helvetica, Verdana; font-size: smaller; color: #000000}
     td {  font-family: Arial, Geneva, Helvetica, Verdana; font-size: smaller; color: #000000}
     th {  font-family: Arial, Geneva, Helvetica, Verdana; font-size: smaller; color: #000000}
     A:link {text-decoration: none;}
     A:visited {text-decoration: none;}
     A:hover {text-decoration: underline;}
-->
</style>
</head>

<body bgcolor="#DDDDDD">

<table bgColor="#003399" border="0" cellPadding="3" cellSpacing="0" height="100%" width="100%">
  <tbody>
    <tr>
      <td vAlign="middle" width="50%" height="60">
      <img src="../images/administration.gif" border="0">
      </td>
      <td vAlign="baseline" width="468" height="60" align="right">
		<%=GetAdminPagesBannerCode()%>
       </td></tr>
    <tr>
      <td height="100%" vAlign="top" width="100%" colspan="2">
        <table align="center" bgColor="#ffffff" border="0" cellPadding="0" cellSpacing="0" height="100%" width="100%">
          <tbody>
            <tr>
              <td height="100%" vAlign="top" width="85%">
                <table bgColor="#ffffff" border="0" cellPadding="10" cellSpacing="0" height="100%" width="100%">
                  <tbody>
                    <tr>
                      <td align="left" height="100%" vAlign="top" width="65%">
                        <table border="0" width="100%">
                          <tr>
                            <td width="50%" valign="middle" align="left"><font color="#aa3333" face="Arial, Geneva, Helvetica, Verdana" size="4"><b>Administra��o
                              de Anunciantes</b></font>
                            </td>
                            <td width="50%" valign="middle" align="right">
                            <%If Session("admin") = True Then %>
                            <%WriteFakeButton "adminaccount.asp?action=new", "Adicionar nova Conta"%> 
                            <%End If%>  
                            </td>
                          </tr>
                        </table>
                        <hr color="#000066" noShade SIZE="1">
      
                        <table border="0" width="100%">
                          <tr>
                            <td width="120"><%AdAdminWriteMenu%></td>
                            <td>
      
                        <div align="center">
                        <table border="0" bgcolor="#000000" cellpadding="0" cellspacing="0"><tr><td>
                        <center>
                        <table border="0" cellpadding="2" cellspacing="1">
                          <tr>
                            <td bgcolor="#C0C0C0" ><b>Nome para Login</b></td>
                            <td bgcolor="#C0C0C0" ><b>Nome completo</b></td>
                            <td bgcolor="#C0C0C0" ><b>� Administrador</b></td>
                            <td bgcolor="#C0C0C0" ><b>A��o</b></td>
                          </tr>
<%	
	Dim strEdit, strDel
	While Not oRS.EOF
	
	strEdit = "adminaccount.asp?id=" & oRS("fldAuto")
	strDel = "deleteaccount.asp?id=" & oRS("fldAuto")
	%>

                          <tr>
                            <td bgcolor="#FFFFFF"><%=oRS("name")%></td>
                            <td bgcolor="#FFFFFF"><%=oRS("fullname")%></td>
                            <td bgcolor="#FFFFFF"><%=oRS("admin")%></td>
                            <td bgcolor="#FFFFFF"><%WriteFakeButton strEdit, "Editar Conta"%>&nbsp;&nbsp;&nbsp;<%WriteFakeButton strDel, "Apagar Conta"%>
								 &nbsp;</td>
                          </tr>
<%
	oRS.MoveNext
	Wend
	oRS.Close
	Set oRS = Nothing
	oConn.Close
	Set oConn = Nothing
%>                          
                        </table>
 

                       </td>
                    </tr>
                </table>
            
                              </td>
                            </tr>
                          </table>
            
              </td>
            </tr>
          </tbody>
        </table>
 </td></tr></table>
      </td>
    </tr>
  </tbody>
</table>
</body>

</html>
















