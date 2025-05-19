/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author franc
 */
public class AddCourseServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddCourseServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCourseServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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

        String course_id = request.getParameter("course_id");
        String courseName = request.getParameter("courseName");
        String username = (String) session.getAttribute("username");
        String description = request.getParameter("description");
        int hours = Integer.parseInt(request.getParameter("hours"));
        double price = Double.parseDouble(request.getParameter("price"));
        LocalDate createdAt = LocalDate.now();
        
        String dbURL = "jdbc:mysql://localhost:3306/mpfour?useSSL=false&zeroDateTimeBehavior=CONVERT_TO_NULL&allowPublicKeyRetrieval=true";
        String mysqlUser = "root";
        String mysqlPass = "root";

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mpfour?useSSL=false&zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "root")) {
            String sql = "INSERT INTO COURSE (course_id, courseName, username, description, hours, price) VALUES (?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, course_id);
                ps.setString(2, courseName);
                ps.setString(3, username);
                ps.setString(4, description);
                ps.setInt(5, hours);
                ps.setDouble(6, price);

                int rowsInserted = ps.executeUpdate();
                if (rowsInserted > 0) {
                    request.setAttribute("successMessage", "Added Course Successfully");
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
        return "Short description";
    }// </editor-fold>

}