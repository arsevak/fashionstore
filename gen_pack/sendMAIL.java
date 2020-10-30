/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gen_pack;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Anuj
 */
public class sendMAIL extends HttpServlet {

    private final String regex_email = "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    private boolean nameBool, noBool, emailBool, msgBool;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String name = request.getParameter("name");
        String c_email = request.getParameter("email");
        String c_no = request.getParameter("number");
        String a_email = "fallonleggings@gmail.com";
        String msg = request.getParameter("message");
        val(name, c_no, c_email, msg, session);
        if (nameBool && noBool && emailBool && msgBool) {
            String subject = "Inquiry";
            String ac_msg = "- Customer's Inquiry -" + "\n" + "Name: " + name + "\n" + "Contact number: " + c_no + "\n" + "Email id: " + c_email + "\n" + "Message: " + msg + "\n";
            String user = "fallonweb420@gmail.com";
            String user_password = "globalit";
            String result_mail = Mail.send(a_email, subject, ac_msg, user, user_password);
            if (result_mail.equalsIgnoreCase("gg")) {
                session.setAttribute("mail_err", "Message successfully sent.");
                response.sendRedirect(response.encodeRedirectURL("contact.jsp"));
            } else {
                session.setAttribute("mail_err", "Unable to send message. Please try again some time.");
                response.sendRedirect(response.encodeRedirectURL("contact.jsp"));
            }
        } else {
            response.sendRedirect(response.encodeRedirectURL("contact.jsp"));
        }
    }

    private void val(String name, String email, String msg, String number, HttpSession session) {
        if (name != null || !name.isEmpty()) {
            nameBool = true;
        } else {
            session.setAttribute("mail_err", "Please enter last name.");
        }
        if (number != null || !number.isEmpty() || number.length() < 14) {
            noBool = true;
        } else {
            session.setAttribute("mail_err", "Please enter valid contact number.");
        }
        if (valemail(email) || !email.isEmpty() || email != null) {
            emailBool = true;
        } else {
            session.setAttribute("mail_err", "Please enter valid email");
        }
        if (!msg.isEmpty() || msg != null) {
            msgBool = true;
        } else {
            session.setAttribute("mail_err", "Please enter your message");
        }
    }

    private boolean valemail(String email) {
        Pattern p = Pattern.compile(regex_email);
        Matcher m = p.matcher(email);
        boolean b = m.matches();
        return b;
    }
}
