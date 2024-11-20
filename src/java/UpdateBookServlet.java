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

public class UpdateBookServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            LmsDbConnection dbcon = new LmsDbConnection();
            HttpSession session = request.getSession();
            int bookId = Integer.parseInt(request.getParameter("id"));
            String bookTitle = request.getParameter("book_title");
            String authorName = request.getParameter("author_name");
            int pages = Integer.parseInt(request.getParameter("pages"));
            String isbn = request.getParameter("isbn");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int active = Integer.parseInt(request.getParameter("active"));
            int language = Integer.parseInt(request.getParameter("language_id"));
            int format = Integer.parseInt(request.getParameter("format_id"));
            String publisher = request.getParameter("publisher");
            int editionYear = Integer.parseInt(request.getParameter("edition_year"));
            long millis = System.currentTimeMillis();
            int modifiedBy = Integer.parseInt((String) session.getAttribute("user_id"));
            java.sql.Date date = new java.sql.Date(millis);
            if(!session.getId().equals(session.getAttribute("key"))){
                response.sendRedirect("index.jsp");
                return;
            }
//            System.out.println("Language ID received: " + language);
//            Class.forName("com.mysql.jdbc.Driver");
//            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
            
            // Check if the ISBN already exists and is different from the current book's ISBN
            String check = "SELECT isbn FROM book_table WHERE book_id=?";
            PreparedStatement pss = dbcon.PsStatment(check);
            pss.setInt(1, bookId);
            ResultSet checkRs = pss.executeQuery();
            if (checkRs.next()) {
                String currentIsbn = checkRs.getString("isbn");
                if (!isbn.equals(currentIsbn)) {
                    String checkQuery = "SELECT COUNT(*) FROM book_table WHERE isbn = ?";
                    PreparedStatement checkPs = dbcon.PsStatment(checkQuery);
                    checkPs.setString(1, isbn);
                    ResultSet rs = checkPs.executeQuery();
                    if (rs.next() && rs.getInt(1) > 0) {
                        // ISBN already exists
                        response.sendRedirect("manageBooks.jsp?message=ISBN already exists!");
                        rs.close();
                        checkPs.close();
                        return;
                    }
                    rs.close();
                    checkPs.close();
                }
            }
            checkRs.close();
            pss.close();
            
            String updateQuery = "UPDATE book_table SET book_title=?, author_name=?, pages=?, price=?, quantity=?, isbn=?, publisher=?, edition_year=?,language=?, format=?, active=?, modifiedBy=?, modifiedOn=? WHERE book_id=?";
            PreparedStatement ps = dbcon.PsStatment(updateQuery);
            ps.setString(1, bookTitle);
            ps.setString(2, authorName);
            ps.setInt(3, pages);
            ps.setDouble(4, price);
            ps.setInt(5, quantity);
            ps.setString(6, isbn);
            ps.setString(7, publisher);
            ps.setInt(8, editionYear);
            ps.setInt(9, language);
            ps.setInt(10, format);
            ps.setInt(11, active);
            ps.setInt(12, modifiedBy);
            ps.setDate(13, date);
            ps.setInt(14, bookId);
            int result = ps.executeUpdate();
            if (result > 0) {
                response.sendRedirect("manageBooks.jsp?message=Book updated successfully!");
            } else {
                response.sendRedirect("manageBooks.jsp?message=Book update failed!");
            }
            ps.close();
//            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageBooks.jsp?message=An error occurred!");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for updating book details";
    }
}
