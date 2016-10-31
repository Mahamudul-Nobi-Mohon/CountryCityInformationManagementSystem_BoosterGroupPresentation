<%@ Page Language="C#" ValidateRequest="false" AutoEventWireup="true" CodeBehind="CountryEntryUI.aspx.cs" Inherits="CountryCityInformationManagementSystem.UI.CountryEntryUI" %>

<%@ Import Namespace="System.Activities.Expressions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <html lang="en" />
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Country Entry Page</title>

    <!-- Bootstrap -->
    <link href="../Bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../alertifyjs/css/alertify.min.css" rel="stylesheet" />
    <link href="../alertifyjs/css/alertify.rtl.min.css" rel="stylesheet" />
    <%--<script src="//cdn.ckeditor.com/4.5.11/standard/ckeditor.js"></script>--%>
    <script type="text/javascript" src="../tinymce/jscripts/tiny_mce/tiny_mce.js"></script>

    <script type="text/javascript">
        tinyMCE.init({
            mode: "textareas",
            theme: "advanced",
            plugins: "safari,spellchecker,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,imagemanager,filemanager",
            theme_advanced_buttons1: "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect",
            theme_advanced_buttons2: "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
            theme_advanced_buttons3: "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
            theme_advanced_buttons4: "insertlayer,moveforward,movebackward,absolute,|,styleprops,spellchecker,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,blockquote,pagebreak,|,insertfile,insertimage",
            theme_advanced_toolbar_location: "top",
            theme_advanced_toolbar_align: "left",
            theme_advanced_statusbar_location: "bottom",
            theme_advanced_resizing: false,
            template_external_list_url: "js/template_list.js",
            external_link_list_url: "js/link_list.js",
            external_image_list_url: "js/image_list.js",
            media_external_list_url: "js/media_list.js",
            height: 300
        });
    </script>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
        .GridviewDiv {
            font-size: 100%;
            font-family: 'Lucida Grande', 'Lucida Sans Unicode', Verdana, Arial, Helevetica, sans-serif;
            color: #303933;
        }

        .headerstyle {
            color: #FFFFFF;
            border-right-color: #abb079;
            border-bottom-color: #abb079;
            background-color: #df5015;
            padding: 0.5em 0.5em 0.5em 0.5em;
            text-align: center;
        }

        p {
            text-align: justify;
            text-justify: inter-word;
            padding-left: 5px;
            padding-right: 5px;
        }

        table, tr, th {
            text-align: center;
        }

        img {
            display: block;
            margin: 0 auto;
        }

        .footer {
            position: fixed;
            left: 0px;
            bottom: 0px;
            height: 30px;
            width: 100%;
            background: #999;
        }

        /* IE 6 */
        * html .footer {
            position: absolute;
            top: expression((0-(footer.offsetHeight)+(document.documentElement.clientHeight ? document.documentElement.clientHeight : document.body.clientHeight)+(ignoreMe = document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop))+'px');
        }
    </style>

    <%-- <script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
    <script>tinymce.init({ selector: 'textarea' });</script>--%>
</head>

<body>

    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">Country City Information</a>
            </div>
            <div class="collapse navbar-collapse" id="myNavbar">
                <ul class="nav navbar-nav">
                    <li><a href="Home.aspx">Home</a></li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Country <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li class="active"><a href="CountryEntryUI.aspx">Country Add</a></li>
                            <li><a href="CountryViewUI.aspx">Country View</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">City <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="CItyEntryUI.aspx">City Add</a></li>
                            <li><a href="CityVIewUI.aspx">City View</a></li>
                        </ul>
                    </li>
                </ul>
                <%--<ul class="nav navbar-nav navbar-right">
                            <li><a href="#"><span class="glyphicon glyphicon-user"></span>Sign Up</a></li>
                            <li><a href="#"><span class="glyphicon glyphicon-log-in"></span>Login</a></li>
                        </ul>--%>
            </div>
        </div>
    </nav>
    <div class="container" style="display: none">
        <div class="col-md-10 col-md-offset-1">

            <%--<div class="col-md-8 col-md-ofset-2">--%>
            <form id="form1" runat="server" class="form-horizontal">

                <div class="form-group">
                    <h3>Country Name </h3>
                    <asp:TextBox ID="nameTextBox" class="form-control" runat="server" Width="329px"></asp:TextBox>

                </div>

                <div class="form-group">
                    <h3>About</h3>
                    <asp:TextBox ID="aboutTextBox" TextMode="MultiLine" class="form-control" runat="server"></asp:TextBox>
                    <asp:FileUpload ID="FileUpload1" class="form-control" runat="server" />
                    <asp:Button ID="btnUpload" runat="server" class="btn btn-info btn-sm" Text="Upload" OnClick="btnUpload_Click" />


                </div>

                <div class="form-group">

                    <input type="submit" id="saveButton" class="btn btn-success btn-lg" value="Save" />

                    <asp:Button ID="cancelButton" runat="server" class="btn btn-info btn-lg" OnClick="cancelButton_Click" Text="Cancel" />
                    &nbsp;<asp:Button ID="showAllButton" runat="server" class="btn btn-warning btn-lg" Text="Show All" OnClick="showAllButton_Click" />

                </div>

                <br />

                <div class="GridviewDiv">
                    <asp:GridView runat="server" ID="countryListGridView" AllowPaging="True" AutoGenerateColumns="False" Width="100%" OnPageIndexChanging="gvDetails_PageIndexChanging" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4">
                        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                        <HeaderStyle CssClass="headerstyle" BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                        <RowStyle HorizontalAlign="Center" />
                        <Columns>

                            <asp:TemplateField HeaderText="serial No">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="countryName" HeaderText="Country Name" />

                            <asp:TemplateField HeaderText="About">
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%#Eval("about") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                        <RowStyle BackColor="White" ForeColor="#330099" />
                        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                        <SortedAscendingCellStyle BackColor="#FEFCEB" />
                        <SortedAscendingHeaderStyle BackColor="#AF0101" />
                        <SortedDescendingCellStyle BackColor="#F6F0C0" />
                        <SortedDescendingHeaderStyle BackColor="#7E0000" />
                    </asp:GridView>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />

                </div>

            </form>

        </div>

    </div>
    <div id="footer" class="footer footer-bottom" style="background-color: black; height: 60px; text-align: center">
        <p style="color: white; padding: 20px">Copyright @ 2016 Websites</p>
    </div>


    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="../alertifyjs/alertify.js"></script>
    <script src="../alertifyjs/alertify.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="../Bootstrap/js/bootstrap.min.js"></script>

    <script>
        $(document)
            .ready(function () {
                $('.container').toggle(3000);
            });
    </script>
    <script type="text/javascript">
        $("#saveButton")
            .click(function (e) {
                e.preventDefault();

                // data.param1 = words[0];

                var name = $('#nameTextBox').val();


                var about = tinyMCE.activeEditor.getContent();
                $('#aboutTextBox').remove();
                $('<textarea id="aboutTextBox" name="aboutTextBox">' + about + '</textarea>').insertAfter($('[name=someinput]'));


                if (name == '') {
                    alertify.error('Please type a Country Name');

                }
                else {
                    $.ajax({
                        type: "POST",
                        url: 'CountryEntryUI.aspx/SaveCountry',
                        //data: "{'countryName':'" +
                        //    name +
                        //    "','countryAbout':'" +
                        //    about +
                        //    "'}",
                        data: JSON.stringify({
                            "countryName": name,
                            "countryAbout": about
                        }),
                        contentType: "application/json; charset=utf-8",
                        cache: false,
                        processData: false,
                        success: function (res) {

                            if (res.d == 1) {
                                alertify.success("Data Saved Successfully !!");
                                $("#form1")[0].reset();
                                $('.website-desc').val('');
                            } else if (res.d == 2) {
                                alertify.error("Country Name Already Exists.");
                            } else {
                                alertify.error("Saved Faild !!");
                            }
                        },
                        error: function (res) {
                            alertify.error("Data Not Saved. Please check your data. !!");
                        }
                    });
                }
            });


    </script>

</body>
</html>
