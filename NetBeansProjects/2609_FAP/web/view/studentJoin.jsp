<%-- 
    Document   : studentJoin
    Created on : 05 17, 25, 9:13:04 PM
    Author     : franc
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Join a Course</title>
    </head>
    <body>
        <h1>Please enter a course to join.</h1>
        <h2>List of available courses:</h2>
        <% HttpSession userSession = request.getSession(false);
            if (userSession == null || userSession.getAttribute("username") == null) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
                return;
            }
            
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
                       
            String driver = "com.mysql.cj.jdbc.Driver";
            Class.forName(driver);
            String url = "jdbc:mysql://localhost:3306/mpfour?useSSL=false&zeroDateTimeBehavior=CONVERT_TO_NULL";
            String dbusername = "root";
            String dbpassword = "root";
            Connection conn = DriverManager.getConnection(url, dbusername, dbpassword);
            String query = "SELECT course_id FROM COURSE WHERE course_id NOT IN (SELECT course_id FROM ENROLLMENT WHERE username=?) ORDER BY course_id ASC";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, (String) userSession.getAttribute("username"));
            ResultSet rs = ps.executeQuery(); %>
        
            <table>
                <tr>
                    <th>Course ID</th>
                </tr>
                <% while(rs.next()) { %>
                    <tr>
                        <td><%= rs.getString("course_id") %></td>
                    </tr>
                <% } %>
            </table>
            
            <form method="post" action="/FAP/JoinCourseServlet">
                <label for="course">Course</label>
                <input type="text" id="course" name="course" maxlength="7" required>
                <input type="submit" value="Submit">
            </form>
    </body>
</html>
