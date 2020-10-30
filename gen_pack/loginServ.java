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
import java.sql.ResultSet;
import java.sql.SQLException;
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
public class loginServ extends HttpServlet {

    boolean ubool = true, pbool = true;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String user = request.getParameter("login_username");
        String password = request.getParameter("login_pass");

        val(user, password, session);
        if (ubool && pbool) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/fallonweb";
                String dbuser = "root";
                String user_password = "Mauryadb@505";
                Connection connection = DriverManager.getConnection(url, dbuser, user_password);
                String cmd = "select * from admintable where username = ?";
                PreparedStatement pst = connection.prepareStatement(cmd);
                pst.setString(1, user);
                ResultSet rs = pst.executeQuery();
                if (rs.next() && rs != null) {
                    if (rs.getString("password").equals(password)) {
                        session.setAttribute("signed", "true");
                        response.sendRedirect(response.encodeRedirectURL("addProd.jsp"));
                    } else {
                        session.setAttribute("login_cred_err", "Invalid username or password!");
                        response.sendRedirect(response.encodeRedirectURL(request.getHeader("referer")));
                    }
                } else {
                    session.setAttribute("login_cred_err", "Invalid username or password!");
                    response.sendRedirect(response.encodeRedirectURL(request.getHeader("referer")));
                }

            } catch (ClassNotFoundException ex) {
                Logger.getLogger(loginServ.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(loginServ.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            session.setAttribute("login_username_trial", user);
            session.setAttribute("login_pass_trial", password);
            response.sendRedirect(response.encodeRedirectURL(request.getHeader("referer")));
        }

    }

    private void val(String user, String password, HttpSession session) {

        if (user == null || user.isEmpty()) {
            session.setAttribute("username_err", "Enter your username");
            ubool = false;
        }
        if (password == null || password.isEmpty()) {
            session.setAttribute("username_err", "Enter your password");
            pbool = false;
        }

    }

}
