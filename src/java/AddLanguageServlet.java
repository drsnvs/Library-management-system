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
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Darshan
 */
public class AddLanguageServlet extends HttpServlet {

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
            
            LmsDbConnection dbcon = new LmsDbConnection();
            // Retrieve form data
            HttpSession session = request.getSession();
            String language_name = request.getParameter("language_name");
            int createdBy = Integer.parseInt((String) session.getAttribute("user_id"));

            // Establish database connection
//            Class.forName("com.mysql.jdbc.Driver"); // Load MySQL JDBC Driver
//            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");

            // Prepare SQL statement to insert the new language
            String sql = "INSERT INTO language_table (language_name, createdOn, createdBy) VALUES (?, CURDATE(), ?)";
            PreparedStatement stmt = dbcon.PsStatment(sql);
            stmt.setString(1, language_name);
            stmt.setInt(2, createdBy);

            // Execute the query
            int rowCount = stmt.executeUpdate();

            // Check if the insertion was successful
            if (rowCount > 0) {
                response.sendRedirect("addLanguage.jsp?message=Language added successfully.");
            } else {
                response.sendRedirect("addLanguage.jsp?message=Failed to add language.");
            }

            stmt.close();
//            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addLanguage.jsp?message=Error occurred while adding language.");
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
