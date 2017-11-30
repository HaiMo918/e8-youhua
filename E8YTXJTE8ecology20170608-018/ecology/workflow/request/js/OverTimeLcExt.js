var sqr = "field6627";//申请人
var jbksrq = "field6633";//加班开始日期
var jbjsrq = "field6636";//加班结束日期
var jbsc = "field6639";//共计加班
var bykyjbsc = "field6642";//可用加班时长

jQuery(document).ready(function(){
    checkCustomize =  function(){  		
        if(calDateTime()){
			if(getJbDb()){
				return checkJbsc();
			}		  
        }
    }
	jQuery("#"+sqr).bindPropertyChange(function(){
         getJbZj();
    });
	jQuery("#"+jbksrq).bindPropertyChange(function(){
         getJbZj();
    });
	getJbZj();
});


//计算时间差
function calDateTime(){
	
     var jbksrq_v = jQuery("#"+jbksrq).val();
     var jbjsrq_v = jQuery("#"+jbjsrq).val();

     if(jbksrq_v != null && jbksrq_v != "" && jbjsrq_v != null && jbjsrq_v != ""){
         if(jbjsrq_v < jbksrq_v){
              alert("加班结束日期不能早于加班开始日期！");
              return false;
         }
         return true;
     }  
}

function getJbZj(){
	
	var sqr_v = jQuery("#"+sqr).val();
    var ksrq_v = jQuery("#"+jbksrq).val();

	if(sqr_v!=null&&sqr_v!=''&&ksrq_v!=''){
		jQuery.ajax({
			type: "post",
			url: "/workflow/request/js/OverTimeExtJS.jsp",
			data:{"sqr":sqr_v,"ksrq":ksrq_v}, 
			success: function(msg){
				msg = msg.replace(/\n/g,"").replace(/\r/g,"");
				eval('var obj ='+msg);
				var jbky_v = obj.JBKY;//加班可用小时数
              
				jQuery("#"+bykyjbsc).val(jbky_v);
				jQuery("#"+bykyjbsc+"span").html(jbky_v);			
			}
		});	    
	}
}
function getJbDb(){
	var bykyjbsc_v = jQuery("#"+bykyjbsc).val()*1.0;
	var jbsc_v = jQuery("#"+jbsc).val()*1.0;
	if(jbsc_v > bykyjbsc_v){
		  alert("加班月份可申请小时数剩余"+bykyjbsc_v+"小时！");
		  return false;
	}
	return true;
}
function checkJbsc(){
	var jbsc_v = jQuery("#"+jbsc).val();
	if(jbsc_v>=1){
		if(jbsc_v%1==0){			
			return true;
		}else{
			alert("加班申请时长最小单位为1小时！");
			return false;
		}
	}else{
		alert("加班申请时长最小单位为1小时！");
		return false;
	}	
}
		