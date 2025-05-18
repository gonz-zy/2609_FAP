<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
    HttpSession userSession = request.getSession(false);
            if (userSession == null || userSession.getAttribute("username") == null) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
                return;
            }
    String firstName = (String) session.getAttribute("firstName");
    String lastName = (String) session.getAttribute("lastName");
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link href="../css/home.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="start">
            <section class="hero-container">
                <nav class="header">
                    <div class="left">
                        <img src="https://activelearning.ph/wp-content/uploads/2021/03/logo-white.png" alt="Logo" class="img">
                    </div>
                    <div class="right">
                        <div>
                            <h1>Welcome <%= firstName %> <%= lastName %></h1>
                        </div>
                        <form action="/2609_FAP/LogoutServlet" method="post">
                            <button class="logout-button" type="submit">Logout</button>
                        </form>
                    </div>
                </nav>
            </section>
        </div>
        <section class="hero-container">
            <div class="main-container main">
                <div class="top-container">
                        <% if ("A".equals(role)) { %>
                            <!-- Admin buttons -->
                            <form class="button-form" action="<%= request.getContextPath() %>/view/home.jsp">
                                <button class="buttons" type="submit">Manage Courses</button>
                            </form>
                            <form class="button-form" action="<%= request.getContextPath() %>/view/reports.jsp">
                                <button class="buttons" type="submit">Print Reports</button>
                            </form>
                            <form class="button-form" action="<%= request.getContextPath() %>/view/editAccount.jsp">
                                <button class="buttons" type="submit">Edit Account</button>
                            </form>
                        <% } else { %>
                            <!-- Non-admin buttons -->
                            <form class="button-form" action="<%= request.getContextPath() %>/view/home.jsp">
                                <button class="buttons" type="submit">Available Courses</button>
                            </form>
                            <form class="button-form" action="<%= request.getContextPath() %>/view/myCourses.jsp">
                                <button class="buttons" type="submit">My Courses</button>
                            </form>
                            <form class="button-form" action="<%= request.getContextPath() %>/view/reports.jsp">
                                <button class="buttons" type="submit">Print Reports</button>
                            </form>
                            <form class="button-form" action="<%= request.getContextPath() %>/view/cartStudent.jsp">
                                <button class="buttons" type="submit">My Cart</button>
                            </form>
                            <form class="button-form" action="<%= request.getContextPath() %>/view/editAccount.jsp">
                                <button class="buttons" type="submit">Edit Account</button>
                            </form>
                        <% } %>
                    
                </div>
                <div class="bottom-container">
                    <div class="course-container">
                        <div class="course-grid">
                        <%
                            String dbURL = "jdbc:mysql://localhost:3306/mpfour?zeroDateTimeBehavior=CONVERT_TO_NULL";
                            String dbUser = "root";
                            String dbPass = "passwordsql";
                            Connection conn = null;
                            PreparedStatement stmt = null;
                            ResultSet rs = null;

                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                                String sql = "SELECT c.course_id, c.courseName, c.username, c.hours, c.price, c.description, " +
                                            "u.firstName AS instructorFirstName, u.lastName AS instructorLastName " +
                                            "FROM COURSE c " +
                                            "JOIN USERS u ON c.username = u.username";

                               stmt = conn.prepareStatement(sql);
                               rs = stmt.executeQuery();

                               while (rs.next()) {
                                   String course_id = rs.getString("course_id");
                                   String courseName = rs.getString("courseName");
                                   String instructorFirstName = rs.getString("instructorFirstName");
                                   String instructorLastName = rs.getString("instructorLastName");
                                   int hours = rs.getInt("hours");
                                   double price = rs.getDouble("price");
                                   String description = rs.getString("description");

                                 %>
                                    <div class="course-card">
                                        <div class="course-info">
                                            <h2><%= courseName %></h2>
                                            <p class="course-description"><%= description %></p>
                                            <div class="cont">
                                                <div class="left-cont">
                                                    <h3><b>Course ID:</b> <%= course_id %></h3>
                                                </div>
                                                <div class="right-cont">
                                                    <h3><b>Instructor:</b> <%= instructorFirstName %> <%= instructorLastName %></h3>
                                                </div>
                                            </div>
                                            <div class="cont" style="margin-top: 0.5rem;">
                                                <div class="left-cont">
                                                    <h3><b>Price:</b> ₱<%= price %></h3>
                                                </div>
                                                <div class="right-cont">
                                                    <h3><b>Expected Hours:</b> <%= hours %> hours</h3>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="button-container">
                                            <% if (role.equals("A")) { %>
                                                <form class="button-form" action="<%= request.getContextPath() %>/view/adminEdit.jsp" method="post">
                                                    <input type="hidden" name="course_id" value="<%= course_id %>" />
                                                    <input type="hidden" name="description" value="<%= description %>" />
                                                    <input type="hidden" name="courseName" value="<%= courseName %>" />
                                                    <input type="hidden" name="price" value="<%= price %>" />
                                                    <input type="hidden" name="hours" value="<%= hours %>" />
                                                    <button style="background-color: rgba(32,155,222,255)" type="submit">Edit Course</button>
                                                </form>
                                                <form class="button-form" action="/2609_FAP/DeleteCourseServlet" method="post">
                                                    <input type="hidden" name="course_id" value="<%= course_id %>" />
                                                    <button style="background-color: red" type="submit" onclick="return confirm('Are you sure you want to delete this course?');">Delete Course</button>
                                                </form>
                                            <% } else { %>
                                                <form class="button-form" action="/2609_FAP/AddToCartServlet" method="post">
                                                    <input type="hidden" name="course_id" value="<%= course_id %>" />
                                                    <button style="background-color: rgb(100,220,20)" type="submit">Buy Now</button>
                                                </form>
                                            <% } %>
                                        </div>
                                    </div>

                        <%
                                } // end while
                        %>
                    </div> <!-- close course-grid -->
                    </div>
                    <% if (role.equals("A")) { %>
                        <div class="add-button" style="margin-top: 20px;">
                            <form class="button-form" action="<%= request.getContextPath() %>/view/adminAdd.jsp" method="get">
                                <button style="background-color: rgba(32,155,222,255); padding: 10px 20px; font-size: 16px; border:none; color:white; cursor:pointer;" type="submit">Add Course</button>
                            </form>
                        </div>
                    <% } %>

                    <%
                            } catch (Exception e) {
                                out.println("Database error: " + e.getMessage());
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                            }
                        %>

        </section>
    </body>
</html>
