<%-- 
    Document   : addProd
    Created on : Oct 19, 2018, 6:38:06 PM
    Author     : Anuj
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
        <title>JSP Page</title>
    </head>
    <body>


        <form action="prodAdd" method="post" id="addpform" enctype="multipart/form-data">
            <table>
                <tr>
                    <td>Category: </td>
                    <td><select id="catlist_id" name="catlist" form="addpform">
                            <%
                                Class.forName("com.mysql.jdbc.Driver");
                                String url = "jdbc:mysql://localhost:3306/fallonweb";
                                String user = "root";
                                String user_password = "GlobalFallon420";
                                Connection connection = DriverManager.getConnection(url, user, user_password);
                                String cmd = "select cat from gen";
                                Statement stmt = connection.createStatement();
                                ResultSet rs = stmt.executeQuery(cmd);
                                String tmpcat;
                                if (rs != null && rs.next()) {
                                    while (!rs.isAfterLast()) {

                                        tmpcat = rs.getString("cat");
                                        rs.next();
                            %>
                            <option value="<%=tmpcat%>"><%=tmpcat%></option>
                            <%                                    }
                                }
                                stmt.close();
                                connection.close();
                            %>
                        </select></td>
                </tr>
                <tr>
                    <td>Description: </td>
                    <td><textarea rows="4" cols="50" name="desc" form="addpform" required="true"/></textarea></td>
                </tr>
                <tr>
                    <td>Low Resolution image -</td>
                    <td><input type = "file" name = "fileL" size = "50" required="true" accept="image/png, image/jpeg, image/jpg" /></td>
                </tr>

                <tr>
                    <td>High Resolution image -</td>
                    <td><input type = "file" name = "fileH" id="fileH_id" size = "50" required="true" accept="image/png, image/jpeg, image/jpg" /></td>
                </tr>

                <tr>
                    <td><button class="button">Upload</button></td>
                    <td><a href="delProd.jsp">Delete Product</a></td>
                </tr>
                <tr>
                    <td><a href="logoutServ">Logout</a></td>
                </tr>
                <tr>
                    <td>
                        <%                            String err = (String) session.getAttribute("err");
                            if (err != null) {
                                out.println(err);
                            }

                        %>
                    </td>
                </tr>
            </table>
        </form>

    </body>
</html>
