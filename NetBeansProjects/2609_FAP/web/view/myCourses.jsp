<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/view/login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String firstName = (String) session.getAttribute("firstName");
    String lastName = (String) session.getAttribute("lastName");
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Courses</title>
    <link href="../css/home.css" rel="stylesheet" type="text/css"/>
    <style>
        .course-card {
            border: 1px solid #ccc;
            padding: 1rem;
            margin: 0.7rem;
            border-radius: 8px;
            box-shadow: 2px 2px 6px #aaa;
            background-color: #f9f9f9;
        }
        .course-info h2 {
            margin: 0;
        }
        .button-container {
            margin-top: 10px;
        }
        .buttons {
            padding: 0.5rem 1rem;
            background-color: rgb(32,155,222);
            border: none;
            color: white;
            cursor: pointer;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <nav class="header">
        <div class="left">
            <img src="https://activelearning.ph/wp-content/uploads/2021/03/logo-white.png" alt="Logo" class="img" />
        </div>
        <div class="right">
            <div>
                <h1>Welcome <%= firstName %> <%= lastName %></h1>
            </div>
            <form action="<%= request.getContextPath() %>/LogoutServlet" method="post">
                <button class="logout-button" type="submit">Logout</button>
            </form>
        </div>
    </nav>

    <section class="hero-container">
        <div class="main-container main">
            <h2>My Courses</h2>

            <%
                // DB connection setup
                String dbURL = "jdbc:mysql://localhost:3306/mpfour?useSSL=false&zeroDateTimeBehavior=CONVERT_TO_NULL&allowPublicKeyRetrieval=true";
                String dbUser = "root";
                String dbPass = "root";
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

                    // Query courses where user is enrolled (assuming ENROLLMENT table links username and course_id)
                    String sql = "SELECT c.course_id, c.courseName, c.username AS instructor, c.hours, c.price, c.description " +
                                 "FROM COURSE c JOIN ENROLLMENT e ON c.course_id = e.course_id " +
                                 "WHERE e.username = ?";

                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, username);
                    rs = stmt.executeQuery();

                    boolean hasCourses = false;

                    while (rs.next()) {
                        hasCourses = true;
                        String courseId = rs.getString("course_id");
                        String courseName = rs.getString("courseName");
                        String instructor = rs.getString("instructor");
                        int hours = rs.getInt("hours");
                        double price = rs.getDouble("price");
                        String description = rs.getString("description");
            %>
                        <div class="course-card">
                            <div class="course-info">
                                <h2><%= courseName %></h2>
                                <p><%= description %></p>
                                <p><b>Course ID:</b> <%= courseId %></p>
                                <p><b>Instructor:</b> <%= instructor %></p>
                                <p><b>Expected Hours:</b> <%= hours %> hours</p>
                                <p><b>Price:</b> ₱<%= price %></p>
                            </div>
                        </div>
            <%
                    }
                    if (!hasCourses) {
            %>
                    <p>You are not enrolled in any courses yet.</p>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                }
            %>

            <form action="<%= request.getContextPath() %>/view/home.jsp" method="get">
                <button class="buttons" type="submit">Back to Available Courses</button>
            </form>

        </div>
    </section>
</body>
</html>
