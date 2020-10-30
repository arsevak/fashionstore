/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gen_pack;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
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
public class AddCategory extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            if (session.getAttribute("signed") == null) {
                response.sendRedirect(response.encodeRedirectURL(request.getHeader("referer")));
                session.setAttribute("err", "Please login to continue..");
            }
            String cat = request.getParameter("cat_name");
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/fallonweb";
            String user = "root";
            String user_password = "Mauryadb@505";
            Connection connection = DriverManager.getConnection(url, user, user_password);
            String cmd = "insert into gen (catg) values(?)";
            PreparedStatement pst = connection.prepareStatement(cmd);
            pst.setString(1, cat);
            pst.executeUpdate();
            cmd = "CREATE TABLE " + cat + " ( catimg TEXT NULL , subcat TEXT NULL ) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_unicode_ci";
            PreparedStatement st = connection.prepareStatement(cmd);
            int t = st.executeUpdate();
            st.close();
            int i = Integer.valueOf(request.getParameter("tot_sub"));
            if (i > 0) {

                if (i > 1) {
                    //ArrayList<String> sub = new ArrayList<String>();
                    for (int n = 1; n <= i; n++) {
                        String subcmd = "insert into " + cat + " (subcat) values(?)";

                        //sub.add(request.getParameter("sub" + n));
                        pst = connection.prepareStatement(subcmd);
                        pst.setString(1, request.getParameter("sub" + n));
                    }

                } else {
                    String subcmd = "insert into " + cat + " (subcat) values(?)";
                    pst = connection.prepareStatement(subcmd);
                    pst.setString(1, request.getParameter("sub1"));
                }
                int j = pst.executeUpdate();
                if (j == 1) {
                    session.setAttribute("err", "Successfully added.");

                } else {
                    session.setAttribute("err", "Something went wrong. Please try again after sometime.");

                }
                response.sendRedirect(response.encodeRedirectURL(request.getHeader("referer")));
            } else {
                if (t == 1) {
                    session.setAttribute("err", "Category added successfully.");

                } else {
                    session.setAttribute("err", "Something went wrong. Please try again after sometime.");

                }
                response.sendRedirect(response.encodeRedirectURL(request.getHeader("referer")));
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddCategory.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AddCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
