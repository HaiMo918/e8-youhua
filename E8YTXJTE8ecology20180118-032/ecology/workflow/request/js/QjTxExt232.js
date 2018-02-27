var _field_resourceId = "field11618";//申请人id
var _field_qjlx  = "field11622";//nj 1 tx 0
var _field_qtqjlx  = "field11623";//其他请假类型

var _field_jytx = "field11648";//上一年结余调休小时数
var _field_dntx = "field11649";//今年可用调休小时数
var _field_kytx = "field11650";//今年可请调休小时数
var _field_djtx = "field11651";//冻结调休数

var _field_jynj = "field11647";//结余年假
var _field_dnnj = "field11638";//今年可用年假小时数 
var _field_kynj = "field11639";//今年可请年假小时数    
var _field_djnj = "field11640";//年假冻结值 

var _field_qjksrq = "field11624";
var _field_qjjsrq = "field11626";

var _field_syqxbj = "field16059";//剩余全薪病假时长

var _field_qjsc = "field11628";//请假时长 


jQuery(document).ready(function(){

    jQuery("#"+_field_resourceId).bindPropertyChange(function(){//监控人员变动事件
		var qjType1 = jQuery("#"+_field_qjlx).val();	
		IsShow(qjType1);

		if(qjType1==5){
			var ksrq_v = jQuery("#"+_field_qjksrq).val();//获取请假开始时间
			if(ksrq_v!=''){
				getQxbj();
			}		
		}
		
		var qtqjType1 = jQuery("#"+_field_qtqjlx).val();
		if(qtqjType1!=null&&qtqjType1!=''){		
			IsShow2(qtqjType1);
		}
		initAnnualInfo();
	});	
	
	jQuery("#"+_field_qjlx).bindPropertyChange(function(){//监控请假类型事件
		var qjType2 = jQuery("#"+_field_qjlx).val();
		IsShow(qjType2)
		initAnnualInfo();

		if(qjType2==5){
			var ksrq_v = jQuery("#"+_field_qjksrq).val();
			if(ksrq_v!=''){
				getQxbj();
			}		
		}
	});
    jQuery("#"+_field_qtqjlx).bindPropertyChange(function(){//监控其他请假类型事件
		var qtqjType2 = jQuery("#"+_field_qtqjlx).val();
		if(qtqjType2!=null&&qtqjType2!=''){
			IsShow2(qtqjType2);
		}
		initAnnualInfo();
	});	
	jQuery("#"+_field_qjsc).change(function(){	//监控请假时长是否符合规定
		var qjType = jQuery("#"+_field_qjlx).val();		

		if(qjType == 1){//年假
			njFunction(); 
		}else if(qjType == 0){//调休
			txFunction(); 
		}else if(qjType == 2){//事假
			sjFunction(); 
		}else if(qjType == 5){//全新病假
			bjFunction(); 
		}else if(qjType == 6){//试用期事假
			sjFunction();  
		}else if(qjType == 7){//转正期事假
			sjFunction();  
		}else if(qjType == 8){//试用期病假
			bjFunction(); 
		}else if(qjType == 9){//转正期病假
			bjFunction(); 
		}
	});
	jQuery("#"+_field_qjksrq).bindPropertyChange(function(){//监控请假时间事件
		var qjType2 = jQuery("#"+_field_qjlx).val();
		
		if(qjType2==5){
			var ksrq_v = jQuery("#"+_field_qjksrq).val();
			if(ksrq_v!=''){
				getQxbj();
			}		
		}		
	});	
	//浏览打开就开始加载的事件
	var qjType = jQuery("#"+_field_qjlx).val();
	IsShow(qjType)
	
	initAnnualInfo();//初始化年假
	/*
	checkCustomize = function (){
		var qjType = jQuery("#"+_field_qjlx).val();	
		if(checkTime()){
			if(qjType == 1){//年假
				return njFunction(); 
			}else if(qjType == 0){//调休
				return txFunction(); 
			}else if(qjType == 2){//事假
				return sjFunction(); 
			}else if(qjType == 3){//病假
				return bjFunction(); 
			}else{	
				return true;
			}
		}
	}
	*/
});
function IsShow(qjlx){
	if(qjlx==1){//年假
		jQuery(".nj").show();
		jQuery(".tx").hide();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").hide();
		jQuery(".syqbj").hide();
		jQuery(".zzqsj").hide();
		jQuery(".hj").hide();
		jQuery(".cj").hide();
		jQuery(".hlj").hide();
		jQuery(".sj").hide();
		jQuery(".cjj").hide();
	}else if(qjlx==0){//调休
		jQuery(".nj").hide();
		jQuery(".tx").show();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").hide();
		jQuery(".syqbj").hide();
		jQuery(".zzqsj").hide();
		jQuery(".hj").hide();
		jQuery(".cj").hide();
		jQuery(".hlj").hide();
		jQuery(".sj").hide();
		jQuery(".cjj").hide();
	}else if(qjlx==4){//其他带薪假
		jQuery(".nj").hide();
		jQuery(".tx").hide();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").hide();
		jQuery(".syqbj").hide();
		jQuery(".zzqsj").hide();
		jQuery(".hj").hide();
		jQuery(".cj").hide();
		jQuery(".hlj").hide();
		jQuery(".sj").hide();
		jQuery(".cjj").hide();
	}else if(qjlx==5){//全薪病假
		jQuery(".nj").hide();
		jQuery(".tx").hide();
		jQuery(".qxbj").show();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").hide();
		jQuery(".syqbj").hide();
		jQuery(".zzqsj").hide();
		jQuery(".hj").hide();
		jQuery(".cj").hide();
		jQuery(".hlj").hide();
		jQuery(".sj").hide();
		jQuery(".cjj").hide();
	}else if(qjlx==6){//试用期事假
		jQuery(".nj").hide();
		jQuery(".tx").hide();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").show();
		jQuery(".zzqbj").hide();
		jQuery(".syqbj").hide();
		jQuery(".zzqsj").hide();
		jQuery(".hj").hide();
		jQuery(".cj").hide();
		jQuery(".hlj").hide();
		jQuery(".sj").hide();
		jQuery(".cjj").hide();
	}else if(qjlx==7){//转正期事假
		jQuery(".nj").hide();
		jQuery(".tx").hide();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").hide();
		jQuery(".syqbj").hide();
		jQuery(".zzqsj").show();
		jQuery(".hj").hide();
		jQuery(".cj").hide();
		jQuery(".hlj").hide();
		jQuery(".sj").hide();
		jQuery(".cjj").hide();
	}else if(qjlx==8){//试用期病假
		jQuery(".nj").hide();
		jQuery(".tx").hide();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").hide();
		jQuery(".syqbj").show();
		jQuery(".zzqsj").hide();
		jQuery(".hj").hide();
		jQuery(".cj").hide();
		jQuery(".hlj").hide();
		jQuery(".sj").hide();
		jQuery(".cjj").hide();
	}else if(qjlx==9){//转正期病假
		jQuery(".nj").hide();
		jQuery(".tx").hide();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").show();
		jQuery(".syqbj").hide();
		jQuery(".zzqsj").hide();
		jQuery(".hj").hide();
		jQuery(".cj").hide();
		jQuery(".hlj").hide();
		jQuery(".sj").hide();
		jQuery(".cjj").hide();
	}
}
function IsShow2(qjlx){	
    if(qjlx==0){
		jQuery(".nj").hide();
		jQuery(".tx").hide();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").hide();
		jQuery(".hj").show();
		jQuery(".cj").hide();
		jQuery(".hlj").hide();
		jQuery(".sj").hide();
		jQuery(".cjj").hide();
	}else if(qjlx==1){
		jQuery(".nj").hide();
		jQuery(".tx").hide();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").hide();
		jQuery(".hj").hide();
		jQuery(".cj").show();
		jQuery(".hlj").hide();
		jQuery(".sj").hide();
		jQuery(".cjj").hide();
	}else if(qjlx==2){
		jQuery(".nj").hide();
		jQuery(".tx").hide();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").hide();
		jQuery(".hj").hide();
		jQuery(".cj").hide();
		jQuery(".hlj").show();
		jQuery(".sj").hide();
		jQuery(".cjj").hide();
	}else if(qjlx==3){
		jQuery(".nj").hide();
		jQuery(".tx").hide();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").hide();
		jQuery(".hj").hide();
		jQuery(".cj").hide();
		jQuery(".hlj").hide();
		jQuery(".sj").show();
		jQuery(".cjj").hide();
	}else if(qjlx==4){
		jQuery(".nj").hide();
		jQuery(".tx").hide();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").hide();
		jQuery(".hj").hide();
		jQuery(".cj").hide();
		jQuery(".hlj").hide();
		jQuery(".sj").hide();
		jQuery(".cjj").show();
	}else if(qjlx==5){
		jQuery(".nj").hide();
		jQuery(".tx").hide();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").hide();
		jQuery(".hj").hide();
		jQuery(".cj").hide();
		jQuery(".hlj").hide();
		jQuery(".sj").hide();
		jQuery(".cjj").hide();
	}else if(qjlx==6){
		jQuery(".nj").hide();
		jQuery(".tx").hide();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").hide();
		jQuery(".hj").hide();
		jQuery(".cj").hide();
		jQuery(".hlj").hide();
		jQuery(".sj").hide();
		jQuery(".cjj").hide();
	}else if(qjlx==7){
		jQuery(".nj").hide();
		jQuery(".tx").hide();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").hide();
		jQuery(".hj").hide();
		jQuery(".cj").hide();
		jQuery(".hlj").hide();
		jQuery(".sj").hide();
		jQuery(".cjj").hide();
	}else if(qjlx==8){
		jQuery(".nj").hide();
		jQuery(".tx").hide();
		jQuery(".qxbj").hide();
		jQuery(".syqsj").hide();
		jQuery(".zzqbj").hide();
		jQuery(".hj").hide();
		jQuery(".cj").hide();
		jQuery(".hlj").hide();
		jQuery(".sj").hide();
		jQuery(".cjj").hide();
	}
	
}
//提交时验证   请假结束日期不能小于开始日期
function checkTime(){
	var ksrq_l = jQuery("#"+_field_qjksrq).val();
	var jsrq_l = jQuery("#"+_field_qjjsrq).val();
	if(ksrq_l != '' && jsrq_l != ''){
		if(jsrq_l<ksrq_l){
			 alert("请假结束日期不能早于开始日期！");
             return false;
        }
        return true;
	}
}
//年假的可用时长和申请时长作对比
function njFunction(){
	var ckqnj_v = jQuery("#"+_field_kynj).val();//当年可用年假小时数
	var qjxhs_v = jQuery("#"+_field_qjsc).val();
	if(qjxhs_v>0){
		if(qjxhs_v<4){
			alert("年假最小单位为4小时,请重新填写");
			jQuery("#"+_field_qjsc).attr("value",'');
		    jQuery("#"+_field_qjsc+"span").html(" ");
			return false;
		}else{
			if(qjxhs_v%4==0){
				var njc = ckqnj_v - qjxhs_v;
				if(njc < 0){
					alert("年假小时数超过可用年假小时数,请重新填写！");
					jQuery("#"+_field_qjsc).attr("value",'');
					jQuery("#"+_field_qjsc+"span").html(" ");
					return false;
				}
					return true;
			}else{
				alert("年假最小单位为4小时,请重新填写！");
				jQuery("#"+_field_qjsc).attr("value",'');
				jQuery("#"+_field_qjsc+"span").html(" ");
				return false;
			}		
		}
	}
}
//调休
function txFunction(){	
	var cktx_v = jQuery("#"+_field_kytx).val();//当年可请年假小时数
	var txxhs_v = jQuery("#"+_field_qjsc).val();//申请调休小时数

	var zz = /^\+?[1-9][0-9]*$/;　
	if(txxhs_v>0){

		if(txxhs_v<1){
			alert("调休小时数不能小于1小时,请重新填写");
			jQuery("#"+_field_qjsc).attr("value",'');
		    jQuery("#"+_field_qjsc+"span").html(" ");
			return false;
		}else{
			if(txxhs_v%1==0){
				var txc = cktx_v - txxhs_v;
				if(txc < 0){
					alert("调休小时数超过今年可请调休小时数,请重新填写！");
					jQuery("#"+_field_qjsc).attr("value",'');
					jQuery("#"+_field_qjsc+"span").html(" ");
					return false;
				}
				return true;
			}else{
				alert("调休小时数为整数,请重新填写！");
				jQuery("#"+_field_qjsc).attr("value",'');
				jQuery("#"+_field_qjsc+"span").html(" ");
				return false;
			}		
		}
	}else if(txxhs_v<0){
		
		alert("调休小时数不能小于1小时,请重新填写！");
		jQuery("#"+_field_qjsc).attr("value",'');
		jQuery("#"+_field_qjsc+"span").html(" ");
		return false;
	}
}
//事假
function sjFunction(){
	var sjxss_v = jQuery("#"+_field_qjsc).val();
	if(sjxss_v<1){
		alert("事假最小申请单单位为1小时,请重新填写");
		jQuery("#"+_field_qjsc).attr("value",'');
		jQuery("#"+_field_qjsc+"span").html(" ");
		return false;
	}else{
		if(sjxss_v%1==0){
				return true;
		}else{
			alert("事假最小申请单单位为1小时,请重新填写！");
			jQuery("#"+_field_qjsc).attr("value",'');
			jQuery("#"+_field_qjsc+"span").html(" ");
			return false;
		}
	}
}
//病假、全薪病假
function bjFunction(){
	var bjxss_v = jQuery("#"+_field_qjsc).val();
	if(bjxss_v>0){
		if(bjxss_v<4){
			alert("病假最小申请单位为4小时,请重新填写！");
			jQuery("#"+_field_qjsc).attr("value",'');
			jQuery("#"+_field_qjsc+"span").html(" ");
			return false;
		}else{
			if(bjxss_v%4==0){
				return true;
			}else{
				alert("病假最小申请单位为4小时,请重新填写！");
				jQuery("#"+_field_qjsc).attr("value",'');
				jQuery("#"+_field_qjsc+"span").html(" ");
				return false;
			}		
		}
	}else if(bjxss_v<=0){
		alert("病假最小申请单位为4小时,请重新填写！");
		jQuery("#"+_field_qjsc).attr("value",'');
		jQuery("#"+_field_qjsc+"span").html(" ");
		return false;
	}
}
//初始化   当前员工的调休或者年假
function initAnnualInfo() {
	var resourceId_v = jQuery("#"+_field_resourceId).val();
	var qjType = jQuery("#"+_field_qjlx).val();
	
	if(resourceId_v!=''&&qjType!='') {
	    if(qjType==0||qjType==1){
			//alert("resourceId_v>>>>>>>>>>:"+resourceId_v+"&qjType>>>>>>>>>>>:"+qjType);
			jQuery.ajax({
				type: "post",
				url: "/workflow/request/js/qjlc153.jsp",
				cache:false,
			    //async:false,//同步   true 异步  不设置默认为异步
				//contentType:"application/x-www-form-urlencoded;charset=UTF-8",
				data:{"resourceId":resourceId_v,"qjType":qjType}, 
				success: function(msg){
					msg = msg.replace(/\n/g,"").replace(/\r/g,"");
					eval('var obj ='+msg);
					
					var qjType_v = obj.QjType;
					if(qjType_v==0){

						var yjtx_v = obj.JYTX;//上一年结余调休小时数 
						var dntx_v = obj.DNTX;//今年调休总小时数    
						var kytx_v = obj.KYTX;//可用调休总小时数
						var djtx_v = obj.DJTX;//调休冻结值

						var jytx_vt = parseFloat(yjtx_v).toFixed(2);//上一年结余调休小时数 
						var dntx_vt = parseFloat(dntx_v).toFixed(2);//今年可用调休小时数  
						var kytx_vt = parseFloat(kytx_v).toFixed(2);//今年可请年假小时数    
						var djtx_vt = parseFloat(djtx_v).toFixed(2);//调休冻结值

						jQuery("#"+_field_jytx).val(jytx_vt);
						jQuery("#"+_field_jytx+"span").html(jytx_vt);				
						jQuery("#"+_field_dntx).val(dntx_vt);
						jQuery("#"+_field_dntx+"span").html(dntx_vt);
						jQuery("#"+_field_kytx).val(kytx_vt);
						jQuery("#"+_field_kytx+"span").html(kytx_vt);
						jQuery("#"+_field_djtx).val(djtx_vt);
						jQuery("#"+_field_djtx+"span").html(djtx_vt);
					}

					if(qjType_v==1){

						var jynj_v = obj.JYNJ;//上一年结余年假小时数 
						var dnnj_v = obj.DNNJ;//今年可用年假小时数 
						var kynj_v = obj.KYNJ;//今年可请年假小时数    
						var djnj_v = obj.DJNJ;//年假冻结值

						var jynj_vt = parseFloat(jynj_v).toFixed(2);//上一年结余年假小时数
						var dnnj_vt = parseFloat(dnnj_v).toFixed(2);//今年可用年假小时数  
						var kynj_vt = parseFloat(kynj_v).toFixed(2);//今年可请年假小时数    
						var djnj_vt = parseFloat(djnj_v).toFixed(2);//年假冻结值

						jQuery("#"+_field_jynj).val(jynj_vt);
						jQuery("#"+_field_jynj+"span").html(jynj_vt);
						jQuery("#"+_field_dnnj).val(dnnj_vt);
						jQuery("#"+_field_dnnj+"span").html(dnnj_vt);
						jQuery("#"+_field_kynj).val(kynj_vt);
						jQuery("#"+_field_kynj+"span").html(kynj_vt);									
						jQuery("#"+_field_djnj).val(djnj_vt);
						jQuery("#"+_field_djnj+"span").html(djnj_vt);
					}
				}
			});
		}
	}
}

//获取全新病假的小时数
function getQxbj(){
	var resourceId_v = jQuery("#"+_field_resourceId).val();
	var field_qjksrq = jQuery("#"+_field_qjksrq).val();
	var qjType = jQuery("#"+_field_qjlx).val();
	
	if(resourceId_v!=''&&qjType!='') {
	    if(qjType==5){

			jQuery.ajax({
				type: "post",
				url: "/workflow/request/js/qjlc60.jsp",
				cache:false,
			    //async:false,//同步   true 异步  不设置默认为异步
				//contentType:"application/x-www-form-urlencoded;charset=UTF-8",
				data:{"resourceId":resourceId_v,"qjType":qjType,"qjksrq":field_qjksrq}, 
				success: function(msg){
					msg = msg.replace(/\n/g,"").replace(/\r/g,"");
					eval('var obj ='+msg);
					
					var qjType_v = obj.QjType;

					if(qjType_v==5){

						var qxbj_v = obj.QXBJ;//全薪病假
						var qxbj_vt = parseFloat(qxbj_v).toFixed(2);//

						jQuery("#"+_field_syqxbj).val(qxbj_vt);
						jQuery("#"+_field_syqxbj+"span").html(qxbj_vt);
					}
				}
			});
		}
	}
}