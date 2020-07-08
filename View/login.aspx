<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login"%>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%: Page.Title %> - HR Application</title>

    <link href="<%=ResolveClientUrl("~/fonts/fontawesome/css/all.css")%>" rel="stylesheet">
    <link href="<%=ResolveClientUrl("~/fonts/fontawesome/css/brands.css")%>" rel="stylesheet">
    <link href="<%=ResolveClientUrl("~/fonts/fontawesome/css/solid.css")%>" rel="stylesheet">
    <script src="<%=ResolveClientUrl("~/Scripts/jquery/jquery.min.js")%>" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/LoginStyle/fonts/font-awesome-4.7.0/css/font-awesome.min.css")%>">
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/LoginStyle/fonts/Linearicons-Free-v1.0.0/icon-font.min.css")%>">
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/LoginStyle/vendor/animate/animate.css")%>">
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/LoginStyle/vendor/css-hamburgers/hamburgers.min.css")%>">
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/LoginStyle/vendor/animsition/css/animsition.min.css")%>">
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/LoginStyle/vendor/select2/select2.min.css")%>">
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/LoginStyle/vendor/daterangepicker/daterangepicker.css")%>">
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/LoginStyle/css/util.css")%>">
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/LoginStyle/css/main.css")%>">
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/LoginStyle/css/style.css")%>" />
    <link rel="stylesheet" type="text/css" href="<%=ResolveClientUrl("~/css/sweetalert.css")%>" />
    <link href="<%=ResolveClientUrl("~/Content/bootstrap.css")%>" rel="stylesheet" />
    <link href="<%=ResolveClientUrl("~/Content/bootstrap-grid.min.css")%>" rel="stylesheet" />
    <link href="<%=ResolveClientUrl("~/Content/bootstrap-reboot.min.css")%>" rel="stylesheet" />
    <link rel="shortcut icon" type="image/x-icon" href="<%=ResolveClientUrl("~/images/favicon.ico")%>" />
    <style>
        body, html {
            height: auto;
            margin: 0;
            background-color: #b61924;
        }

        form {
            position: relative;
            height: 100vh;
        }

        .form__login {
            margin: 0;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        input[type="text"],
        input[type="password"],
        input[type="text"]:focus {
            border-bottom: 1px solid #ddd !important;
        }

        .form__login .img-header img {
            width: 100px;
            z-index: 1;
        }

        /* ---- reset ---- */
        canvas {
            display: block;
            vertical-align: bottom;
        }

        /* ---- particles.js container ---- */

        #particles-js {
            position: absolute;
            width: 100%;
            height: 100%;
            background-color: #b61924;
            background-image: url("");
            background-repeat: no-repeat;
            background-size: cover;
            background-position: 50% 50%;
        }

        .bg-logo-wse {
            height: 450px;
            background: #153359;
            border-radius: 10px 0 0 10px;
            box-shadow: 0px 0px 5px 0px rgba(0, 0, 0, 0.5);
        }

        .bg-form-wse {
            background: #fff;
            border-radius: 0 10px 10px 0;
            box-shadow: 0px 0px 5px 0px rgba(0, 0, 0, 0.5);
        }

        .mascot-woman {
            position: absolute;
            top: -79px;
            right: 0;
            width: 100px;
        }

        .content-center {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        img.content-center {
            width: 50%;
        }

        h2 {
            font-size: 1.5rem !important;
        }

        @media(max-width:575px) {
             img.content-center {
                width: auto;
                height: 60%;
            }
            .bg-logo-wse {
                 height: 120px;
                border-radius: 10px 10px 0 0;
            }

            .bg-form-wse {
                border-radius: 0 0 10px 10px;
            }
        }
        @media(max-width:768px) {
            .form__login {
                top: 1% !important;
                transform: translate(-50%, 0%) !important;
            }
        }
    </style>
</head>
<body>
   <form id="form1" method="POST" runat="server">
       <!-- particles.js container -->
        <div id="particles-js"></div>
        <div class="row">
            <div class="col-lg-7 col-md-9 col-sm-11 col-11 form__login">
                <div class="row">
                    <div class="col-12 img-header text-right d-lg-block d-md-block d-sm-block d-none">
                        <img src="<%=ResolveClientUrl("~/images/mascot/herry-welcomeV2.png")%>" />
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-12 py-lg-5 py-md-5 py-sm-3 py-3 bg-logo-wse">
                        <img src="<%=ResolveClientUrl("~/images/wse-logo-v-light.png")%>" class="content-center"/>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-12 px-lg-4 px-md-4 px-sm-3 p-5 bg-form-wse">
                        <img src="<%=ResolveClientUrl("~/images/mascot/woman-welcome.png")%>" class="mascot-woman d-lg-none d-md-none d-sm-none d-block"/>
                        <h2 class="p-0 blue-color"><b>HR Application</b></h2>
                        <div class="w3l-form-group">
                            <label>Username:</label>
                            <div class="group">
                                <i class="fas fa-user"></i>
                                <input id="txtUsername" type="text" name="username" placeholder="Username" autofocus="" required="required" runat="server">
                            </div>
                        </div>
                        <div class=" w3l-form-group">
                            <label>Password:</label>
                            <div class="group">
                                <i class="fas fa-unlock"></i>
                                <input id="txtPassword" type="password" name="pass" placeholder="Password" required="required" runat="server">
                            </div>
                        </div>
                        <div class="forgot">
                            <div class="contact100-form-checkbox">
                                <input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me">
                                <label class="label-checkbox100" for="ckb1">
                                    Remember me
                                </label>
                            </div>
                        </div>
                        <asp:Button ID="BtnSubmit" runat="server" Text="Login" class="btn btn-danger p-2" OnClick="BtnSubmit_Click" />
                        <asp:HiddenField ID="hdfstat" Value="" runat="server" />
                    </div>
                </div>
            </div>
        </div>
       <!--  Plugin for Sweet Alert -->
        <script src="<%=ResolveClientUrl("~/Scripts/jquery/jquery.min.js")%>" type="text/javascript"></script>
        <script src="<%=ResolveClientUrl("~/Scripts/jquery/popper.min.js")%>"></script>
        <script src="<%=ResolveClientUrl("~/Scripts/bootstrap/bootstrap.min.js")%>"></script>

	    <script src="<%=ResolveClientUrl("~/LoginStyle/vendor/select2/select2.min.js")%>"></script>
	    <script src="<%=ResolveClientUrl("~/LoginStyle/vendor/daterangepicker/moment.min.js")%>"></script>
	    <script src="<%=ResolveClientUrl("~/LoginStyle/vendor/daterangepicker/daterangepicker.js")%>"></script>
	    <script src="<%=ResolveClientUrl("~/LoginStyle/vendor/countdowntime/countdowntime.js")%>"></script>
	    <script src="<%=ResolveClientUrl("~/LoginStyle/js/main.js")%>"></script>

        <link href="<%=ResolveClientUrl("~/LoginStyle/sweetalert2.min.css")%>" rel="stylesheet" />
        <script src="<%=ResolveClientUrl("~/LoginStyle/sweetalert2.min.js")%>"></script>


        <script type="text/javascript">
            $(document).ready(function () {
                $('#ckb1').click(function () {
                    var stat = $(this);
                    if (stat.is(':checked')) {
                        $('#MainContent_hdfstat').val("checked");
                    }
                    else {
                        $('#MainContent_hdfstat').val("Unchecked");
                    }
                });

            });

            function wrongUser() {
                swal({
                    type: 'warning',
                    title: 'Username or Password is incorrect.',
                    text: 'Try again input Username Password like login your laptop',
                    animation: false,
                    customClass: 'animated tada'
                }).then((result) => {
                    if (result.value) {
                        window.location.href = "Login";
                    }
                });
            }

            function permissionOut() {
                swal({
                    type: 'warning',
                    title: 'Permission denied',
                    animation: false,
                    customClass: 'animated tada'
                }).then((result) => {
                    if (result.value) {
                        window.location.href = "Login";
                    }
                });
            }
        </script>
    </form>
</body>
</html>
<script src="<%=ResolveClientUrl("~/Scripts/particles.js")%>"></script>
<script src="<%=ResolveClientUrl("~/Scripts/app.js")%>"></script>

