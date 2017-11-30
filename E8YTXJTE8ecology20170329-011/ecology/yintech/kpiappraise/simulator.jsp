<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="weaver.file.Prop" %>
<%@ page import="weaver.hrm.appdetach.*" %>
<HTML>
	<head>
			<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
			<script language="javascript" src="/js/weaver_wev8.js"></script>
			<script language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
			<script language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	</head>
	<%	

	String imagefilename = "/images/hdMaintenance_wev8.gif";
	String titlename = "项目明细信息";
	String needfav ="1";
	String needhelp =""; 
	%>
<BODY>

<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<FORM id=weaver name=weaver action="projectUpdate.jsp" method=post >
<wea:layout type="2col">
	<wea:group context='个人捐赠所得税计算模拟器' >	  
	   <wea:item>国 籍:</wea:item>
	   <wea:item>
			<select id="national" class="national" name="national" onChange="GjFunction(this)">
				<option value="0">中国</option>
				<option value="1">外籍</option>
			</select>
	   </wea:item>

	   <wea:item>月 薪:</wea:item>
	   <wea:item>
		 <input type ='text' id="yx"  name="yx" value="0.00" onblur="YxFunction();"/>
	   </wea:item>
      
	   <wea:item>社保和公积金扣除额:</wea:item>
	   <wea:item>
		 <input type ='text' id="wxyj"  name="wxyjspn" value="0.00" onblur="WxyjFunction();"/>
	   </wea:item>
	   <wea:item>月捐赠额:</wea:item>
	   <wea:item>
		 <input type ='text' id="yjze"  name="yjze" value="0.00" onblur="YjzeFunction();"/>
	   </wea:item>
	   <wea:item>捐赠后个税:</wea:item>
	   <wea:item>
		 <span id="jzhgs" name="jzhgsspan"></span>
	   </wea:item>

	   <wea:item>未捐赠个税:</wea:item>
	   <wea:item>
		 <span id="wjzgs" name="wjzgsspan"></span>
	   </wea:item>

	   <wea:item>少交个税:</wea:item>
	   <wea:item>
		 <span id="sjge" name="sjgespan"></span>
	   </wea:item>
	   <wea:item>说明:</wea:item>
	   <wea:item>
		 <span>一中国籍员工，月薪为8000元，社保和公积金扣除额为1700元，月捐赠额为200元；<br>则捐赠后个税比未捐赠个税少交20元，即相当于员工捐赠了180元。</span>
	   </wea:item>
	</wea:group>
</wea:layout>	
<div style="width:100%;height:50%;">
	<script id="editor" type="text/plain" style="width:800px;height:200px;"></script>
</div>

<input type ='hidden' id="kcjze"  name="kcjzespn" value="0.00" />
</form>
<script type="text/javascript" src="workflowComment/json2.js"></script>
<script type="text/javascript" src="workflowComment/workflowComment.js"></script>

<script language=javascript>

var ue = UE.getEditor('editor');

function isMoneys(inputId){     
    //在匹配123XXX时，匹配123,不去验证后面的字符。  
   // var regu = "(^[1-9]+|[0][\.][0-9]{1,2}[元]?$)|(^[1-9]+|[0][元]?$)";  
   //为了解决上面的问题，在正则开头加了括号这样就不会放过123xxx了。  
   //但匹配123.12时，正则(^([1-9]+|[0])[元]?$)会匹配123.  
    //var regu = "(^([1-9]+|[0])[\.][0-9]{1,2}[元]?$)|(^([1-9]+|[0])[元]?$)";   
 
   //为了在匹配123.12时，避免正则(^([1-9]+|[0])[元]?$)会匹配123，所以把去掉了括号()中的竖线，把正则分开写。  
    var val = jQuery("#" + inputId).val();
    var regu = "(^[1-9]+[\.][0-9]{1,2}[元]?$)|(^[0-9]+[元]?$)|(^[0][元]$)|(^[0][\.][0-9]{1,2}[元]?$)";  
    var re = new RegExp(regu);
    //alert(re.exec(s));  
    if (re.test(val)) {
       return true;  
    } else {  
       alert("金额输入有误！");
       jQuery("#" + inputId).val("");
       return false;  
    }
}  

//监控国籍变化
function GjFunction(obj){// selectedIndex代表的是你所选中项的index
	//var gj_v = obj.options[obj.selectedIndex].value;

	YxFunction();
}
function getNational(){
	var rateStart;
	var myselect=document.getElementById("national");//  获取下拉框的对象
    var index=myselect.selectedIndex ;// selectedIndex代表的是你所选中项的index 
	var gj_v = myselect.options[index].value;// 获取下拉框的值

	if(gj_v==0){
		rateStart = "3500";
	}else{
		rateStart = "4800";
	}
	return rateStart;
}
//月薪
var yx_v;
function YxFunction(){
	yx_v = jQuery("input[name=yx]").val()*1;//月薪
	EventCollection();
}
//五险一金算法函数
function WxyjFunction(){
	var wxyj_v = jQuery("input[name=wxyjspn]").val()*1;//社保基数
	EventCollection();
}
//准扣除的捐赠额
function YjzeFunction(){
	var yjze_v = jQuery("input[name=yjze]").val()*1;//月捐赠额
	var wxyj_v = jQuery("input[name=wxyjspn]").val()*1;//五险一金
	var rateStart = getNational()*1;//根据国际获取税后起征点
	var compareTemp = (yx_v-wxyj_v-rateStart)*0.3;

	if(yjze_v==0){
		jQuery("#yjze").val(yjze_v);
		jQuery("#kcjze").val(yjze_v);
	}else{
		if(yjze_v<compareTemp){
			jQuery("#kcjze").val(yjze_v);
		}else{
			jQuery("#kcjze").val(compareTemp);
		}
	}
	EventCollection();
}
//触发事件集合
function EventCollection(){
	var yx_v = jQuery("input[name=yx]").val()*1;//月薪
	var yjze_v = jQuery("input[name=kcjzespn]").val()*1;//月捐赠额
	var wxyj_v = jQuery("input[name=wxyjspn]").val()*1;//五险一金
	
	if(yx_v>0&&(yjze_v>0||yjze_v==0)&&(wxyj_v>0||wxyj_v==0)){
		JzhgsFunction();
		WjzhgsFunction();
		SjgeFunction();
	}
}
//捐赠后个税  
function JzhgsFunction(){
	var yjze_v = jQuery("input[name=kcjzespn]").val()*1;//月捐赠额
	var wxyj_v = jQuery("input[name=wxyjspn]").val()*1;//五险一金
	var rateStart = getNational()*1;//根据国籍获取税后起征点
	var ynse = yx_v-wxyj_v-yjze_v-rateStart;//应纳税额

    var jzhgs = RateJs(ynse);
	if(jzhgs>=0){
		jQuery("#jzhgs").val(toDecimal(jzhgs));
		jQuery("#jzhgs").html(toDecimal(jzhgs));
	}else{
		jQuery("#jzhgs").val("0.00");
		jQuery("#jzhgs").html("0.00");
	}
}
//捐赠后到手收入
function JzhdssrFunction(){
	var wxyj_v = jQuery("input[name=wxyjspn]").val()*1;//五险一金
	var jzhgs_v = jQuery("#jzhgs").val()*1;//捐赠后个税

    var jzhdssr = yx_v-wxyj_v-jzhgs_v;
	if(jzhdssr>=0){
		jQuery("#jzhdssr").html(toDecimal(jzhdssr));
	}else{
		jQuery("#jzhdssr").html("0.00");
	}
}
//未捐赠个税
function WjzhgsFunction(){
	var wxyj_v = jQuery("input[name=wxyjspn]").val()*1;//五险一金
	var rateStart = getNational()*1;//根据国际获取税后起征点
	var ynse = yx_v-wxyj_v-rateStart;//应纳税额

    var wjzgs = RateJs(ynse);
	if(wjzgs>=0){
		jQuery("#wjzgs").val(toDecimal(wjzgs));
		jQuery("#wjzgs").html(toDecimal(wjzgs));
	}else{
		jQuery("#wjzgs").val("0.00");
		jQuery("#wjzgs").html("0.00");
	}
	
}
//未捐赠到手收入
function WjzhdssrFunction(){
	var wxyj_v = jQuery("input[name=wxyjspn]").val()*1;//五险一金
	var wjzgs_v = jQuery("#wjzgs").val()*1;//未捐赠个税

    var wjzdssr = yx_v-wxyj_v-wjzgs_v;
	if(wjzdssr>=0){
		jQuery("#wjzdssr").html(toDecimal(wjzdssr));		
	}else{
		jQuery("#wjzdssr").html("0.00");
	}	
}
//少交个税

function SjgeFunction(){
	var wjzgs_v = jQuery("#wjzgs").val()*1;//未捐赠个税
	var jzhgs_v = jQuery("#jzhgs").val()*1;//捐赠后个税
	var sjge_v = wjzgs_v-jzhgs_v;
	if(sjge_v>=0){
		jQuery("#sjge").html(toDecimal(sjge_v));
	}else{
		jQuery("#sjge").html("0.00");
	}	
}
//保留两位小数
function toDecimal(num){    
    var f = parseFloat(num);    
	if (isNaN(f)) {    
        return;    
	}    
	f = Math.round(num*100)/100;    
	return f;    
} 
	
//捐赠后个税计算函数
function RateJs(ynse){	
	var Rate;//税率
	var Balan;//速算扣除数
    var jzhgs;//捐赠后个税
	if (ynse<1500)   {
		Rate=3;   
		Balan=0;
	}  
	if ((ynse>=1500) && (ynse<4500)){
		Rate=10;  
		Balan=105;   
	}  
	if ((ynse>=4500) &&  (ynse<9000))  {
		Rate=20;   
		Balan=555;   
	}  
	if ((ynse>=9000) && (ynse<35000)) {
		Rate=25;   
		Balan=1005;   
	}  
	if ((ynse>=35000) && (ynse<55000)) {
		Rate=30;   
		Balan=2755;   
	}  
	if ((ynse>=55000) && (ynse<80000)) {
		Rate=35;   
		Balan=5505;  
	}  
	if (ynse>=80000)   {
		Rate=45;   
		Balan=13505;   
	}   
	jzhgs = ynse*Rate/100-Balan;
	return jzhgs;
}

</script>
</BODY>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</HTML>				   	