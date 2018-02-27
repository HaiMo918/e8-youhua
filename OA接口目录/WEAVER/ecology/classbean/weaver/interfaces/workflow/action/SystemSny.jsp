<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetShare" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CheckUserRight" class="weaver.systeminfo.systemright.CheckUserRight" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />

<%
//新增部门助理名单
if(user.getUID()!=1){
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
}

%>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</HEAD>
<%
String imagefilename = "/images/hdReport.gif";
String titlename = "E7员工数据补录到E8手动同步";
String needfav ="1";
String needhelp ="";

%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(615,user.getLanguage())+",javascript:doSave(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;

%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>


<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">
			<FORM id=weaver name=weaver action="SynHrmrosterOperation.jsp" method=post >
			<TABLE class=ListStyle cellspacing=1 >
			  <COLGROUP>
			  <COL width="10%">
			  <COL width="90%">
			  <TBODY> 
					<TR class=header>	 
						<TD class=Field>是否同步</TD>		
					</TR>
					<TR class=datalight> 
						<TD class=Field>
							<select id="syn" name = "syn">
								<option value='0'>开始</option>
							</select>
						</TD>  
					</TR>
			  </TBODY>
			  </COLGROUP>
			 </TABLE>
			</FORM>
		</td>
		</tr>
		</TABLE>
	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>
<script language=javascript>
function doSave() {	
	document.weaver.submit();
}
</script>
</BODY>
</HTML>
