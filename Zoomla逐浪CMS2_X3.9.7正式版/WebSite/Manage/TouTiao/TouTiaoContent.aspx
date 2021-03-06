﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TouTiaoContent.aspx.cs" Inherits="ZoomLaCMS.Manage.TouTiao.TouTiaoContent" MasterPageFile="~/Manage/I/Index.master" %>

<asp:Content runat="server" ContentPlaceHolderID="head"><title>内容管理</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <ol class="breadcrumb fixed-top">
        <li class="breadcrumb-item"><a href='<%=CustomerPageAction.customPath2 %>Main.aspx'>工作台</a></li>
        <li class="breadcrumb-item"><a href='TouTiaoContent.aspx'>头条号管理</a></li>
        <li class="breadcrumb-item">内容管理 <a href='AddTouTiaoContent.aspx'> [发布文章]</a> <a href='AddTouTiaoVideo.aspx'> [发布视频]</a></li>
        <div id="help" class="pull-right text-center mr-2"><a href="javascript:;" onclick="selbox.toggle();" id="sel_btn" class="help_btn"><i class="zi zi_search"></i></a></div>
        <div id="sel_box" runat="server">
            <div class="input-group pull-left max20rem">
                <asp:TextBox runat="server" ID="SKey" CssClass="form-control" placeholder="请输入文章标题" />
                <span class="input-group-append">
                    <asp:Button ID="Search_B" CssClass="btn btn-outline-secondary" runat="server" Text="搜索" OnClick="Search_B_Click" />
                </span>
            </div>
        </div>
    </ol>
	<div class="list_choice">
    <div class="alert alert-warning alert-dismissible fade show" >
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
        <span><strong>提示：</strong></span>
        投递成功的文章可登录头条号，在文章管理处查看， <a href="https://mp.toutiao.com/core/article/index/?source_type=0" target="_blank"><i class="zi zi_sharealt"></i>前往查看</a>
    </div>
    <ul class="nav nav-tabs">
        <li class="nav-item" id="all_li"><a class="nav-link" href="TouTiaoContent.aspx">全部</a></li>
        <li class="nav-item" id="issave_li"><a class="nav-link" href="TouTiaoContent.aspx?issave=1">发布</a></li>
        <li class="nav-item" id="nosave_li"><a class="nav-link" href="TouTiaoContent.aspx?issave=0">草稿</a></li>
    </ul>
<div class="table-responsive-md pr-1">
    <ZL:ExGridView ID="EGV" runat="server" PageSize="20" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover" OnRowDataBound="EGV_RowDataBound"
        EnableTheming="False" AllowPaging="true" EmptyDataText="<%$Resources:L,当前没有信息 %>" OnPageIndexChanging="EGV_PageIndexChanging" OnRowCommand="EGV_RowCommand">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <input type="checkbox" name="idchk" value='<%#Eval("ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="ID" DataField="ID" />
            <asp:BoundField HeaderText="标题" DataField="Title" />
            <asp:BoundField HeaderText="作者" DataField="UserName" />
            <asp:TemplateField HeaderText="状态">
                <ItemTemplate>
                    <%# Eval("Status","").Equals("1") ? "<span class='text-primary'>成功</span>" : "<span class='text-danger'>失败</span>" %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="发文类型">
                <ItemTemplate>
                    <%# Eval("IsSave","").Equals("1") ? "发布" : "草稿" %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="文章类型">
                <ItemTemplate>
                    <%# Eval("NewsType","").Equals("1") ? "视频" : "文章" %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="文章分类">
                <ItemTemplate>
                    <%#GetContentType(Eval("Type",""),Eval("NewsType","")) %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="备注信息" DataField="ErrMsg" />
            <asp:BoundField HeaderText="发布时间" DataField="CreateDate" />
            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                    <a href="ShowTouTiaoContent.aspx?ID=<%#Eval("ID") %>" ><i class="zi zi_listul" zico="无序列表"></i>详情</a>
                    <asp:LinkButton runat="server" CommandArgument='<%#Eval("ID") %>' CommandName="del" OnClientClick="return confirm('此操作不会删除头条号中的信息，确认删除吗？')" ><i class="zi zi_trashalt" title="删除"></i>删除</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </ZL:ExGridView>
	</div>
	</div>
    <div class="sysBtline">
        <asp:Button ID="DelBatch_B" runat="server" Text="批量删除" OnClientClick="return confirm('此操作不删除头条号中的信息，确认删除选中记录吗？');" OnClick="DelBatch_B_Click" CssClass="btn btn-outline-danger" />
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script>
        $(function () {
            var issave = <%=IsSave%>;
            if(issave==1){ $("#issave_li").find("a").addClass("active"); }
            else if(issave==0){ $("#nosave_li").find("a").addClass("active"); }
            else{ $("#all_li").find("a").addClass("active"); }
        });
    </script>
</asp:Content>
