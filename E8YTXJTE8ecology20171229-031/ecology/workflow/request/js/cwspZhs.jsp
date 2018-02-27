<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="weaver.general.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.IsGovProj" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<%!
	public String getUserid(String userid){
		weaver.conn.RecordSet rst = new weaver.conn.RecordSet();
		String yggh = "";
		String ygghsql = "select workcode from HrmResource where id = '"+userid+"'";
		rst.executeSql(ygghsql);
		if(rst.next()){
			yggh = rst.getString("workcode");
		}
		return yggh;
	}
%>
<%
BaseBean log = new BaseBean();
String requestid = Util.null2String(request.getParameter("requestid"));
StringBuffer json = new StringBuffer();
int zsh = 0;
String sql = "select DATEDIFF(day,startdatetime,currentdatetime) as zsh from ("+
"select createdate+' '+createtime as startdatetime,CONVERT(varchar(100), GETDATE(), 120) as currentdatetime  from workflow_requestbase where requestid = '"+requestid+"') a";
rs.executeSql(sql);
if(rs.next()){
	zsh = Util.getIntValue(rs.getString("zsh"));
}
log.writeLog("sql>>>>:"+sql+";>>>:"+zsh);

json.append("{");
json.append("'ZSH':'").append(zsh).append("'");	
json.append("}");

out.println(json.toString());

%>