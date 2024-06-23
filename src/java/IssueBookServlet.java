/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.sql.ResultSet;
import java.time.LocalDate;
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
            try {
                HttpSession session = request.getSession();
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");

                int user_id = Integer.parseInt(request.getParameter("user_id").toString());
                int book_id = Integer.parseInt(request.getParameter("book_id"));

                // Check if user exists
                String checkUserQuery = "SELECT active, allocated_book FROM data_table WHERE id = ?";
                PreparedStatement checkUserPs = con.prepareStatement(checkUserQuery);
                checkUserPs.setInt(1, user_id);
                ResultSet rsUser = checkUserPs.executeQuery();
                if (rsUser.next()) {
                    boolean isActive = rsUser.getBoolean("active");
                    int allocatedBooks = rsUser.getInt("allocated_book");
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
                String checkBookQuery = "SELECT COUNT(*) FROM book_table WHERE book_id = ?";
                PreparedStatement checkBookPs = con.prepareStatement(checkBookQuery);
                checkBookPs.setInt(1, book_id);
                ResultSet rsBook = checkBookPs.executeQuery();
                if (rsBook.next()) {
                    int bookCount = rsBook.getInt(1);
                    if (bookCount == 0) {
                        response.sendRedirect("issueBook.jsp?message=Book not found!");
                        return;
                    }
                }

                LocalDate today = LocalDate.now();
                Date date_out;
                Date date_due;

                if (request.getParameter("issue_date").isEmpty()) {
                    date_out = Date.valueOf(today);
                    date_due = Date.valueOf(today.plusDays(14));
                } else {
                    LocalDate issueDate = LocalDate.parse(request.getParameter("issue_date"));
                    date_out = Date.valueOf(issueDate);
                    date_due = Date.valueOf(date_out.toLocalDate().plusDays(14));
                }

//                date_due = Date.valueOf(today.plusDays(14));
                int createdBy = Integer.parseInt(session.getAttribute("user_id").toString());
                Date createdOn = Date.valueOf(today);

                // Insert into book_rent_table
                String rentQuery = "INSERT INTO book_rent_table (book_id, id, date_out, date_due, active, createdBy, createdOn) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement rentPs = con.prepareStatement(rentQuery);
                rentPs.setInt(1, book_id);
                rentPs.setInt(2, user_id);
                rentPs.setDate(3, date_out);
                rentPs.setDate(4, date_due);
                rentPs.setInt(5, 1);
                rentPs.setInt(6, createdBy);
                rentPs.setDate(7, createdOn);
                int result = rentPs.executeUpdate();

                // Update data_table to increment allocated books count
                if (result > 0) {
                    String updateQuery = "UPDATE data_table SET allocated_book = allocated_book + 1 WHERE id = ?";
                    PreparedStatement updatePs = con.prepareStatement(updateQuery);
                    updatePs.setInt(1, user_id);
                    updatePs.executeUpdate();

                    // Insert into record_table
                    String recordQuery = "INSERT INTO record_table (book_id, id, date_out, date_due, createdBy, createdOn) VALUES (?, ?, ?, ?, ?, ?)";
                    PreparedStatement recordPs = con.prepareStatement(recordQuery);
                    recordPs.setInt(1, book_id);
                    recordPs.setInt(2, user_id);
                    recordPs.setDate(3, date_out);
                    recordPs.setDate(4, date_due);
                    recordPs.setInt(5, createdBy);
                    recordPs.setDate(6, createdOn);
                    recordPs.executeUpdate();

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
