﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SaleByProduct.aspx.cs" Inherits="ZoomLaCMS.Manage.Shop.SaleReport.SaleByProduct" MasterPageFile="~/Manage/I/Index.Master"%>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title><%=Resources.L.销售详情 %></title>
		<%=Call.SetBread( new Bread[] {
	new Bread("ProductManage.aspx",Resources.L.商城管理),
	new Bread(){url="TotalSale.aspx", text=Resources.L.按商品统计}
	}) %>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div id="BreadDiv" class="container-fluid" style="height:10px;">
    <div class="row">
	    <ol id="BreadNav" class="breadcrumb navbar-fixed-top">
            <li><a href="ProductManage.aspx"><%=Resources.L.商城管理 %></a></li>
            <li><a href="TotalSale.aspx"><%=Resources.L.按商品统计 %></a></li>
            <div id="help" class="pull-right text-center"><a href="javascript:;" class="help_btn active" onclick="selbox.toggle();"><i class="zi zi_search"></i></a></div>
            <div id="sel_box">
                <div class="input-group" style="display: inline-block;">
                    <asp:TextBox runat="server" ID="SDate_T" class="form-control text_md" placeholder="<%=Resources.L.起始时间 %>" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd' });" />
                    <asp:TextBox runat="server" ID="EDate_T" class="form-control text_md" placeholder="<%=Resources.L.结束时间 %>" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd' });" />
                    <span class="input-group-btn">
                        <asp:LinkButton runat="server" ID="Search_Btn" OnClick="Search_Btn_Click" class="btn btn-default"><i class="zi zi_search"></i></asp:LinkButton>
                    </span>
                </div>
            </div>
	    </ol>
    </div>
</div>
<div class="date_wrap list_choice">
    <div class="item d-flex flex-wrap">
        <strong><%=Resources.L.年份 %> ：</strong>
        <div class="btn-group d-flex flex-wrap" id="years_div">
            <asp:Literal ID="Years_Li" runat="server"></asp:Literal>
        </div>
    </div>
    <div class="item d-flex flex-wrap">
        <strong><%=Resources.L.月份 %> ：</strong>
        <div class="btn-group d-flex flex-wrap">
            <asp:Literal ID="Months_Li" runat="server"></asp:Literal>
        </div>
    </div>
</div>
<div id="condiv">
<table class="table table-bordered table-striped">
    <tr><td><%=Resources.L.商品名称 %></td><td><%=Resources.L.销售数 %></td><td><%=Resources.L.所属类别 %></td><td><%=Resources.L.销售金额 %></td></tr>
    <asp:Repeater runat="server" ID="RPT">
        <ItemTemplate>
            <tr><td><a href="<%#CustomerPageAction.customPath2+"/Shop/ShowProduct.aspx?id="+Eval("ProID") %>" title="<%=Resources.L.查看商品 %>"><%#Eval("ProName") %></a></td><td><%#Eval("Pronum") %></td><td><%#Eval("NodeName") %></td><td><%#Eval("AllMoney","{0:f2}") %></td></tr>
        </ItemTemplate>
    </asp:Repeater>
</table>
</div>
<div class="Conent_fix">
<%--    在线支付：<asp:Label runat="server" ID="PayOnline_L" class="rd_red_l" />
    余额支付：<asp:Label runat="server" ID="PayPurse_L" class="rd_red_l" />--%>
        <input type="button" value="<%=Resources.L.Excel导出 %>" onclick="OutToExcel();" class="btn btn-info" />
    <%=Resources.L.销售总计 %> ：<asp:Label runat="server" ID="TotalSale_L" class="rd_red_l" />
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script src="/JS/DatePicker/WdatePicker.js"></script>
<script src="/JS/Controls/DateHelper.js"></script>
<script src="/JS/Label/ZLHelper.js"></script>
<script>
    $(function () {
        $(".filter_year").click(function () {
            $(".filter_year").removeClass("active");
            $(this).addClass("active");
            filter();
        });
        $(".filter_month").click(function () {
            $(".filter_month").removeClass("active");
            $(this).addClass("active");
            filter();
        });
    })
    function filter() {
        var year = $(".filter_year.active").data("num");
        var month = $(".filter_month.active").data("num");
        var stime, etime;
        if (year == "0") { stime = ""; etime = ""; }
        else if (month == "0") {
            stime = year + "/01/01";
            etime = year + "/12/" + DateHelper.getMonthDays(year, 12);
        }
        else {
            stime = year + "/" + month + "/01";
            etime = year + "/" + month + "/" + DateHelper.getMonthDays(year, month);
        }
        location = "SaleByProduct.aspx?stime=" + stime + "&etime=" + etime+"&nodeid=<%:NodeID%>";
    }
    function OutToExcel() {
        var $html = $(document.getElementById("condiv").outerHTML);
        $html.find("td").css("border", "1px solid #666");
        ZLHelper.OutToExcel($html.html(), $("title").text());
    }
</script>
</asp:Content>