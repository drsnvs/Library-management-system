/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
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
        try {
            HttpSession session = request.getSession();
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");

            int user_id = Integer.parseInt(request.getParameter("user_id"));
            int book_id = Integer.parseInt(request.getParameter("book_id"));
            request.setAttribute("user_id", user_id);
            request.setAttribute("book_id", book_id);
            // Check if user has borrowed the book
            String checkRentQuery = "SELECT * FROM book_rent_table WHERE book_id = ? AND id = ? AND active = 1 AND  book_allocated = 1 ";
            PreparedStatement checkRentPs = con.prepareStatement(checkRentQuery);
            checkRentPs.setInt(1, book_id);
            checkRentPs.setInt(2, user_id);
            ResultSet rsRent = checkRentPs.executeQuery();
            if (rsRent.next()) {
                LocalDate today = LocalDate.now();
                Date returnDate = Date.valueOf(today);
                int rent_id = Integer.parseInt(rsRent.getString("rent_id"));
                Date dueDate = rsRent.getDate("date_due");
                if (returnDate.after(rsRent.getDate("date_due"))) {
                    // Redirect to penalty payment page
                    message = "Pay Penalty for due date!";
//                    response.sendRedirect("bookPenalty.jsp?message=Pay Penalty for due date!");
//                    RequestDispatcher rd = request.getRequestDispatcher("bookPenalty.jsp");
//                    rd.forward(request, response);
//                    request.setAttribute("user_id", user_id);
//                    request.setAttribute("book_id", book_id);
//                    RequestDispatcher rd = request.getRequestDispatcher("payPenalty.jsp");
//                    rd.forward(request, response);
                    long daysLate = (returnDate.getTime() - dueDate.getTime()) / (1000 * 60 * 60 * 24);
                    double fineAmount = daysLate * 10.0; // 1 per day
                    request.setAttribute("message", message);
                    session.setAttribute("message", message);
                    request.setAttribute("fineAmount", fineAmount);
                    session.setAttribute("fineAmount", fineAmount);
                    // Insert penalty data into book_fine_table
                    String insertFineQuery = "INSERT INTO book_fine_table (rent_id, id, fine_amount, paid, active, createdBy, createdOn) VALUES (?, ?, ?, 0, 1, ?, ?)";
                    PreparedStatement insertFinePs = con.prepareStatement(insertFineQuery);
                    insertFinePs.setInt(1, rent_id);
                    insertFinePs.setInt(2, user_id);
                    insertFinePs.setDouble(3, fineAmount);
                    insertFinePs.setInt(4, Integer.parseInt(session.getAttribute("user_id").toString())); // assuming the user who creates the record is the one who pays the fine
                    insertFinePs.setDate(5, returnDate);
                    insertFinePs.executeUpdate();
                    RequestDispatcher rd = request.getRequestDispatcher("payPenalty.jsp");
                    rd.forward(request, response);
                    return;
                    // Redirect to penalty payment page
//                    response.sendRedirect("bookPenalty.jsp?message=Pay Penalty for due date!&fine_amount=" + fineAmount);
//                    return;
                }else{
                    
                    
                // Update book_rent_table to mark the book as returned
                    String updateRentQuery = "UPDATE book_rent_table SET book_allocated = 0, return_date = ? WHERE book_id = ? AND id = ? AND rent_id = ?";
                    PreparedStatement updateRentPs = con.prepareStatement(updateRentQuery);
                    updateRentPs.setDate(1, returnDate);
                    updateRentPs.setInt(2, book_id);
                    updateRentPs.setInt(3, user_id);
                    updateRentPs.setInt(4, rent_id);
                    int result = updateRentPs.executeUpdate();

                    if (result > 0) {

    //                    if(returnDate.after(rsRent.getDate("date_due"))){
    //                        response.sendRedirect("returnBook.jsp?message=Pay Penalty for due date!");
    //                    }
                        // Update book_table to increment quantity by 1
                        String updateQuantityQuery = "UPDATE book_table SET quantity = quantity + 1 WHERE book_id = ?";
                        PreparedStatement updateQuantityPs = con.prepareStatement(updateQuantityQuery);
                        updateQuantityPs.setInt(1, book_id);
                        updateQuantityPs.executeUpdate();

                    // Update data_table to decrement allocated books count
                        String updateAllocatedQuery = "UPDATE data_table SET allocated_book = allocated_book - 1 WHERE id = ?";
                        PreparedStatement updateAllocatedPs = con.prepareStatement(updateAllocatedQuery);
                        updateAllocatedPs.setInt(1, user_id);
                        updateAllocatedPs.executeUpdate();

//                        response.sendRedirect("returnBook.jsp?message=Book returned successfully!");
                        message = "Book returned successfully!";
                    } else {
//                        response.sendRedirect("returnBook.jsp?message=Failed to return book!");
                        message = "Failed to return book!";
                    }
                }
            } else {
//                response.sendRedirect("returnBook.jsp?message=User has not borrowed this book or book return already processed!");
                message = "User has not borrowed this book or book return already processed!";
            }
            con.close();
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
