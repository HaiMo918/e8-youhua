<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rst" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>

<% 
	String rqstid  = Util.null2String(request.getParameter("requestid")); 
	String sqlStr ="select khxm,khid,jyzh,sfzh,yhxyyxqxzi,yhxyyxqxz,dkyhkhh,dkyhzh,ssx,fzh,jyssxfjlbl,hysxfyhbl,jyyqfyhbl,ljcrjjzbdy,jyssxfjlblwb,hysxfyhwb,jyyqfyhblwb,crjwb,htbh  from formtable_main_106 where requestid =  " + rqstid ;
	rst.executeSql(sqlStr);

	rst.next();
	String khxm 		 =  rst.getString("khxm");  			 //�ͻ�����
	String khid  		 =  rst.getString("khid"); 				 //�ͻ�ID
	String jyzh 		 =  rst.getString("jyzh");   			 //�����˺�
	String sfzh  		 =  rst.getString("sfzh");  			 //���֤��
	String yhxyyxqz 	 =  rst.getString("yhxyyxqxzi");  	 //�Ż�Э�鿪ʼ����
	String yhxyyxqjz     =  rst.getString("yhxyyxqxz"); 	 //�Ż�Э���������
	String dkyhkhh 	     =  rst.getString("dkyhkhh"); 		 //������п�����
	String dkyhzhkh 	 =  rst.getString("dkyhzh");  	 //��������˺�
	String ssx 			 =  rst.getString("ssx");  			 // ʡ����
	String fzh 			 =  rst.getString("fzh");  				 // ��/֧��

	String sxfjl	     =  rst.getString("jyssxfjlbl");  		//  �������������Żݱ���
	String sxfyh		 =  rst.getString("hysxfyhbl");  	     // ��Ա�������Żݱ���
	String yqfyh	     =  rst.getString("jyyqfyhbl");  		// �������ڷ��Żݱ���
    String ljcrjjzbdy	 =  rst.getString("ljcrjjzbdy");        // �ۼƳ����ֵ������

	String jyssxfjlwb 	 =  rst.getString("jyssxfjlblwb");       // �������������Żݱ���  �ı�
	String hysxfyhwb     =  rst.getString("hysxfyhwb");          // ��Ա�������Żݱ���
	String jyyqfyhwb     =  rst.getString("jyyqfyhblwb");              // �������ڷ��Żݱ���   �ı�
	String crjdx 	     =  rst.getString("crjwb");  			 // �ۼƳ����ֵ  �ı�

	String htbh 	     =  rst.getString("htbh");  			// ��ͬ���
	
	String[] yhxyyxqzArr = yhxyyxqz.split("-");//�Żݿ�ʼ����
	String year_b 		=   yhxyyxqzArr[0]; //   ��
	String month_b    =   yhxyyxqzArr[1]; //   ��
	String day_b 		=   yhxyyxqzArr[2]; //    ��
	
	String[] yhxyyxqjzArr = yhxyyxqjz.split("-");//�Żݽ�������
	String year_e 		=   yhxyyxqjzArr[0]; //   ��
	String month_e    =   yhxyyxqjzArr[1]; //   ��
	String day_e 		=   yhxyyxqjzArr[2]; //   ��
%>

<HTML>
<HEAD>
<TITLE>javascript��ӡ-��ӡҳ������-��ӡԤ������</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312" />
<style media=print>
.Noprint{display:none;}
.PageNext{page-break-after: always;}
body{
	
}
html{width:100%; height:100%;}

</style>

<SCRIPT language=javascript>
	function pagesetup_null() {
        try {
            var RegWsh = new ActiveXObject("WScript.Shell");
            hkey_key = "header";
            RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "");
            hkey_key = "footer";
            RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "");
        } catch (e) {
        }
    }
����function printsetup(){
	����// ��ӡҳ������
	����wb.execwb(8,1);
����}
����function printpreview(){
	����// ��ӡҳ��Ԥ��
	����wb.execwb(7,1);
����}
����function printit()
����{
����if (confirm('ȷ����ӡ��')) {
����wb.execwb(6,6)
����}
����}
    window.onload=printpreview;//��Ҫ����
</SCRIPT>

</HEAD>
<BODY >
<!-- <div id="kpr"  style="height: 30px; width:210mm; border:1px solid #eee; background-color: #EEE; text-align: right;  " >
	    <INPUT onclick="kpr.style.display='none';javascript:printit()"         		style="margin-right:-7px;  height: 30px; line-height: 30px;  font-weight: bold;    border:1px solid rgb(242,221,220); background-color:rgb(242,221,220);   width: 150px;"   type=button value=��ӡ name=button_print />
	    
		<INPUT onclick="kpr.style.display='none';javascript:printsetup();" 		style=" margin-right:-7px; height: 30px; line-height: 30px;  font-weight: bold;    border:1px solid rgb(219,229,241); width: 150px;   background-color:rgb(219,229,241);"    type=button value=��ӡҳ������ name=button_setup />
		<INPUT onclick="kpr.style.display='none';javascript:printpreview();"	style="   height: 30px; line-height: 30px;  font-weight: bold;   border:1px solid rgb(234,241,221); width: 150px;   background-color:rgb(234,241,221);"    type=button value=��ӡԤ�� name=button_show />
</div> -->
<div style="position:relative;  border:1px solid #fff; width:210mm; height:297mm;" >
	<div style="border-bottom:2px solid #000;" ><img src="/huaxin/yry.jpg" /></div>
	<DIV align=center>
		<OBJECT id=wb height=0 width=0
		classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 name=wb></OBJECT>
		
	</DIV>
	<div style="height:60px; margin-top:20px;  line-height:50px;  font-size:38px; text-align:center; font-weight:bold;  font-family:STXinwei;  position: relative;  /* border:1px solid red;   */ " >
		���׷����Ż�Э��<div style="position:absolute; right:-23px; top:0px;   height:25px;  line-height:20px; width:300px;  font-size: 14px; font-weight: bold; vertical-align: top; " >��ţ�<%=htbh %></div>
	</div>
	<div style="margin: 0px; height: 45px; line-height: 25px;"  >
		<span  style="display:inline-block; vertical-align:bottom; " >�ͻ�������</span><span style="display:inline-block; vertical-align:bottom;  height: 20px; width: 280px; border-bottom: 1px solid #000;"  ><%=khxm %></span>                                 <span  style="display:inline-block; vertical-align:bottom; " > �����ʺţ�</span><span style="display:inline-block; vertical-align:bottom;  height: 20px; width: 280px; border-bottom: 1px solid #000;"  ><%=jyzh %></span>   
	</div>
	<div style="margin: 0px; height: 45px; line-height: 25px; "  >
		<span  style="display:inline-block; vertical-align:bottom; " >�ͻ� I D��</span><span style="display:inline-block;  height: 20px; width: 280px; border-bottom: 1px solid #000; vertical-align:bottom; "  ><%=khid %></span>                                  <span  style="display:inline-block; vertical-align:bottom; " >���֤�ţ�</span><span style="display:inline-block; height: 20px; width: 280px; border-bottom: 1px solid #000; vertical-align:bottom;  "  ><%=sfzh %></span>   
	</div>
	
	<div style="margin: 0px; height: 32px; line-height: 32px; font-weight: bold; "  >
		һ��	���׷���Э������   
	</div>
	<div style="margin: 0px; height: 34px; line-height: 34px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;1��	����ԭ��
	</div>
	<div style="margin: 0px; line-height: 25px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;��Э��רΪ��������˾���ʿͻ��ṩ���ͻ������й�˾�Ļ�������֮�⣬����ý��׷��õ��Żݣ������Żݶ�ȵĺ�������ͻ��ڽ�������˾���׵�����Ʒ�֡�
	</div>
	<div style="margin: 0px; height: 34px; line-height:34px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;2��	Э�����ݣ�
	</div>
	<div style="margin: 0px; line-height: 25px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;* ��˫���Ѻ�Э�̣��Ա�Э��Լ��֮���𣬿ͻ������˻�ͨ���㶫����������������¼�ơ���������������ƽ̨���н��ף�����������ȡ�������Ѽ������Ϊ 	
		<%-- <span style="display:inline-block; height: 17px;  text-align:center;  width: 100px; border-bottom: 1px solid #000;"  >�ٷ�֮<%=hysxfyhwb %></span> --%><label style="padding-bottom:3px; border-bottom:1px solid #000;"  >&nbsp;&nbsp;�ٷ�֮<%=hysxfyhwb %>&nbsp;&nbsp;</label>��
		��ȡ�����ɽ�������Ϊ <%-- <span style="display:inline-block; height: 17px;  text-align:center;  width: 100px; border-bottom: 1px solid #000;"  >�ٷ�֮<%=jyyqfyhwb %></span> --%><label style="padding-bottom:3px; border-bottom:1px solid #000;" >&nbsp;&nbsp;�ٷ�֮<%=jyyqfyhwb %>&nbsp;&nbsp;</label>��
		�罻��������ϵͳʵ����ȡ�������Ѻ����ɽ����˫��Լ����׼��������Ľ��׷��ò��ֽ��ɽ�����������Żݼ��⣬��ͨ��ת�˵ķ�ʽ�˻����ͻ������뽻�����󶨵������ʽ��˻������յ��˽��Ϊ�����Żݲ��ֵĿ۳�˰������ע�������ڽ�������̨ϵͳ�ܹ����ɵ������������Ѻ����ɽ���ȡ��׼������ϵͳ��ֱ�Ӱ��ձ�Э��Լ���ķ��ʱ�׼������ȡ����
	

	</div>
	<div style="margin: 0px;  line-height: 25px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;* �Ż�Э����Ч���ޣ���<span style="display:inline-block; text-align:center;   height: 20px; width: 40px; border-bottom: 1px solid #000;"  ><%=year_b %></span>  ��  <span style="display:inline-block;  height: 20px; text-align:center;   width: 40px; border-bottom: 1px solid #000;"  ><%=month_b %></span> �� <span style="display:inline-block; text-align:center;   height: 20px; width: 40px; border-bottom: 1px solid #000;"  ><%=day_b %></span> �� 
		&nbsp;&nbsp;��&nbsp;&nbsp;
		<span style="display:inline-block; height: 20px;  text-align:center;  width: 40px; border-bottom: 1px solid #000;"  ><%=year_e %></span>  ��<span style="display:inline-block;  height: 20px;  width: 40px;  text-align:center;  border-bottom: 1px solid #000;"  ><%=month_e %></span>  ��<span style="display:inline-block;  height: 20px; width: 40px; text-align:center;  border-bottom: 1px solid #000;"  ><%=day_e %></span>  �գ�
	</div>
	<div style="margin: 0px;  line-height: 25px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;* �Żݽ��������ڣ�����Ϊ���ڽ��㣬ÿ���µ����һ������Ϊһ���������ڵĽ�ֹ�գ����¼�ơ������ա�����
	</div>
	<div style="margin: 0px;  line-height: 25px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;* �����Żݽ��ʱ�䣺ÿ�������յĴ���15�գ����ڼ���˳�ӣ���
	</div>
	<div style="margin: 0px;  line-height: 25px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;* �����Żݽ�ʽ�����л�ת��ͻ����˽������󶨵������ʽ��˻���
	</div>
	<div style="margin: 0px;  line-height: 25px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;�˻�������<span style="display:inline-block;  height: 20px; width: 80px; border-bottom: 1px solid #000;"  ></span>  �����У�<span style="display:inline-block;  height: 20px; width: 150px; border-bottom: 1px solid #000;"  ><%=dkyhkhh%></span> ����<span style="display:inline-block;  height: 20px; width: 80px; border-bottom: 1px solid #000;"  ><%=ssx %></span>ʡ/�� <span style="display:inline-block;  height: 20px; border-bottom: 1px solid #000;"  ><%=fzh %></span>���У�
	</div>
	<div style="margin: 0px;  line-height: 25px;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;�����˺�/���п��ţ�<span style="display:inline-block;  height: 20px; width: 300px; border-bottom: 1px solid #000;"  ><%=dkyhzhkh %></span> 
	</div>

	<div style="margin: 0px; height: 32px; line-height: 32px; font-weight: bold; "  >
		����	���׷����Ż�����Ҫ��
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 5px; "  >
			&nbsp;&nbsp;&nbsp;&nbsp;1��	���ع��ҷ��ɡ���������ߡ����ع㶫���������������ع����ƶȡ�
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 5px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;2��	��ֹ�������գ��ͻ����˻��ۼƳ����ֵ������<span style="display:inline-block; height: 20px;  text-align:center;  width: 80px; border-bottom: 1px solid #000;"  ><%=crjdx%></span>��Ԫ����ң����˻����վ������ֵ�������ۼƳ����ֵ��50%��
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 5px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;3��	��ǩ����Ϣ�ϸ��ܣ���͸©����������
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 5px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;4��	Ը��Э����������˾������������������
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 5px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;ע���ۼƳ����ֵָ�ͻ��Կ��������ν����յ�������ȥ�ܳ����վ������ֵ=�ڳ��ۼƳ����ֵ+��������ÿ���ۼƾ�ֵ*�ʽ��ڵ��µ��ۼƽ�����������/�����ܽ����������������Э����ʼ�»��ֹ�·����£����յ����Żݵ���Ч���������վ���ֵ��
	</div>
	
	<div style="margin: 0px; height: 32px; line-height: 32px; font-weight: bold; "  >
		����	ֹͣ����Э����ֹ
	</div>
	
	<div style="margin: 0px;  line-height: 25px;  padding: 5px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;1��	�ͻ�ͬ�⣬����Э����Ч���ڣ��ͻ�δ�����㱾Э�����µ��Ż���������������˾��Ȩ������ͣ������ͻ��ṩ�Żݷ���
	</div>
	<div style="width: 100%; height: 100px;"  > </div>
	<div style="position:absolute; bottom:0px; right:0px;  width: 100%; font-size: 14px; color: #666; font-weight: bold; text-align: center;  " >&nbsp;1&nbsp;/&nbsp;3&nbsp;</div>
	<div style="position:absolute; bottom:0px; right:0px;  width: 100%; font-size: 14px; color: #ccc; font-weight: bold; text-align: right;  " >&nbsp;&nbsp;���ƿعɣ�Nasdaq���룺YIN������Ʒ��&nbsp;&nbsp;</div>
</div>


<div style="position:relative;   border:1px solid #fff; width:210mm; height:297mm;" >
	<div class="PageNext"></div>
	<div style="border-bottom:2px solid #000;" ><img src="/huaxin/yry.jpg" /></div>
	
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;2��	�ͻ�ͬ�⣬����Э����Ч���ڣ��ͻ��˻������쳣�����ĳ��Ʒ�ֵĲ��������쳣����ģ���������˾��Ȩѡ����ǰ��ֹ��Э�����Բ����쳣��Ʒ����ֹ�ṩ�����Żݷ��񡣻��ڽ������Կͻ�������Ϊ�Ϲ滯��Ҫ�󣬼���������˾�����ͻ����˲�����ȷ���˻���ȫ��ԭ�򣬿ͻ���Ⲣͬ�⣬�緢��������һ���Σ����ۿͻ������٣�����������Ȩ������ֹ�Żݣ�������׷���ͻ��ѻ��֮�Żݵ�Ȩ����
	</div>
	
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a)	�ͻ������˻��쳣�������쳣���ֲ��쳣���ʽ��쳣�ȣ�
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b)	�������˻����ʽ������˻��Ƚ������˹���ʹ�ã�����ȫȨί������ֱ�ӽ���ͻ������˻����н��ײ������´ｻ��ָ�
	</div>
	
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c)	���ý����ʸ����ҵ����зǷ���Ӫ���
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;d)	���������Դ��Ͳ��̡�������ơ��������ʡ���ŵ��������ȷ�ʽ���뽻�ף�
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;e)	�ܲ�ִ�н�������ȡ�����ƽ��״�ʩ��
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;f)	Υ����������ع����ƶȣ����߱�Э�鸽���涨���������Σ�
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;3��	�ͻ�ͬ�⣬��������ط��ɡ����漰�㶫�������������ؽ��׹������ģ���������˾��Ȩѡ����ǰ��ֹ��Э����޸ı�Э���Ż�������Ҫ�󣨰����������ڷ�����ȡ��׼���Ż�������Ҫ��ȣ�����������˾ѡ���޸ı�Э��ģ����ͻ����ܣ�˫������ǩ������Э������ȷ�ϣ����ͻ������ܣ���������˾��Ȩ��ǰ��ֹ��Э�顣
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;4��	��������˾���ձ���1��2��3��涨��ǰ��ֹ���޸�Э��ģ��ͻ���ȨҪ���������˾�е��κ�ΥԼ���������Ρ�
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  >
		&nbsp;&nbsp;&nbsp;&nbsp;<label style="font-weight: bold;"  >�ͻ����뼰��ŵ��</label>����Ը�����ؽ��������йؽ��׷����Ż�Э��Ĺ涨��������ط������ݣ���Ը�����ге������еķ��գ�����������Ҫ��δ����������˻��쳣�����������ͬ��������������׷����Ż�Э�����Ȩ���񣬲�ͬ���������˾��ǰ��ֹ��Э�飬���˲������Ҫ���������˾�е��κ�ΥԼ���������Ρ���֣��������������뽻�׷����Żݷ����Ա�Э��ǩ��֮���𣬿ͻ�֮ǰ���������˾ǩ��ġ����׷����Ż�Э�顷���Զ����ϣ��Ա�Э��Ϊ׼��ͬʱ��������ȡ���Ż�Э��ԭ��/��ӡ��Ҽ�ݡ�
�����������Ķ�����ȫ����ͬ���������׷����Ż�Э���ȫ���������ŵ����Ӧ�ϸ����ء��ͻ����뼰��ŵ���������ݡ�
	</div>

	<div style="margin: 0px; line-height: 32px; font-weight: bold;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;�����������Ķ�����ȫ����ͬ���������׷����Ż�Э���ȫ���������ŵ����Ӧ�ϸ����ء��ͻ����뼰��ŵ���������ݡ�
	</div>
	<div style="margin: 0px; line-height: 32px; font-weight: bold;  "  >
		&nbsp;&nbsp;&nbsp;&nbsp;�ͻ��ܳ���<span style="display:inline-block; vertical-align:bottom;  height: 20px; width:650px; border-bottom: 1px solid #000;"  ></span>
		<br/>
		<div style="margin-left:5px;  margin-right:25px;  height: 34px; border-bottom: 1px solid #000;"  ></div>
	</div>
	<div style="height: 10px;" ></div>
    <div style="margin: 0px; height: 33px; line-height: 35px; font-weight: bold; "  >
		 &nbsp;&nbsp; 1.	�ͻ������˻��쳣���Σ�
	</div>                                                     
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;a)	�ͻ��ڰ�����ҵ��ʱ���������ӻ������Լ��ǵ��ӻ������Ƚ������Ͽɵ��κ�һ�ֿ�����ʽ���Ǳ������԰���ģ�
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;b)	�ͻ��Ŀ������ϷǱ�������ǩ��ί�������˴�Ϊǩ��ģ�
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;c)	�ͻ��ܾ�������ϻ�Ա��λ�������绰�طã������ڻط�ʱ�޷��ṩ׼ȷ��Ϣ�ģ�
	</div>
	<div style="margin: 0px;  line-height: 25px;  padding: 4px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;d)	�����������������忪��ʱʹ��ͬһIP��ַ��IP��ַ�䲻����ͬ������ͬһ�����ַ�ģ�
	</div>
	<div style="margin: 0px;  line-height: 20px;  padding: 4px;  padding-right: 0px;"  > 
		&nbsp;&nbsp;&nbsp;&nbsp;e)	�����������������忪��ʱ������Ϣ��ͬ��ʹ��ͬһ��ϵ�绰��������������Ҫ����ʾ�����˻������������й�����ϵ�ģ�
	</div>
	<div style="width: 100%; height: 75px;"  > </div>
	<div style="position:absolute; bottom:0px; right:0px;  width: 100%; font-size: 14px; color: #666; font-weight: bold; text-align: center;  " >&nbsp;2&nbsp;/&nbsp;3&nbsp;</div>
	<div style="position:absolute; bottom:0px; right:0px;  width: 100%; font-size: 14px; color: #ccc; font-weight: bold; text-align: right;  " >&nbsp;&nbsp;���ƿعɣ�Nasdaq���룺YIN������Ʒ��&nbsp;&nbsp;</div>
</div>


<div style=" position:relative;  border:1px solid #fff; width:210mm; height:297mm;" >
	<div class="PageNext"></div>
	<div style="border-bottom:2px solid #000;" ><img src="/huaxin/yry.jpg" /></div>
	
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;f)	�ͻ�����ʱ������Ϣ�����������ģ�
	</div>
	
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;g)	����������Ա��λ�϶��ͻ������˻������쳣���������Ρ�
	</div>

	<div style="margin: 0px; height: 35px; line-height: 35px; font-weight: bold; "  >
		 &nbsp;&nbsp;2.	�ͻ������쳣���Σ�
	</div> 
	
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
			&nbsp;&nbsp;&nbsp;&nbsp;a)	�ͻ��ڶ�ʱ����Ƶ�����н��ף�����ʱ������15�������ڵģ�
	</div>
	
	<div style="margin: 0px;  line-height: 20px;  padding: 5px;  padding-right: 0px;"  > 
			&nbsp;&nbsp;&nbsp;&nbsp;b)	�ͻ����ʳɽ������ﵽ���������ʽ����޶�򵥱ʽ����޶�ﵽ�������涨���ʽ����޶�80%���ϵģ�
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px;   padding-right: 0px;"  > 
			&nbsp;&nbsp;&nbsp;&nbsp;c)	�����˻��飨ָ�������ʵ�ʿ��ƹ�����ϵ���˻��飬��ͬ�����м۵��ڳɽ���Ʒ���ɽ����򡢳ɽ��۸񡢳ɽ��������ɽ�ʱ����һ������ָ�����һ�µģ�
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px;  padding-right: 0px;"  > 
			&nbsp;&nbsp;&nbsp;&nbsp;d)	�����˻����ָ�۵��ڳɽ���Ʒ���ɽ����򡢳ɽ��۸񡢳ɽ�������һ������ָ�����һ�µģ�
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; padding-right: 0px; "  > 
			&nbsp;&nbsp;&nbsp;&nbsp;e)	�����˻�����м۵��ڳɽ�ʱ�䡢�ɽ���Ʒ���ɽ�������һ������ָ�����һ�£����ɽ������෴�ģ�
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; padding-right: 0px; "  > 
			&nbsp;&nbsp;&nbsp;&nbsp;f)	�����˻����ָ�۵��ڳɽ���Ʒ���ɽ��۸񡢳ɽ�������һ������ָ�����һ�£����ɽ������෴�ģ�
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; padding-right: 0px; "  > 
			&nbsp;&nbsp;&nbsp;&nbsp;g)	�����˻���ĳɽ�IP��ַһ�»�IP��ַ�䲻����ͬ������ͬһ�����ַ�ģ�
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
			&nbsp;&nbsp;&nbsp;&nbsp;h)	�����˻���ĵ�¼���˳�IP��ַһ?»�IP��ַ�䲻����ͬ������ͬһ�����ַ�ģ�
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
			&nbsp;&nbsp;&nbsp;&nbsp;i)	��һ�˻��ͻ����ճɽ������ﵽ30�����ϵģ�
	</div>		
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
			&nbsp;&nbsp;&nbsp;&nbsp;j)	����������Ա��λ�϶��ͻ������쳣���������Ρ�
	</div>		
	
	
	<div style="margin: 0px; height: 35px; line-height: 35px; font-weight: bold; "  >
		 &nbsp;&nbsp;3.	�ͻ��ֲ��쳣���Σ�
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;a)	�ͻ��ֲִﵽ�������涨�ĳֲ��޶�������涨�ĳֲ��޶�80%���ϵģ�
	</div>		 			
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;b)	�����˻���ĳֲֲ�Ʒ���ֲ�ʱ�䡢�ֲ��������ֲַ�����һ������ָ�����һ�µģ�
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;c)	�����˻���ĳֲֲ�Ʒ���ֲ�ʱ�䡢�ֲ�������һ������ָ�����һ�£����ֲַ����෴�ģ�
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;d)	����������Ա��λ�϶��ͻ��ֲ��쳣���������Ρ�
	</div>		 
	
	<div style="margin: 0px; height: 35px; line-height: 35px; font-weight: bold; "  >
		&nbsp;&nbsp;4.	�ͻ��ʽ��쳣���Σ�
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;a)	�ͻ����ʽ��������ʱ�������ڷǽ��׵����س��ֽϴ�ı䶯�ģ�
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;b)	����˻���һ����������𳬹�һ�����ģ�
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;c)	����˻����������ʱ������ģ�
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;d)	����˻�ͬʱ������������������ģ�
	</div>		 
	<div style="margin: 0px;  line-height: 20px;  padding: 5px; "  > 
		&nbsp;&nbsp;&nbsp;&nbsp;e)	����������Ա��λ�϶��ͻ��ʽ��쳣���������Ρ�
	</div>		 
	<div style="margin: 0px; height: 32px; line-height: 32px; font-weight: bold; "  >
		&nbsp;&nbsp;5.	�ͻ�����ΥԼΥ��ģ�
	</div>		 
	<div style="margin: 0px; height: 32px; line-height: 32px; font-weight: bold; "  >
		&nbsp;&nbsp;6.	�ͻ��漰˾������ģ�
	</div>		 
	<div style="margin: 0px; height: 32px; line-height: 32px; font-weight: bold; "  >
		&nbsp;&nbsp;7.	��������Ϊ��Ҫ���������Ρ�
	</div>		 
	<span style=" display:inline-block;  margin: 0px; height: 32px; width:48%;   font-weight: bold; "  >&nbsp;&nbsp;�ͻ�ǩ����      </span>  <span style=" display:inline-block;  margin: 0px; height: 32px; width:48%;   font-weight: bold; "  > �쵼ǩ�֣�</span>
     <span style="  display:inline-block;  margin: 0px; height: 32px; width:48%;   font-weight: bold; "  >
     	<span style="margin-left:100px; display:inline-block;  height: 20px; width: 40px; border-bottom: 1px solid #000;"  ></span> ��  <span style="display:inline-block;  height: 20px; width: 40px; border-bottom: 1px solid #000;"  ></span>     ��<span style="display:inline-block;  height: 20px; width: 40px; border-bottom: 1px solid #000;"  ></span> ��     
     </span> 
     <span style=" display:inline-block;  margin: 0px; height: 32px; width:48%;   font-weight: bold; "  >
     	<span style="margin-left:100px; display:inline-block;  height: 20px; width: 40px; border-bottom: 1px solid #000;"  ></span> ��    <span style="display:inline-block;  height: 20px; width: 40px; border-bottom: 1px solid #000;"  ></span>   ��    <span style="display:inline-block;  height: 20px; width: 40px; border-bottom: 1px solid #000;"  ></span>   ��	
     </span>	
     <div style="margin: 0px;  line-height: 20px;  padding: 5px; "  >
		&nbsp;&nbsp;��Э��Ҽʽ���ݣ�˫����ִҼ�ݡ���˫��ǩ�֣����£���߱�ͬ�ȷ���Ч����
	 </div>	
	 <div style="margin: 0px;  line-height: 50px; text-align:right;  padding: 5px; font-weight: bold;  "  >
			�㶫��������������Ӫ���޹�˾
	 </div>
	 
	<div style="width: 100%; height: 10px;"  > </div>
	<div style="position:absolute; bottom:0px; right:0px;  width: 100%; font-size: 14px; color: #666; font-weight: bold; text-align: center;  " >&nbsp;3&nbsp;/&nbsp;3&nbsp;</div>
	<div style="position:absolute; bottom:0px; right:0px;  width: 100%; font-size: 14px; color: #ccc; font-weight: bold; text-align: right;  " >&nbsp;&nbsp;���ƿعɣ�Nasdaq���룺YIN������Ʒ��&nbsp;&nbsp;</div>
</div>
</BODY>
</HTML> 