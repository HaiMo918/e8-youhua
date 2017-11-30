var beginDate = "field8616";//预计培训开始日期
var endDate = "field8617";//预计培训结束日期
var iscg = "field11578";//培训时间是否超过30天

jQuery(document).ready(function(){  
    

	jQuery("#"+beginDate).bindPropertyChange(function(){//预计培训开始日期
		
		voluation();
	});
	jQuery("#"+endDate).bindPropertyChange(function(){//预计培训结束日期
		
		voluation();
	});
	
});

function voluation(){
	var beginVal = jQuery("#"+beginDate).val();
	var endVal = jQuery("#"+endDate).val();
	var days=0;
	if(beginVal!=''&&endVal!=''){
		days = DateDiff(beginVal,endVal);
		if(days>30||days==30){
			jQuery("#"+iscg).val('0');
		}else{
			jQuery("#"+iscg).val('1');
		}
	}	
}
//计算天数差的函数，通用  
   function  DateDiff(sDate1,  sDate2){    //sDate1和sDate2是2002-12-18格式  
       var  aDate,  oDate1,  oDate2,  iDays  
       aDate  =  sDate1.split("-");  
       oDate1  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0]);    //转换为12-18-2002格式  
       aDate  =  sDate2.split("-"); 
       oDate2  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0]);  
       iDays  =  parseInt(Math.abs(oDate1  -  oDate2)  /  1000  /  60  /  60  /24);   //把相差的毫秒数转换为天数  
       return  iDays;  
   }
