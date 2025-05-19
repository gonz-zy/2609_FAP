package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve course_id from form
        String course_id = request.getParameter("course_id");

        // Get the logged-in user's username from session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("view/login.jsp"); // redirect if not logged in
            return;
        }

        String username = (String) session.getAttribute("username");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            String driver = "com.mysql.cj.jdbc.Driver";
            Class.forName(driver);

            String url = "jdbc:mysql://localhost:3306/mpfour?useSSL=false&zeroDateTimeBehavior=CONVERT_TO_NULL&allowPublicKeyRetrieval=true";
            String dbusername = "root";
            String dbpassword = "root";

            conn = DriverManager.getConnection(url, dbusername, dbpassword);

            String query = "INSERT INTO CART (username, course_id) VALUES (?, ?)";
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, course_id);

            System.out.println("Hello " + username);
            System.out.println("Hello " + course_id);
            ps.executeUpdate();

            System.out.println("Hello");
            // Success, redirect or forward
            request.setAttribute("successMessage", "Course added to cart successfully.");
            request.setAttribute("jspPath", "/2609_FAP/view/home.jsp");
            request.setAttribute("pageName", "Home Page");
            request.getRequestDispatcher("view/success.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
