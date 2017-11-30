<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.*,weaver.general.Util"%>
<%@ page import="weaver.file.Prop" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
Calendar today = Calendar.getInstance ();
String currentDate = Util.add0(today.get(Calendar.YEAR), 4) + "-"
                   + Util.add0(today.get(Calendar.MONTH) + 1, 2) + "-"
                   + Util.add0(today.get(Calendar.DAY_OF_MONTH), 2);;
int formid = Util.getIntValue(request.getParameter("formid"));
String fwclbmField = "";//发文处理部门
String fwztfield = "";  //发文主体
String gwlbfield = "";  //公文类别
String zdlbfield = "";  //制度类别
String jdlbfield = "";  //决定类别
String rmjbfield = "";  //任命级别
rs.executeSql("select id,fieldname from workflow_billfield where billid = " + formid + " ");
while(rs.next()){
	String fieldnameStrTemp = Util.null2String(rs.getString("fieldname")); 
	if("fwclbm".equals(fieldnameStrTemp))
		fwclbmField = "field" + Util.null2String(rs.getString("id"));
	if("fwzt".equals(fieldnameStrTemp))
		fwztfield = "field" + Util.null2String(rs.getString("id"));
	if("gwlb".equals(fieldnameStrTemp))
		gwlbfield = "field" + Util.null2String(rs.getString("id"));
	if("zdlb".equals(fieldnameStrTemp))
		zdlbfield = "field" + Util.null2String(rs.getString("id"));
	if("jdlb".equals(fieldnameStrTemp))
		jdlbfield = "field" + Util.null2String(rs.getString("id"));
	if("rmjb".equals(fieldnameStrTemp))
		rmjbfield = "field" + Util.null2String(rs.getString("id"));
}
%>
<script language="javascript">

function ajaxInit(){
    var ajax=false;
    try {
        ajax = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            ajax = false;
        }
    }
    if (!ajax && typeof XMLHttpRequest!='undefined') {
    	ajax = new XMLHttpRequest();
    }
    return ajax;
}
var fwclbm = "<%=fwclbmField%>";//发文处理部门
var fwzt = "<%=fwztfield%>";  //发文主体
var gwlb = "<%=gwlbfield%>";  //公文类别
var zdlb = "<%=zdlbfield%>";  //制度类别
var jdlb = "<%=jdlbfield%>";  //决定类别
/*
	等于运营中心  + 常规制度  是  是否总裁审批必填
<option value="0">运营中心
<option value="1">制品贸易中心
<option value="2">银天下事业部
<option value="3">银如意事业部
<option value="4">金兜事业部
<option value="6">丰华中心
<option value="7">大象事业部
<option value="8">金大师事业部
<option value="9">银科控股
*/

var visibleSystemObj = {
	'zt_0':[{ id : "0" , name : "常规制度" },{ id : "1" , name : "基础制度" }],
	'zt_1':[{ id : "0" , name : "常规制度" }],
	'zt_2':[{ id : "0" , name : "常规制度" }],
	'zt_3':[{ id : "0" , name : "常规制度" }],
	'zt_4':[{ id : "0" , name : "常规制度" }],
	'zt_6':[{ id : "0" , name : "常规制度" }],
	'zt_7':[{ id : "0" , name : "常规制度" }],
	'zt_8':[{ id : "0" , name : "常规制度" }],
	'zt_9':[{ id : "0" , name : "常规制度" },{ id : "1" , name : "基础制度" }],
	'zt_10':[{ id : "0" , name : "常规制度" }]
}

var visibleFwclbmObj = {
	'zt_0':[{ id : "0" , name : "总裁办" },{ id : "1" , name : "人力资源部" },{ id : "2" , name : "合规部" },{ id : "4" , name : "财务部" },{ id : "5" , name : "流程部" }],
	'zt_1':[{ id : "0" , name : "总裁办" },{ id : "1" , name : "人力资源部" },{ id : "2" , name : "合规部" },{ id : "3" , name : "董事办公室" },{ id : "4" , name : "财务部" }],
	'zt_2':[{ id : "0" , name : "总裁办" },{ id : "1" , name : "人力资源部" },{ id : "2" , name : "合规部" },{ id : "3" , name : "董事办公室" },{ id : "4" , name : "财务部" }],
	'zt_3':[{ id : "0" , name : "总裁办" },{ id : "1" , name : "人力资源部" },{ id : "2" , name : "合规部" },{ id : "3" , name : "董事办公室" },{ id : "4" , name : "财务部" }],
	'zt_4':[{ id : "0" , name : "总裁办" },{ id : "1" , name : "人力资源部" },{ id : "2" , name : "合规部" },{ id : "3" , name : "董事办公室" },{ id : "4" , name : "财务部" }],
	'zt_6':[{ id : "0" , name : "总裁办" },{ id : "1" , name : "人力资源部" },{ id : "2" , name : "合规部" },{ id : "3" , name : "董事办公室" },{ id : "4" , name : "财务部" }],
	'zt_7':[{ id : "0" , name : "总裁办" },{ id : "1" , name : "人力资源部" },{ id : "2" , name : "合规部" },{ id : "3" , name : "董事办公室" },{ id : "4" , name : "财务部" }],
	'zt_8':[{ id : "0" , name : "总裁办" },{ id : "1" , name : "人力资源部" },{ id : "2" , name : "合规部" },{ id : "3" , name : "董事办公室" },{ id : "4" , name : "财务部" }],
	'zt_9':[{ id : "0" , name : "总裁办" },{ id : "3" , name : "董事办公室" }],
	'zt_10':[{ id : "0" , name : "总裁办" },{ id : "1" , name : "人力资源部" },{ id : "2" , name : "合规部" },{ id : "3" , name : "董事办公室" },{ id : "4" , name : "财务部" }]
}

var visibleGwlbObj = {
	'zt_0':[{ id : "0" , name : "制度" },{ id : "1" , name : "通知" },{ id : "2" , name : "决定" },{ id : "3" , name : "纪要" },{ id : "5" , name : "批复" }],
	'zt_1':[{ id : "0" , name : "制度" },{ id : "1" , name : "通知" },{ id : "2" , name : "决定" },{ id : "3" , name : "纪要" },{ id : "4" , name : "请示" },{ id : "5" , name : "批复" },{ id : "6" , name : "报告" }],
	'zt_2':[{ id : "0" , name : "制度" },{ id : "1" , name : "通知" },{ id : "2" , name : "决定" },{ id : "3" , name : "纪要" },{ id : "4" , name : "请示" },{ id : "5" , name : "批复" },{ id : "6" , name : "报告" }],
	'zt_3':[{ id : "0" , name : "制度" },{ id : "1" , name : "通知" },{ id : "2" , name : "决定" },{ id : "3" , name : "纪要" },{ id : "4" , name : "请示" },{ id : "5" , name : "批复" },{ id : "6" , name : "报告" }],
	'zt_4':[{ id : "0" , name : "制度" },{ id : "1" , name : "通知" },{ id : "2" , name : "决定" },{ id : "3" , name : "纪要" },{ id : "4" , name : "请示" },{ id : "5" , name : "批复" },{ id : "6" , name : "报告" }],
	'zt_6':[{ id : "0" , name : "制度" },{ id : "1" , name : "通知" },{ id : "2" , name : "决定" },{ id : "3" , name : "纪要" },{ id : "4" , name : "请示" },{ id : "5" , name : "批复" },{ id : "6" , name : "报告" }],
	'zt_7':[{ id : "0" , name : "制度" },{ id : "1" , name : "通知" },{ id : "2" , name : "决定" },{ id : "3" , name : "纪要" },{ id : "4" , name : "请示" },{ id : "5" , name : "批复" },{ id : "6" , name : "报告" }],
	'zt_8':[{ id : "0" , name : "制度" },{ id : "1" , name : "通知" },{ id : "2" , name : "决定" },{ id : "3" , name : "纪要" },{ id : "4" , name : "请示" },{ id : "5" , name : "批复" },{ id : "6" , name : "报告" }],
	'zt_9':[{ id : "0" , name : "制度" },{ id : "1" , name : "通知" },{ id : "2" , name : "决定" },{ id : "3" , name : "纪要" },{ id : "5" , name : "批复" }],
	'zt_10':[{ id : "0" , name : "制度" },{ id : "1" , name : "通知" },{ id : "2" , name : "决定" },{ id : "3" , name : "纪要" },{ id : "4" , name : "请示" },{ id : "5" , name : "批复" },{ id : "6" , name : "报告" }]
}
jQuery(document).ready(function(){
         
		hideInit();//初始化隐藏行

	    jQuery("#"+gwlb).bindPropertyChange(function(){//公文类别 触发公文类别和制度类别的变化

	        gwlb_fun();//公文类别
			zdlb_fun();//制度类别
	    });
		jQuery("#"+zdlb).bindPropertyChange(function(){//制度类别 触发发文主体的变化

	        zcsp_fun();//是否总裁审批
	    });
		jQuery("#"+fwzt).bindPropertyChange(function(){//发文主体   
			fwclbm_fun();//发文处理部门
			gwlbInit();//公文类别
			zcsp_fun();//是否总裁审批
			zdlb_fun();//制度类别
			fwclbmInit();//发文处理部门下拉框值的初始化
		});
        jQuery("#"+jdlb).bindPropertyChange(function(){//决定类别    变动会引起任命级别变化	
			jdlb_fun();//决定类别
		});
		gwlb_fun();	//公文类别
		fwclbm_fun();//发文处理部门
		jdlb_fun();//决定类别
});

function hideInit(){

	    jQuery("#fwclbm").hide();//发文处理部门
	  	jQuery("#zd").hide();//制度类别
	    jQuery("#jd").hide();//决定类别
		jQuery("#jb").hide();//任命类别
	    jQuery("#jy").hide();//纪要类别
        jQuery("#zchq").hide();//是否总裁审批
}
function zcsp_fun(){ 
	var fwzt_v = jQuery("#"+fwzt).val();
	var zdlb_v = jQuery("#"+zdlb).val();

	if(fwzt_v!=''&&zdlb_v!=''){
		if(fwzt_v==0&&zdlb_v==0){
			jQuery("#zchq").show();
		}else{
			jQuery("#zchq").hide();
		}  
	}else{
		jQuery("#zchq").hide();
	}  
}

function fwclbm_fun(){
	var fwzt_v = jQuery("#"+fwzt).val();

	if(fwzt_v!=''&&fwzt_v==0){
		//fwclbmInit();
		jQuery("#fwclbm").show();
	}else if(fwzt_v==9){
		//fwclbmInit();
		jQuery("#fwclbm").show();
	}else{
		jQuery("#fwclbm").hide();
	}
}
//发文处理部门下拉框值的初始化
function fwclbmInit(){
	var fwztval = jQuery("#"+fwzt).val();

	if(fwztval == 9||fwztval == 0){
		jQuery("#"+fwclbm).empty();
		var keyStr = "zt_" + fwztval;
		var optionJsonArr = visibleFwclbmObj[keyStr];
		var optionStr0 = '<option value=""></option>';
		$("#"+fwclbm).append(optionStr0);
		for(var i = 0; i < optionJsonArr.length; i++){
			var optionObj = optionJsonArr[i];
			var optionStr = '<option value="'+ optionObj.id +'">'+ optionObj.name +'</option>';
			$("#"+fwclbm).append(optionStr);
		}
	}
}
//根据发文主体初始化公文类别
function gwlbInit(){

	var fwztval = jQuery("#"+fwzt).val();
	if(fwztval.length>0){
		jQuery("#"+gwlb).empty();
		var keyStr = "zt_" + fwztval;
		var optionJsonArr = visibleGwlbObj[keyStr];
		var optionStr0 = '<option value=""></option>';
		$("#"+gwlb).append(optionStr0);
		for(var i = 0; i < optionJsonArr.length; i++){
			var optionObj = optionJsonArr[i];
			var optionStr = '<option value="'+ optionObj.id +'">'+ optionObj.name +'</option>';
			$("#"+gwlb).append(optionStr);
		}
	 }
}
		
function gwlb_fun(){
	
	var gwlb_v = jQuery("#"+gwlb).val();
	 //制度
     if(gwlb_v==0&&gwlb_v!=''){ 
	    jQuery("#zd").show();
        jQuery("#jd").hide();
		jQuery("#jd").val('');
		jQuery("#jb").hide();
		jQuery("#jb").val('');
        jQuery("#jy").hide();
        jQuery("#jy").val('');
		jQuery("#zchq").show();

     }else if(gwlb_v==1){ //通知
	    jQuery("#zd").hide();
		jQuery("#zd").val('');
        jQuery("#jd").hide();
		jQuery("#jd").val('');
		jQuery("#jb").hide();
		jQuery("#jb").val('');
        jQuery("#jy").hide();
        jQuery("#jy").val('');
		jQuery("#zchq").hide();
		jQuery("#zchq").val("");
		
    }else if(gwlb_v==2){ //决定
	    jQuery("#zd").hide();
		jQuery("#zd").val('');
        jQuery("#jd").show();
		jQuery("#jb").hide();
		jQuery("#jb").val('');
        jQuery("#jy").hide();
        jQuery("#jy").val('');
		jQuery("#zchq").hide();
		jQuery("#zchq").val("");
		
    }else if(gwlb_v==3){ //纪要
	    jQuery("#zd").hide();
		jQuery("#zd").val('');
        jQuery("#jd").hide();
		jQuery("#jd").val('');
		jQuery("#jb").hide();
		jQuery("#jb").val('');
	    jQuery("#jy").show();
		//jQuery("#hq").show();
    } else{
        jQuery("#zd").hide();
		jQuery("#zd").val('');
        jQuery("#jd").hide();
		jQuery("#jd").val('');
		jQuery("#jb").hide();
		jQuery("#jb").val('');
        jQuery("#jy").hide();
        jQuery("#jy").val('');
		jQuery("#zchq").hide();
		jQuery("#zchq").val("");
    }  
}

function zdlb_fun(){
	var fwztval = jQuery("#"+fwzt).val();

	if(fwztval.length > 0){
		jQuery("#"+zdlb).empty();
		var keyStr = "zt_" + fwztval;
		var optionJsonArr = visibleSystemObj[keyStr];
		var optionStr0 = '<option value=""></option>';
		$("#"+zdlb).append(optionStr0);
		for(var i = 0; i < optionJsonArr.length; i++){
			var optionObj = optionJsonArr[i];
			var optionStr = '<option value="'+ optionObj.id +'">'+ optionObj.name +'</option>';
			$("#"+zdlb).append(optionStr);
		}
	}
}
//根据决定类别控制任命级别是否显示
function jdlb_fun(){
	var jdlb_v = jQuery("#"+jdlb).val();
	if(jdlb_v!=''&&jdlb_v==0){
		
	    jQuery("#jb").show();
    }else if(jdlb_v==1){ 

		jQuery("#jb").hide();	
		jQuery("#"+rmjbfield).val('');
    }else if(jdlb_v==2){ 
	  
		jQuery("#jb").hide();
		jQuery("#"+rmjbfield).val('');
    }else{ 
		jQuery("#jb").hide();
		jQuery("#"+rmjbfield).val('');
    }
}
</script>