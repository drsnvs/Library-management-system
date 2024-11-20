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

public class ManageBooksServlet extends HttpServlet {

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
                int bookId = Integer.parseInt(request.getParameter("book_id"));
                String deleteQuery = "DELETE FROM book_table WHERE book_id=?";
                PreparedStatement ps = dbcon.PsStatment(deleteQuery);
                ps.setInt(1, bookId);
                int result = ps.executeUpdate();
                if (result > 0) {
                    response.sendRedirect("manageBooks.jsp?message=Book deleted successfully!");
                } else {
                    response.sendRedirect("manageBooks.jsp?message=Book deletion failed!");
                }
            } else if ("Edit".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("book_id"));
                String fetchQuery = "SELECT * FROM book_table,language_table,format_table WHERE book_id=?";
                PreparedStatement ps = dbcon.PsStatment(fetchQuery);
                ps.setInt(1, bookId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    // Book found, forward to editBook.jsp with book details
                    request.setAttribute("book_id", rs.getInt("book_id"));
                    request.setAttribute("book_title", rs.getString("book_title"));
                    request.setAttribute("author_name", rs.getString("author_name"));
                    request.setAttribute("price", rs.getDouble("price"));
                    request.setAttribute("quantity", rs.getInt("quantity"));
                    request.setAttribute("isbn", rs.getString("isbn"));
                    request.setAttribute("active", rs.getInt("active"));
                    request.setAttribute("publisher", rs.getString("publisher"));
                    request.setAttribute("edition_year", rs.getInt("edition_year"));
                    request.setAttribute("language_id", rs.getInt("language_id"));
                    request.setAttribute("format_id", rs.getInt("format_id"));
                    request.setAttribute("language_name", rs.getString("language_name"));
                    request.setAttribute("format_name", rs.getString("format_name"));
                    request.setAttribute("pages", rs.getString("pages"));
                    request.getRequestDispatcher("editBook.jsp").forward(request, response);
                } else {
                    // Book not found, redirect with error message
                    out.println("Book not found for ID: " + bookId); // Debugging output
                    response.sendRedirect("manageBooks.jsp?message=Book not found!");
                }
            }
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
        return "Servlet for managing books";
    }
}
