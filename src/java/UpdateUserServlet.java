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

public class UpdateUserServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            int id = Integer.parseInt(request.getParameter("id"));
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            String email = request.getParameter("email_id");
            String mobileNo = request.getParameter("mobile_no");
            String address = request.getParameter("address");
            HttpSession session = request.getSession();
            if(!session.getId().equals(session.getAttribute("key"))){
                response.sendRedirect("index.jsp");
            }
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");

            String updateQuery = "UPDATE data_table SET first_name=?, last_name=?, email_id=?, mobile_no=?, address=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(updateQuery);
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, email);
            ps.setString(4, mobileNo);
            ps.setString(5, address);
            ps.setInt(6, id);

            int result = ps.executeUpdate();
            if (result > 0) {
                response.sendRedirect("manageUsers.jsp?message=User updated successfully!");
            } else {
                response.sendRedirect("manageUsers.jsp?message=User update failed!");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageUsers.jsp?message=An error occurred!");
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
        return "Servlet for updating user details";
    }
}
