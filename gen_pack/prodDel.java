/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gen_pack;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Anuj
 */
public class prodDel extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fileLoc = File.separator + "opt" + File.separator + "tomcat" + File.separator + "webapps" + File.separator + "ROOT" + File.separator;
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        if (session.getAttribute("signed") == null) {
            response.sendRedirect(response.encodeRedirectURL(request.getHeader("referer")));
        } else {
            String prodname = request.getParameter("del");
            int id;
            if (request.getParameter("id") != null) {
                id = Integer.parseInt(request.getParameter("id"));
            } else {
                id = -1;
            }

            if (prodname == null || id == -1) {
                session.setAttribute("err", "No such product");
                response.sendRedirect(response.encodeRedirectURL(request.getHeader("referer")));
            }
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/fallonweb";
                String user = "root";
                String user_password = "Mauryadb@505";
                Connection connection = DriverManager.getConnection(url, user, user_password);
                String cmd = "select lpath from " + prodname + " where id = " + id;
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(cmd);
                if (rs.first()) {
                    String lpath = rs.getString("lpath");
                    cmd = "delete from " + prodname + " where id=" + id;
                    stmt.clearBatch();
                    int r = stmt.executeUpdate(cmd);
                    if (r > 0) {
                        File deleteFile = new File(fileLoc + lpath);

                        if (deleteFile.exists()) {
                            deleteFile.delete();
                        }
                        deleteFile = new File(fileLoc + lpath.replace("low", "high"));
                        if (deleteFile.exists()) {
                            deleteFile.delete();
                        }
                        session.setAttribute("progress", "Deleted successfully.");
                        response.sendRedirect(response.encodeRedirectURL(request.getHeader("referer")));
                    } else {
                        session.setAttribute("err", "Something went wrong. Please try again after sometime.");
                        response.sendRedirect(response.encodeRedirectURL(request.getHeader("referer")));
                    }
                } else {
                    session.setAttribute("err", "No such product");
                    response.sendRedirect(response.encodeRedirectURL(request.getHeader("referer")));
                }
            } catch (ClassNotFoundException | SQLException ex) {
                out.println(ex);
            }
        }
    }
}
