package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EditCourseServlet extends HttpServlet {

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
            out.println("<title>Servlet EditCourseServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditCourseServlet at " + request.getContextPath() + "</h1>");
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
        response.sendRedirect("/FAP/view/courseList.jsp");
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    Connection conn;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String courseName = request.getParameter("courseName");
        String course_id = request.getParameter("course_id");
        String description = request.getParameter("description");   
        int hours = Integer.parseInt(request.getParameter("hours"));
        float price = Float.parseFloat(request.getParameter("price"));

        PreparedStatement ps = null;
        ResultSet records = null;
        
        try {
            String driver = "com.mysql.cj.jdbc.Driver";
            Class.forName(driver);
            String url = "jdbc:mysql://localhost:3306/mpfour?useSSL=false&zeroDateTimeBehavior=CONVERT_TO_NULL&allowPublicKeyRetrieval=true";
            String dbusername = "root";
            String dbpassword = "root";
            conn = DriverManager.getConnection(url, dbusername, dbpassword);
            String query = "UPDATE COURSE SET courseName=?, description=?, hours=?, price=? WHERE course_id=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, courseName);
            ps.setString(2,description);
            ps.setInt(3, hours);
            ps.setFloat(4, price);
            ps.setString(5,course_id);
            
            System.out.println(courseName + description + hours + price + course_id);
            
            int check = ps.executeUpdate();
            
            
            if (check > 0) {
            request.setAttribute("successMessage", "Updated Course Successfully");
            request.setAttribute("jspPath", "/2609_FAP/view/home.jsp");
            request.setAttribute("pageName", "Home Page");
            request.getRequestDispatcher("view/success.jsp").forward(request, response);
            } else {
                    response.sendRedirect("view/error_5.jsp");
                }
        }
        
        catch (SQLException sqle) {

            sqle.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            // Close the statement and connection
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
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
