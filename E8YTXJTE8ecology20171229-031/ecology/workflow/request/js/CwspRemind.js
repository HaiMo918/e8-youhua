jQuery(document).ready(function(){
	remind();
});
function remind(){
	var requestid_v = jQuery("#requestid").val();

	if(requestid_v!='') {
		jQuery.ajax({
			type: "post",
			url: "/workflow/request/js/cwspZhs.jsp",
			cache:false,
			//async:false,//同步   true 异步  不设置默认为异步
			//contentType:"application/x-www-form-urlencoded;charset=UTF-8",
			data:{"requestid":requestid_v}, 
			success: function(msg){
				msg = msg.replace(/\n/g,"").replace(/\r/g,"");
				eval('var obj ='+msg);
			
				var zsh_v = obj.ZSH;
				if(parseInt(zsh_v)>15||parseInt(zsh_v)==15)
				{
				alert("当前流程已审批耗时"+zsh_v+"天,总裁要求该类流程需在17日内完成所有节点审批，请您酌情予以尽快处理！");
				};//（计算方式为：当前时间-流程发起时间），
			}
		});
	}
}