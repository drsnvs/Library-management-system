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
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DARSHAN
 */
public class editUserProfileServlet extends HttpServlet {

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
            out.println("<title>Servlet editUserProfileServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            try{
                
                LmsDbConnection dbcon = new LmsDbConnection();
//                Class.forName("com.mysql.jdbc.Driver");
//                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
                
                String email_id = request.getParameter("email_id");
                String password = request.getParameter("password");
                String mobile_no = request.getParameter("mobile_no");
                String first_name = request.getParameter("first_name");
                String last_name = request.getParameter("last_name");
                String address = request.getParameter("address");
                String enrollment_no = request.getParameter("enrollment_no");
                String id = request.getParameter("id");

                // Check for existing email_id
                String checkEmailQuery = "SELECT * FROM data_table WHERE email_id = ? AND id != ?";
                PreparedStatement checkEmailStmt = dbcon.PsStatment(checkEmailQuery);
                checkEmailStmt.setString(1, email_id);
                checkEmailStmt.setString(2, id);
                ResultSet rsEmail = checkEmailStmt.executeQuery();
                
                if (rsEmail.next()) {
                    response.sendRedirect("userDashboard.jsp?message=Email already exists!");
                    return;
                }

                // Check for existing enrollment_no
                String checkEnrollmentQuery = "SELECT * FROM data_table WHERE enrollment_no = ? AND id != ?";
                PreparedStatement checkEnrollmentStmt = dbcon.PsStatment(checkEnrollmentQuery);
                checkEnrollmentStmt.setString(1, enrollment_no);
                checkEnrollmentStmt.setString(2, id);
                ResultSet rsEnrollment = checkEnrollmentStmt.executeQuery();
                
                if (rsEnrollment.next()) {
                    response.sendRedirect("userDashboard.jsp?message=Enrollment number already exists!");
                    return;
                }

                // Update user information
                String updateQuery = "UPDATE data_table SET email_id=?, password=?, enrollment_no=?, mobile_no=?, first_name=?, last_name=?, address=? WHERE id=?";
                PreparedStatement ps = dbcon.PsStatment(updateQuery);
                ps.setString(1, email_id);
                ps.setString(2, password);
                ps.setString(3, enrollment_no);
                ps.setString(4, mobile_no);
                ps.setString(5, first_name);
                ps.setString(6, last_name);
                ps.setString(7, address);
                ps.setInt(8, Integer.parseInt(id));
                
                int result = ps.executeUpdate();
                if (result > 0) {
                    response.sendRedirect("userDashboard.jsp?message=Profile updated successfully! For getting updated information login again!!");
                } else {
                    response.sendRedirect("userDashboard.jsp?message=Profile update failed!");
                }
            }catch(Exception e){
                e.printStackTrace();
            }
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
