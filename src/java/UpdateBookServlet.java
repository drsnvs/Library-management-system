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
            
            int bookId = Integer.parseInt(request.getParameter("id"));
            String bookTitle = request.getParameter("book_title");
            String authorName = request.getParameter("author_name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String isbn = request.getParameter("isbn");
            String publisher = request.getParameter("publisher");
            int editionYear = Integer.parseInt(request.getParameter("edition_year"));
            HttpSession session = request.getSession();
            if(!session.getId().equals(session.getAttribute("key"))){
                response.sendRedirect("index.jsp");
            }
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");

            String updateQuery = "UPDATE book_table SET book_title=?, author_name=?, price=?, quantity=?, ISBN=?, publisher=?, edition_year=? WHERE book_id=?";
            PreparedStatement ps = con.prepareStatement(updateQuery);
            ps.setString(1, bookTitle);
            ps.setString(2, authorName);
            ps.setDouble(3, price);
            ps.setInt(4, quantity);
            ps.setString(5, isbn);
            ps.setString(6, publisher);
            ps.setInt(7, editionYear);
            ps.setInt(8, bookId);

            int result = ps.executeUpdate();
            if (result > 0) {
                response.sendRedirect("manageBooks.jsp?message=Book updated successfully!");
            } else {
                response.sendRedirect("manageBooks.jsp?message=Book update failed!");
            }
            con.close();
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
