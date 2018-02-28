<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var _jllx="field10946";
jQuery(document).ready(function(){
  //jQuery("#hide01").hide();   
window.onload=function(){
         f_jllx();
};
 jQuery("#"+_jllx).change(function(){     
         f_jllx();
   });
 
});
function f_jllx(){  
    var va=jQuery("#"+_jllx).val();   
    if(va==1){ 
      jQuery("#hide01").show();
    }else{ 
    jQuery("#field10953span").attr("value",""); 
    jQuery("#field10953span").html("");       
     jQuery("#hide01").hide();  
    }
}   
</script>
