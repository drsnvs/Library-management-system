/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//import java.io.PrintWriter;
import java.io.IOException;
//import java.sql.Connection;
//import java.sql.Date;
//import java.sql.DriverManager;
import java.sql.PreparedStatement;
//import java.time.LocalDate;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DARSHAN
 */
public class PayPenaltyServlet extends HttpServlet {

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
    boolean paymentSuccess = false;

    try {
        // Database connection
        
        LmsDbConnection dbcon = new LmsDbConnection();
//        Class.forName("com.mysql.jdbc.Driver");
//        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "")) {
            // Initialize variables
            int user_id = 0;
            int rent_id = 0;
            double fineAmount = 0.0;

            // Get parameters and check for null or invalid values
            String userIdParam = request.getParameter("user_id");
            String rentIdParam = request.getParameter("rent_id");
            String fineAmountParam = request.getParameter("fineAmount");

            // Validate user_id
            if (userIdParam != null && !userIdParam.equals("null") && !userIdParam.isEmpty()) {
                user_id = Integer.parseInt(userIdParam);
            } else {
                message = "User ID is missing or invalid.";
            }

            // Validate rent_id
            if (rentIdParam != null && !rentIdParam.equals("null") && !rentIdParam.isEmpty()) {
                rent_id = Integer.parseInt(rentIdParam);
            } else {
                message = "Rent ID is missing or invalid.";
            }

            // Validate fine_amount
            if (fineAmountParam != null && !fineAmountParam.equals("null") && !fineAmountParam.isEmpty()) {
                fineAmount = Double.parseDouble(fineAmountParam);
            } else {
                message = "Fine amount is missing or invalid.";
            }

            // Proceed only if no messages indicate errors
            if (message.isEmpty()) {
                String updateFineQuery = "UPDATE book_fine_table SET paid = 1, active=0, modifiedBy = ?, modifiedOn = CURDATE() WHERE rent_id = ? AND id = ? AND paid = 0";
                try (PreparedStatement updateFinePs = dbcon.PsStatment(updateFineQuery)) {
                    updateFinePs.setInt(1, user_id); // Assuming modifiedBy is the user paying
                    updateFinePs.setInt(2, rent_id);
                    updateFinePs.setInt(3, user_id); // Assuming id corresponds to the user_id

                    int result = updateFinePs.executeUpdate();

                    if (result > 0) {
                        paymentSuccess = true; // Payment was successful
                    } else {
                        message = "Failed to pay penalty or penalty already paid!";
                    }
                }
            }
//        }
    } catch (Exception e) {
        e.printStackTrace();
        message = "An error occurred while processing the payment!";
    } finally {
        // Redirect based on payment success
        RequestDispatcher dispatcher;
            if (paymentSuccess) {
                request.setAttribute("paymentStatus", "success");
                request.setAttribute("message", "Penalty paid successfully!");
                dispatcher = request.getRequestDispatcher("bookPenalty.jsp");
            } else {
                request.setAttribute("paymentStatus", "failed");
                request.setAttribute("message", message);
                dispatcher = request.getRequestDispatcher("bookPenalty.jsp");
            }
            dispatcher.forward(request, response);
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
