<%-- 
    Document   : products
    Created on : Oct 21, 2018, 5:46:14 PM
    Author     : Anuj
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String prodname = request.getParameter("name");
    String dname = request.getParameter("dname");
    if (prodname == null || dname == null) {
        response.sendRedirect(response.encodeRedirectURL(request.getHeader("referer")));
    }
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/fallonweb";
    String user = "root";
    String user_password = "GlobalFallon420";
    Connection connection = DriverManager.getConnection(url, user, user_password);
    String cmd = "select * from gen where cat = ?";
    PreparedStatement st = connection.prepareStatement(cmd);
    st.setString(1, prodname);
    ResultSet rs = st.executeQuery();
    if (!rs.first()) {
        response.sendRedirect(response.encodeRedirectURL(request.getHeader("referer")));
    }

%>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><%=dname%></title>
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
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <style>
            .dropdown-submenu {
                position: relative;
            }

            .dropdown-submenu .dropdown-menu {
                top: 0;
                left: 100%;
                margin-top: -1px;
            }
        </style>
    </head>

    <body id="font_prodPage">
        <div class="div_head_boxes" id="first">
            <div class="div_head_boxes" id="second">
                <div class="div_head_boxes" id="third">
                    <div id="huge_cont">
                        <div id="cont_head">
                            <div>
                                <nav class="navbar navbar-light navbar-expand-md navigation-clean">
                                    <div class="container"><a href="http://fallonindia.com/"><img id="rel_img" src="assets/img/logo.png"></a><button data-toggle="collapse" data-target="#navcol-1" class="navbar-toggler"><span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
                                        <div class="collapse navbar-collapse"
                                             id="navcol-1">
                                            <ul class="nav navbar-nav ml-auto">
                                                <li class="nav-item" role="presentation"><a class="nav-link" href="http://fallonindia.com/">Home</a></li>
                                                <li class="nav-item" role="presentation">

                                                    <div class="dropdown">
                                                        <a style="background-color: #000000; color: #ffffff;" class="dropdown-toggle" data-toggle="dropdown">Products</a>
                                                        <ul class="dropdown-menu">


                                                            <li class="dropdown-submenu">
                                                                <a style="color: #ffffff;" class="test" tabindex="-1" href="#">Leggings<span class="caret"></span></a>
                                                                <ul class="dropdown-menu">
                                                                    <li><a style="color: #ffffff;" tabindex="-1" href="http://fallonindia.com/products.jsp?name=chudidarleggings&dname=Chudidar Leggings">Chudidar leggings</a></li>
                                                                    <li><a style="color: #ffffff;" tabindex="-1" href="http://fallonindia.com/products.jsp?name=ankleleggings&dname=Ankle Leggings">Ankle leggings</a></li>
                                                                    <li><a style="color: #ffffff;" tabindex="-1" href="http://fallonindia.com/products.jsp?name=sportsankleleggings&dname=Sports Ankle Leggings">Sports ankle leggings</a></li>
                                                                </ul>
                                                            </li>
                                                            <li class="dropdown-submenu">
                                                                <a style="color: #ffffff;" class="test" tabindex="-1" href="#">Capris<span class="caret"></span></a>
                                                                <ul class="dropdown-menu">
                                                                    <li><a style="color: #ffffff;" tabindex="-1" href="http://fallonindia.com/products.jsp?name=4waycap&dname=4way Capris">4way capris</a></li>
                                                                    <li><a style="color: #ffffff;" tabindex="-1" href="http://fallonindia.com/products.jsp?name=sportscap&dname=Sports Capris">Sports capris</a></li>
                                                                    <li><a style="color: #ffffff;" tabindex="-1" href="http://fallonindia.com/products.jsp?name=printedcap&dname=Printed Papris">Printed capris</a></li>
                                                                </ul>
                                                            </li>
                                                            <li class="dropdown-submenu">
                                                                <a style="color: #ffffff;" class="test" tabindex="-1" href="#">Track pants<span class="caret"></span></a>
                                                                <ul class="dropdown-menu">
                                                                    <li><a style="color: #ffffff;" tabindex="-1" href="http://fallonindia.com/products.jsp?name=track&dname=Track Pants">Track pants</a></li>
                                                                    <li><a style="color: #ffffff;" tabindex="-1" href="http://fallonindia.com/products.jsp?name=joggers&dname=Joggers Pants">Joggers pants</a></li>
                                                                </ul>
                                                            </li>
                                                            <li class="dropdown-submenu">
                                                                <a style="color: #ffffff;" class="test" tabindex="-1" href="#">Pyjamas<span class="caret"></span></a>
                                                                <ul class="dropdown-menu">
                                                                    <li><a style="color: #ffffff;" tabindex="-1" href="http://fallonindia.com/products.jsp?name=printedpyjamas&dname=Printed Pyjamas">Printed pyjamas</a></li>

                                                                </ul>
                                                            </li>
                                                            <li class="dropdown-submenu">
                                                                <a style="color: #ffffff;" class="test" tabindex="-1" href="#">Shorts<span class="caret"></span></a>
                                                                <ul class="dropdown-menu">
                                                                    <li><a style="color: #ffffff;" tabindex="-1" href="http://fallonindia.com/products.jsp?name=cyclingshorts&dname=Cycling Shorts">Cycling shorts</a></li>

                                                                </ul>
                                                            </li>
                                                            <li><a style="color: #ffffff;" tabindex="-1" href="http://fallonindia.com/products.jsp?name=plainplazos&dname=Plain Plazos">Plain Plazos</a></li>
                                                        </ul>
                                                    </div>

                                                </li>


                                                <li class="nav-item" role="presentation"><a class="nav-link" href="about.html">About</a></li>
                                                <li class="nav-item" role="presentation"><a class="nav-link" href="contact.jsp">Contact</a></li>

                                            </ul>
                                        </div>

                                    </div>
                                </nav>
                            </div>

                        </div>
                        <div id="LAB"><div id="motto_al">LEGGINGS AND BOTTOMWEAR</div></div>
                        <div id="grey_border"><div id="motto_al">A satisfied customer is the best business strategy of all.</div></div>
                    </div>
                </div>

            </div>
        </div>



        <h1 class="text-center" id="womenWear_head" style="color:#ffffff;margin:0px;background-color:#000000;padding-bottom:30px;"><%=dname%></h1>
        <div style="background-color:#000000;padding-bottom:50px;">
            <div class="container">
                <%                String name, lpath, link;
                    int prod = 0;
                    rs = null;
                    String detLink = "http://fallonindia.com/productDetails.jsp?prodDet=";

                    cmd = "select id,lpath from " + prodname;
                    Statement st1 = connection.createStatement();
                    rs = st1.executeQuery(cmd);
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

                            link = detLink + prodname + "&id=" + id + "&dname=" + dname;
                            prod++;
                            rs.next();
                    %>
                    <div class="col-md-4">
                        <div class="border">
                            <div class="wrap">
                                <div class="product-wrap"><a href="<%=link%>"><img id="home_prod" src="<%=lpath%>" /></a></div>
                                <div class="loop-action"><a href="<%=link%>" class="add-to-cart">Details</a></div>
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
            <h1 style="color: #ffffff">Uploading soon...</h1>
            <% }%>
        </div>
        <div id="foot_bord" class="footer-dark">
            <footer>
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6 col-md-3 item">
                            <h3>GIVE US A CALL!</h3>
                            <ul>

                                <li><a href="tel:+919925624292">CALL OFFICE 1</a></li>
                                <li><a href="tel:+917043645679">CALL OFFICE 2</a></li>
                                <li><a href="mailto:fallonleggings@gmail.com?subject=Inquiry">EMAIL US</a></li>
                            </ul>
                        </div>
                        <div class="col-sm-6 col-md-3 item">
                            <h3>Quick Links</h3>
                            <ul>
                                <li><a href="http://fallonindia.com/">Home</a></li>                                
                                <li><a href="about.html">About</a></li>
                                <li><a href="contact.jsp">Contact</a></li>
                            </ul>
                        </div>
                        <div class="col-md-6 item text">
                            <h3>Fallon</h3>
                            <p>Established in the mega-city, Ahmedabad of Gujarat on October 2018, we are proudly selling supreme quality women's wear with our excellent know-how of cotton and lycra raw materials.</p>
                        </div>
                        <div class="col item social" data-aos="zoom-in" data-aos-duration="300"><a href="https://www.facebook.com/Fallonindia/" data-aos="zoom-in" data-aos-duration="300"><i class="fa fa-facebook"></i></a><a href="https://www.instagram.com/fallonindia/" data-aos="zoom-in" data-aos-duration="300"><i class="fa fa-instagram"></i></a><a href="mailto:fallonleggings@gmail.com?subject=Inquiry" data-aos="zoom-in" data-aos-duration="300"><i class="fa fa-envelope-o"></i></a>
                            <a href="https://in.pinterest.com/fallonindia/" data-aos="zoom-in" data-aos-duration="300"><i class="fa fa-pinterest-p"></i></a></div>
                    </div>
                    <p class="copyright">Fallon © 2018</p>
                </div>
            </footer>
        </div>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/js/bs-animation.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.1.1/aos.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.3.1/js/swiper.jquery.min.js"></script>
        <script src="assets/js/Simple-Slider1.js"></script>


    </body>
</html>
