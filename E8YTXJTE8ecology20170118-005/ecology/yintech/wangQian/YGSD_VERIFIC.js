var	jyzh		  = "field10353";	//交易账号.
var dkyhzh 	      = "field10366";	//打款银行账号 .

var jysxfsq1 	  = "field10386";	//交易手续费收取万分之.
var zhjysxfsq     = "field10384";	//综合会员收取手续费万分之.
var jyyqfysq      = "field10387";	//交易延期费收取万分之 .
var  crjjz        = "field10370";	//累计出入金净值不低于 正整数，默认为空 .

var special		  = "field10374"; //是否特批 0-是,1-否 .
var exceed	      = "field10375"; //是否超限 0-是,1-否 .
var	scjyrq		  = "field10359"; //首次交易日期 .
var subDateId	  = "field10351"; //协议提交日期 .	

var name 			  =  "field10354";		//客户姓名
var cardNumbe		  =  "field10355";		//身份证编号
var customerId		  =	 "field10356";		//客户ids
var exchange		  =  "field10357";		//所属交易所
var company			  =  "field10358";		//所属公司
var tradeDate		  =  "field10359";		//首次交易日期 .
var bank			  =	 "field10361";		//开户绑定银行开户行.
var bindBankCard 	  =  "field10362";		//开户绑定银行账号/卡号.
var remittBank 		  =	 "field10363";		//打款银行开户行.
var remittBankCard    =  "field10366";  	//打款银行账号/卡号.
var isBindBankAlike   =  "field10367";		//打款银行是否与绑定银行账号/卡号相同
var isNewCstm		  =  "field10360";		//是否新客户 .

var jyssxfZH          = "field10389";		//交易所手续费
var zhhysxfZH         = "field10388";		//综合会员手续费
var jyyqsxfZH		  = "field10391";		//交易延期手续费
var crjZH			  = "field10390";		//出入金

var beginDate 		  = "field10368";       //开始日期
var beginDateInput    = "field10383";		//开始日期中文表单
var beginDateSpan     = "field10383span";	//开始日期显示
var endDate 		  = "field10369"; 	    //结束日期
var endDateInput      = "field10385";	    //结束日期中文表单
var endDateSpan       = "field10385span";	//结束日期显示

var nameZhVal 		  = "field10393";		//姓名中文表单值
var nameZhSpan 	      = "field10393span";	//姓名中文显示
var errorImgStr = '<img align="absMiddle" src="/images/BacoError.gif" complete="complete"/>';    //表单不能为空的图片
var pageObj = {   //页面对象   系统当前月份，和客户记录信息
		thisMonth:"thisMonth",
		customer:{   									//客户信息模板
			name					: '',   							//客户姓名
			cardNumbe			: '', 		//身份证编号
			customerId			: '',								//客户id
			exchange				: '',										//所属交易所
			company				: '',											//所属公司
			tradeDate			: '',							//首次交易日期
			bank					    : '',							//开户绑定银行开户行
			bindBankCard      : '',		//开户绑定银行账号/卡号
			remittBank 		    : '',							//开户绑定银行账号/卡号
			remittBankCard   : '',  	//打款银行开户行
			companyCode     : ''
		},
		getCustomerAndMonth : function(tradeNum){ //加载月份和客户数据 
			pageObj.showmyBox();  //加载之前防止继续操作
			jQuery.ajax({
				type: "post",
				url: "/yintech/wangQian/GetData.jsp",
				async : false,
				contentType:"application/x-www-form-urlencoded;charset=UTF-8",
				data:{"tradeNum":tradeNum},
				dataType:"json",
				success: function(data){
					//alert("tradeNum : " + tradeNum + ";       month : " +data.thisMonth + ";   customerInfo : " + data.customerInfo.name);
					pageObj.thisMonth = data.thisMonth;
					if(data.customerInfo != undefined){
						pageObj.customer  = data.customerInfo;
					}
					pageObj.setCostomerToPage();
					
					pageObj.closeBox();
				}
			});
		},
		setCostomerToPage:function(){ //交易账号不为空就把返回的用户信息，填写到页面上

			jQuery("#" + name).val(pageObj.customer.name);
			jQuery("#" + name +"span").html(pageObj.customer.name);
			jQuery("#" + cardNumbe).val(pageObj.customer.cardNumbe);
			if(pageObj.customer.cardNumbe.length > 0){
				jQuery("#" + cardNumbe+"span").empty();
			}

			//jQuery("#" + "field14984span").empty();
			//jQuery("#" + cardNumbe +"span").html(pageObj.customer.cardNumbe);
			jQuery("#" + customerId).val(pageObj.customer.customerId);
			jQuery("#" + customerId +"span").html(pageObj.customer.customerId);
			jQuery("#" + exchange).val(pageObj.customer.exchange);
			jQuery("#" + exchange +"span").html(pageObj.customer.exchange);
			jQuery("#" + company).val(pageObj.customer.companyCode);
			jQuery("#" +"dis" +  company ).val(pageObj.customer.companyCode);
			jQuery("#" + tradeDate).val(pageObj.customer.tradeDate);
			jQuery("#" + tradeDate +"span").html(pageObj.customer.tradeDate);
			jQuery("#" + bank).val(pageObj.customer.bank);
			jQuery("#" + bank +"span").html(pageObj.customer.bank);
			jQuery("#" + bindBankCard).val(pageObj.customer.bindBankCard);
			jQuery("#" + bindBankCard +"span").html(pageObj.customer.bindBankCard);
			jQuery("#" + remittBank).val(pageObj.customer.remittBank);
			if(pageObj.customer.remittBank.length > 0){
				jQuery("#" + remittBank+"span").empty();
			}
			jQuery("#" + remittBankCard).val(pageObj.customer.remittBankCard);
			if(pageObj.customer.remittBankCard.length > 0){
				jQuery("#" + remittBankCard+"span").empty();
			}
			
			computeObj.isBankAlike();  //开户绑定银行开户行  ，开户绑定银行开户行账号，  会影响”是否与开户绑定相同“ 字段
			computeObj.change();		//首次交易日期会影响是否超限或特批
			computeObj.isNewCustomer();   //首次交易日期会影响是否
			
		},
		showmyBox : function(){
			if ($("#myboxbg").length > 0){ 
				jQuery("#myboxbg").css("display","block");
				jQuery("#myboxtxt").css("display","block");
			}else{
				var boxleft = (jQuery(document).width() -  300) / 2;
				var boxHeight = jQuery(document).height() + 300;
				//alert(boxHeight);
				var boxStr  = '<div id="myboxbg" style=" position:absolute; top:0px; left:0px; z-index:1000; height:'+ boxHeight +'px; width:100%; background-color:#000; filter:alpha(Opacity=30);-moz-opacity:0.5;opacity: 0.5;"  ></div>'; 
						boxStr +='';
						boxStr += '<div id="myboxtxt" style=" position:absolute; top:40%; left:'+ boxleft +'px; background-color:#fff; border:#FFF; text-align:center; width:300px; height:40px; line-height:40px; font-weight:bold; z-index:9999;" >'; 
						boxStr += '正在加载系统资源，请稍后！';
						boxStr += '</div>'
				jQuery("body").append(boxStr);
			}
		},
		closeBox : function(){
			jQuery("#myboxbg").css("display","none");
			jQuery("#myboxtxt").css("display","none");
		},
		pageInit : function(){
			var val = jQuery("#"+jysxfsq1).val(); //交易手续费收取万分之
			computeObj.change();
			var numStr = NoToChinese(val);
			jQuery("#"+jyssxfZH).val(numStr);
			jQuery("#"+jyssxfZH +"span").html(numStr);
			
			var val2 = jQuery("#"+jyyqfysq).val();    //交易延期费收取万分之   
			var numStr = NoToChinese(val2);
			jQuery("#"+jyyqsxfZH).val(numStr);
			jQuery("#"+jyyqsxfZH +"span").html(numStr);
		}
}
function checkIsO(){
	
	
	var scjyrq_v = jQuery("#"+scjyrq).val();//首次交易日期 .
	var subDateId_v = jQuery("#"+subDateId).val();//协议提交日期 .
	//alert("1>>>>>>:"+scjyrq_v+";>>>>>>>>>:"+subDateId_v);
	var beforeSubDateId = getMonthBefore(subDateId_v,3);

	var beforeSub    =  strParseDate(beforeSubDateId);
	var scjyrqStr    =  strParseDate(scjyrq_v);
    
	if(beforeSub.getTime()>scjyrqStr.getTime()){//如何协议提交日期-3>首次交易日期  可以申请奖励流程
		//alert("2>>>>>>:"+beforeSub.getTime()+";>>>>>>>>>:"+scjyrqStr.getTime());
		return true;
	}else{//反之，提醒走优惠流程	
		alert("新客户请选择优惠协议不能提交奖励协议！");
		return false;
	}	
	
}
jQuery(document).ready(function(){
	//1.根据交易账号获取信息
	//2.初始化表单
	//3.绑定字段校验条件
	
	pageObj.pageInit();
	checkCustomize = function(){//提交验证流程	 
		//var workflowid = document.getElementById("workflowid").value;
		//if(workflowid==442){
		//	checkIsO();
		//}else{
		//	return true;
		//}		
	}

	jQuery("#"+beginDate).bindPropertyChange(function(){//优惠开始日期
		var beginVal = jQuery("#"+beginDate).val();
		//alert(beginVal);
		if(beginVal != undefined && beginVal.length > 0){
			var str =  getMonthZH(beginVal);
			 jQuery("#"+beginDateInput).val(str);
			 jQuery("#"+beginDateSpan).html(str);
		}
		
		var isNewVal = jQuery("#"+isNewCstm).val();
		var endVal = jQuery("#"+endDate).val();
		//alert("isNewVal : " + isNewVal +";		  beginVal : " + beginVal+";		  endVal : " + endVal);
		if(( beginVal != undefined  &&  beginVal.length > 0) && ( endVal != undefined  &&   endVal.length > 0)){
			if(isNewVal == 0){			//新客户限制
				if(judgementMonth()){
					var beforeDateStr = getMonthBefore(endVal,3);
					var beforeDate    =  strParseDate(beforeDateStr);
					var beginDateObj    =  strParseDate(beginVal);
					if(beginDateObj.getTime() <  beforeDate.getTime()){
						alert("优惠协议有效期截止时间必须在三个月之内");
						 jQuery("#"+endDate).val("");
						 jQuery("#"+endDate +"span").html("");
					}
				}
			}else{
				var beforeDateStr = getMonthBefore(endVal,12);
				var beforeDate    =  strParseDate(beforeDateStr);
				var beginDateObj    =  strParseDate(beginVal);
				if(beginDateObj.getTime() <  beforeDate.getTime()){
					alert("优惠协议有效期截止时间必须在一年之内");
					 jQuery("#"+endDate).val("");
					 jQuery("#"+endDate +"span").html("");
				}
			}
		}
	});
	
	jQuery("#"+endDate).bindPropertyChange(function(){//优惠结束日期
		var endVal = jQuery("#"+endDate).val();
		if( endVal != undefined  &&   endVal.length > 0){
			var str =  getMonthZH(endVal);
			 jQuery("#"+endDateInput).val(str);
			 jQuery("#"+endDateSpan).html(str);
		}
		
		var isNewVal = jQuery("#"+isNewCstm).val();
		var beginVal = jQuery("#"+beginDate).val();
		//alert("isNewVal : " + isNewVal +";		  beginVal : " + beginVal);
		if(( beginVal != undefined  &&  beginVal.length > 0) && ( endVal != undefined  &&   endVal.length > 0)){
			if(strParseDate(beginVal).getTime() > strParseDate(endVal).getTime()){
				alert("优惠协议结束日期必须大于开始日期！");
				jQuery("#"+endDate).val("");
			        jQuery("#"+endDate +"span").html("");
			}
			if(isNewVal == 0){			//新客户限制
				if(judgementMonth()){
					var beforeDateStr = getMonthBefore(endVal,3);
					var beforeDate    =  strParseDate(beforeDateStr);
					var beginDateObj    =  strParseDate(beginVal);
					if(beginDateObj.getTime() <  beforeDate.getTime()){
						alert("优惠协议有效期截止时间必须在三个月之内");
						 jQuery("#"+endDate).val("");
						 jQuery("#"+endDate +"span").html("");
					}
				}
			}else{
				var beforeDateStr = getMonthBefore(endVal,12);
				var beforeDate    =  strParseDate(beforeDateStr);
				var beginDateObj    =  strParseDate(beginVal);
				if(beginDateObj.getTime() <  beforeDate.getTime()){
					alert("优惠协议有效期截止时间必须在一年之内");
					 jQuery("#"+endDate).val("");
					 jQuery("#"+endDate +"span").html("");
				}
			}
		}
	});

	//验证2月份只有28天或者29天
	function judgementMonth(){
		var beginVal = jQuery("#"+beginDate).val();
		var endVal = jQuery("#"+endDate).val();

		var beginStr = beginVal.substring(0,4);
		var endStr = endVal.substring(0,4);
		var beginMonth = beginVal.substring(5,10);
		var endMonth = endVal.substring(5,10);
        var temp1 = "02-28";
		var temp2 = "03-01";
		var temp3 = "03-02";
		var temp4 = "05-29";
		var temp5 = "05-30";
		var temp6 = "05-31";
		if(beginStr==endStr){
			if(beginMonth!=temp1&&beginMonth!=temp2&&beginMonth!=temp3){
		         return true;
			}else{
			    if(beginMonth.toString()==temp1.toString()){
					if(endMonth.toString()==temp4.toString()){
						return false;
					}else if(endMonth.toString()==temp5.toString()){
						return false;
					}else if(endMonth.toString()==temp6.toString()){
					    return false;
					}else{
					    return true;
					}
				}else if(beginMonth.toString()==temp2.toString()){
					if(endMonth.toString()==temp5.toString()){
						return false;
					}else if(endMonth.toString()==temp6.toString()){
					    return false;
					}else{
						return true;
					}
				}else if(beginMonth.toString()==temp3.toString()){
					if(endMonth.toString()==temp6.toString()){
						return false;
					}else{
					    return true;
					}
				}			
			}
		}	
		//return true;
	}
	jQuery("#"+name).bindPropertyChange(function(){//客户姓名
		var val = jQuery("#"+name).val();
		 jQuery("#"+nameZhVal).val(val);
		 jQuery("#"+nameZhSpan).html(val);
	});
	
	
	jQuery("#"+jysxfsq1).change(function(){//交易所手续费奖励比例    (0,100]，最小变更单位25
		var val = jQuery("#"+jysxfsq1).val();
		var isPositiveNum = computeObj.isPositiveNum(  val / 5);
		if((val < 0 || val > 100)  ||  !isPositiveNum){
			jQuery("#"+jysxfsq1).val("");
			jQuery("#"+jyssxfZH).val("");
			jQuery("#"+jyssxfZH +"span").html("");
			alert("交易所手续费奖励比例    (0,100]，最小变更单位5");
		}else{
			computeObj.change();
			var numStr = NoToChinese(val);
			jQuery("#"+jyssxfZH).val(numStr);
			jQuery("#"+jyssxfZH +"span").html(numStr);
		}
	});
	
	
	var zhjysxfsq_v = jQuery("#"+zhjysxfsq).val();	

	if(zhjysxfsq_v>0||zhjysxfsq_v==0){

		computeObj.change();
		var numStr = NoToChinese(zhjysxfsq_v);
		jQuery("#"+zhhysxfZH).val(numStr);
		jQuery("#"+zhhysxfZH +"span").html(numStr);
    }
	
	jQuery("#"+zhjysxfsq).change(function(){// 会员手续费优惠比例   (0,100]，最小变更单位5
		var val = jQuery("#"+zhjysxfsq).val();
		if((val < 0 || val > 100)  ||  !computeObj.isPositiveNum(  val / 5) ){
			jQuery("#"+zhjysxfsq).val("");
			jQuery("#"+zhhysxfZH).val("");
			jQuery("#"+ zhhysxfZH + "span").val("");
			alert("会员手续费优惠比例  (0,100]，最小变更单位5");
		}else{
			computeObj.change();
			var numStr = NoToChinese(val);
			jQuery("#"+zhhysxfZH).val(numStr);
			jQuery("#"+zhhysxfZH +"span").html(numStr);
		}
	});
	
	jQuery("#"+jyyqfysq).change(function(){//交易延期费优惠比例  (0,100]，最小变更单位25
		var val = jQuery("#"+jyyqfysq).val();
		if((val <  0 || val > 100)  || !computeObj.isPositiveNum(  val / 5) ){
			jQuery("#"+jyyqfysq).val("");
			
			jQuery("#"+jyyqsxfZH).val("");
			jQuery("#"+jyyqsxfZH +"span").val("");
			alert("交易延期费优惠比例    (0,100]，最小变更单位5");
		}else{
			computeObj.change();
			var numStr = NoToChinese(val);
			jQuery("#"+jyyqsxfZH).val(numStr);
			jQuery("#"+jyyqsxfZH +"span").html(numStr);
		}
	});
	
	jQuery("#"+crjjz).change(function(){	//累计出入金净值不低于 正整数，默认为空
		var val = jQuery("#"+crjjz).val();
		//var reg = /^[1-9]+[0-9]*]*$/;
		var reg =/^-?[0-9]\d*$/;
		if(!reg.test(val)){
			jQuery("#"+crjjz).val("");
			jQuery("#"+crjZH).val("");
			jQuery("#"+crjZH +"span").val("");
			alert("累计出入金净值必须是正整数");
		}else{
			var numStr = NoToChinese(val);
			jQuery("#"+crjZH).val(numStr);
			jQuery("#"+crjZH +"span").html(numStr);
			computeObj.change();			
		}
	});
	
	jQuery("#"+jyzh).change(function(){			//交易账号 							15位正整数
		var val = jQuery("#"+jyzh).val();
		var reg = new RegExp("^[0-9]*$");
		if(!reg.test(val)  || val.length != 15){
			jQuery("#"+jyzh).val("");
			alert("交易账号必须是15位正整数");
		}else{
			//TODO 异步请求交易账号对应数据
			pageObj.getCustomerAndMonth(val);
		}
	});
	
	jQuery("#"+dkyhzh).change(function(){	//打款银行账号 全数字，无标点符号
		var val = jQuery("#"+dkyhzh).val();
		var reg = new RegExp("^[0-9]*$");
		if(!reg.test(val)){
			jQuery("#"+dkyhzh).val("");
			jQuery("#"+dkyhzh+"span").html(errorImgStr);
			alert("打款银行账号/卡号必须是全数字");	
		}
		computeObj.isBankAlike();
	});
	
	jQuery("#"+cardNumbe).change(function(){	// 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
		   var val = jQuery("#"+cardNumbe).val();
		   //var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
		   if(!computeObj.identityCodeValid(val)) {
		       jQuery("#"+cardNumbe).val("");
		       jQuery("#"+cardNumbe+"span").html(errorImgStr);
		   }
	});
	
	 jQuery("#"+ isNewCstm).bindPropertyChange(function(){				//是否新客户变更
			var isNewVal = jQuery("#"+isNewCstm).val();
			var beginVal = jQuery("#"+beginDate).val();
			var endVal = jQuery("#"+endDate).val();
			if(beginVal.length > 0 && endVal.length > 0){
				if(isNewVal == 0){			//新客户限制
					if(judgementMonth()){
						var beforeDateStr = getMonthBefore(endVal,3);
						var beforeDate    =  strParseDate(beforeDateStr);
						var beginDateObj    =  strParseDate(beginVal);
						if(beginDateObj.getTime() <  beforeDate.getTime()){
							alert("优惠协议有效期截止时间必须在三个月之内");
							 jQuery("#"+endDate).val("");
							 jQuery("#"+endDate +"span").html("");
						}
					}
				}else{
					var beforeDateStr = getMonthBefore(endVal,12);
					var beforeDate    =  strParseDate(beforeDateStr);
					var beginDateObj    =  strParseDate(beginVal);
				
					if(beginDateObj.getTime() <  beforeDate.getTime()){
						alert("优惠协议有效期截止时间必须在一年之内");
						 jQuery("#"+endDate).val("");
						 jQuery("#"+endDate +"span").html("");
					}
				}
			}
	});
	
	jQuery("#"+remittBank).change(function(){	//打款银行 变更判断是否与开户绑定银行相同
		computeObj.isBankAlike();
	});
	
	pageObj.getCustomerAndMonth('');   //页面加载阶段需要去获取服务器当前日期
	//pageObj.setCostomerToPage();
	
});

var computeObj = {
		change : function(){ // 以下值变动调用  "累计出入金净值(万元)"	| 交易所手续费奖励比例(%)	| 会员手续费优惠比例(%)	| 交易延期费优惠比例(%)
			
			//判断首次交易时间与当前日期的间隔 是否在三个月内
			var beforeDateStr = getMonthBefore(pageObj.thisMonth,3);
			var scjyVal = jQuery("#"+scjyrq).val();
			var scjyDate 		= strParseDate(jQuery("#" + tradeDate).val()); //首次交易日期
			var beforeDate   = strParseDate(beforeDateStr);
			//alert("beforeDateStr : " + beforeDateStr + ";      		 首次交易日期："+ jQuery("#" + tradeDate).val() +";   		是否三个月： " + (scjyDate.getTime()  >  beforeDate.getTime()));
			if(scjyDate.getTime()  >  beforeDate.getTime()){//三个月之内
				computeObj. isSpecial3();
			}else{
				computeObj.isSpecial();
			}
			
			computeObj.isExceed();
		},
		isSpecial3 : function(){   //判断是否总监特批    首次交易时间与当前日期的间隔,在三个月内 
			var crjjzVal	  =  jQuery("#"+crjjz).val();  		    //出入金值
			var sxfVal1 	  =  jQuery("#"+jysxfsq1).val();  	//交易所手续费奖励比例(%)
			var zhjysx2		 =  jQuery("#"+zhjysxfsq).val();  	//会员手续费优惠比例(%)
			var yqfVal	  =  jQuery("#"+jyyqfysq).val();   //延期费值
			//alert("crjjzVal : " + crjjzVal + ";    sxfVal1:"+sxfVal1 +";     zhjysx2:"+zhjysx2 + "; 	   yqfVal :"+yqfVal);
			var specialVal = false;
			var num = 0;
			if(yqfVal > 0 && yqfVal <= 100){
				specialVal = true;
				num = 1;
			}else if((sxfVal1 > 0 && sxfVal1 <= 100) && zhjysx2 == 100){
				specialVal = true;
				num = 2;
			}else if(sxfVal1 == 0 && yqfVal == 0){
				if((crjjzVal >= 0 && crjjzVal < 30) && (zhjysx2 > 0 && zhjysx2 <= 100)){
					specialVal = true;
					num = 3;
				}else if((crjjzVal >= 30 && crjjzVal < 50) && (zhjysx2 > 20 && zhjysx2 <= 100)){
					specialVal = true;
					num = 4;
				}else if((crjjzVal >= 50 && crjjzVal < 100) && (zhjysx2 > 40 && zhjysx2 <= 100)){
					specialVal = true;
					num = 5;
				}else if((crjjzVal >= 100 && crjjzVal < 200) && (zhjysx2 > 60 && zhjysx2 <= 100)){
					specialVal = true;
					num = 6;
				}else if((crjjzVal >= 200 && crjjzVal < 300) && (zhjysx2 > 80 && zhjysx2 <= 100)){
					specialVal = true;
					num = 6;
				}
			}
			//alert("num : "+ num  +";      specialVal : " + specialVal);
			if(specialVal){
				$("#" + special).val("0"); 
				$("#dis" + special).val("0");
			}else{
				$("#" + special).val("1"); 
				$("#dis" + special).val("1");
			}
		},
		isSpecial : function(){ //判断是否总监特批    三个月以上
			var crjjzVal	  =  jQuery("#"+crjjz).val();  		    //出入金值
			var sxfVal1 	  =  jQuery("#"+jysxfsq1).val();  	//交易所手续费奖励比例(%)
			var zhjysx2		 =  jQuery("#"+zhjysxfsq).val();  	//会员手续费优惠比例(%)
			var yqfVal	  =  jQuery("#"+jyyqfysq).val();   //延期费值
			//alert("crjjzVal : " + crjjzVal + ";    sxfVal1:"+sxfVal1 +";     zhjysx2:"+zhjysx2 + "; 	   yqfVal :"+yqfVal);
			var specialVal = false;
			var num = 0;
			if(yqfVal > 0 && yqfVal <= 100){
				specialVal = true;
				num = 1;
			}else if((sxfVal1 > 0 && sxfVal1 <= 100) && zhjysx2 == 100){
				specialVal = true;
				num = 2;
			}else if(sxfVal1 == 0 && yqfVal == 0){
				if((crjjzVal >= 0 && crjjzVal < 30) && (zhjysx2 > 0 && zhjysx2 <= 100)){
					specialVal = true;
					num = 3;
				}else if((crjjzVal >= 30 && crjjzVal < 50) && (zhjysx2 > 40 && zhjysx2 <= 100)){
					specialVal = true;
					num = 4;
				}else if((crjjzVal >= 50 && crjjzVal < 100) && (zhjysx2 > 60 && zhjysx2 <= 100)){
					specialVal = true;
					num = 5;
				}else if((crjjzVal >= 100 && crjjzVal < 200) && (zhjysx2 > 80 && zhjysx2 <= 100)){
					specialVal = true;
					num = 6;
				}
			}
			//alert("num : "+ num  +";      specialVal2 : " + specialVal);
			if(specialVal){
				$("#" + special).val("0"); 
				$("#dis" + special).val("0");
			}else{
				$("#" + special).val("1"); 
				$("#dis" + special).val("1");
			}
		},
		isExceed : function(){   //判断是否超限
			var sxfVal1 	  =  jQuery("#"+jysxfsq1).val();  	//交易所手续费奖励比例(%)
			var zhjysx2		 =  jQuery("#"+zhjysxfsq).val();  	//会员手续费优惠比例(%)
			var yqfVal	  =  jQuery("#"+jyyqfysq).val();   //延期费值
			
			var exceedVal = false;
			if((sxfVal1.length > 0 && zhjysx2.length > 0 ) &&  (sxfVal1 > 0 && sxfVal1 <= 100) && zhjysx2 == 100){
				exceedVal = true;
			}else if(yqfVal > 0 && yqfVal <= 100){
				exceedVal = true;
			}
			//alert( "yqfVal : " +yqfVal +  ";           isExceed : " + exceedVal);
			if(exceedVal){
				$("#" + exceed).val("0"); 
				$("#dis" + exceed).val("0");
			}else{
				$("#" + exceed).val("1"); 
				$("#dis" + exceed).val("1");
			}
		},
		isBankAlike : function(){
			var val1 = jQuery("#"+bank).val();
			var val2 = jQuery("#"+remittBank).val();
			var val3 = jQuery("#"+bindBankCard).val();
			var val4 = jQuery("#"+remittBankCard).val();
			var isAlike = false;
			
			if(val1.length <= 0 || val2.length <= 0 || val3.length <= 0 || val4.length <= 0 ){
				isAlike = false;
			}else if((val1 == val2)  && (val3 == val4)){
				isAlike = true;
			}else{
				isAlike = false;
			}
			//alert("绑定银行 ：" + val1 +";  	 打款银行 ：" + val2 +";      绑定银行账号：" +  val3 + ";        打款银行账号：" +val4 + ";      是否相同："+ isAlike);
			if(isAlike){
				jQuery("#"+isBindBankAlike).val("0");
				jQuery("#dis"+isBindBankAlike).val("0");
			}else{
				jQuery("#"+isBindBankAlike).val("1");
				jQuery("#dis"+isBindBankAlike).val("1");
			}
		},
		isNewCustomer  :  function(){
			var beforeDateStr = getMonthBefore( jQuery("#"+subDateId).val(),3);
			var tradeVal  =  jQuery("#" + tradeDate).val();
			var scjyVal = jQuery("#"+scjyrq).val();
			var scjyDate 		= strParseDate(jQuery("#" + tradeDate).val()); //首次交易日期
			var beforeDate   = strParseDate(beforeDateStr);
			//alert("beforeDateStr : " + beforeDateStr + ";      		 首次交易日期："+ jQuery("#" + tradeDate).val() +";   		是否三个月： " + (scjyDate.getTime()  >  beforeDate.getTime()));
			if(tradeVal.length <= 0){
				jQuery("#"+isNewCstm).val("0");
				jQuery("#dis"+isNewCstm).val("0");
			}else if(scjyDate.getTime()  >  beforeDate.getTime()){//三个月之内
				jQuery("#"+isNewCstm).val("0");
				jQuery("#dis"+isNewCstm).val("0");
			}else{
				jQuery("#"+isNewCstm).val("1");
				jQuery("#dis"+isNewCstm).val("1");
			}
		},
		isPositiveNum : function (str){	//是否为正整数
			if(str == 0){
				return true;
			}else{
				var re = /^[0-9]*[1-9][0-9]*$/ ;
				return re.test(str);
			}
			
		},
		identityCodeValid : function (code) { 
            var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
            var tip = "";
            var pass= true;
            
            if(!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
                tip = "身份证号格式错误";
                pass = false;
            }
            
           else if(!city[code.substr(0,2)]){
                tip = "地址编码错误";
                pass = false;
            }
            else{
                //18位身份证需要验证最后一位校验位
                if(code.length == 18){
                    code = code.split('');
                    //∑(ai×Wi)(mod 11)
                    //加权因子
                    var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
                    //校验位
                    var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
                    var sum = 0;
                    var ai = 0;
                    var wi = 0;
                    for (var i = 0; i < 17; i++)
                    {
                        ai = code[i];
                        wi = factor[i];
                        sum += ai * wi;
                    }
                    var last = parity[sum % 11];
                    if(parity[sum % 11] != code[17]){
                        tip = "校验位错误";
                        pass =false;
                    }
                }
            }
            if(!pass) alert(tip);
            return pass;
        }
}

//日期字符串转化中文
function getMonthZH(dateStr){
	var date = new strParseDate(dateStr);
	return   date.format("yyyy年MM月dd日");
}

//是否超限   延期费[0,3) 或 手续费[0,1)
function getMonthBefore(dateStr,num){ 				//获取dateStr三个月之前的日期
	   var date = new strParseDate(dateStr);
	   date.setMonth(date.getMonth()-num);
	   return   date.format("yyyy-MM-dd");
}

function strParseDate(dateStr) {   //IE8不能直接用 new Date(para) 创建日期对象
	var isoExp = /^\s*(\d{4})-(\d\d)-(\d\d)\s*$/,
	date = new Date(NaN), month,
	parts = isoExp.exec(dateStr);

	if(parts) {
		month = +parts[2];
		date.setFullYear(parts[1], month - 1, parts[3]);
		if(month != date.getMonth() + 1) {
			date.setTime(NaN);
		}
	}
	return date;
}

Date.prototype.format = function(format){
        var o =
        {
            "M+" : this.getMonth()+1, // month
            "d+" : this.getDate(),    // day
            "h+" : this.getHours(),   // hour
            "m+" : this.getMinutes(), // minute
            "s+" : this.getSeconds(), // second
            "q+" : Math.floor((this.getMonth()+3)/3), // quarter
            "S" : this.getMilliseconds() // millisecond
        }
       
        if(/(y+)/.test(format))
        format=format.replace(RegExp.$1,(this.getFullYear()+"").substr(4 - RegExp.$1.length));
        for(var k in o)
        if(new RegExp("("+ k +")").test(format))
        format = format.replace(RegExp.$1,RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
        return format;
} 


function NoToChinese(num) {
		
		/*var re = /^[0-9]*[1-9][0-9]*$/ ; 
		if (!re.test(num)) { alert(num = "    Number is wrong!"); return "Number is wrong!"; }*/
		var AA = new Array("零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖");
		var BB = new Array("", "拾", "佰", "仟", "萬", "億", "点", "");
		var a = ("" + num).replace(/(^0*)/g, "").split("."), k = 0, re = "";
		for (var i = a[0].length - 1; i >= 0; i--) {
			switch (k) {
				case 0: re = BB[7] + re; break;
				case 4: if (!new RegExp("0{4}\\d{" + (a[0].length - i - 1) + "}$").test(a[0]))
				re = BB[4] + re; break;
				case 8: re = BB[5] + re; BB[7] = BB[5]; k = 0; break;
			}
			if (k % 4 == 2 && a[0].charAt(i + 2) != 0 && a[0].charAt(i + 1) == 0) re = AA[0] + re;
			if (a[0].charAt(i) != 0) re = AA[a[0].charAt(i)] + BB[k % 4] + re; k++;
		}
		if(a[0] == 0){
			re = '零';
		}
		if (a.length > 1) {//加上小数部分(如果有小数部分)
			var  numstr =  delzoerstr(a[1]);
			if(numstr.length > 0){
				re += BB[6];
				for (var i = 0; i < numstr.length; i++){
					re += AA[numstr.charAt(i)];
				}
			}
		}
		return re;
  } 
	
function delzoerstr(str){
	//var str = "20345000";
	var sfkyj = false;
	var numstr = "";
	for(var i = str.length - 1;  i >= 0 ;  i--){
		var tnum = str.charAt(i);
		if(tnum != 0 && !sfkyj){
			sfkyj = true;
		}
		if(sfkyj){
			numstr += tnum;
		}
	}
	var znumstr = "";
	for(var i = numstr.length - 1;  i >= 0 ;  i--){
		znumstr += numstr.charAt(i);
	}	
	return znumstr;
}








