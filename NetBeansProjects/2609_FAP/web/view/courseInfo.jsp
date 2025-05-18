<%-- 
    Document   : courseInfo
    Created on : 05 17, 25, 9:56:29 AM
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
        <title>Course Info</title>
    </head>
    <%
            HttpSession userSession = request.getSession(false);
            if (userSession == null || userSession.getAttribute("username") == null) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
                return;
            }
            
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            String courseId = request.getParameter("courseId");
                       
            String driver = "com.mysql.cj.jdbc.Driver";
            Class.forName(driver);
            String url = "jdbc:mysql://localhost:3306/mpfour?useSSL=false&zeroDateTimeBehavior=CONVERT_TO_NULL";
            String dbusername = "root";
            String dbpassword = "root";
            Connection conn = DriverManager.getConnection(url, dbusername, dbpassword);
            String query = "SELECT * FROM COURSE WHERE course_id=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, courseId);
            ResultSet records = ps.executeQuery();
            
            records.next();
            String professor = records.getString("username");
            String description = records.getString("description");
            String hours = records.getString("hours");
            String price = records.getString("price");
            String created_at = records.getString("created_at");
            
            query = "SELECT username, role FROM USERS WHERE username IN (SELECT username FROM ENROLLMENT WHERE course_id=?)";
            ps = conn.prepareStatement(query);
            ps.setString(1, courseId);
            ResultSet rs = ps.executeQuery();
            
            query = "SELECT status, enrolled_at FROM ENROLLMENT WHERE course_id=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, courseId);
            ResultSet rs2 = ps.executeQuery();
    %>
    
    <body>
        <h1>Welcome to <%= courseId %>'s Information Page!</h1>
        <p>Professor: <%= professor %></p>
        <p><%= description %></p>
        <p>Total Hours: <%= hours %></p>
        <p>Enrollment Price: <%= price %></p>
        <p>Created At: <%= created_at %></p>
        
        <!-- Display course list of user -->
        <h2>Students in Course</h2>
        <table>
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Enrolled On</th>
                    <% if(role.equals("A")) { %>
                        <th>Actions</th>
                    <% } %>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Iterate over the ResultSet to display user data
                    while (rs.next() && rs2.next()) {
                        String recordUser = rs.getString("username");
                        String recordRole = rs.getString("role");
                        String recordStatus = rs2.getString("status");
                        String recordEnrollDate = rs2.getString("enrolled_at");
                %>
                <tr>
                    <td><%= recordUser %></td>
                    <td><%= recordRole %></td>
                    <td><%= recordStatus %></td>
                    <td><%= recordEnrollDate %></td>
                    
                    <% if(role.equals("A")) { %>
                    <td>
                        <!-- Course Info Button -->
                        <form action="/FAP/EditUserServlet" method="post">
                            <input type="hidden" name="username" value="<%= recordUser %>">
                            <button type="submit">Edit Details</button>
                        </form>
                        
                        <!-- Remove Guest from Course -->
                        <form action="/FAP/LeaveCourseServlet" method="post">
                            <input type="hidden" name="username" value="<%= recordUser %>">
                            <input type="hidden" name="courseId" value="<%= courseId %>">
                            <button type="submit">Remove from Course</button>
                        </form>
                    </td>
                    <% } %>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <% if(role.equals("A")) { %>
            <!-- Edit Course Details for Admin -->
            <form action="/FAP/view/adminEdit.jsp" method="post">
                <input type="hidden" name="courseId" value="<%= courseId %>">
                <button type="submit">Edit Course Details</button>
            </form>
                
            <!-- Delete Course for Admin --> 
            <form action="/FAP/DeleteCourseServlet" method="post">
                <input type="hidden" name="courseId" value="<%= courseId %>">
                <button type="submit">Delete Course</button>
            </form>
        <% } %>
            
        <!-- Print Report --> 
        <form action="/FAP/ReportServlet" method="post">
            <input type="hidden" name="courseId" value="<%= courseId %>">
            <button type="submit">Print Course Report</button>
        </form>
            
        <!-- Return to Course List -->
        <form action="/FAP/view/courseList.jsp" method="get">
            <button type="submit">Return to Course List</button>
        </form>
    </body>
</html>