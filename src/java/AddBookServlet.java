/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
//import java.io.PrintWriter;
//import java.sql.Connection;
import java.sql.Date;
//import java.sql.DriverManager;
import java.sql.PreparedStatement;
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
public class AddBookServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NullPointerException {
        response.setContentType("text/html;charset=UTF-8");
        String bookTitle;
        String authorName;
        double price;
        int quantity;
        String isbn;
        String publisher;
        int editionYear;
        int language;
        int format;
        int pages;
        try {
            HttpSession session = request.getSession();
            if(!session.getId().equals(session.getAttribute("key"))){
                response.sendRedirect("index.jsp");
            }
            bookTitle = request.getParameter("title");
            authorName = request.getParameter("author");
//            price = Double.parseDouble(request.getParameter("price"));
//            quantity = Integer.parseInt(request.getParameter("quantity"));
            isbn = request.getParameter("isbn");
            publisher = request.getParameter("publisher");
//            editionYear = Integer.parseInt(request.getParameter("year"));
//            language = Integer.parseInt(request.getParameter("language_id"));
//            format = Integer.parseInt(request.getParameter("format_id"));
//            pages = Integer.parseInt(request.getParameter("pages"));
            try {
                price = Double.parseDouble(request.getParameter("price"));
                quantity = Integer.parseInt(request.getParameter("quantity"));
                editionYear = Integer.parseInt(request.getParameter("year"));
                language = Integer.parseInt(request.getParameter("language_id"));
                format = Integer.parseInt(request.getParameter("format_id"));
                pages = Integer.parseInt(request.getParameter("pages"));
            } catch (NumberFormatException e) {
                response.sendRedirect("addBook.jsp?message=Invalid input for number fields!");
                return;
            }
            LocalDate today = LocalDate.now();
            Date createdOn = Date.valueOf(today);
            
            LmsDbConnection dbcon = new LmsDbConnection();
//            Class.forName("com.mysql.jdbc.Driver");
//            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
            
            int createdBy = Integer.parseInt((String) session.getAttribute("user_id"));
            String checkQuery = "SELECT COUNT(*) FROM book_table WHERE isbn = ?";
            PreparedStatement checkPs = dbcon.PsStatment(checkQuery);
            checkPs.setString(1, isbn);
            ResultSet rs = checkPs.executeQuery();
            rs.next();
            int count = rs.getInt(1);
            rs.close();
            checkPs.close();

            if (count > 0) {
                // ISBN already exists
                response.sendRedirect("addBook.jsp?message=ISBN already exists!");
                return;
            }
            String query = "INSERT INTO book_table (book_title, author_name, pages,  price, quantity, isbn , publisher, edition_year, language, format, active, createdBy, createdOn) VALUES (?, ?, ? ,?, ?, ?, ? ,?, ?, ?, ?, ?, ?)";
//            String query = "INSERT INTO book_table (book_title, author_name, price, quantity, ISBN, publisher, edition_year, active, createdBy, createdOn) VALUES (?, ?, ?, ?, ?, ?, ?, 1, ?, ?)";
            PreparedStatement ps = dbcon.PsStatment(query);
            ps.setString(1, bookTitle);
            ps.setString(2, authorName);
            ps.setInt(3, pages);
            ps.setDouble(4, price);
            ps.setInt(5, quantity);
            ps.setString(6, isbn);
            ps.setString(7, publisher);
            ps.setInt(8, editionYear);
            ps.setInt(9,language);
            ps.setInt(10,format);
            ps.setInt(11,1);
            ps.setInt(12,createdBy);
            ps.setDate(13, createdOn);
            int result = ps.executeUpdate();
//            con.close();

            if (result > 0) {
                response.sendRedirect("addBook.jsp?message=Book added successfully!");
            } else {
                response.sendRedirect("addBook.jsp?message=Book addition failed!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addBook.jsp?message=An error occurred!");
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
