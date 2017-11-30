<%@ page import="weaver.general.*" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.util.*" %>  
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />  
<jsp:useBean id="BaseBean" class="weaver.general.BaseBean" scope="page" />
<%  
	
	StringBuffer json = new StringBuffer();
	BaseBean lg = new BaseBean();
	String sql = "";
	String year = "";
	String month = "";
	String sqr = Util.null2String(request.getParameter("sqr"));
	String ksrq = Util.null2String(request.getParameter("ksrq"));
	year = ksrq.substring(0, 4);
	month = ksrq.substring(5, 7);

    double jbsc = 0.0;
    double jbky = 0.0;//加班可用小时数

	sql = "select SUM(jbsc) as jbsc from formtable_main_30 a left join workflow_requestbase b on a.requestId = b.requestid "+
          " where jblx = '0' and b.currentnodetype <>0  and substring(JBKSRQ,1,4) = '"+year+"' and  substring(JBKSRQ,6,2) = '"+month+"' and sqr ='"+sqr+"'";
	//out.println("sql>>>:"+sql);
    rs.executeSql(sql);    
    if(rs.next()){
		jbsc = Util.getDoubleValue(rs.getString("jbsc"),0);//加班总时长
	}

    jbky = 36-jbsc;
    json.append("{");
    json.append("'JBKY':'").append(jbky).append("'");
    json.append("}");
	out.println(json.toString());
  
%>