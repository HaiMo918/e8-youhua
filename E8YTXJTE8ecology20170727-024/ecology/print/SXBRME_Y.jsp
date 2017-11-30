<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rst" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<% 
	String rqstid  = Util.null2String(request.getParameter("requestid")); 
	String sqlStr ="select htbh,khxm,khID,jyzh,sfzh,yhxyyxqks,yhxyyxqjs,yhcx,dkyhzhkh,sfzxscx,sqx,fzh,jyssxfjlbl,hysxfyhbl,jyyqfjlbl,ljcrjjzbdy,jyssxfjlblwb,hysxfyhblwb,jyyqfjlblwb,crjwb from formtable_main_233  where requestid =  " + rqstid ;
	rst.executeSql(sqlStr);

	rst.next();
	String htbh 		 =  rst.getString("htbh");  		 //合同编号
	String khxm 	     =  rst.getString("khxm");  		 //客户姓名
	String khid  	     =  rst.getString("khID"); 			 //客户ID
	String jyzh 		 =  rst.getString("jyzh");   		 //交易账号
	String sfzh  	     =  rst.getString("sfzh");  		 //身份证号
	String yhxyyxqz 	 =  rst.getString("yhxyyxqks");  	 //奖励协议开始日期
	String yhxyyxqjz     =  rst.getString("yhxyyxqjs"); 	 //奖励协议结束日期
	String dkyhkhh 	     =  rst.getString("yhcx"); 		     //打款银行开户行
	String dkyhzhkh 	 =  rst.getString("dkyhzhkh");  	 //打款银行账号
	String sfzxscx 		 =  rst.getString("sfzxscx");  	     // 省市县
	String sqx 			 =  rst.getString("sqx");  	         // 省市县
	String ssx = sfzxscx+" "+sqx;
	String fzh 			 =  rst.getString("fzh");  			 // 分/支行
    String sxfyh		 =  rst.getString("hysxfyhbl");  	 // 会员手续费奖励比例
	String sxfjl		 =  rst.getString("jyssxfjlbl");  	 //  交易所手续费奖励比例
	String yqfyh		 =  rst.getString("jyyqfjlbl");  	 // 交易延期费奖励比例
	String ljcrjjzbdy	 =  rst.getString("ljcrjjzbdy");  	 // 累计出入金净值不低于

	
	String hysxfyhwb     =  rst.getString("hysxfyhblwb");     // 会员手续费奖励比例
	String jyssxfjlwb 	 =  rst.getString("jyssxfjlblwb");    // 交易所手续费奖励比例  文本
	String jyyqfyhwb     =  rst.getString("jyyqfjlblwb");     // 交易延期费奖励比例   文本
	String crjdx 		 =  rst.getString("crjwb");  		// 累计出入金净值  文本
	
	String[] yhxyyxqzArr = yhxyyxqz.split("-");//奖励开始日期
	String year_b 		 =   yhxyyxqzArr[0]; //   年
	String month_b       =   yhxyyxqzArr[1]; //   月
	String day_b 		 =   yhxyyxqzArr[2]; //    日
	
	String[] yhxyyxqjzArr = yhxyyxqjz.split("-");//奖励结束日期
	String year_e 		  =   yhxyyxqjzArr[0]; //   年
	String month_e        =   yhxyyxqjzArr[1]; //   月
	String day_e 	      =   yhxyyxqjzArr[2]; //   日
%>

<HTML>
<HEAD>
<TITLE>javascript打印-打印页面设置-打印预览代码</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312" />
<style media=print>
.Noprint{display:none;}
.PageNext{page-break-after: always;}
body{
	
}
html{width:100%; height:100%;}

</style>

<SCRIPT language=javascript>
	function pagesetup_null() {
        try {
            var RegWsh = new ActiveXObject("WScript.Shell");
            hkey_key = "header";
            RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "");
            hkey_key = "footer";
            RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "");
        } catch (e) {
        }
    }
　　function printsetup(){
	　　// 打印页面设置
	　　wb.execwb(8,1);
　　}
　　function printpreview(){
	　　// 打印页面预览
	　　wb.execwb(7,1);
　　}
　　function printit()
　　{
　　if (confirm('确定打印吗？')) {
　　wb.execwb(6,6)
　　}
　　}
    window.onload=printpreview;//不要括号
</SCRIPT>

</HEAD>
<BODY >
<!-- <div id="kpr"  style="height: 30px; width:210mm; border:1px solid #eee; background-color: #EEE; text-align: right;  " >
	    <INPUT onclick="kpr.style.display='none';javascript:printit()"         		style="margin-right:-7px;  height: 30px; line-height: 30px;  font-weight: bold;    border:1px solid rgb(242,221,220); background-color:rgb(242,221,220);   width: 150px;"   type=button value=打印 name=button_print />
	    
		<INPUT onclick="kpr.style.display='none';javascript:printsetup();" 		style=" margin-right:-7px; height: 30px; line-height: 30px;  font-weight: bold;    border:1px solid rgb(219,229,241); width: 150px;   background-color:rgb(219,229,241);"    type=button value=打印页面设置 name=button_setup />
		<INPUT onclick="kpr.style.display='none';javascript:printpreview();"	style="   height: 30px; line-height: 30px;  font-weight: bold;   border:1px solid rgb(234,241,221); width: 150px;   background-color:rgb(234,241,221);"    type=button value=打印预览 name=button_show />
</div> -->
<div style="position:relative;  border:1px solid #fff; width:210mm; height:297mm;" >
	<div style="border-bottom:2px solid #000;" ><img src="/yintech/print/ytxlog.png" /></div>
	<DIV align=center>
		<OBJECT id=wb height=0 width=0
		classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 name=wb></OBJECT>
		
	</DIV>
	<div style="height:60px; margin-top:20px;  line-height:50px;  font-size:38px; text-align:center; font-weight:bold;  font-family:STXinwei;  position: relative;  /* border:1px solid red;   */ " >
		交易费用奖励协议<div style="position:absolute; right:0px; top:0px;   height:25px;  line-height:20px; width:300px;  font-size: 14px; font-weight: bold; vertical-align: top; " >编号：<%=htbh %></div>
	</div>
	<div style="margin: 0px; height: 45px; line-height: 25px;"  >
		<span  style="display:inline-block; vertical-align:bottom; " >客户姓名：</span><span style="display:inline-block; vertical-align:bottom;  height: 20px; width: 280px; border-bottom: 1px solid #000;"  ><%=khxm %></span>                                 <span  style="display:inline-block; vertical-align:bottom; " > 交易帐号：</span><span style="display:inline-block; vertical-align:bottom;  height: 20px; width: 280px; border-bottom: 1px solid #000;"  ><%=jyzh %></span>   
	</div>
	<div style="margin: 0px; height: 45px; line-height: 25px; "  >
		<span  style="display:inline-block; vertical-align:bottom; " >客户 I D：</span><span style="display:inline-block;  height: 20px; width: 280px; border-bottom: 1px solid #000; vertical-align:bottom; "  ><%=khid %></span>                                  <span  style="display:inline-block; vertical-align:bottom; " >身份证号：</span><span style="display:inline-block; height: 20px; width: 280px; border-bottom: 1px solid #000; vertical-align:bottom;  "  ><%=sfzh %></span>   
	</div>
	
	<div style="margin: 0px; height: 32px; line-height: 32px; font-weight: bold; "  >
		一、	交易费用协议内容   
	</div>
	<div style="margin: 0px; height: 34px; line-height: 34px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;1、	服务原则：
	</div>
	<div style="margin: 0px; line-height: 25px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;本协议专为盛鼎公司优质客户提供，客户除享有公司的基本服务之外，还获得交易费用的奖励，上述奖励额度的核算包含客户在盛鼎公司交易的所有品种。
	</div>
	<div style="margin: 0px; height: 34px; line-height:34px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;2、	协议内容：
	</div>
	<div style="margin: 0px; line-height: 25px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;* 经双方友好协商，自本协议约定之日起，客户个人账户通过陕西一带一路大宗商品交易中心(以下简称“交易中心”)交易平台进行交易，交易延期费奖励比例为 <label style="padding-bottom:3px; border-bottom:1px solid #000;" >&nbsp;&nbsp;百分之<%=jyyqfyhwb %>&nbsp;&nbsp;</label>，并通过转账的方式退还到客户本人与交易中心绑定的银行资金账户，最终到账金额为以上奖励部分的扣除税金后金额。(注：若后期交易中心后台系统能够自由调整交易手续费收取标准，交易系统将直接按照本协议约定的费率标准调整收取)。
	</div>
	<div style="margin: 0px;  line-height: 25px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;* 奖励协议有效期限：自<span style="display:inline-block; text-align:center;   height:20px; width: 40px; border-bottom: 1px solid #000;"  ><%=year_b %></span>  年  <span style="display:inline-block;  height:20px; text-align:center;   width: 40px; border-bottom: 1px solid #000;"  ><%=month_b %></span> 月 <span style="display:inline-block; text-align:center;   height:20px; width: 40px; border-bottom: 1px solid #000;"  ><%=day_b %></span> 日 
		&nbsp;&nbsp;至&nbsp;&nbsp;
		<span style="display:inline-block; height:20px;  text-align:center;  width: 40px; border-bottom: 1px solid #000;"  ><%=year_e %></span>  年<span style="display:inline-block;  height:20px;  width: 40px;  text-align:center;  border-bottom: 1px solid #000;"  ><%=month_e %></span>  月<span style="display:inline-block;  height:20px; width: 40px; text-align:center;  border-bottom: 1px solid #000;"  ><%=day_e %></span>  日；
	</div>
	<div style="margin: 0px;  line-height: 25px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;* 奖励金额结算周期：以月为周期结算，每个月的最后一交易日为一个结算周期的截止日(以下简称“结算日”)；
	</div>
	<div style="margin: 0px;  line-height: 25px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;* 返还奖励金额时间：每个结算日的次月15日(遇节假日顺延)；
	</div>
	<div style="margin: 0px;  line-height: 25px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;* 返还奖励金额方式：银行划转入客户本人交易中心绑定的银行资金账户：
	</div>
	<div style="margin: 0px;  line-height: 25px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;账户姓名：<span style="display:inline-block;  height: 20px; width: 80px; border-bottom: 1px solid #000;"  ></span>  开户行：<span style="display:inline-block;  height: 20px; width: 150px; border-bottom: 1px solid #000;"  ><%=dkyhkhh%></span> 银行<span style="display:inline-block;  height: 20px; width: 150px; border-bottom: 1px solid #000;"  ><%=ssx %></span>省/市 <span style="display:inline-block;  height: 20px;  border-bottom: 1px solid #000;"  ><%=fzh %></span>分行；
	</div>
	<div style="margin: 0px;  line-height: 25px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;银行账号/银行卡号：<span style="display:inline-block;  height: 20px; width: 300px; border-bottom: 1px solid #000;"  ><%=dkyhzhkh %></span> 
	</div>

	<div style="margin: 0px; height: 32px; line-height: 32px; font-weight: bold; "  >
		二、	交易费用奖励条件要求
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 5px; "  >
			&nbsp;&nbsp;&nbsp;&nbsp;1、	遵守国家法律、法规和政策、遵守陕西一带一路大宗商品交易中心的相关规章制度。
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 5px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;2、	截止至结算日，客户的账户累计出入金净值不低于<span style="display:inline-block; height:20px;  text-align:center;  width: 80px; border-bottom: 1px solid #000;"  ><%=crjdx%></span>万元人民币，且账户的日均出入金净值不低于累计出入金净值的50%。
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 5px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;3、	对签署信息严格保密，不透漏给第三方。
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 5px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;4、	愿意协助盛鼎公司做好正面宣传工作。
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 5px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;注：累计出入金净值指客户自开户至本次结算日的总入金减去总出金；日均出入金净值=期初累计出入金净值+(结算月每日累计净值*资金在当月的累计交易日天数)/当月总交易日天数。(如果协议起始月或截止月非整月，则按照当月奖励的有效天数计算日均净值)
	</div>
	
	<div style="margin: 0px; height: 32px; line-height: 32px; font-weight: bold; "  >
		三、	停止服务及协议终止
	</div>
	
	<div style="margin: 0px;  line-height: 25px;  padding: 5px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;1、	客户同意，若本协议有效期内，客户未能满足本协议项下的奖励条件，盛鼎公司有权即刻暂停当月向客户提供奖励服务。
	</div>
	<div style="width: 100%; height: 100px;"  > </div>
	<div style="position:absolute; bottom:0px; right:0px;  width: 100%; font-size: 14px; color: #666; font-weight: bold; text-align: center;  " >&nbsp;1&nbsp;/&nbsp;3&nbsp;</div>
	<div style="position:absolute; bottom:0px; right:0px;  width: 100%; font-size: 14px; color: #ccc; font-weight: bold; text-align: right;  " >&nbsp;&nbsp;银科控股（Nasdaq代码：YIN）旗下公司&nbsp;&nbsp;</div>
</div>


<div style="position:relative;   border:1px solid #fff; width:210mm; height:297mm;" >
	<div class="PageNext"></div>
	<div style="border-bottom:2px solid #000;" ><img src="/yintech/print/ytxlog.png" /></div>
	
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;2、	客户同意，若本协议有效期内，客户账户存在异常情况或某个品种的操作存在异常情况的，盛鼎公司有权选择提前终止本协议或针对操作异常的品种终止提供交易奖励服务。基于交易中心对客户交易行为合规化的要求，及盛鼎公司倡导客户本人操作，确保账户安全等原因，客户理解并同意，如发生下列任一情形，不论客户入金多少，盛鼎有权即刻终止奖励，并保留追索客户已获得之奖励的权利：
	</div>
	
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a)	客户开立账户异常、交易异常、持仓异常及资金异常等；
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b)	将交易账户、资金清算账户等交由他人管理、使用，或者全权委托他人直接进入客户交易账户进行交易操作和下达交易指令；
	</div>
	
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c)	利用交易资格或交易业务进行非法经营活动；
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;d)	接受他人以代客操盘、代客理财、变相融资、承诺保底收益等方式参与交易；
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;e)	拒不执行交易中心采取的限制交易措施；
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;f)	违反交易中心相关规则制度，或者本协议附件规定的其他情形；
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;3、	客户同意，遇国家相关法律、法规及陕西一带一路交易中心相关交易规则变更的，盛鼎公司有权选择提前终止本协议或修改本协议奖励条件及要求（包括但不限于费用收取标准、奖励条件及要求等）。盛鼎公司选择修改本协议的，若客户接受，双方另行签署书面协议予以确认；若客户不接受，盛鼎公司有权提前终止本协议。
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;4、	盛鼎公司按照本条1、2、3款规定提前终止或修改协议的，客户无权要求盛鼎公司承担任何违约或其他责任。
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;<label style="font-weight: bold;"  >客户申请及承诺：</label>本人愿意遵守盛鼎有关交易费用奖励协议的规定，接受相关服务内容，并愿意自行承担交易中的风险；若出现以上要求未能满足或本人账户异常的情况，本人同意放弃盛鼎交易费用奖励协议的特权服务，并同意盛鼎公司提前终止本协议，本人不得因此要求盛鼎公司承担任何违约或其他责任。现郑重向盛鼎申请交易费用奖励服务，自本协议签订之日起，客户之前与盛鼎公司签署的《交易费用奖励协议》将自动作废，以本协议为准！同时本人已领取本奖励协议原件/复印件壹份。
本人已认真阅读并完全理解和同意上述交易费用奖励协议的全部条款，并承诺本人应严格遵守“客户申请及承诺”部分内容。
	</div>

	<div style="margin: 0px; line-height: 32px; font-weight: bold;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;本人已认真阅读并完全理解和同意上述交易费用奖励协议的全部条款，并承诺本人应严格遵守“客户申请及承诺”部分内容。
	</div>
	<div style="margin: 0px; line-height: 32px; font-weight: bold;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;客户誊抄：<span style="display:inline-block; vertical-align:bottom;  height: 20px; width:650px; border-bottom: 1px solid #000;"  ></span>
		<br/>
		<div style="margin-left:5px;  margin-right:25px;  height: 34px; border-bottom: 1px solid #000;"  ></div>
	</div>
	<div style="height: 10px;" ></div>
    <div style="margin: 0px; height: 33px; line-height: 35px; font-weight: bold; "  >
		 &nbsp;&nbsp; 1.	客户开立账户异常情形：
	</div>                                                     
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;a)	客户在办理开户业务时（包括电子化开户以及非电子化开户等交易中心认可的任何一种开户方式）非本人亲自办理的；
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;b)	客户的开户资料非本人亲自签署，委托其他人代为签署的；
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;c)	客户拒绝、不配合会员单位或交易中心电话回访，或者在回访时无法提供准确信息的；
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;d)	两个或两个以上主体开户时使用同一IP地址或IP地址虽不尽相同但属于同一物理地址的；
	</div>
	<div style="margin: 0px;  line-height: 20px;  padding: 4px;  padding-right: 0px;"  > 
		&nbsp;&nbsp;&nbsp;&nbsp;e)	两个或两个以上主体开户时开户信息不同但使用同一联系电话或者有其他关联要素提示交易账户持有主体间具有关联关系的；
	</div>
	<div style="width: 100%; height: 75px;"  > </div>
	<div style="position:absolute; bottom:0px; right:0px;  width: 100%; font-size: 14px; color: #666; font-weight: bold; text-align: center;  " >&nbsp;2&nbsp;/&nbsp;3&nbsp;</div>
	<div style="position:absolute; bottom:0px; right:0px;  width: 100%; font-size: 14px; color: #ccc; font-weight: bold; text-align: right;  " >&nbsp;&nbsp;银科控股（Nasdaq代码：YIN）旗下公司&nbsp;&nbsp;</div>
</div>


<div style=" position:relative;  border:1px solid #fff; width:210mm; height:297mm;" >
	<div class="PageNext"></div>
	<div style="border-bottom:2px solid #000;" ><img src="/yintech/print/ytxlog.png" /></div>
	
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;f)	客户开户时留有信息存在虚假现象的；
	</div>
	
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;g)	交易中心、会员单位认定客户开立账户存在异常的其他情形。
	</div>

	<div style="margin: 0px; height: 35px; line-height: 35px; font-weight: bold; "  >
		 &nbsp;&nbsp;2.	客户交易异常情形：
	</div> 
	
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
			&nbsp;&nbsp;&nbsp;&nbsp;a)	客户在短时间内频繁进行交易，建仓时间间隔在15分钟以内的；
	</div>
	
	<div style="margin: 0px;  line-height: 20px;  padding: 5px;  padding-right: 0px;"  > 
			&nbsp;&nbsp;&nbsp;&nbsp;b)	客户单笔成交数量达到交易中心单笔交易限额或单笔交易限额达到交易中心规定单笔交易限额80%以上的；
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px;   padding-right: 0px;"  > 
			&nbsp;&nbsp;&nbsp;&nbsp;c)	关联账户组（指多个具有实际控制关联关系的账户组，下同）的市价单在成交产品、成交方向、成交价格、成交数量、成交时间中一项或多项指标基本一致的；
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px;  padding-right: 0px;"  > 
			&nbsp;&nbsp;&nbsp;&nbsp;d)	关联账户组的指价单在成交产品、成交方向、成交价格、成交数量中一项或多项指标基本一致的；
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; padding-right: 0px; "  > 
			&nbsp;&nbsp;&nbsp;&nbsp;e)	关联账户组的市价单在成交时间、成交产品、成交数量中一项或多项指标基本一致，而成交方向相反的；
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; padding-right: 0px; "  > 
			&nbsp;&nbsp;&nbsp;&nbsp;f)	关联账户组的指价单在成交产品、成交价格、成交数量中一项或多项指标基本一致，而成交方向相反的；
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; padding-right: 0px; "  > 
			&nbsp;&nbsp;&nbsp;&nbsp;g)	关联账户组的成交IP地址一致或IP地址虽不尽相同但属于同一物理地址的；
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
			&nbsp;&nbsp;&nbsp;&nbsp;h)	关联账户组的登录或退出IP地址一致或IP地址虽不尽相同但属于同一物理地址的；
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
			&nbsp;&nbsp;&nbsp;&nbsp;i)	单一账户客户单日成交笔数达到30笔以上的；
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
			&nbsp;&nbsp;&nbsp;&nbsp;j)	交易中心、会员单位认定客户交易异常的其他情形。
	</div>		
	
	
	<div style="margin: 0px; height: 35px; line-height: 35px; font-weight: bold; "  >
		 &nbsp;&nbsp;3.	客户持仓异常情形：
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;a)	客户持仓达到交易中心规定的持仓限额或交易中心规定的持仓限额80%以上的；
	</div>		 			
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;b)	关联账户组的持仓产品、持仓时间、持仓数量、持仓方向中一项或多项指标基本一致的；
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;c)	关联账户组的持仓产品、持仓时间、持仓数量中一项或多项指标基本一致，而持仓方向相反的；
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;d)	交易中心、会员单位认定客户持仓异常的其他情形。
	</div>		 
	
	<div style="margin: 0px; height: 35px; line-height: 35px; font-weight: bold; "  >
		&nbsp;&nbsp;4.	客户资金异常情形：
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;a)	客户的资金在相近的时间内由于非交易的因素出现较大的变动的；
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;b)	多个账户的一次性入金或出金超过一定金额的；
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;c)	多个账户的入金或出金时间相近的；
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;d)	多个账户同时进行相近金额的入金或出金的；
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;e)	交易中心、会员单位认定客户资金异常的其他情形。
	</div>		 
	<div style="margin: 0px; height: 32px; line-height: 32px; font-weight: bold; "  >
		&nbsp;&nbsp;5.	客户涉嫌违约违规的；
	</div>		 
	<div style="margin: 0px; height: 32px; line-height: 32px; font-weight: bold; "  >
		&nbsp;&nbsp;6.	客户涉及司法调查的；
	</div>		 
	<div style="margin: 0px; height: 32px; line-height: 32px; font-weight: bold; "  >
		&nbsp;&nbsp;7.	交易中心认为必要的其他情形。
	</div>		 
	<span style=" display:inline-block;  margin: 0px; height: 32px; width:48%;   font-weight: bold; "  >&nbsp;&nbsp;客户签名：      </span>  <span style=" display:inline-block;  margin: 0px; height: 32px; width:48%;   font-weight: bold; "  > 领导签字：</span>
     <span style="  display:inline-block;  margin: 0px; height: 32px; width:48%;   font-weight: bold; "  >
     	<span style="margin-left:100px; display:inline-block;  height: 20px; width: 40px; border-bottom: 1px solid #000;"  ></span> 年  <span style="display:inline-block;  height: 20px; width: 40px; border-bottom: 1px solid #000;"  ></span>     月<span style="display:inline-block;  height: 20px; width: 40px; border-bottom: 1px solid #000;"  ></span> 日     
     </span> 
     <span style=" display:inline-block;  margin: 0px; height: 32px; width:48%;   font-weight: bold; "  >
     	<span style="margin-left:100px; display:inline-block;  height: 20px; width: 40px; border-bottom: 1px solid #000;"  ></span> 年    <span style="display:inline-block;  height: 20px; width: 40px; border-bottom: 1px solid #000;"  ></span>   月    <span style="display:inline-block;  height: 20px; width: 40px; border-bottom: 1px solid #000;"  ></span>   日	
     </span>	
     <div style="margin: 0px;  line-height: 20px;  padding: 5px; "  >
		&nbsp;&nbsp;本协议壹式贰份，双方各执壹份。经双方签字（盖章）后具备同等法律效力。
	 </div>	
	 <div style="margin: 0px;  line-height: 50px; text-align:right;  padding: 5px; font-weight: bold;  "  >
			广东盛鼎贵金属经营有限公司
	 </div>
	 
	<div style="width: 100%; height: 10px;"  > </div>
	<div style="position:absolute; bottom:0px; right:0px;  width: 100%; font-size: 14px; color: #666; font-weight: bold; text-align: center;  " >&nbsp;3&nbsp;/&nbsp;3&nbsp;</div>
	<div style="position:absolute; bottom:0px; right:0px;  width: 100%; font-size: 14px; color: #ccc; font-weight: bold; text-align: right;  " >&nbsp;&nbsp;银科控股（Nasdaq代码：YIN）旗下公司&nbsp;&nbsp;</div>
</div>
</BODY>
</HTML> 