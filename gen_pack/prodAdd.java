package gen_pack;

// Import required java libraries
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class prodAdd extends HttpServlet {

    private boolean isMultipart;
    private String filePath;
    private int maxFileSize = 10000 * 1024;
    private int maxMemSize = 15 * 1024;
    private File file;
    private int last;
    String cat = null, des, lpath, hpath;
    java.io.PrintWriter out;

    public void init() {

        // Get the file location where it would be stored.
        filePath = File.separator + "opt" + File.separator + "tomcat" + File.separator + "webapps" + File.separator + "ROOT" + File.separator + "assets" + File.separator + "ess" + File.separator;

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, java.io.IOException {
        HttpSession session = request.getSession();
        String sign_in = (String) session.getAttribute("signed");

        if (sign_in == null) {
            response.sendRedirect(response.encodeRedirectURL("http://fallonindia.com/"));
        } else {

            // Check that we have a file upload request
            isMultipart = ServletFileUpload.isMultipartContent(request);
            response.setContentType("text/html");
            out = response.getWriter();

            if (!isMultipart) {
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Servlet upload</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<p>No file uploaded</p>");
                out.println("</body>");
                out.println("</html>");
                return;
            }

            DiskFileItemFactory factory = new DiskFileItemFactory();

            // maximum size that will be stored in memory
            factory.setSizeThreshold(maxMemSize);

            // Location to save data that is larger than maxMemSize.
            factory.setRepository(new File(File.separator + "opt" + File.separator + "tomcat" + File.separator + "Temp"));

            // Create a new file upload handler
            ServletFileUpload upload = new ServletFileUpload(factory);

            // maximum file size to be uploaded.
            upload.setSizeMax(maxFileSize);

            try {

                // Parse the request to get file items.
                List fileItems = upload.parseRequest(request);

                // Process the uploaded file items
                Iterator i = fileItems.iterator();
                int count = 1;
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Servlet upload</title>");
                out.println("</head>");
                out.println("<body>");

                while (i.hasNext()) {
                    FileItem fi = (FileItem) i.next();
                    if (!fi.isFormField()) {
                        // Get the uploaded file parameters
                        String fieldName = fi.getFieldName();
                        String fileName = fi.getName();
                        String contentType = fi.getContentType();
                        boolean isInMemory = fi.isInMemory();
                        long sizeInBytes = fi.getSize();

                        // Write the file
                        if (count == 1) {
                            File dir = new File(filePath + cat + File.separator + "low" + File.separator);
                            if (!dir.exists()) {
                                dir.mkdirs();
                            }

                            file = new File(filePath + cat + File.separator + "low" + File.separator + cat + last + "." + contentType.substring(contentType.indexOf("/")).replace("/", ""));
                            lpath = "assets" + File.separator + "ess" + File.separator + cat + File.separator + "low" + File.separator + cat + last + "." + contentType.substring(contentType.indexOf("/")).replace("/", "");

                            fi.write(file);

                            out.println("Uploaded Filename: " + fileName + "<br>");
                            count++;
                        } else if (count == 2) {
                            File dir = new File(filePath + cat + File.separator + "high" + File.separator);
                            if (!dir.exists()) {
                                dir.mkdirs();
                            }

                            file = new File(filePath + cat + File.separator + "high" + File.separator + cat + last + "." + contentType.substring(contentType.indexOf("/")).replace("/", ""));
                            hpath = "assets" + File.separator + "ess" + File.separator + cat + File.separator + "high" + File.separator + cat + last + "." + contentType.substring(contentType.indexOf("/")).replace("/", "");

                            fi.write(file);
                            wid(lpath, hpath, des);
                            out.println("Uploaded Filename: " + fileName + "<br>");
                        }
                    } else {
                        if (fi.getFieldName().equals("catlist")) {
                            cat = fi.getString();
                            maxid();
                        }
                        if (fi.getFieldName().equals("desc")) {
                            des = fi.getString();
                        }

                    }
                }
                out.println("</body>");
                out.println("</html>");
            } catch (Exception ex) {
                out.println(ex);
            }
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, java.io.IOException {

        throw new ServletException("GET method used with "
                + getClass().getName() + ": POST method required.");
    }

    private void maxid() {

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/fallonweb";
            String user = "root";
            String user_password = "Mauryadb@505";
            Connection connection = DriverManager.getConnection(url, user, user_password);
            String cmd = "SELECT * FROM " + cat + " ORDER BY id DESC LIMIT 0, 1";
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(cmd);
            //ResultSetMetaData rsmd = rs.getMetaData();
            //String name = rsmd.getColumnName(1);

            if (rs.first()) {

                last = rs.getInt("id") + 1;

            }
        } catch (ClassNotFoundException ex) {
            out.println(ex);
        } catch (SQLException ex) {
            last = 1;
            out.println(ex);
        }
    }

    private void wid(String lpath1, String hpath1, String des1) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/fallonweb";
            String user = "root";
            String user_password = "Mauryadb@505";
            Connection connection = DriverManager.getConnection(url, user, user_password);
            String cmd = "INSERT INTO " + cat + " (id, lpath, hpath, des) VALUES (?,?,?,?)";
            PreparedStatement pst = connection.prepareStatement(cmd);
            pst.setInt(1, last);
            pst.setString(2, lpath1);
            pst.setString(3, hpath1);
            pst.setString(4, des1);
            pst.executeUpdate();
            pst.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            out.println(ex);
        } catch (SQLException ex) {
            out.println(ex);
        }
    }
}
