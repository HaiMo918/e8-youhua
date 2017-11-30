jQuery(document).ready(function(){
	//alert(getUrlParam("requestid"));
	
	var rqstid = getUrlParam("requestid");

	//var top =  jQuery("#toolbarmenu", window.parent.document).position().top;
	//var right = jQuery("#toolbarmenu", window.parent.document).position().left  +  jQuery("#toolbarmenu", window.parent.document).width() - 57;
	
	var htmlstr ='<a href="/yintech/print/SXBRME_S.jsp?requestid='+ rqstid +'" target="_blank"><span style="font-size:12pt;letter-spacing:2px;text-align:center;color:red;margin:4px 40px;line-height:26px;">合同打印</span></a>';
	//jQuery("#toolbarmenudiv", window.parent.document).css("display","none"); 
	jQuery(".print").append(htmlstr); 
});

function getUrlParam(name){
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.parent.location.search.substr(1).match(reg);  //匹配目标参数
    if (r!=null) return unescape(r[2]); return null; //返回参数值
}