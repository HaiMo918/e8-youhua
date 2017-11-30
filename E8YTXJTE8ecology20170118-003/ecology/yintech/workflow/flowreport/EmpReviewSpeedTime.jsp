<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.*" %>
<%@ page import="weaver.conn.*" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="departmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="subCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page" />
<jsp:useBean id="DateFormateMethod" class="weaver.general.DateFormateMethod" scope="page" />
<HTML>
	<head>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script language="javascript" src="/js/weaver_wev8.js"></script>
		<link rel="stylesheet" href="/css/ecology8/request/requestTopMenu_wev8.css" type="text/css" />
		<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
		<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<script type="text/javascript">
		    /*	
			jQuery(document).ready(function () {//初始化表单查询按钮   
				$("#topTitle").topMenuTitle({searchFn:onBtnSearchClick});    
				$(".topMenuTitle td:eq(0)").html($("#tabDiv").html());   
				$("#tabDiv").remove();
			});
		    */
			function onBtnSearchClick(){//点击快捷搜索的放大镜调用的方法。   
				enableAllmenu();    
				var name=$("input[name='flowTitle']",parent.document).val();    
				jQuery("input[name='name']").val(name);    
				location.href="/demo/demo_listall.jsp?temp="+Math.random()+"&name="+name;
			}
		
			function onReset() {    
				jQuery('input[name="flowTitle"]', parent.document).val('');   
				jQuery('input[name="name"]').val('');
			}
			function doSearchsubmit(){
				weaver.submit();
				
				//location.href="/yintech/hrm/HrmAnnualLeaveInfo.jsp";
			}
		</script>
	</head>
<%

String imagefilename = "/images/hdMaintenance_wev8.gif";
String titlename = SystemEnv.getHtmlLabelName(25181,user.getLanguage());
String needfav ="1";
String needhelp ="";
String qname = Util.null2String(request.getParameter("flowTitle"));

String seclevel = Util.null2String(request.getParameter("seclevel"));//安全级别
String fromdate = Util.null2String(request.getParameter("fromdate"));//开始日期
String todate = Util.null2String(request.getParameter("todate"));//结束日期

String sqlWhere = " where b.status in (0,1,2,3)";
if(!"".equals(seclevel)){
	sqlWhere+=" and b.seclevel &gt;= '"+seclevel+"'";
}
String sqlWhereIn = "";
if(!"".equals(fromdate)){
	sqlWhereIn+=" and a.receivedate &gt;= '"+fromdate+"'";
}else{
	fromdate = DateFormateMethod.getLastWeekMonday(new Date());
	sqlWhereIn+=" and a.receivedate &gt;= '"+fromdate+"'";
}

if(!"".equals(todate)){
	sqlWhereIn+=" and a.receivedate &lt;= '"+todate+"' and a.operatedate &lt;= '"+todate+"'";
}else{
	todate = DateFormateMethod.getPreviousWeekSunday();
	sqlWhereIn+=" and a.receivedate &lt;= '"+todate+"' and a.operatedate &lt;= '"+todate+"'";
}

String objIds=Util.null2String(request.getParameter("objId"));
int objType1=2;
String objNames = "";
if (!"".equals(objIds)) {		
	if (objIds.startsWith(",")) {
		objIds = objIds.replaceFirst(",", "");
	}
	String[] objIdArr = objIds.split(",");
	switch (objType1){
		case 1:
			if (objIdArr.length == 1) {
				objNames = Util.toScreen(ResourceComInfo.getLastname(objIdArr[0]), user.getLanguage());
			} else {
				StringBuilder sb = new StringBuilder();
				for(int i = 0; i < objIdArr.length; i++) {
					if(i > 0){
						sb.append(",");
					}
					sb.append(Util.toScreen(ResourceComInfo.getLastname(objIdArr[i]), user.getLanguage()));
				}
				objNames = sb.toString();
			}
		break;
		case 2:
			if (objIdArr.length == 1) {
				objNames = Util.toScreen(departmentComInfo.getDepartmentname(objIdArr[0]), user.getLanguage());
			} else {
				StringBuilder sb = new StringBuilder();
				for(int i = 0; i < objIdArr.length; i++) {
					if(i > 0){
						sb.append(",");
					}
					sb.append(Util.toScreen(departmentComInfo.getDepartmentname(objIdArr[i]), user.getLanguage()));
				}
				objNames = sb.toString();
			}
			break;
		case 3:
			if (objIdArr.length == 1) {
				objNames = Util.toScreen(subCompanyComInfo.getSubCompanyname(objIdArr[0]), user.getLanguage());
			} else {
				StringBuilder sb = new StringBuilder();
				for(int i = 0; i < objIdArr.length; i++) {
					if(i > 0){
						sb.append(",");
					}
					sb.append(Util.toScreen(subCompanyComInfo.getSubCompanyname(objIdArr[i]), user.getLanguage()));
				}
				objNames = sb.toString();
			}
			break;
	}	
}

%>	
<BODY>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
			//RCMenu += "{"+SystemEnv.getHtmlLabelName(197 ,user.getLanguage())+",javascript:doSearchsubmit(),_self}";
			//RCMenuHeight += RCMenuHeightStep ;
			
			//RCMenu += "{导出Excel,javascript:exportExcel(),_self} " ;
			//RCMenuHeight += RCMenuHeightStep ;
		%>	
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td></td>
				<td class="rightSearchSpan" style="text-align:right; width:500px!important">
				
					<!--<input type="button" value="<%=SystemEnv.getHtmlLabelName(197 ,user.getLanguage()) %>" class="e8_btn_top" onclick="doSearch()"/>
					<input type="button" value="<%=SystemEnv.getHtmlLabelName(23777 ,user.getLanguage()) %>" class="e8_btn_top" onclick="DeleteData()"/>
					<input type="text" class="searchInput" name="flowTitle" value="<%=qname%>"/>
					&nbsp;&nbsp;&nbsp;-->
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995 ,user.getLanguage()) %></span>&nbsp;&nbsp;
					<span title="<%=SystemEnv.getHtmlLabelName(23036 ,user.getLanguage()) %>" class="cornerMenu"></span>
				</td>
			</tr>
		</table>		
		<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
			<form id=weaver name=weaver action="EmpReviewSpeedTime.jsp" method=post >
				<wea:layout type="4col">
					<wea:group context='<%= SystemEnv.getHtmlLabelName(20331,user.getLanguage())%>'>
						
						<wea:item><%=SystemEnv.getHtmlLabelName(32530,user.getLanguage())%></wea:item>
						<wea:item>
								<BUTTON class=Calendar type="button" id=selectfromdate onclick="getDate('fromdatespan','fromdate')"></BUTTON>
								<SPAN id=fromdatespan ><%=fromdate%></SPAN>－
								<BUTTON class=Calendar type="button" id=selecttodate onclick="getDate('todatespan','todate')"></BUTTON>
								<SPAN id=todatespan ><%=todate%></SPAN>
								<input type="hidden" id=fromdate name="fromdate" value="<%=fromdate%>">
								<input type="hidden" id=todate name="todate" value="<%=todate%>">
						</wea:item>
														
						<wea:item><%=SystemEnv.getHtmlLabelName(125893,user.getLanguage())%></wea:item>
						<wea:item><input  type="text" name="seclevel" value='<%=seclevel%>'></wea:item>
					</wea:group>
					<wea:group context="" attributes="{'groupDisplay':'none'}">
						<wea:item type="toolbar">
							<input type="submit" value="<%=SystemEnv.getHtmlLabelName(197 ,user.getLanguage()) %>" class="e8_btn_submit" name="submit" onclick="doSearchsubmit();"/>
							<input type="button" value="<%=SystemEnv.getHtmlLabelName(2022 ,user.getLanguage()) %>" class="e8_btn_cancel"name="reset" onclick="resetCondtion();"/>
							<input type="button" value="<%=SystemEnv.getHtmlLabelName(201 ,user.getLanguage()) %>" class="e8_btn_cancel" id="cancel"/>
						</wea:item>
					</wea:group>
				</wea:layout>
			</form>
		</div>	
		<wea:layout type="fourCol">
			<wea:group context="记录明细">
				<wea:item attributes="{'isTableList':'true'}">		
				
					<%

                        String backfields =" b.id,b.workcode,b.lastname,b.seclevel,c.lastname as mamager,b.subcompanyid1,b.departmentid,cjlczgs,(ltrim(zhs/60) +'小时'+right('0'+ltrim(zhs%60),2)+'分'+ltrim(zhs%60)+'秒') as zhs,"+
						"(ltrim(pjhs/60) +'小时'+right('0'+ltrim(pjhs%60),2)+'分'+ltrim(pjhs%60)+'秒') as averagehs";

						String fromSql = " from ( "+
						"	select COUNT(requestid) as cjlczgs,userid as id,SUM(ss) as zhs,SUM(ss)/COUNT(requestid) as pjhs from ( "+
						"		select a.requestid,a.ss,b.requestname,userid from ( "+
						"			select a.requestid,sum(DATEDIFF(MINUTE,receivedate+' '+receivetime,operatedate+' '+operatetime)) as ss,userid from	workflow_currentoperator a "+
						"			left join workflow_nodebase b on a.nodeid = b.id "+
						"			where 1=1 and a.workflowid not in (1,93,94,137) and b.isstart not in (1) and isend not in (1) "+  
						"			and a.isremark not in (1,8) and preisremark not in (1,8,9) "+sqlWhereIn+
						"			group by a.requestid,userid "+
						"		) a left join workflow_requestbase b on a.requestid = b.requestid "+
						"	) t1 group by userid "+
						") a "+
						" left join hrmresource b on a.id = b.id "+
                        " left join HrmResource c on b.managerid = c.id ";
						String orderby = " a.pjhs desc"; 

					    String tableString =" <table tabletype=\"none\" pagesize=\"10\" >"+
								" <sql backfields=\""+backfields+"\"  sqlform=\""+Util.toHtmlForSplitPage(fromSql)+"\"  sqlwhere=\""+ sqlWhere+ "\" sqlorderby=\""+orderby+"\"  sqlprimarykey=\"b.id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
									 "<head>"+
										 "<col width=\"7%\" text=\"员工工号\"  column=\"workcode\"  orderkey=\"workcode\" />"+  
										 "<col width=\"7%\" text=\"姓名\"	   column=\"lastname\"  orderkey=\"lastname\" />"+
										 "<col width=\"7%\" text=\"安全级别\"  column=\"seclevel\"  orderkey=\"seclevel\"  />"+
										 "<col width=\"7%\" text=\"直接上级\"  column=\"mamager\"  orderkey=\"mamager\"  />"+
										 "<col width=\"10%\" text=\"公司\"     column=\"subcompanyid1\"  orderkey=\"subcompanyid1\" transmethod=\"weaver.general.GetDeptNamesByDeptid.getConpanyNames\"/>"+
										 "<col width=\"15%\" text=\"部门\" 	   column=\"departmentid\"  orderkey=\"departmentid\" transmethod=\"weaver.general.GetDeptNamesByDeptid.getDeptNames\"/>"+ 
										 "<col width=\"12%\" text=\"参与流程量\"  column=\"cjlczgs\"  orderkey=\"cjlczgs\" />"+
										 "<col width=\"10%\" text=\"总耗时\"      column=\"zhs\"  orderkey=\"zhs\"  />"+
										 "<col width=\"7%\"  text=\"平均耗时\"    column=\"averagehs\"  orderkey=\"averagehs\"  />"+
										
									 "</head>"+ 
								" </table>";
                   String sql = "select "+backfields+fromSql+sqlWhere+" orderby"+orderby;
				   //out.print(">>>>>>>>>>>>>:"+sql);
					%>
					<wea:SplitPageTag isShowTopInfo="fasle" tableString='<%=tableString%>' showExpExcel="true"  mode="run"/><!-- showExpExcel="true"-->
				</wea:item>
			</wea:group>
		</wea:layout>
</BODY>
<script type="text/javascript">
function getObjWindowUrl() {
	var objType1 = jQuery('#objType').val();
	if (objType1 == 2) {
		var tmpids = document.all('objId').value;
		return "/systeminfo/BrowserMain.jsp?url=/hrm/company/MutiDepartmentBrowser.jsp?selectedids=" + tmpids + "&selectedDepartmentIds=" + tmpids+"&show_virtual_org=-1";
	} else if (objType1 == 3) {
		var tmpids = document.all('objId').value;
		return "/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser3.jsp?selectedids=" + tmpids + "&selectedDepartmentIds=" + tmpids+"&show_virtual_org=-1";
	} else {
		return "/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids=" + $G('objId').value;
	}
}
function getAjaxUrl(){
	var objType1 = jQuery('#objType').val();
	var url = "";
	if (objType1 == 2) {
		url = "/data.jsp?type=4";
	} else if (objType1 == 3) {
		url = "/data.jsp?type=164";
	} else {
		url = "/data.jsp";
	}
	return url;
}
			
	
</script>
</HTML>

