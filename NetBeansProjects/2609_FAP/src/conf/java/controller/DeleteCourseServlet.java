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

/**
 *
 * @author franc
 */
public class DeleteCourseServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("view/courseList.jsp");
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is an admin
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("view/login.jsp");
            return;
        }
        
        String courseId = request.getParameter("course_id");
        String username = (String) session.getAttribute("username");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mpfour?useSSL=false&zeroDateTimeBehavior=CONVERT_TO_NULL&allowPublicKeyRetrieval=true", "root", "root")) {
            // First verify the course belongs to the current user (admin)
            String verifySql = "SELECT 1 FROM COURSE WHERE course_id = ? AND username = ?";
            try (PreparedStatement verifyPs = conn.prepareStatement(verifySql)) {
                verifyPs.setString(1, courseId);
                verifyPs.setString(2, username);
                
                if (!verifyPs.executeQuery().next()) {
                    // Course doesn't exist or doesn't belong to this user
                    response.sendRedirect("view/error_1.jsp");
                    return;
                }
            }
            
            // Delete the course (enrollments and cart items will be deleted automatically due to ON DELETE CASCADE)
            String deleteSql = "DELETE FROM COURSE WHERE course_id = ?";
            try (PreparedStatement deletePs = conn.prepareStatement(deleteSql)) {
                deletePs.setString(1, courseId);

                int rowsDeleted = deletePs.executeUpdate();
                if (rowsDeleted > 0) {
                    request.setAttribute("successMessage", "Course Deleted Successfully");
                    request.setAttribute("jspPath", "/2609_FAP/view/home.jsp");
                    request.setAttribute("pageName", "Home Page");
                    request.getRequestDispatcher("view/success.jsp").forward(request, response);
                } else {
                    response.sendRedirect("view/error_5.jsp");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view/error_5.jsp");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Handles course deletion";
    }
}