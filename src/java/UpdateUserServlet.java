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
import java.sql.ResultSet;
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
            String active = request.getParameter("active");
            String enrollment_no = request.getParameter("e_no");
            String allocated_book = request.getParameter("allocated_book");
            
            long millis = System.currentTimeMillis();
            java.sql.Date date = new java.sql.Date(millis);
            HttpSession session = request.getSession();
            if (!session.getId().equals(session.getAttribute("key"))) {
                response.sendRedirect("index.jsp");
                return;
            }
            
            LmsDbConnection dbcon = new LmsDbConnection();
//            Class.forName("com.mysql.jdbc.Driver");
//            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
            int modifiedBy = Integer.parseInt((String) session.getAttribute("user_id"));
            
            // Check for existing email_id
            String checkEmailQuery = "SELECT * FROM data_table WHERE email_id = ? AND id != ?";
            PreparedStatement checkEmailStmt = dbcon.PsStatment(checkEmailQuery);
            checkEmailStmt.setString(1, email);
            checkEmailStmt.setInt(2, id);
            ResultSet rsEmail = checkEmailStmt.executeQuery();
            
            if (rsEmail.next()) {
                response.sendRedirect("manageUsers.jsp?message=Email already exists!");
                return;
            }
            
            // Check for existing enrollment_no
            String checkEnrollmentQuery = "SELECT * FROM data_table WHERE enrollment_no = ? AND id != ?";
            PreparedStatement checkEnrollmentStmt = dbcon.PsStatment(checkEnrollmentQuery);
            checkEnrollmentStmt.setString(1, enrollment_no);
            checkEnrollmentStmt.setInt(2, id);
            ResultSet rsEnrollment = checkEnrollmentStmt.executeQuery();
            
            if (rsEnrollment.next()) {
                response.sendRedirect("manageUsers.jsp?message=Enrollment number already exists!");
                return;
            }
            
            // Update user information
            String updateQuery = "UPDATE data_table SET first_name=?, last_name=?, email_id=?, mobile_no=?, address=?, active=?, modifiedBy=?, modifiedOn=?, enrollment_no=?, allocated_book=? WHERE id=?";
            PreparedStatement ps = dbcon.PsStatment(updateQuery);
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, email);
            ps.setString(4, mobileNo);
            ps.setString(5, address);
            ps.setInt(6, Integer.parseInt(active));
            ps.setInt(7, modifiedBy);
            ps.setDate(8, date);
            ps.setString(9, enrollment_no);
            ps.setInt(10, Integer.parseInt(allocated_book));
            ps.setInt(11, id);
            
            int result = ps.executeUpdate();
            if (result > 0) {
                response.sendRedirect("manageUsers.jsp?message=User updated successfully!");
            } else {
                response.sendRedirect("manageUsers.jsp?message=User update failed!");
            }
//            con.close();
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
