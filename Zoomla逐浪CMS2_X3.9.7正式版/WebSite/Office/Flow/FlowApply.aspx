﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FlowApply.aspx.cs" Inherits="ZoomLaCMS.MIS.OA.Flow.FlowApply" MasterPageFile="~/Office/OAMain.master"  ValidateRequest="false"%>
<%@ Register Src="~/Office/Tlp/defTlp.ascx" TagPrefix="oa" TagName="defTlp" %>
<%@ Register Src="~/Office/Tlp/send.ascx" TagPrefix="oa" TagName="send" %>
<%@ Register Src="~/Office/Tlp/rece.ascx" TagPrefix="oa" TagName="rece" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>新建公文</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <ol id="BreadNav" class="breadcrumb fixed-top">
        <li class="breadcrumb-item"><a href="/Office/Main.aspx">办公管理</a></li>
        <li class="breadcrumb-item"><a href="FlowList.aspx">流程管理</a></li>
        <li class="breadcrumb-item">
            <asp:Label runat="server" ID="CurPage_L"></asp:Label>
            [<a href="javascript:;" onclick="ShowImgDiag(<%=ProID %>)">查看流程图</a>]</li>
    </ol>
    <div class="list_choice container-fluid p-0">
	<div class="pr-1 pl-1 table-responsive-md">
    <asp:Panel runat="server" ID="OAForm_Div">
        <oa:send runat="server" ID="ascx_send" Visible="false" />
        <oa:rece runat="server" ID="ascx_rece" Visible="false" />
        <oa:defTlp runat="server" ID="ascx_def" Visible="false" />
    </asp:Panel>
    <table class="table table-bordered table_red1">
        <tr><td class="text-right">公文编辑器：</td><td><input type="button" onclick="ShowWord();" class="btn btn-outline-info" value="打开公文" /></td></tr>
        <tr runat="server" id="attach_tr">
            <td class="text-right td_md">附件：</td>
            <td>
                <input type="button" id="upfile_btn" class="btn btn-outline-info" value="添加文件" />
                <div  id="uploader" class="uploader mt-2">
                    <ul class="filelist"></ul>
                </div>
                <asp:HiddenField runat="server" ID="Attach_Hid" />
            </td>
        </tr>
        <tr runat="server" id="ReferUser_TR">
            <td>
                <input type="button" class="btn btn-info pull-right" onclick="selrefer();" value="主办人" runat="server" id="ReferUser_Btn" /></td>
            <td>
                <asp:Label runat="server" ID="ReferUser_T" ></asp:Label>
                <asp:HiddenField runat="server" ID="ReferUser_Hid" />
            </td>
        </tr>
        <tr runat="server" id="CCUser_TR">
            <td><input type="button" class="btn btn-primary pull-right" onclick="selccuser();" value="协办人" runat="server" id="CCUser_Btn" /></td>
            <td>
                <asp:Label runat="server" ID="CCUser_T" ></asp:Label>
                <asp:HiddenField runat="server" ID="CCUser_Hid" />
            </td>
        </tr>
        <tr runat="server" id="HelpUser_TR">
            <td><input type="button" class="btn btn-primary pull-right" onclick="selhelpuser();" value="辅办人" runat="server" id="HelpUser_Btn" /></td>
             <td>
                <asp:Label runat="server" ID="HelpUser_T" ></asp:Label>
                <asp:HiddenField runat="server" ID="HelpUser_Hid" />
            </td>
        </tr>
        <tr>
            <td class="text-right">操作：</td>
            <td>
                <asp:Button runat="server" ID="Save_Btn" OnClientClick="return CheckData();" Text="添加发文" OnClick="Save_Btn_Click" CssClass="btn btn-info" />
                <a href="FlowList.aspx" class="btn btn-outline-info">返回列表</a></td>
        </tr>
    </table>
	</div>
	</div>
     <asp:HiddenField runat="server" ID="FName_Hid" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<script src="/JS/ICMS/ZL_Common.js"></script>
<script src="/JS/DatePicker/WdatePicker.js"></script>
<script src="/JS/Controls/ZL_Dialog.js"></script>
<script src="/JS/Controls/ZL_Webup.js"></script>
<script src="/JS/ZL_Regex.js"></script>
<link href="/JS/Controls/ZL_Webup.css" rel="stylesheet" />
<script>
    var diag = new ZL_Dialog();//用于word文档
   
    $(function () {
        ZL_Webup.config.json.ashx = "action=OAattach";
        $("#upfile_btn").click(ZL_Webup.ShowFileUP);
        if (!ZL_Regex.isEmpty($("#Attach_Hid").val())) {
            var files = $("#Attach_Hid").val().split('|');
            $("#Attach_Hid").val("");
            for (var i = 0; i < files.length; i++) {
                AddAttach(files[i], { _raw: files[i] }, {});
            }
        }
    })
    function AddAttach(file, ret, pval) { return ZL_Webup.AddAttach(file, ret, pval); }
    function WordBack(fname) { $("#FName_Hid").val(fname); }
    function ShowDiag(url, title) {
        //diag.reload = false;
        diag.maxbtn = false;
        diag.title = title;
        diag.url = url;
        diag.ShowModal();
        console.log("here");
    }
    function ShowWord() {
        var appid=parseInt("<%:Mid%>");
        var url="/Plugins/Office/office.aspx?Action=add&ProID=<%=ProID%>&fname=" + $("#FName_Hid").val();
        if (appid > 0) {
            var url = "/Plugins/Office/office.aspx?ID=" + appid;
        }
        ShowDiag(url, "正文管理");
    }
    function ShowImgDiag(proID) {
        ShowComDiag("ImgWorkFlow.aspx?proid=" + proID, "查看流程图");
    }
    function CheckData() {
        if ($("#ReferUser_Hid").length > 0) {
            var val = $("#ReferUser_Hid").val();
            if (ZL_Regex.isEmpty(val)) {
                alert("主办人不能为空"); return false;
            }
        }
        if (ZL_Regex.isEmpty($("#Title_T").val())) {
            alert("标题不能为空");
            return false;
        }
        if (!confirm("确定要保存吗?")) { return false; }
        return true;
    }
    //------
    function selrefer() {
        ShowComDiag("/Common/Dialog/SelStructure.aspx?Type=AllInfo#ReferUser", "选择成员");
    }
    function selccuser() {
        ShowComDiag("/Common/Dialog/SelStructure.aspx?Type=AllInfo#CCUser", "选择成员");
    }
    function selhelpuser() { ShowComDiag("/Common/Dialog/SelStructure.aspx?Type=AllInfo#HelpUser", "选择成员"); }
    function UserFunc(json, select) {
        return user.deal_def(json, select);
    }

	
</script>
</asp:Content>
