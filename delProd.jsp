<%-- 
    Document   : delProd
    Created on : Oct 21, 2018, 5:43:54 PM
    Author     : Anuj
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String sign_in = (String) session.getAttribute("signed");

    if (sign_in == null) {
        response.sendRedirect(response.encodeRedirectURL("http://fallonindia.com/"));
    }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Delete Product</title>
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Aldrich">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700">
        <link rel="stylesheet" href="assets/css/dd.css">
        <link rel="stylesheet" href="assets/css/Footer-Dark.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.1.1/aos.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.3.1/css/swiper.min.css">
        <link rel="stylesheet" href="assets/css/Navigation-Clean.css">
        <link rel="stylesheet" href="assets/css/s-product-catalog.css">
        <link rel="stylesheet" href="assets/css/Simple-Slider.css">
        <link rel="stylesheet" href="assets/css/styles.css">
    </head>
    <body>
        <form method="post" name="delpform">
            <table>
                <tr>
                    <td><select id="catlist_id" name="catlist_del" form="delpform">
                            <%                                Class.forName("com.mysql.jdbc.Driver");
                                String url = "jdbc:mysql://localhost:3306/fallonweb";
                                String user = "root";
                                String user_password = "GlobalFallon420";
                                Connection connection = DriverManager.getConnection(url, user, user_password);
                                String cmd;
                                ResultSet rs;
                                cmd = "select cat from gen";
                                Statement stmt = connection.createStatement();
                                rs = stmt.executeQuery(cmd);
                                String tmpcat;
                                if (rs != null && rs.next()) {
                                    while (!rs.isAfterLast()) {

                                        tmpcat = rs.getString("cat");
                                        rs.next();
                            %>
                            <option value="<%=tmpcat%>"><%=tmpcat%></option>
                            <%                                    }
                                }
                                stmt.clearBatch();

                            %>
                        </select></td>
                    <td><button type="button" onclick="red()">View --></button></td>
                    <td><a href="addProd.jsp">Add Product</a></td>
                <tr>
                    <td>
                        <%                            String progress = (String) session.getAttribute("progress");
                            session.removeAttribute("progress");
                            if (progress != null) {

                        %> 
                        <%=progress%>
                        <%
                            }
                        %>

                    </td>
                </tr>
                <tr>
                    <td><a href="logoutServ">Logout</a></td>
                </tr>
                </tr>
                <tr>
                    <td>
                        <%                            String err = (String) session.getAttribute("err");
                            session.removeAttribute("err");
                            if (err != null) {

                        %> 
                        <%=err%>
                        <%
                            }
                        %>

                    </td>
                </tr>
            </table>
        </form>

        <%            String delProd = request.getParameter("dellist");
            if (delProd != null) {


        %>
        <div style="padding-bottom:50px;">
            <div class="container">
                <%                String name, lpath, link;
                    int prod = 0;
                    rs = null;
                    String delLink = "http://fallonindia.com/prodDel?del=";

                    cmd = "select id,lpath from " + delProd;
                    stmt = connection.createStatement();
                    rs = stmt.executeQuery(cmd);
                    if (rs.first()) {

                        while (!rs.isAfterLast()) {
                            prod++;
                            if (prod % 13 == 0) {
                                break;
                            }

                %>


                <div class="row" style="margin-bottom: 40px">
                    <%                            while (prod % 4 != 0) {
                            if (rs.isAfterLast()) {
                                break;
                            }
                            int id = rs.getInt("id");
                            lpath = rs.getString("lpath");

                            link = delLink + delProd + "&id=" + id;
                            prod++;
                            rs.next();
                    %>
                    <div class="col-md-4">
                        <div class="border">
                            <div class="wrap">
                                <div class="product-wrap"><a href><img id="home_prod" src="<%=lpath%>" /></a></div>
                                <div class="loop-action"><a href="<%=link%>" class="add-to-cart">Delete</a></div>
                            </div>

                        </div>
                    </div>
                    <%                            }

                    %>
                </div>
                <%                            }

                %>
            </div>
            <%                            } else {

            %>
            <h1 style="color: #F2453E">NO PRODUCTS YET</h1>
            <% }%>
        </div>
        <% }%>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/js/bs-animation.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.1.1/aos.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.3.1/js/swiper.jquery.min.js"></script>
        <script src="assets/js/Simple-Slider1.js"></script>
    </body>
</html>
<script type="text/javascript">

                        function red() {
                            var linkV = "http://fallonindia.com/delProd.jsp?dellist=";
                            var prod = document.getElementById("catlist_id").value;
                            window.location = linkV + prod;
                        }
</script>