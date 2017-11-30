var _field_resourceId = "field6673";//申请人id
var _field_qjlx  = "field6677";//nj 1 tx 0

var _field_jytx = "field10231";//上一年结余调休小时数
var _field_dntx = "field10232";//今年可用调休小时数
var _field_kytx = "field10233";//今年可请调休小时数
var _field_djtx = "field10234";//冻结调休数

var _field_jynj = "field10230";//结余年假
var _field_dnnj = "field9102";//今年可用年假小时数 
var _field_kynj = "field9103";//今年可请年假小时数    
var _field_djnj = "field9104";//年假冻结值 

var _field_qjsc = "field6683";//请假时长 

jQuery(document).ready(function(){

    jQuery("#"+_field_resourceId).bindPropertyChange(function(){
		var qjType1 = jQuery("#"+_field_qjlx).val();
		IsShow(qjType1);
		initAnnualInfo();
	});	
	jQuery("#"+_field_qjlx).bindPropertyChange(function(){
		var qjType2 = jQuery("#"+_field_qjlx).val();
		IsShow(qjType2)
		initAnnualInfo();
	});

	var qjType = jQuery("#"+_field_qjlx).val();
	IsShow(qjType)
	initAnnualInfo();//初始化年假
	checkCustomize = function (){
		var qjType = jQuery("#"+_field_qjlx).val();	
		if(qjType == 1){
			return njFunction(); 
		}else if(qjType == 0){
			return txFunction(); 
		}else{	
			return true;
		}
	}
});
function IsShow(qjlx){
	if(qjlx==1){
		jQuery(".nj").show();
		jQuery(".tx").hide();
	}else if(qjlx==0){
		jQuery(".nj").hide();
		jQuery(".tx").show();
	}else{
		jQuery(".nj").hide();
		jQuery(".tx").hide();
	}
}

//年假的可用时长和申请时长作对比
function njFunction(){
	var ckqnj_v = jQuery("#"+_field_kynj).val();//当年可用年假小时数
	var qjxhs_v = jQuery("#"+_field_qjsc).val();
	if(qjxhs_v>0){
		if(qjxhs_v<4){
			alert("请假小时数不能小于4小时");
			return false;
		}else{
			if(qjxhs_v%4==0){
				var njc = ckqnj_v - qjxhs_v;
				if(njc < 0){
					alert("请假小时数超过可用年假小时数！");
					return false;
				}
			}else{
				alert("请假小时数不能被4整除！");
				return false;
			}		
		}
	}
	return true;
}
function txFunction(){	
	var cktx_v = jQuery("#"+_field_kytx).val();//当年可请年假小时数
	var txxhs_v = jQuery("#"+_field_qjsc).val();//申请调休小时数

	var zz = /^\+?[1-9][0-9]*$/;　
	if(txxhs_v>0){

		if(txxhs_v<1){
			alert("请假小时数不能小于1小时");
			return false;
		}else{
			//alert(">>>>>:"+zz.test(txxhs_v));
			if(txxhs_v%1==0){
				var txc = cktx_v - txxhs_v;
				if(txc < 0){
					alert("调休小时数超过今年可请调休小时数！");
					return false;
				}
				return true;
			}else{
				alert("请假小时数为整数！");
				return false;
			}		
		}
	}else if(txxhs_v<0){
		alert("调休小时数不能小于1小时！");
		return false;
	}else{
		return true;
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
				url: "/workflow/request/js/qjlc60.jsp",
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
