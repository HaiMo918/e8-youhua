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
String fwclbmField = "";//���Ĵ�����
String fwztfield = "";  //��������
String gwlbfield = "";  //�������
String zdlbfield = "";  //�ƶ����
String jdlbfield = "";  //�������
String rmjbfield = "";  //��������
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
var fwclbm = "<%=fwclbmField%>";//���Ĵ�����
var fwzt = "<%=fwztfield%>";  //��������
var gwlb = "<%=gwlbfield%>";  //�������
var zdlb = "<%=zdlbfield%>";  //�ƶ����
var jdlb = "<%=jdlbfield%>";  //�������
/*
	������Ӫ����  + �����ƶ�  ��  �Ƿ��ܲ���������
<option value="0">��Ӫ����
<option value="1">��Ʒó������
<option value="2">��������ҵ��
<option value="3">��������ҵ��
<option value="4">����ҵ��
<option value="6">�Ừ����
<option value="7">������ҵ��
<option value="8">���ʦ��ҵ��
<option value="9">���ƿع�
*/

var visibleSystemObj = {
	'zt_0':[{ id : "0" , name : "�����ƶ�" },{ id : "1" , name : "�����ƶ�" }],
	'zt_1':[{ id : "0" , name : "�����ƶ�" }],
	'zt_2':[{ id : "0" , name : "�����ƶ�" }],
	'zt_3':[{ id : "0" , name : "�����ƶ�" }],
	'zt_4':[{ id : "0" , name : "�����ƶ�" }],
	'zt_6':[{ id : "0" , name : "�����ƶ�" }],
	'zt_7':[{ id : "0" , name : "�����ƶ�" }],
	'zt_8':[{ id : "0" , name : "�����ƶ�" }],
	'zt_9':[{ id : "0" , name : "�����ƶ�" },{ id : "1" , name : "�����ƶ�" }],
	'zt_10':[{ id : "0" , name : "�����ƶ�" }]
}

var visibleFwclbmObj = {
	'zt_0':[{ id : "0" , name : "�ܲð�" },{ id : "1" , name : "������Դ��" },{ id : "2" , name : "�Ϲ沿" },{ id : "4" , name : "����" },{ id : "5" , name : "���̲�" }],
	'zt_1':[{ id : "0" , name : "�ܲð�" },{ id : "1" , name : "������Դ��" },{ id : "2" , name : "�Ϲ沿" },{ id : "3" , name : "���°칫��" },{ id : "4" , name : "����" }],
	'zt_2':[{ id : "0" , name : "�ܲð�" },{ id : "1" , name : "������Դ��" },{ id : "2" , name : "�Ϲ沿" },{ id : "3" , name : "���°칫��" },{ id : "4" , name : "����" }],
	'zt_3':[{ id : "0" , name : "�ܲð�" },{ id : "1" , name : "������Դ��" },{ id : "2" , name : "�Ϲ沿" },{ id : "3" , name : "���°칫��" },{ id : "4" , name : "����" }],
	'zt_4':[{ id : "0" , name : "�ܲð�" },{ id : "1" , name : "������Դ��" },{ id : "2" , name : "�Ϲ沿" },{ id : "3" , name : "���°칫��" },{ id : "4" , name : "����" }],
	'zt_6':[{ id : "0" , name : "�ܲð�" },{ id : "1" , name : "������Դ��" },{ id : "2" , name : "�Ϲ沿" },{ id : "3" , name : "���°칫��" },{ id : "4" , name : "����" }],
	'zt_7':[{ id : "0" , name : "�ܲð�" },{ id : "1" , name : "������Դ��" },{ id : "2" , name : "�Ϲ沿" },{ id : "3" , name : "���°칫��" },{ id : "4" , name : "����" }],
	'zt_8':[{ id : "0" , name : "�ܲð�" },{ id : "1" , name : "������Դ��" },{ id : "2" , name : "�Ϲ沿" },{ id : "3" , name : "���°칫��" },{ id : "4" , name : "����" }],
	'zt_9':[{ id : "0" , name : "�ܲð�" },{ id : "3" , name : "���°칫��" }],
	'zt_10':[{ id : "0" , name : "�ܲð�" },{ id : "1" , name : "������Դ��" },{ id : "2" , name : "�Ϲ沿" },{ id : "3" , name : "���°칫��" },{ id : "4" , name : "����" }]
}

var visibleGwlbObj = {
	'zt_0':[{ id : "0" , name : "�ƶ�" },{ id : "1" , name : "֪ͨ" },{ id : "2" , name : "����" },{ id : "3" , name : "��Ҫ" },{ id : "5" , name : "����" }],
	'zt_1':[{ id : "0" , name : "�ƶ�" },{ id : "1" , name : "֪ͨ" },{ id : "2" , name : "����" },{ id : "3" , name : "��Ҫ" },{ id : "4" , name : "��ʾ" },{ id : "5" , name : "����" },{ id : "6" , name : "����" }],
	'zt_2':[{ id : "0" , name : "�ƶ�" },{ id : "1" , name : "֪ͨ" },{ id : "2" , name : "����" },{ id : "3" , name : "��Ҫ" },{ id : "4" , name : "��ʾ" },{ id : "5" , name : "����" },{ id : "6" , name : "����" }],
	'zt_3':[{ id : "0" , name : "�ƶ�" },{ id : "1" , name : "֪ͨ" },{ id : "2" , name : "����" },{ id : "3" , name : "��Ҫ" },{ id : "4" , name : "��ʾ" },{ id : "5" , name : "����" },{ id : "6" , name : "����" }],
	'zt_4':[{ id : "0" , name : "�ƶ�" },{ id : "1" , name : "֪ͨ" },{ id : "2" , name : "����" },{ id : "3" , name : "��Ҫ" },{ id : "4" , name : "��ʾ" },{ id : "5" , name : "����" },{ id : "6" , name : "����" }],
	'zt_6':[{ id : "0" , name : "�ƶ�" },{ id : "1" , name : "֪ͨ" },{ id : "2" , name : "����" },{ id : "3" , name : "��Ҫ" },{ id : "4" , name : "��ʾ" },{ id : "5" , name : "����" },{ id : "6" , name : "����" }],
	'zt_7':[{ id : "0" , name : "�ƶ�" },{ id : "1" , name : "֪ͨ" },{ id : "2" , name : "����" },{ id : "3" , name : "��Ҫ" },{ id : "4" , name : "��ʾ" },{ id : "5" , name : "����" },{ id : "6" , name : "����" }],
	'zt_8':[{ id : "0" , name : "�ƶ�" },{ id : "1" , name : "֪ͨ" },{ id : "2" , name : "����" },{ id : "3" , name : "��Ҫ" },{ id : "4" , name : "��ʾ" },{ id : "5" , name : "����" },{ id : "6" , name : "����" }],
	'zt_9':[{ id : "0" , name : "�ƶ�" },{ id : "1" , name : "֪ͨ" },{ id : "2" , name : "����" },{ id : "3" , name : "��Ҫ" },{ id : "5" , name : "����" }],
	'zt_10':[{ id : "0" , name : "�ƶ�" },{ id : "1" , name : "֪ͨ" },{ id : "2" , name : "����" },{ id : "3" , name : "��Ҫ" },{ id : "4" , name : "��ʾ" },{ id : "5" , name : "����" },{ id : "6" , name : "����" }]
}
jQuery(document).ready(function(){
         
		hideInit();//��ʼ��������

	    jQuery("#"+gwlb).bindPropertyChange(function(){//������� �������������ƶ����ı仯

	        gwlb_fun();//�������
			zdlb_fun();//�ƶ����
	    });
		jQuery("#"+zdlb).bindPropertyChange(function(){//�ƶ���� ������������ı仯

	        zcsp_fun();//�Ƿ��ܲ�����
	    });
		jQuery("#"+fwzt).bindPropertyChange(function(){//��������   
			fwclbm_fun();//���Ĵ�����
			gwlbInit();//�������
			zcsp_fun();//�Ƿ��ܲ�����
			zdlb_fun();//�ƶ����
			fwclbmInit();//���Ĵ�����������ֵ�ĳ�ʼ��
		});
        jQuery("#"+jdlb).bindPropertyChange(function(){//�������    �䶯��������������仯	
			jdlb_fun();//�������
		});
		gwlb_fun();	//�������
		fwclbm_fun();//���Ĵ�����
		jdlb_fun();//�������
});

function hideInit(){

	    jQuery("#fwclbm").hide();//���Ĵ�����
	  	jQuery("#zd").hide();//�ƶ����
	    jQuery("#jd").hide();//�������
		jQuery("#jb").hide();//�������
	    jQuery("#jy").hide();//��Ҫ���
        jQuery("#zchq").hide();//�Ƿ��ܲ�����
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
//���Ĵ�����������ֵ�ĳ�ʼ��
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
//���ݷ��������ʼ���������
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
	 //�ƶ�
     if(gwlb_v==0&&gwlb_v!=''){ 
	    jQuery("#zd").show();
        jQuery("#jd").hide();
		jQuery("#jd").val('');
		jQuery("#jb").hide();
		jQuery("#jb").val('');
        jQuery("#jy").hide();
        jQuery("#jy").val('');
		jQuery("#zchq").show();

     }else if(gwlb_v==1){ //֪ͨ
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
		
    }else if(gwlb_v==2){ //����
	    jQuery("#zd").hide();
		jQuery("#zd").val('');
        jQuery("#jd").show();
		jQuery("#jb").hide();
		jQuery("#jb").val('');
        jQuery("#jy").hide();
        jQuery("#jy").val('');
		jQuery("#zchq").hide();
		jQuery("#zchq").val("");
		
    }else if(gwlb_v==3){ //��Ҫ
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
//���ݾ������������������Ƿ���ʾ
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