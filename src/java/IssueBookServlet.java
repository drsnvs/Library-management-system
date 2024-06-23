/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
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
    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Retrieve book_id and user_id from request parameters
            int bookId = Integer.parseInt(request.getParameter("book_id"));
            int userId = Integer.parseInt(request.getParameter("user_id"));

            // Check if user can allocate another book
            if (!canAllocateMoreBooks(userId)) {
                out.println("<p>User already has maximum allocated books!</p>");
                return;
            }

            // Calculate due date (14 days from today)
            LocalDate today = LocalDate.now();
            LocalDate dueDate = today.plusDays(14);

            try {
                // Establish database connection
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
                // Insert into book_rent_table
                String insertRentQuery = "INSERT INTO book_rent_table (book_id, id, date_out, date_due, active, createdBy, createdOn) VALUES (?, ?, ?, ?, 1, ?, ?)";
                PreparedStatement psRent = con.prepareStatement(insertRentQuery);
                psRent.setInt(1, bookId);
                psRent.setInt(2, userId);
                psRent.setDate(3, Date.valueOf(today));
                psRent.setDate(4, Date.valueOf(dueDate));
                psRent.setInt(5, getUserIdFromSession(request.getSession())); // Assuming session stores user ID
                psRent.setDate(6, Date.valueOf(today));

                int rowsInsertedRent = psRent.executeUpdate();

                // Update allocated_books count in data_table
                if (rowsInsertedRent > 0) {
                    updateAllocatedBooks(userId, con); // Update allocated books count

                    // Insert into record_table
                    String insertRecordQuery = "INSERT INTO record_table (book_id, rent_id, id) VALUES (?, ?, ?)";
                    PreparedStatement psRecord = con.prepareStatement(insertRecordQuery);
                    psRecord.setInt(1, bookId);
                    psRecord.setInt(2, userId);
                    psRecord.setInt(3, getUserIdFromSession(request.getSession())); // Assuming session stores user ID

                    int rowsInsertedRecord = psRecord.executeUpdate();

                    if (rowsInsertedRecord > 0) {
                        // Book issued and record inserted successfully
                        out.println("<p>Book issued successfully!</p>");
                    } else {
                        // Issue failed to record
                        out.println("<p>Failed to record issuance!</p>");
                    }
                } else {
                    // Issue failed
                    out.println("<p>Failed to issue book!</p>");
                }

                con.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                out.println("<p>Database error: " + e.getMessage() + "</p>");
            }
        }
    }




    // Check if user can allocate more books (assuming max 2 books)
    private boolean canAllocateMoreBooks(int userId) {
        int currentAllocatedBooks = getCurrentAllocatedBooks(userId);
        return currentAllocatedBooks < 2;
    }

    // Method to retrieve current allocated books count for a user
    private int getCurrentAllocatedBooks(int userId) {
        int allocatedBooks = 0;

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem",
                "root", "")) {
            String query = "SELECT allocated_book FROM data_table WHERE id = ?";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        allocatedBooks = rs.getInt("allocated_book");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return allocatedBooks;
    }

    // Method to update allocated books count for a user
    private void updateAllocatedBooks(int userId, Connection con) {
        String query = "UPDATE data_table SET allocated_book = allocated_book + 1 WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to get user ID from session (assuming session stores user ID)
    private int getUserIdFromSession(HttpSession session) {
        return (int) session.getAttribute("user_id");
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
