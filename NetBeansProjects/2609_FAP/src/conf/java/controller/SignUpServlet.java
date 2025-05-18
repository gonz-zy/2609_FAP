/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.codec.binary.Base64;

/**
 *
 * @author franc
 */
public class SignUpServlet extends HttpServlet {

    private String dbURL = "jdbc:mysql://localhost:3306/mpfour?useSSL=false&zeroDateTimeBehavior=CONVERT_TO_NULL";
    private String dbUser = "root";
    private String dbPass = "root";

    private String secretKey;
    private String cipherAlgorithm;
    private SecretKeySpec keySpec;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        secretKey = getServletContext().getInitParameter("secretKey");
        cipherAlgorithm = getServletContext().getInitParameter("cipherAlgorithm");

        try {
            keySpec = new SecretKeySpec(secretKey.getBytes("UTF-8"), "AES");
        } catch (Exception e) {
            throw new ServletException("Failed to init encryption key", e);
        }
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SignUpServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignUpServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String roleInput = request.getParameter("role");

        String role = roleInput.equalsIgnoreCase("admin") ? "A" : "S";

        if (username == null || password == null || firstname == null || lastname == null || role == null) {
            response.sendRedirect("view/error_6.jsp");
            return;
        }

        try {

            String driver = "com.mysql.cj.jdbc.Driver";
            Class.forName(driver);
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO USERS (username, password, firstname, lastname, role, created_at) VALUES (?, ?, ?, ?, ?, ?)"
            );

            Timestamp ts = java.sql.Timestamp.valueOf(LocalDateTime.now());  
            
            stmt.setString(1, username);
            stmt.setString(2, encryptPassword(password));
            stmt.setString(3, firstname);
            stmt.setString(4, lastname);
            stmt.setString(5, role);
            stmt.setTimestamp(6, ts);

            stmt.executeUpdate();
            stmt.close();
            
            String driver2 = "org.apache.derby.jdbc.ClientDriver";
            Class.forName(driver2);
            Connection conn2 = DriverManager.getConnection("jdbc:derby://localhost:1527/mpfour", "app", "app");
            
            PreparedStatement stmt2 = conn2.prepareStatement(
                "INSERT INTO USERS (username, password, firstname, lastname, role, created_at) VALUES (?, ?, ?, ?, ?, ?)"
            );
            
            stmt2.setString(1, username);
            stmt2.setString(2, encryptPassword(password));
            stmt2.setString(3, firstname);
            stmt2.setString(4, lastname);
            stmt2.setString(5, role);
            stmt2.setTimestamp(6, ts);
            
            stmt2.executeUpdate();
            stmt2.close();
            
            /*Connection conn2 = DriverManager.getConnection("jdbc:derby://localhost:1527/mpfour", "app", "app");
            PreparedStatement stmt2 = conn2.prepareStatement(
                "INSERT INTO USERS (username, password, firstname, lastname, role, created_at) VALUES (?, ?, ?, ?, ?, ?)"
            );
            
            stmt2.setString(1, username);
            stmt2.setString(2, encryptPassword(password));
            stmt2.setString(3, firstname);
            stmt2.setString(4, lastname);
            stmt2.setString(5, role);
            stmt2.setTimestamp(6, ts);
            
            stmt2.executeUpdate();
            stmt2.close();*/
            
            request.setAttribute("successMessage", "Added Successfully");
            request.setAttribute("jspPath", "view/login.jsp");
            request.setAttribute("pageName", "Login Page");
            request.getRequestDispatcher("view/success.jsp").forward(request,response);

        } catch (SQLIntegrityConstraintViolationException e) {
            e.printStackTrace();
            response.sendRedirect("view/error_6.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("view/error_6.jsp");
        } catch (Exception en) {}
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
    
    private String encryptPassword(String plainText) {
        try {
            ServletContext context = getServletContext();
            String keyString = context.getInitParameter("secretKey");
            String cipherAlgorithm = context.getInitParameter("cipher");
            // Convert the key to a byte array
            byte[] key = keyString.getBytes("UTF-8");
            String encryptedPassword = null;
                Cipher cipher = Cipher.getInstance(cipherAlgorithm);
                final SecretKeySpec secretKey = new SecretKeySpec(key, "AES");
                cipher.init(Cipher.ENCRYPT_MODE, secretKey);
                encryptedPassword = Base64.encodeBase64String(cipher.doFinal(plainText.getBytes()));
                
                return encryptedPassword;
        } catch (Exception e) {
            throw new RuntimeException("Password encryption failed", e);
        }
    }

}
