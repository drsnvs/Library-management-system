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
public class ManageFormatServlet extends HttpServlet {

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
            HttpSession session =request.getSession();
            String action = request.getParameter("action");
            String formatId = request.getParameter("format_id");
            int updatedBy = Integer.parseInt((String) session.getAttribute("user_id"));
            try {
                LmsDbConnection dbcon = new LmsDbConnection();
//                Class.forName("com.mysql.jdbc.Driver");
//                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");

                if ("Edit".equals(action)) {
                    // Redirect to the edit form
                    response.sendRedirect("editFormats.jsp?format_id=" + formatId);
                } else if ("Delete".equals(action)) {
                    // Handle delete operation
                    PreparedStatement pstmt = dbcon.PsStatment("DELETE FROM format_table WHERE format_id = ?");
                    pstmt.setString(1, formatId);
                    pstmt.executeUpdate();
                    pstmt.close();
                    
                    // Redirect back with a success message
                    response.sendRedirect("addFormats.jsp?message=Format Deleted Successfully");
                } else if ("Update".equals(action)) {
                    // Handle update operation
                    String formatName = request.getParameter("format_name");
                    PreparedStatement pstmt = dbcon.PsStatment("UPDATE format_table SET format_name = ?, updatedOn=CURDATE(),updatedBy=? WHERE format_id = ?");
                    pstmt.setString(1, formatName);
                    pstmt.setInt(2, updatedBy);
                    pstmt.setString(3, formatId);
                    pstmt.executeUpdate();
                    pstmt.close();
                    
                    // Redirect back with a success message
                    response.sendRedirect("addFormats.jsp?message=Format Updated Successfully");
                }
                
//                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("addFormats.jsp?message=Error: " + e.getMessage());
            }
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
