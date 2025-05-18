<%-- 
    Document   : courseList
    Created on : 05 15, 25, 3:10:26 PM
    Author     : franc
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
    </head>
    <body>
        <h1>Dashboard/Courses</h1>
        
        <form method="post" action="/FAP/LogoutServlet">
            <input type="submit" name="submit" value="Logout Button">
        </form>
        
        <%
            HttpSession userSession = request.getSession(false);
            if (userSession == null || userSession.getAttribute("username") == null) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
                return;
            }
            
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            
            if(role.equals("A"))
                role = "Admin";
            else
                role = "Student";
                       
            String driver = "com.mysql.cj.jdbc.Driver";
            Class.forName(driver);
            String url = "jdbc:mysql://localhost:3306/mpfour?useSSL=false&zeroDateTimeBehavior=CONVERT_TO_NULL";
            String dbusername = "root";
            String dbpassword = "root";
            Connection conn = DriverManager.getConnection(url, dbusername, dbpassword);
            
            String query = "";
            if(role.equals("Student")) {
             query = "SELECT course_id FROM ENROLLMENT WHERE username=? ORDER BY course_id ASC";
            }
            else {
                 query = "SELECT course_id FROM COURSE WHERE username=? ORDER BY course_id ASC";
            }
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, (String) userSession.getAttribute("username"));
            ResultSet rs = ps.executeQuery();
            
        %>
                <h1>Welcome <%= session.getAttribute("username") %>, Role: <%= role %></h1>

                <!-- Display course list of user -->
                <table>
                    <thead>
                        <tr>
                            <th>Course ID</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            // Iterate over the ResultSet to display user data
                            while (rs.next()) {
                                String courseId = rs.getString("course_id");
                        %>
                        <tr>
                            <td><%= courseId %></td>
                            <td>
                                <!-- Course Info Button -->
                                <form action="/FAP/view/courseInfo.jsp" method="get">
                                    <input type="hidden" name="courseId" value="<%= courseId %>">
                                    <button type="submit">Course Info</button>
                                </form>
                                
                                <% if(session.getAttribute("role").equals("S")) { %>
                                <!-- Course Leave Button for Guests -->
                                <form action="/FAP/LeaveCourseServlet" method="post">
                                    <input type="hidden" name="username" value="<%= username %>">
                                    <input type="hidden" name="courseId" value="<%= courseId %>">
                                    <button type="submit">Leave Course</button>
                                </form>
                                <% } 
                                
                                else { %>
                                <!-- Course Edit Button for Admins -->
                                <form action="/FAP/view/adminEdit.jsp" method="post">
                                    <input type="hidden" name="courseId" value="<%= courseId %>">
                                    <button type="submit">Edit Course Details</button>
                                </form>
                                    
                                <!-- Delete Button for Admins --> 
                                    <form action="/FAP/DeleteCourseServlet" method="post">
                                        <input type="hidden" name="courseId" value="<%= courseId %>">
                                        <button type="submit">Delete Course</button>
                                    </form>
                                </td>
                                <% } %>
                            </tr>
                            <% } %>
                    </tbody>
                </table>
                <% if (session.getAttribute("role").equals("A")) { %>
                    <form action="/FAP/view/adminAdd.jsp" method="post">
                        <button type="submit">Add Course</button>
                    </form>
                    <form action="/FAP/ReportServlet" method="post">
                        <input type="hidden" id="choice" name="choice" value="all">
                        <button type="submit">Print All Records</button>
                    </form>
                    <form action="/FAP/ReportServlet" method="post">
                        <input type="hidden" id="choice" name="choice" value="none">
                        <button type="submit">Print Personal Record</button>
                    </form>
                <% }  else { %>
                    <form action="/FAP/view/studentJoin.jsp" method="post">
                        <button type="submit">Join Course</button>
                    </form>
                <% } %>
    </body>
</html>