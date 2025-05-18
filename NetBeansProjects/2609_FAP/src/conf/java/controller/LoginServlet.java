package controller;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletContext;
import org.apache.commons.codec.binary.Base64;

public class LoginServlet extends HttpServlet {
    private String dbURL = "jdbc:derby://localhost:1527/mpfour";
    private String dbUser = "app";
    private String dbPass = "app";
    private String secretKey;
    private String cipherAlgorithm;
    private SecretKeySpec keySpec;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

        secretKey = getServletContext().getInitParameter("secretKey");
        cipherAlgorithm = getServletContext().getInitParameter("cipherAlgorithm");

        try {
            keySpec = new SecretKeySpec(secretKey.getBytes("UTF-8"), "AES");
        } catch (Exception e) {
            throw new ServletException("Failed to initialize encryption key", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (isEmpty(username) && isEmpty(password)) {
            res.sendRedirect("view/noLoginCredentials.jsp");
            return;
        }

        try {
            String driver = "org.apache.derby.jdbc.ClientDriver";
            Class.forName(driver);
            
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            
            PreparedStatement stmt = conn.prepareStatement(
                    "SELECT password, role FROM USERS WHERE username=?"
            );
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            boolean userExists = false;
            boolean passwordMatch = false;
            String role = null;

            if (rs.next()) {
                userExists = true;
                String encryptedPassword = rs.getString("password");
                role = rs.getString("role");
                passwordMatch = matchPassword(password, encryptedPassword);
            }

            handleLoginResult(req, res, username, role, userExists, passwordMatch, password);

        } catch (SQLException e) {
            e.printStackTrace();
            res.sendRedirect("view/error_4.jsp");
        } catch (Exception en) {}
    }

    private boolean matchPassword(String plainPassword, String encrypted) {
        try {
            ServletContext context = getServletContext();
            
            String keyString = context.getInitParameter("secretKey");
            String cipherAlgorithm = context.getInitParameter("cipher");
            byte[] key = keyString.getBytes("UTF-8");
                
            Cipher cipher = Cipher.getInstance(cipherAlgorithm);
            final SecretKeySpec secretKey = new SecretKeySpec(key, "AES");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            
            String decrypted = new String(cipher.doFinal(Base64.decodeBase64(encrypted)));
            
            return decrypted.equals(plainPassword);
        } catch (Exception e) {
            return false;
        }
    }

    private void handleLoginResult(HttpServletRequest req, HttpServletResponse res,
                                   String username, String role,
                                   boolean userExists, boolean passwordMatch,
                                   String password) throws IOException {

        if (userExists && passwordMatch) {
            HttpSession session = req.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            session.setMaxInactiveInterval(5 * 60);
            res.sendRedirect("view/courseList.jsp");

        } else if (userExists) {
            res.sendRedirect("view/error_2.jsp"); // wrong password

        } else {
            res.sendRedirect(isEmpty(password) ? "view/error_1.jsp" : "view/error_3.jsp");
        }
    }

    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }
}
