<%-- 
    Document   : login
    Created on : Oct 20, 2018, 4:12:02 PM
    Author     : Anuj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String sign_in = (String) session.getAttribute("signed");

    if (sign_in != null) {
        response.sendRedirect(response.encodeRedirectURL("http://fallonindia.com/addProd.jsp"));
    }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div>
            <form onsubmit="javascript: return val();" action="loginServ" id="login_form" method="post">
                <table>
                    <tr>
                        <td>Username:</td>
                        <%                            String username_trial = (String) session.getAttribute("login_username_trial");
                            session.removeAttribute("login_username_trial");
                            if (username_trial == null) {
                                username_trial = "";
                            }
                        %>
                        <td><input type="text" id="login_username_id" name="login_username" value="<%=username_trial%>" required="true"></td>
                            <%
                                String username_err = (String) session.getAttribute("username_err");

                                if (username_err != null) {

                            %>
                        <td><%=username_err%></td>
                        <%
                                session.removeAttribute("username_err");
                            }
                        %>
                    </tr>
                    <tr>
                        <td>Password: </td>
                        <%
                            String pass_trial = (String) session.getAttribute("login_pass_trial");
                            session.removeAttribute("login_pass_trial");
                            if (pass_trial == null) {
                                pass_trial = "";
                            }

                        %>
                        <td><input type="password" id="login_pass_id" name="login_pass" value="<%=pass_trial%>" required="true"></td>

                        <%
                            String pass_err = (String) session.getAttribute("pass_err");
                            if (pass_err != null) {

                        %>
                        <td><%=pass_err%></td>
                        <%
                                session.removeAttribute("pass_err");
                            }
                        %>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <a><button class="button" onclick="val()"><span>Login</span></button></a>
                        </td>
                    </tr>
                    <%
                        String cred_err = (String) session.getAttribute("login_cred_err");
                        String err = (String) session.getAttribute("err");
                        if (cred_err != null) {

                    %>
                    <table>
                        <tr>
                            <td><%=cred_err%></td>
                        </tr>
                        <%
                                session.removeAttribute("login_cred_err");
                            }
                            if (err != null) {

                        %>

                        <tr>
                            <td><%=err%></td>
                        </tr>
                        <%
                                session.removeAttribute("err");
                            }
                        %>


                    </table>
            </form>
        </div>
    </body>
</html>
<script type="text/javascript">

    function val() {

        var user = document.getElementById("login_username_id");
        var pass = document.getElementById("login_pass_id");

        if (user.value === "") {
            user.setCustomValidity("Required");
        } else {
            user.setCustomValidity('');
        }
        if (pass.value === "") {
            pass.setCustomValidity("Required");
        } else {
            pass.setCustomValidity('');
        }


    }
</script>