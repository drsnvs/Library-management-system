/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
//import java.sql.Connection;
import java.sql.Date;
//import java.sql.DriverManager;
import java.sql.PreparedStatement;
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
public class UpdateIssuedBookServlet extends HttpServlet {

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
            
            HttpSession session = request.getSession();
        
        // Retrieve parameters from request
        String rentIdParam = request.getParameter("rent_id");
        String bookIdParam = request.getParameter("book_id");
        String userIdParam = request.getParameter("user_id");
        String issueDateParam = request.getParameter("date_out");
        String dueDateParam = request.getParameter("date_due");
        String returnDateParam = request.getParameter("return_date");
        String activeParam = request.getParameter("active");

        // Convert parameters to appropriate types
        int rentId = rentIdParam != null ? Integer.parseInt(rentIdParam) : 0; // Default value or handle accordingly
        int bookId = bookIdParam != null ? Integer.parseInt(bookIdParam) : 0; // Default value or handle accordingly
        int userId = userIdParam != null ? Integer.parseInt(userIdParam) : 0; // Default value or handle accordingly
        int active = activeParam != null ? Integer.parseInt(activeParam) : 0; // Default value or handle accordingly
        Date issueDate = issueDateParam != null ? Date.valueOf(issueDateParam) : null; // Handle null case
        Date dueDate = dueDateParam != null ? Date.valueOf(dueDateParam) : null; // Handle null case
//        Date returnDate = returnDateParam == null ? Date.valueOf(returnDateParam) : null; // Handle null case
        int modifiedBy = Integer.parseInt(session.getAttribute("user_id").toString());
        LocalDate today = LocalDate.now();
        Date modifiedOn = Date.valueOf(today);
                

        // Check session validity
        if (!session.getId().equals(session.getAttribute("key"))) {
            response.sendRedirect("index.jsp");
            return; // End processing
        }
        LmsDbConnection dbcon = new LmsDbConnection();
        // Establish database connection
//        Class.forName("com.mysql.jdbc.Driver");
//        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
        PreparedStatement ps;
        PreparedStatement pss;
        // Prepare and execute update query
        if(!returnDateParam.equals(null)){
            String updateQuery = "UPDATE book_rent_table SET book_id=?, id=?, date_out=?, date_due=?, modifiedBy=? , modifiedOn=? WHERE rent_id=?";
            
            ps = dbcon.PsStatment(updateQuery);
            ps.setInt(1, bookId);
            ps.setInt(2, userId);
            ps.setDate(3, issueDate);
            ps.setDate(4, dueDate);
//            ps.setDate(5, returnDate);
            ps.setInt(5, modifiedBy);
            ps.setDate(6, modifiedOn);
            ps.setInt(7, rentId);
            
            
        }else{
            String updateQuery = "UPDATE book_rent_table SET book_id=?, id=?, date_out=?, date_due=?, modifiedBy=? , modifiedOn=? WHERE rent_id=?";

            ps = dbcon.PsStatment(updateQuery);
            ps.setInt(1, bookId);
            ps.setInt(2, userId);
            ps.setDate(3, issueDate);
            ps.setDate(4, dueDate);
            ps.setInt(5, modifiedBy);
            ps.setDate(6, modifiedOn);
            ps.setInt(7, rentId);
        }
//        String updateQuery = "UPDATE book_rent_table SET book_id=?, id=?, date_out=?, date_due=?, return_date=?, modifiedBy=? , modifiedOn=? WHERE rent_id=?";
//
//        PreparedStatement ps = con.prepareStatement(updateQuery);
//        ps.setInt(1, bookId);
//        ps.setInt(2, userId);
//        ps.setDate(3, issueDate);
//        ps.setDate(4, dueDate);
//        ps.setDate(5, returnDate);
//        ps.setInt(6, modifiedBy);
//        ps.setDate(7, modifiedOn);
//        ps.setInt(8, rentId);


//        String update = "UPDATE record_table SET date_out=?, date_due=?, modifiedBy=? , modifiedOn=? WHERE rent_id=?";
//        pss = con.prepareStatement(update);
//        pss.setDate(1,issueDate);
//        pss.setDate(2,dueDate);
//        pss.setInt(3,modifiedBy);
//        pss.setDate(4,modifiedOn);
//        pss.setInt(5,rentId);
//        int resultQ = pss.executeUpdate();
//        if (resultQ > 0) {
//            response.sendRedirect("manageIssuedBooks.jsp?message=Issued book updated successfully!");
//        } else {
//            response.sendRedirect("manageIssuedBooks.jsp?message=Issued book update failed!");
//        }
        int result = ps.executeUpdate();
        if (result > 0) {
            response.sendRedirect("manageIssuedBooks.jsp?message=Issued book updated successfully!");
        } else {
            response.sendRedirect("manageIssuedBooks.jsp?message=Issued book update failed!");
        }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageIssuedBooks.jsp?message=An error occurred!");
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
