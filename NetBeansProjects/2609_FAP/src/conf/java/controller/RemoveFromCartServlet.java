package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RemoveFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database credentials and URL
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mpfour?useSSL=false&zeroDateTimeBehavior=CONVERT_TO_NULL&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get session and verify user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You must be logged in to modify your cart.");
            return;
        }
        String username = (String) session.getAttribute("username");

        // Get course_id from form
        String courseId = request.getParameter("course_id");
        if (courseId == null || courseId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/view/cartStudent.jsp");
            return;
        }

        // Remove the course from the cart
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Explicitly load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            String sql = "DELETE FROM CART WHERE username = ? AND course_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, courseId);
            stmt.executeUpdate();

            // Set success message and forward
            request.setAttribute("successMessage", "Course removed from cart successfully.");
            request.setAttribute("jspPath", "/2609_FAP/view/cartStudent.jsp");
            request.setAttribute("pageName", "My Cart Page");
            request.getRequestDispatcher("view/success.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error removing course from cart.");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
