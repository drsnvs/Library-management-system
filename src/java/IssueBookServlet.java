/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
//import java.sql.Connection;
//import java.sql.DriverManager;
import java.sql.PreparedStatement;

import java.sql.Date;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DARSHAN
 */
public class IssueBookServlet extends HttpServlet {

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
            out.println("<title>Servlet IssueBookServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            String title = null;
            
            try {
                LmsDbConnection dbcon = new LmsDbConnection();
                HttpSession session = request.getSession();
//                Class.forName("com.mysql.jdbc.Driver");
//                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
//                String user_id_s = request.getParameter("user_id");
//                int user_id = Integer.parseInt(user_id_s);
//                String book_id_s = request.getParameter("book_id");
//                int book_id = Integer.parseInt(book_id_s);
                String user_id_s = request.getParameter("user_id");
                int user_id = Integer.parseInt(user_id_s);
                System.out.println(user_id);
                String book_id_s = request.getParameter("book_id");
                int book_id = Integer.parseInt(book_id_s);
                System.out.println(book_id);
                String email = "";
                String firstName = "";
                String lastName = "";
                // Check if user exists
                String checkUserQuery = "SELECT active,email_id,first_name,last_name, allocated_book FROM data_table WHERE id = ?";
                PreparedStatement checkUserPs = dbcon.PsStatment(checkUserQuery);
                checkUserPs.setInt(1, user_id);
                ResultSet rsUser = checkUserPs.executeQuery();
                if (rsUser.next()) {
                    boolean isActive = rsUser.getBoolean("active");
                    int allocatedBooks = rsUser.getInt("allocated_book");
                    email = rsUser.getString("email_id");
                    firstName = rsUser.getString("first_name");
                    lastName = rsUser.getString("last_name");
                    if (!isActive) {
                        response.sendRedirect("login.jsp");
                        return;
                    }
                    if (allocatedBooks >= 2) {
                        response.sendRedirect("issueBook.jsp?message=Maximum book limit reached!");
                        return;
                    }
                } else {
                    response.sendRedirect("issueBook.jsp?message=User not found!");
                    return;
                }

                // Check if book exists
                String checkBookQuery = "SELECT COUNT(*) FROM book_table WHERE book_id = ? and quantity > 0";
                PreparedStatement checkBookPs = dbcon.PsStatment(checkBookQuery);
                checkBookPs.setInt(1, book_id);
                ResultSet rsBook = checkBookPs.executeQuery();
                if (rsBook.next()) {
                    int bookCount = rsBook.getInt(1);
                    if (bookCount == 0) {
                        response.sendRedirect("issueBook.jsp?message=Book not found!");
                        return;
                    }
                }
                
                
                String q = "SELECT book_title FROM book_table WHERE book_id = ?";
                PreparedStatement pas = dbcon.PsStatment(q);
                pas.setInt(1, book_id);
                ResultSet r = pas.executeQuery();
                if (r.next()) {
                    title = r.getString("book_title");
                }
                
                

                LocalDate today = LocalDate.now();
                Date date_out;
                Date date_due;

//                if (request.getParameter("issue_date").isEmpty()) {
//                    date_out = Date.valueOf(today);
//                    date_due = Date.valueOf(today.plusDays(14));
//                } else {
//                    LocalDate issueDate = LocalDate.parse(request.getParameter("issue_date"));
//                    date_out = Date.valueOf(issueDate);
//                    date_due = Date.valueOf(date_out.toLocalDate().plusDays(14));
//                }
                date_out = Date.valueOf(today);
                date_due = Date.valueOf(today.plusDays(14)); 
//                date_due = Date.valueOf(today.plusDays(14));
                int createdBy = Integer.parseInt(session.getAttribute("user_id").toString());
                Date createdOn = Date.valueOf(today);

                // Insert into book_rent_table
                String rentQuery = "INSERT INTO book_rent_table (book_id, id, date_out, date_due, active, allocated_book, createdBy, createdOn) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement rentPs = dbcon.PsStatment(rentQuery);
                rentPs.setInt(1, book_id);
                rentPs.setInt(2, user_id);
                rentPs.setDate(3, date_out);
                rentPs.setDate(4, date_due);
                rentPs.setInt(5, 1);
                rentPs.setInt(6, 1);
                rentPs.setInt(7, createdBy);
                rentPs.setDate(8, createdOn);
                int result = rentPs.executeUpdate();

                // Update data_table to increment allocated books count
                if (result > 0) {
                    
                    String updateQuantityQuery = "UPDATE book_table SET quantity = quantity - 1 WHERE book_id = ?";
                    PreparedStatement updatePss = dbcon.PsStatment(updateQuantityQuery);
                    updatePss.setInt(1, book_id);
                    updatePss.executeUpdate();
                    
                    
                    String updateQuery = "UPDATE data_table SET allocated_book = allocated_book + 1 WHERE id = ?";
                    PreparedStatement updatePs = dbcon.PsStatment(updateQuery);
                    updatePs.setInt(1, user_id);
                    updatePs.executeUpdate();

                    // Insert into record_table
                    String recordQuery = "INSERT INTO record_table (book_id, id, date_out, date_due, createdBy, createdOn) VALUES (?, ?, ?, ?, ?, ?)";
                    PreparedStatement recordPs = dbcon.PsStatment(recordQuery);
                    recordPs.setInt(1, book_id);
                    recordPs.setInt(2, user_id);
                    recordPs.setDate(3, date_out);
                    recordPs.setDate(4, date_due);
                    recordPs.setInt(5, createdBy);
                    recordPs.setDate(6, createdOn);
                    recordPs.executeUpdate();
                    // mail
                    String to = email; // change accordingly
                    String from = "sarvaiyadarshan50@gmail.com"; // change accordingly
                    String host = "smtp.gmail.com";

                    // Get the session object
                    Properties properties = System.getProperties();
                    properties.put("mail.smtp.host", host);
                    properties.put("mail.smtp.port", "587");
                    properties.put("mail.smtp.auth", "true");
                    properties.put("mail.smtp.starttls.enable", "true");

                    Session ssn = Session.getInstance(properties, new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(dbcon.getEmailId(),dbcon.getEmailProtect()); // change accordingly
                        }
                    });

                    // compose the message
                    try {
                        MimeMessage message = new MimeMessage(ssn);
                        message.setFrom(new InternetAddress(from));
                        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                        message.setSubject("Book Transaction LMS");
//                        message.setText("Hello, "+firstName+" "+lastName+". \nYou are successfully Rgistered in LMS\n\nRegistered Email id : "+email+"\nPassword : \n\nThank you...\nHave a nice day !!!");
                        String messageContent = "<html>" +
                                                "<body>" +
                                                "<p>Dear Reader,</p>" +
                                                "<p>You have successfully issued the following books on " + date_out + ". " +
                                                "If you find any discrepancies in the details below, please contact the issuing department within 24 hours.</p>" +
                                                "<table style='border-collapse: collapse; width: 100%;'>" +
                                                "<tr>" +
                                                "<th style='border: 1px solid #000; padding: 8px; background-color: #f2f2f2;'>Title</th>" +
                                                "<th style='border: 1px solid #000; padding: 8px; background-color: #f2f2f2;'>Issue Date</th>" +
                                                "<th style='border: 1px solid #000; padding: 8px; background-color: #f2f2f2;'>Return Date</th>" +
                                                "</tr>" +
                                                "<tr>" +
                                                "<td style='border: 1px solid #000; padding: 8px;text-align: center;'>" + title + "</td>" +
                                                "<td style='border: 1px solid #000; padding: 8px;text-align: center;'>" + date_out + "</td>" +
                                                "<td style='border: 1px solid #000; padding: 8px;text-align: center;'>" + date_due + "</td>" +
                                                "</tr>" +
                                                "</table>" +
                                                "<p>Thank you for your cooperation.</p>" +
                                                "<p>Library Management System</p>" +
                                                "<p>Ahmedabad</p>" +
                                                "<p>Contact Number: 079-40016261</p>" +
                                                "</body>" +
                                                "</html>";

                        // Send message
                        message.setContent(messageContent, "text/html; charset=UTF-8");
                        Transport.send(message);
                        System.out.println("Book issued successfully!....");

                    } catch (MessagingException mex) {
                        mex.printStackTrace();
                    }
                    
                    response.sendRedirect("issueBook.jsp?message=Book issued successfully!");
                } else {
                    response.sendRedirect("issueBook.jsp?message=Book issue failed!");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("issueBook.jsp?message=An error occurred!");
            }
            
            
            out.println("<h1>Servlet IssueBookServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
