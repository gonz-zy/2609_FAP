/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfTemplate;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
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
public class ReportServlet extends HttpServlet {
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
            out.println("<title>Servlet ReportServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReportServlet at " + request.getContextPath() + "</h1>");
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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        String role = (String) request.getSession().getAttribute("role");
        String choice = request.getParameter("choice");
        
        Document document = new Document(PageSize.LETTER.rotate());
        Font fontTitle = new Font(Font.FontFamily.TIMES_ROMAN, 15, Font.BOLD),
            fontNormal = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)    ;
        
        Date date = new Date();
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        
        String year = String.valueOf(calendar.get(Calendar.YEAR));
        String month = String.valueOf(calendar.get(Calendar.MONTH) + 1);
        String day = String.valueOf(calendar.get(Calendar.DAY_OF_MONTH));
        String hour = String.valueOf(calendar.get(Calendar.HOUR_OF_DAY));
        String minute = String.valueOf(calendar.get(Calendar.MINUTE));
        String second = String.valueOf(calendar.get(Calendar.SECOND));
        
        if(month.length() == 1) 
            month = "0" + month;
        if(day.length() == 1) 
            day = "0" + day;
        if(hour.length() == 1) 
            hour = "0" + hour;
        if(minute.length() == 1) 
            minute = "0" + minute;
        if(second.length() == 1) 
            second = "0" + second;
        
        String filename = "COURSELIST_" + year + month + day + hour + minute + second + ".pdf";
        
        try {
            String driver = "com.mysql.cj.jdbc.Driver";
            Class.forName(driver);
            String url = "jdbc:mysql://localhost:3306/mpfour?useSSL=false&zeroDateTimeBehavior=CONVERT_TO_NULL&allowPublicKeyRetrieval=true";
            String dbusername = "root";
            String dbpassword = "root";
            Connection conn = DriverManager.getConnection(url, dbusername, dbpassword);
            Statement stmt = conn.createStatement();
            ResultSet rs = null;
            
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
                    
            PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
            String reportUser = (String) request.getSession().getAttribute("username");
            writer.setPageEvent(new FooterHandler(reportUser));
            
            String query = "";
            String recordUser, encryptedPassword, recordPassword, recordRole;
            String recordID, recordProf, recordDesc, recordHours, recordPrice, recordCreate;
            String recordEnroll, recordStatus;
            
            ServletContext context = getServletContext();
                    
            String keyString = context.getInitParameter("secretKey");
            String cipherAlgorithm = context.getInitParameter("cipher");
            byte[] key = keyString.getBytes("UTF-8");
                
            Cipher cipher = Cipher.getInstance(cipherAlgorithm);
            final SecretKeySpec secretKey = new SecretKeySpec(key, "AES");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            
            document.open();
            
            if(role.equals("A")) {
                Paragraph paragraph1 = new Paragraph("ADMIN REPORT", fontTitle);
                
                paragraph1.setAlignment(Element.ALIGN_CENTER);
                document.add(paragraph1);
                    
                Paragraph paragraph2 = new Paragraph(("Made on: " + new java.util.Date()) + "\n\n", fontNormal);
                paragraph2.setAlignment(Element.ALIGN_CENTER);
                document.add(paragraph2);
                
                if(choice.equals("all")) {
                    query = "SELECT * FROM USERS ORDER BY LENGTH(USERNAME), USERNAME ASC";
                    rs = stmt.executeQuery(query);
                    
                    Paragraph paragraph3 = new Paragraph("\nList of Accounts\n\n", fontNormal);
                    document.add(paragraph3);
                    
                    PdfPTable table = new PdfPTable(2);
                    table.setHorizontalAlignment(Element.ALIGN_CENTER);
                    
                    PdfPCell cell = new PdfPCell(new Phrase("User\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase("Role", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    while(rs.next()) {
                        recordUser = rs.getString("USERNAME");
                        recordRole = rs.getString("ROLE");
                        
                        if(recordRole.equals("A"))
                            recordRole = "Admin";
                        else
                            recordRole = "Student";
                        
                        if(recordUser.equals(username))
                            recordUser = recordUser + " *";
                    
                        cell = new PdfPCell(new Phrase(recordUser, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                        table.addCell(cell);
                        
                        cell = new PdfPCell(new Phrase(recordRole + "\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.ITALIC)));
                        table.addCell(cell);
                    }
                    
                    document.add(table);
                        
                    Paragraph paragraph4 = new Paragraph("\n\nList of Courses\n\n", fontNormal);
                    document.add(paragraph4);
                    
                    query = "SELECT * FROM COURSE ORDER BY LENGTH(course_id), course_id ASC";
                    rs = stmt.executeQuery(query);
                    
                    table = new PdfPTable(6);
                    table.setHorizontalAlignment(Element.ALIGN_CENTER);
                    
                    cell = new PdfPCell(new Phrase("Course ID\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase("Professor", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase("Description", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase("Hours", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase("Price", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase("Created At", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    while(rs.next()) {
                        recordID = rs.getString("course_id");
                        recordProf = rs.getString("username");
                        recordDesc = rs.getString("description");
                        recordHours = String.valueOf(rs.getInt("hours"));
                        recordPrice = String.valueOf(rs.getFloat("price"));
                        recordCreate = rs.getDate("created_at").toString();
                        
                        cell = new PdfPCell(new Phrase(recordID, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                        table.addCell(cell);
                        
                        cell = new PdfPCell(new Phrase(recordProf, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                        table.addCell(cell);
                    
                        cell = new PdfPCell(new Phrase(recordDesc + "\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.ITALIC)));
                        table.addCell(cell);
                        
                        cell = new PdfPCell(new Phrase(recordHours, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                        table.addCell(cell);
                        
                        cell = new PdfPCell(new Phrase(recordPrice, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                        table.addCell(cell);
                    
                        cell = new PdfPCell(new Phrase(recordCreate + "\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.ITALIC)));
                        table.addCell(cell);
                    }
                    
                    document.add(table);
                    
                    Paragraph paragraph5 = new Paragraph("\n\nList of Enrollments\n\n", fontNormal);
                    document.add(paragraph5);
                    
                    query = "SELECT * FROM ENROLLMENT ORDER BY LENGTH(enroll_id), enroll_id ASC";
                    rs = stmt.executeQuery(query);
                    
                    table = new PdfPTable(5);
                    table.setHorizontalAlignment(Element.ALIGN_CENTER);
                    
                    cell = new PdfPCell(new Phrase("Enrollment ID\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase("Enrollee", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase("Course Enrolled", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase("Status", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase("Enrolled At", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    
                    while(rs.next()) {
                        recordEnroll = rs.getString("enroll_id");
                        recordUser = rs.getString("username");
                        recordID = rs.getString("course_id");
                        recordStatus = rs.getString("status");
                        recordCreate = rs.getDate("enrolled_at").toString();
                        
                        if(recordStatus.equals("A"))
                            recordStatus = "Active";
                        else
                            recordStatus = "Dropped";
                        
                        cell = new PdfPCell(new Phrase(recordEnroll, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                        table.addCell(cell);
                        
                        cell = new PdfPCell(new Phrase(recordUser, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                        table.addCell(cell);
                    
                        cell = new PdfPCell(new Phrase(recordID + "\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.ITALIC)));
                        table.addCell(cell);
                        
                        cell = new PdfPCell(new Phrase(recordStatus, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                        table.addCell(cell);
                        
                        cell = new PdfPCell(new Phrase(recordCreate, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                        table.addCell(cell); 
                    }
                    
                    document.add(table);
                }
                else {
                    query = "SELECT * FROM USERS WHERE USERNAME='" + username +"'";
                    rs = stmt.executeQuery(query);
                    
                    rs.next();
                        
                    recordUser = rs.getString("USERNAME");
                    encryptedPassword = rs.getString("PASSWORD");
                    recordPassword = new String(cipher.doFinal(Base64.decodeBase64(encryptedPassword)));
                    recordRole = rs.getString("ROLE");
                    
                    if(recordRole.equals("A"))
                            recordRole = "Admin\n";
                        else
                            recordRole = "Student\n";
                    
                    Paragraph paragraph = new Paragraph(("\nUsername: " + recordUser), fontNormal);
                    document.add(paragraph);
                    
                    paragraph = new Paragraph(("\nPassword: " + recordPassword), fontNormal);
                    document.add(paragraph);
                    
                    paragraph = new Paragraph(("\nRole: " + recordRole), fontNormal);
                    document.add(paragraph);
                    
                    PdfPTable table = new PdfPTable(6);
                    table.setHorizontalAlignment(Element.ALIGN_CENTER);
                    
                    PdfPCell cell = new PdfPCell(new Phrase("Course ID\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase("Professor\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase("Description\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase("Hours\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase("Price\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase("Created On\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                    table.addCell(cell);
                    
                    
                    query = "SELECT * FROM COURSE WHERE username='" + username + "' ORDER BY LENGTH(course_id), course_id ASC";
                    rs = stmt.executeQuery(query);
                    while(rs.next()) {
                        recordID = rs.getString("course_id");
                        recordProf = rs.getString("username");
                        recordDesc = rs.getString("description");
                        recordHours = String.valueOf(rs.getInt("hours"));
                        recordPrice = String.valueOf(rs.getFloat("price"));
                        recordCreate = rs.getDate("created_at").toString();
                        
                        cell = new PdfPCell(new Phrase(recordID, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                        table.addCell(cell);
                        
                        cell = new PdfPCell(new Phrase(recordProf, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                        table.addCell(cell);
                    
                        cell = new PdfPCell(new Phrase(recordDesc + "\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.ITALIC)));
                        table.addCell(cell);
                        
                        cell = new PdfPCell(new Phrase(recordHours, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                        table.addCell(cell);
                        
                        cell = new PdfPCell(new Phrase(recordPrice, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                        table.addCell(cell);
                    
                        cell = new PdfPCell(new Phrase(recordCreate + "\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.ITALIC)));
                        table.addCell(cell);
                    }

                    document.add(table);
                }
            }
            else {
                Paragraph paragraph1 = new Paragraph("GUEST COURSE REPORT", fontTitle);
                
                paragraph1.setAlignment(Element.ALIGN_CENTER);
                document.add(paragraph1);
                    
                Paragraph paragraph2 = new Paragraph(("Made on: " + new java.util.Date()) + "\n\n", fontNormal);
                paragraph2.setAlignment(Element.ALIGN_CENTER);
                document.add(paragraph2);
                
                String courseId = request.getParameter("courseId");
                query = "SELECT * FROM COURSE WHERE course_id='"+courseId + "'";
                rs = stmt.executeQuery(query);
                
                rs.next();
                
                recordID = rs.getString("course_id");
                recordProf = rs.getString("username");
                recordDesc = rs.getString("description");
                recordHours = String.valueOf(rs.getInt("hours"));
                recordPrice = String.valueOf(rs.getFloat("price"));
                recordCreate = rs.getDate("created_at").toString();
                
                Paragraph paragraph = new Paragraph("\nCourse ID: " + recordID, fontNormal);
                document.add(paragraph);
                
                paragraph = new Paragraph("\nProfessor: " + recordProf, fontNormal);
                document.add(paragraph);
                
                paragraph = new Paragraph("\nDescription: " + recordDesc, fontNormal);
                document.add(paragraph);
                
                paragraph = new Paragraph("\nHours: " + recordHours, fontNormal);
                document.add(paragraph);
                
                paragraph = new Paragraph("\nPrice: " + recordPrice, fontNormal);
                document.add(paragraph);
                
                paragraph = new Paragraph("\nCreated On: " + recordCreate, fontNormal);
                document.add(paragraph);
                
                query = "SELECT username, password, role FROM USERS WHERE username=(SELECT "
                    + "username FROM ENROLLMENT WHERE course_id='" + courseId + "')";
                rs = stmt.executeQuery(query);
            
                Statement stmt2 = conn.createStatement();
                query = "SELECT status, enrolled_at FROM ENROLLMENT WHERE course_id='" + courseId + "'";
                ResultSet rs2 = stmt2.executeQuery(query);
                
                PdfPTable table = new PdfPTable(4);
                table.setHorizontalAlignment(Element.ALIGN_CENTER);
                    
                PdfPCell cell = new PdfPCell(new Phrase("Username\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                table.addCell(cell);
                    
                cell = new PdfPCell(new Phrase("Role", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                table.addCell(cell);
                
                cell = new PdfPCell(new Phrase("Status", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                table.addCell(cell);
                
                cell = new PdfPCell(new Phrase("Enrolled On", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                table.addCell(cell);
                    
                paragraph = new Paragraph("\nList of Course Enrollees\n\n", fontNormal);
                document.add(paragraph);
                while (rs.next() && rs2.next()) {
                    recordUser = rs.getString("username");
                    recordRole = rs.getString("role");
                    recordStatus = rs2.getString("status");
                    recordCreate = rs2.getString("enrolled_at");
                    
                    cell = new PdfPCell(new Phrase(recordUser, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                    table.addCell(cell);
                        
                    cell = new PdfPCell(new Phrase(recordRole, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                    table.addCell(cell);
                        
                    cell = new PdfPCell(new Phrase(recordStatus, new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
                    table.addCell(cell);
                    
                    cell = new PdfPCell(new Phrase(recordCreate + "\n\n", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.ITALIC)));
                    table.addCell(cell);
                }
                document.add(table);
                
                rs2.close();
                stmt2.close();
            }
            
            rs.close();
            stmt.close();
            conn.close();
            
            document.close();
            writer.close();
        }
        catch(Exception e) {
            e.printStackTrace();
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

class FooterHandler extends PdfPageEventHelper {
    Date date = new Date();
    
    String username;
    PdfTemplate total;
    Font footerFont = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.ITALIC);
    
    FooterHandler(String username) {
        this.username = username;
    }
    
    @Override
    public void onOpenDocument(PdfWriter writer, Document document) {
        total = writer.getDirectContent().createTemplate(50, 20);
    }
    
    @Override
    public void onEndPage(PdfWriter writer, Document document) {
        try {
            PdfContentByte cb = writer.getDirectContent();
            Phrase pages = new Phrase("Page " + writer.getPageNumber() + " of ", footerFont);
            Phrase user = new Phrase("User: " + username, footerFont);
            Phrase header = new Phrase("ICS2609 / 2CSA / Group 5");
            Phrase footer = new Phrase("FAP | Current Date: " + date);
            
            //Header
            ColumnText.showTextAligned(cb,
                Element.ALIGN_CENTER,
                header,
                ((document.left() + document.right())/2),
                document.top() + 10, // Adjust this value for spacing
                0);
            
            //FAP footer
            ColumnText.showTextAligned(cb,
                Element.ALIGN_CENTER,
                footer,
                ((document.left() + document.right())/2),
                document.bottom() - 10, // Adjust this value for spacing
                0);
            
            //Pages footer
            ColumnText.showTextAligned(cb,
                Element.ALIGN_RIGHT,
                pages,
                document.right(),
                document.bottom() - 10, // Adjust this value for spacing
                0);
            
            // User footer
            ColumnText.showTextAligned(cb,
                Element.ALIGN_LEFT,
                user,
                document.left(),
                document.bottom() - 10, // Adjust this value for spacing
                0);
            
            cb.addTemplate(total, document.right(), (document.bottom() - 10));
        }
        catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public void onCloseDocument(PdfWriter writer, Document document) {
        String num = writer.getPageNumber() + "";
        System.out.println(num);
        
        // Write the total page count to the template
        ColumnText.showTextAligned(total, Element.ALIGN_CENTER,
            new Phrase(String.valueOf(writer.getPageNumber()), footerFont),
            7, 0, 0);
    }
}