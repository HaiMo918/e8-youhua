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
String resourceid = Util.null2String(request.getParameter("resourceId"));
String workcode  = getUserid(resourceid);
String qjType = Util.null2String(request.getParameter("qjType"));

//out.print("resourceid>>>>>>>:"+resourceid+";qjType>>>:"+qjType);
Calendar today = Calendar.getInstance();
//int year = Integer.parseInt(Util.add0(today.get(Calendar.YEAR), 4));
StringBuffer json = new StringBuffer();
if("1".equals(qjType)){
	//------------------------------- 年假开始
	double dnnj = 0.00;//员工当年年假
	String dnnjsql = "select isnull(dnnj,0.00) as dnnj from uf_formtable_njtx where yggh = '"+workcode+"'";
	rs.executeSql(dnnjsql);
	if(rs.next()){
		dnnj = Util.getDoubleValue(rs.getString("dnnj"));
	}

	double jynj = 0.00;//员工结余年假
	String jynjsql = "select isnull(jynj,0.00) as jynj from uf_formtable_njtx where yggh = '"+workcode+"'";
	rs.executeSql(jynjsql);
	if(rs.next()){
		jynj = Util.getDoubleValue(rs.getString("jynj"));
	}

	double djnj = 0.00;//员工冻结年假
	String djnjsql = "select sqr,SUM(qjsc) as djnj from formtable_main_31 a left join workflow_requestbase b on a.requestId = b.requestid where qjlx = '1' and a.qsrq >= '2017-01-01' and b.currentnodetype in (1,2) and sqr = '"+resourceid+"' group by sqr";
	rs.executeSql(djnjsql);
	if(rs.next()){
		djnj = Util.getDoubleValue(rs.getString("djnj"));
	}
	double xxnj = 0.00;//员工线下请假
	String xxqjsql = "select workcode,SUM(qjts) as xxnj from empxxqjd where qjlx = '1' and ksrq>='2017-01-01' and workcode = '"+workcode+"' group by workcode";
	rs.executeSql(xxqjsql);
	if(rs.next()){
		xxnj = Util.getDoubleValue(rs.getString("xxnj"));
	}
	double kynj = dnnj+jynj-djnj-xxnj;
	
	json.append("{");
	json.append("'QjType':'").append(qjType).append("',");
	json.append("'JYNJ':'").append(jynj).append("',");
	json.append("'DNNJ':'").append(dnnj).append("',");
	json.append("'KYNJ':'").append(kynj).append("',");
	json.append("'DJNJ':'").append(djnj).append("'");	
	json.append("}");
	//---------------------------- 年假结束

}else if("0".equals(qjType)){
	//---------------------------- 调休开始

	double jytx = 0.00;//员工结余调休
	String jytxsql = "select isnull(jytx,0.00) as jytx from uf_formtable_njtx where yggh = '"+workcode+"'";
	rs.executeSql(jytxsql);
	if(rs.next()){
		jytx = Util.getDoubleValue(rs.getString("jytx"));
	}

	double dntx = 0.00;//员工当年调休
	String dntxsql = "select isnull(dntx,0.00) as dntx from uf_formtable_njtx where yggh = '"+workcode+"'";
	rs.executeSql(dntxsql);
	if(rs.next()){
		dntx = Util.getDoubleValue(rs.getString("dntx"));
	}

	double djtx = 0.00;//员工冻结调休
	String djtxsql = "select sqr,SUM(qjsc) as djtx from formtable_main_31 a left join workflow_requestbase b on a.requestId = b.requestid where qjlx = '0' and a.qsrq >= '2017-01-01' and b.currentnodetype in (1,2) and sqr = '"+resourceid+"' group by sqr";
	rs.executeSql(djtxsql);
	if(rs.next()){
		djtx = Util.getDoubleValue(rs.getString("djtx"));
	}

	double xxtx = 0.00;//员工线下调休
	String xxtxsql = "select workcode,SUM(qjts) as xxtx from empxxqjd where qjlx = '0' and ksrq>='2017-01-01' and workcode = '"+workcode+"' group by workcode";
	rs.executeSql(xxtxsql);
	if(rs.next()){
		xxtx = Util.getDoubleValue(rs.getString("xxtx"));
	}

	double kytx =jytx+dntx-xxtx-djtx;

	json.append("{");
	json.append("'QjType':'").append(qjType).append("',");
	json.append("'JYTX':'").append(jytx).append("',");
	json.append("'DNTX':'").append(dntx).append("',");
	json.append("'KYTX':'").append(kytx).append("',");
	json.append("'DJTX':'").append(djtx).append("'");	
	json.append("}");
	//---------------------------- 调休结束
}else if("5".equals(qjType)){
	//---------------------------- 全薪病假开始
	String qjksrq = Util.null2String(request.getParameter("qjksrq"));
    String year = qjksrq.substring(0, 4);
	double qxbj = 0.00;//全薪病假
	String qxbjsql = "select sqr,SUM(qjsc) as qxbj from formtable_main_31 a left join workflow_requestbase b on a.requestId = b.requestid where qjlx = '5' and substring(a.qsrq,1,4) = '"+year+"' and b.currentnodetype <> 0 and sqr = '"+resourceid+"' group by sqr";
	rs.executeSql(qxbjsql);
	if(rs.next()){
		qxbj = Util.getDoubleValue(rs.getString("qxbj"));
	}

	double syqxbj = 24-qxbj;
	json.append("{");
	json.append("'QjType':'").append(qjType).append("',");
	json.append("'QXBJ':'").append(qxbj).append("'");	
	json.append("}");
	//---------------------------- 全薪病假结束
}
out.println(json.toString());

%>