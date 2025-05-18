<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@page import="java.sql.*"%>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("username") == null) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>My Cart</title>
    <link href="../css/home.css" rel="stylesheet" type="text/css"/>
    <style>
        .course-grid {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            padding: 2rem;
            flex: 1;
            overflow:auto;
        }
        .bottom-container {
    display: flex;
    flex-direction: column;
    height: 82vh; /* keep your existing height */
    width: 100%;
    border-top: 1px solid #ddd;
    background: #fff;
}

.course-container {
    flex: 1;
    overflow-y: auto;
    padding: 2rem;
}
        .course-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #fefefe;
            border: 1px solid #ddd;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 1rem 2rem;
            max-height: none;
        }

        .course-name, .course-price, .button-container {
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            font-weight: 600;
        }

        .course-name {
            flex: 3;
            justify-content: flex-start;
            text-align: left;
        }

        .course-price {
            flex: 1;
            color: #2e8b57;
        }
        
        .main{
            padding: 0;
            height:82vh;
            
        }
        
        .main-container{
            background-color: #fff4ee;

        }
        .bottom-container{
            width:100%;
            background-color: #fff4ee;

            flex: 1;
        }
        .button-container {
            flex: 1;
            justify-content: center;
        }

        .button-container button {
            background-color: #d9534f; /* red */
            border: none;
            color: white;
            padding: 8px 16px;
            font-size: 1rem;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .button-form{
            flex: 1;

        }
        .course-container{
            overflow: auto;
            background-color: #fff4ee;

        }
        .button-container button:hover {
            background-color: #c9302c;
        }

        /* Checkout button - green & full width */
        .checkout-button {
            background-color: #28a745; /* green */
            color: white;
            border: none;
            padding: 1rem;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1.25rem;
            width: 100%;
            transition: background-color 0.3s ease;
            flex:1;
        }
        .checkout-button:hover {
            background-color: #1e7e34;
        }
        
        .checkout-container {
            width: 100%;
            display: flex;
            justify-content: center;
            padding: 1rem 2rem;
            background-color: #fff4ee;

        }
    </style>
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

                                String sql = "SELECT c.course_id, c.courseName, c.price " +
                                             "FROM CART cart " +
                                             "JOIN COURSE c ON cart.course_id = c.course_id " +
                                             "WHERE cart.username = ?";

                                stmt = conn.prepareStatement(sql);
                                stmt.setString(1, username);
                                rs = stmt.executeQuery();

                                boolean hasItems = false;

                                while (rs.next()) {
                                    hasItems = true;
                                    String course_id = rs.getString("course_id");
                                    String courseName = rs.getString("courseName");
                                    double price = rs.getDouble("price");
                        %>
                                    <div class="course-card">
                                        <div class="course-name"><%= courseName %></div>
                                        <div class="course-price">₱<%= price %></div>
                                        <div class="button-container">
                                            <form action="/2609_FAP/RemoveFromCartServlet" method="post" onsubmit="return confirm('Remove this course from your cart?');">
                                                <input type="hidden" name="course_id" value="<%= course_id %>"/>
                                                <button style="background-color: red; font-weight: bold" type="submit">Remove</button>
                                            </form>
                                        </div>
                                    </div>
                        <%
                                }
                                if (!hasItems) {
                        %>
                                    <h1 style="text-align: center; margin-top:5rem; padding: 2rem; font-size: 5rem; color: black;">Your cart is empty.</h1>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<p style='color:red;'>Database error: " + e.getMessage() + "</p>");
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                            }
                        %>
                    </div>

                    

                </div>
                    <!-- Checkout Button -->
                     <% if (!"A".equals(role)) { %>
                        <div class="checkout-container" style="padding: 1rem 2rem; background-color: #fff4ee;
">
                            <form action="/2609_FAP/CheckoutServlet" method="post" style="width: 100%; margin: 0;">
                                <button type="submit" class="checkout-button">Checkout</button>
                            </form>
                        </div>
                    <% } %>
            </div>
        </div>
    </section>
</body>
</html>
