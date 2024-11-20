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
import javax.servlet.http.HttpSession;

/**
 *
 * @author DARSHAN
 */
public class ManageIssuedBooksServlet extends HttpServlet {

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
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            if(!session.getId().equals(session.getAttribute("key"))){
                response.sendRedirect("index.jsp");
            }
//            Class.forName("com.mysql.jdbc.Driver");
//            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");

            if ("Delete".equals(action)) {
                int issueId = Integer.parseInt(request.getParameter("rent_id"));
                String deleteQuery = "DELETE FROM book_rent_table WHERE rent_id=?";
                PreparedStatement ps = dbcon.PsStatment(deleteQuery);
                ps.setInt(1, issueId);
                int result = ps.executeUpdate();
                if (result > 0) {
                    response.sendRedirect("manageIssuedBooks.jsp?message=Issued book deleted successfully!");
                } else {
                    response.sendRedirect("manageIssuedBooks.jsp?message=Issued book deletion failed!");
                }
            } else if ("Edit".equals(action)) {
                int issueId = Integer.parseInt(request.getParameter("rent_id"));
                String fetchQuery = "SELECT * FROM book_rent_table WHERE rent_id=?";
                PreparedStatement ps = dbcon.PsStatment(fetchQuery);
                ps.setInt(1, issueId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    // Issued book found, forward to editIssuedBook.jsp with book details
                    request.setAttribute("rent_id", rs.getInt("rent_id"));
                    request.setAttribute("book_id", rs.getInt("book_id"));
                    request.setAttribute("user_id", rs.getInt("id"));
                    request.setAttribute("date_out", rs.getDate("date_out"));
                    request.setAttribute("date_due", rs.getDate("date_due"));
                    request.setAttribute("return_date", rs.getDate("return_date"));
                    request.setAttribute("active", rs.getInt("active"));
                    request.setAttribute("return_date",rs.getDate("return_date"));
//                    request.setAttribute("fine", rs.getDouble("fine"));
                    request.getRequestDispatcher("editIssuedBook.jsp").forward(request, response);
                } else {
                    // Issued book not found, redirect with error message
                    response.sendRedirect("manageIssuedBooks.jsp?message=Issued book not found!");
                }
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
