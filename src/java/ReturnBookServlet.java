/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
//import java.sql.Connection;
import java.sql.Date;
//import java.sql.DriverManager;
import java.sql.PreparedStatement;
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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DARSHAN
 */
public class ReturnBookServlet extends HttpServlet {

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
        String message = "";
        LocalDate today = LocalDate.now();
        Date returnDate = Date.valueOf(today);
        String title = null;
        String email_e = null;
        try {
            
            LmsDbConnection dbcon = new LmsDbConnection();
            HttpSession session = request.getSession();
//            Class.forName("com.mysql.jdbc.Driver");
//            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");

            int user_id = Integer.parseInt(request.getParameter("user_id"));
            int book_id = Integer.parseInt(request.getParameter("book_id"));
            request.setAttribute("user_id", user_id);
            request.setAttribute("book_id", book_id);
            // Check if user has borrowed the book
            String checkRentQuery = "SELECT * FROM book_rent_table WHERE book_id = ? AND id = ? AND active = 1 AND  allocated_book = 1 ";
            PreparedStatement checkRentPs = dbcon.PsStatment(checkRentQuery);
            checkRentPs.setInt(1, book_id);
            checkRentPs.setInt(2, user_id);
            ResultSet rsRent = checkRentPs.executeQuery();
//            if (rsRent.next()) {
//                LocalDate today = LocalDate.now();
//                Date returnDate = Date.valueOf(today);
//                int rent_id = Integer.parseInt(rsRent.getString("rent_id"));
//                Date dueDate = rsRent.getDate("date_due");
//                if (returnDate.after(rsRent.getDate("date_due"))) {
//                    // Redirect to penalty payment page
//                    message = "Pay Penalty for due date!";
////                    response.sendRedirect("bookPenalty.jsp?message=Pay Penalty for due date!");
////                    RequestDispatcher rd = request.getRequestDispatcher("bookPenalty.jsp");
////                    rd.forward(request, response);
////                    request.setAttribute("user_id", user_id);
////                    request.setAttribute("book_id", book_id);
////                    RequestDispatcher rd = request.getRequestDispatcher("payPenalty.jsp");
////                    rd.forward(request, response);
//                    long daysLate = (returnDate.getTime() - dueDate.getTime()) / (1000 * 60 * 60 * 24);
//                    double fineAmount = daysLate * 10.0; // 1 per day
//                    request.setAttribute("message", message);
//                    session.setAttribute("message", message);
//                    request.setAttribute("fineAmount", fineAmount);
//                    session.setAttribute("fineAmount", fineAmount);
//                    // Insert penalty data into book_fine_table
//                    String insertFineQuery = "INSERT INTO book_fine_table (rent_id, id, fine_amount, paid, active, createdBy, createdOn) VALUES (?, ?, ?, 0, 1, ?, ?)";
//                    PreparedStatement insertFinePs = con.prepareStatement(insertFineQuery);
//                    insertFinePs.setInt(1, rent_id);
//                    insertFinePs.setInt(2, user_id);
//                    insertFinePs.setDouble(3, fineAmount);
//                    insertFinePs.setInt(4, Integer.parseInt(session.getAttribute("user_id").toString())); // assuming the user who creates the record is the one who pays the fine
//                    insertFinePs.setDate(5, returnDate);
//                    insertFinePs.executeUpdate();
//                    RequestDispatcher rd = request.getRequestDispatcher("payPenalty.jsp");
//                    rd.forward(request, response);
//                    return;
//                    // Redirect to penalty payment page
////                    response.sendRedirect("bookPenalty.jsp?message=Pay Penalty for due date!&fine_amount=" + fineAmount);
////                    return;
//                }else{
//                    
//                    
//                // Update book_rent_table to mark the book as returned
//                    String updateRentQuery = "UPDATE book_rent_table SET allocated_book = 0, return_date = ? WHERE book_id = ? AND id = ? AND rent_id = ?";
//                    PreparedStatement updateRentPs = con.prepareStatement(updateRentQuery);
//                    updateRentPs.setDate(1, returnDate);
//                    updateRentPs.setInt(2, book_id);
//                    updateRentPs.setInt(3, user_id);
//                    updateRentPs.setInt(4, rent_id);
//                    int result = updateRentPs.executeUpdate();
//
//                    if (result > 0) {
//
//    //                    if(returnDate.after(rsRent.getDate("date_due"))){
//    //                        response.sendRedirect("returnBook.jsp?message=Pay Penalty for due date!");
//    //                    }
//                        // Update book_table to increment quantity by 1
//                        String updateQuantityQuery = "UPDATE book_table SET quantity = quantity + 1 WHERE book_id = ?";
//                        PreparedStatement updateQuantityPs = con.prepareStatement(updateQuantityQuery);
//                        updateQuantityPs.setInt(1, book_id);
//                        updateQuantityPs.executeUpdate();
//
//                    // Update data_table to decrement allocated books count
//                        String updateAllocatedQuery = "UPDATE data_table SET allocated_book = allocated_book - 1 WHERE id = ?";
//                        PreparedStatement updateAllocatedPs = con.prepareStatement(updateAllocatedQuery);
//                        updateAllocatedPs.setInt(1, user_id);
//                        updateAllocatedPs.executeUpdate();
//
////                        response.sendRedirect("returnBook.jsp?message=Book returned successfully!");
//                        message = "Book returned successfully!";
//                    } else {
////                        response.sendRedirect("returnBook.jsp?message=Failed to return book!");
//                        message = "Failed to return book!";
//                    }
//                }
//            } else {
////                response.sendRedirect("returnBook.jsp?message=User has not borrowed this book or book return already processed!");
//                message = "User has not borrowed this book or book return already processed!";
//            }
            if (rsRent.next()) {
                
                int rent_id = Integer.parseInt(rsRent.getString("rent_id"));
                Date dueDate = rsRent.getDate("date_due");

                // Check if the fine has been paid
                String checkFineQuery = "SELECT * FROM book_fine_table WHERE rent_id = ? AND id = ? AND paid = 1";
                PreparedStatement checkFinePs = dbcon.PsStatment(checkFineQuery);
                checkFinePs.setInt(1, rent_id);
                checkFinePs.setInt(2, user_id);
                ResultSet rsFine = checkFinePs.executeQuery();

                if (returnDate.after(dueDate)) {
                    // If the return date is after the due date, check payment status
                    if (rsFine.next()) {
                        // User has paid the fine, allow book return
                        String updateRentQuery = "UPDATE book_rent_table SET allocated_book = 0, return_date = ? WHERE book_id = ? AND id = ? AND rent_id = ?";
                        PreparedStatement updateRentPs = dbcon.PsStatment(updateRentQuery);
                        updateRentPs.setDate(1, returnDate);
                        updateRentPs.setInt(2, book_id);
                        updateRentPs.setInt(3, user_id);
                        updateRentPs.setInt(4, rent_id);
                        int result = updateRentPs.executeUpdate();

                        if (result > 0) {
                            // Update book quantity and allocated books count
                            String updateQuantityQuery = "UPDATE book_table SET quantity = quantity + 1 WHERE book_id = ?";
                            PreparedStatement updateQuantityPs = dbcon.PsStatment(updateQuantityQuery);
                            updateQuantityPs.setInt(1, book_id);
                            updateQuantityPs.executeUpdate();

                            String updateAllocatedQuery = "UPDATE data_table SET allocated_book = allocated_book - 1 WHERE id = ?";
                            PreparedStatement updateAllocatedPs = dbcon.PsStatment(updateAllocatedQuery);
                            updateAllocatedPs.setInt(1, user_id);
                            updateAllocatedPs.executeUpdate();

                            message = "Book returned successfully!";
                        } else {
                            message = "Failed to return book!";
                        }
                    } else {
                        // User has not paid the fine, redirect to penalty page
                        long daysLate = (returnDate.getTime() - dueDate.getTime()) / (1000 * 60 * 60 * 24);
                        double fineAmount = daysLate * 10.0; // Assuming 10 per day fine

                        message = "Pay Penalty for overdue!";
                        request.setAttribute("message", message);
                        session.setAttribute("message", message);
                        request.setAttribute("fineAmount", fineAmount);
                        session.setAttribute("fineAmount", fineAmount);

                        // Insert the penalty record into the book_fine_table
                        String insertFineQuery = "INSERT INTO book_fine_table (rent_id, id, fine_amount, paid, active, createdBy, createdOn) VALUES (?, ?, ?, 0, 1, ?, ?)";
                        PreparedStatement insertFinePs = dbcon.PsStatment(insertFineQuery);
                        insertFinePs.setInt(1, rent_id);
                        insertFinePs.setInt(2, user_id);
                        insertFinePs.setDouble(3, fineAmount);
                        insertFinePs.setInt(4, Integer.parseInt(session.getAttribute("user_id").toString())); // Record creator
                        insertFinePs.setDate(5, returnDate);
                        insertFinePs.executeUpdate();
                        request.setAttribute("rent_id", rent_id);

                        // Redirect to penalty payment page
                        RequestDispatcher rd = request.getRequestDispatcher("payPenalty.jsp");
                        rd.forward(request, response);
                        return;
                    }
                } else {
                    // If return is on time, proceed with returning the book as usual
                    String updateRentQuery = "UPDATE book_rent_table SET allocated_book = 0, return_date = ? WHERE book_id = ? AND id = ? AND rent_id = ?";
                    PreparedStatement updateRentPs = dbcon.PsStatment(updateRentQuery);
                    updateRentPs.setDate(1, returnDate);
                    updateRentPs.setInt(2, book_id);
                    updateRentPs.setInt(3, user_id);
                    updateRentPs.setInt(4, rent_id);
                    int result = updateRentPs.executeUpdate();

                    if (result > 0) {
                        // Update book quantity in book_table
                        String updateQuantityQuery = "UPDATE book_table SET quantity = quantity + 1 WHERE book_id = ?";
                        PreparedStatement updateQuantityPs = dbcon.PsStatment(updateQuantityQuery);
                        updateQuantityPs.setInt(1, book_id);
                        updateQuantityPs.executeUpdate();

                        // Update allocated book count in data_table
                        String updateAllocatedQuery = "UPDATE data_table SET allocated_book = allocated_book - 1 WHERE id = ?";
                        PreparedStatement updateAllocatedPs = dbcon.PsStatment(updateAllocatedQuery);
                        updateAllocatedPs.setInt(1, user_id);
                        updateAllocatedPs.executeUpdate();
                        
                        
                        String q = "SELECT book_title FROM book_table WHERE book_id = ?";
                        PreparedStatement pas = dbcon.PsStatment(q);
                        pas.setInt(1, book_id);
                        ResultSet r = pas.executeQuery();
                        if (r.next()) {
                            title = r.getString("book_title");
                        }
                        
                        String getEmail = "SELECT email_id FROM data_table WHERE id = ?";
                        PreparedStatement pase = dbcon.PsStatment(getEmail);
                        pase.setInt(1, user_id);
                        ResultSet re = pase.executeQuery();
                        if (re.next()) {
                            email_e = re.getString("email_id");
                        }
                        
                        // mail
                        String to = email_e; // change accordingly
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
                            MimeMessage msg = new MimeMessage(ssn);
                            msg.setFrom(new InternetAddress(from));
                            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                            msg.setSubject("Book Transaction LMS");
    //                        message.setText("Hello, "+firstName+" "+lastName+". \nYou are successfully Rgistered in LMS\n\nRegistered Email id : "+email+"\nPassword : \n\nThank you...\nHave a nice day !!!");
                            String messageContent = "<html>" +
                                                    "<body>" +
                                                    "<p>Dear Reader,</p>" +
                                                    "If you find any discrepancies in the details below, please contact the issuing department within 24 hours.</p>" +
                                                    "<table style='border-collapse: collapse; width: 100%;'>" +
                                                    "<tr>" +
                                                    "<th style='border: 1px solid #000; padding: 8px; background-color: #f2f2f2;'>Title</th>" +
                                                    "<th style='border: 1px solid #000; padding: 8px; background-color: #f2f2f2;'>Return Date</th>" +
                                                    "<th style='border: 1px solid #000; padding: 8px; background-color: #f2f2f2;'>Type</th>" +
                                                    "</tr>" +
                                                    "<tr>" +
                                                    "<td style='text-align: center;border: 1px solid #000; padding: 8px;'>" + title + "</td>" +
                                                    "<td style='text-align: center;border: 1px solid #000; padding: 8px;'>" + returnDate + "</td>" +
                                                    "<td style='text-align: center;border: 1px solid #000; padding: 8px;'>Success</td>" +
                                                    "</tr>" +
                                                    "</table>" +
                                                    "<p>Thank you for your cooperation.</p>" +
                                                    "<p>Library Management System</p>" +
                                                    "<p>Ahmedabad</p>" +
                                                    "<p>Contact Number: 079-40016261</p>" +
                                                    "</body>" +
                                                    "</html>";

                            // Send message
                            msg.setContent(messageContent, "text/html; charset=UTF-8");
                            Transport.send(msg);
                            System.out.println("Book issued successfully!....");

                        } catch (MessagingException mex) {
                            mex.printStackTrace();
                        }

                        message = "Book returned successfully!";
                    } else {
                        message = "Failed to return book!";
                    }
                }
            } else {
                message = "User has not borrowed this book or book return already processed!";
            }


//            con.close();
        } catch (Exception e) {
            e.printStackTrace();
//            response.sendRedirect("returnBook.jsp?message=An error occurred!");
            message = "An error occurred!";
        } finally{
            response.sendRedirect("returnBook.jsp?message=" + message);
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
