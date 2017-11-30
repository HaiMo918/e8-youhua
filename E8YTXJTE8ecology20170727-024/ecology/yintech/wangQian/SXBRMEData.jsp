<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@ page import="weaver.general.*" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.util.*" %>  
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />  
<jsp:useBean id="BaseBean" class="weaver.general.BaseBean" scope="page" />
<jsp:useBean id="RecordSetDataSource" class="weaver.conn.RecordSetDataSource" scope="page" />
<%
	JSONObject resultJson = new JSONObject();
	JSONObject customerInfo = new JSONObject();
	RecordSetDataSource rsd = new RecordSetDataSource("WangQian");
	String tradeNum =Util.null2String( request.getParameter("tradeNum"));
	
	//融金1 金祥2 盛鼎3 中盘4 恒大5
	Map<String,String> companyMap = new HashMap<String,String>();
	companyMap.put("盛鼎", "0");

	if( tradeNum != null &&  !tradeNum.equals("")){
		   String sqlStr = "     select ";
			     sqlStr+= "		    [客户ID], ";
			     sqlStr+= "			[登录账号], ";
			     sqlStr+= "			[用户名称], ";
			     sqlStr+= "			[所属机构], ";
			     sqlStr+= "			[所属经纪人], ";
			     sqlStr+= "			[证件类型], ";
			     sqlStr+= "			[证件号码], ";
			     sqlStr+= "			[银行开户行], ";
			     sqlStr+= "			[银行账号], ";
			     sqlStr+= "			[首次交易日期], ";
			     sqlStr+= "			[公司], ";
			     sqlStr+= "			[交易所]  ";
			     sqlStr+= "		from  ";
			     sqlStr+= "			[Exchange].[YK].[客户信息提供表_OA] "; 
			     sqlStr+= "		 where 登录账号 = '"+ tradeNum +"'";
		rsd.executeSql(sqlStr);
		rsd.next();
		//out.print(sqlStr);
		String name 				 =  Util.null2String(rsd.getString("用户名称"));			//客户姓名
		String cardNumbe		 =  Util.null2String(rsd.getString("证件号码"));	   		//身份证编号
		String customerId		 =	  Util.null2String(rsd.getString("客户ID"));				//客户id
		String exchange			 =  Util.null2String(rsd.getString("交易所"));			//所属交易所
		String company			 =  Util.null2String(rsd.getString("公司"));					//所属公司
		String tradeDate			 =  Util.null2String(rsd.getString("首次交易日期"));	//首次交易日期
		String bank					 =	  Util.null2String(rsd.getString("银行开户行"));		//开户绑定银行开户行
		String bindBankCard 	 =  Util.null2String(rsd.getString("银行账号"));		    //开户绑定银行账号/卡号
		String remittBank 		 =	  Util.null2String(rsd.getString("银行开户行"));		//打款银行 默认与开户绑定银行开户行相同
		String remittBankCard =   Util.null2String(rsd.getString("银行账号"));  	    //打款银行开户行   默认与开户绑定银行账号/卡号
		
		customerInfo.put("name", name);
		customerInfo.put("cardNumbe", cardNumbe);
		customerInfo.put("customerId", customerId);
		customerInfo.put("exchange", exchange);
		customerInfo.put("company", company);
		customerInfo.put("tradeDate", tradeDate);
		customerInfo.put("bank", bank);
		customerInfo.put("bindBankCard", bindBankCard);
		customerInfo.put("remittBank", remittBank);
		customerInfo.put("remittBankCard", remittBankCard);
		customerInfo.put("companyCode", companyMap.get(company));
		resultJson.put("customerInfo", customerInfo);
	}

	DateFormat thisMonth = new SimpleDateFormat("yyyy-MM-dd");
	resultJson.put("thisMonth", thisMonth.format(new Date()));
	out.println(resultJson.toJSONString());
%>
