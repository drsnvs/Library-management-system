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
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class loginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            
            if(!session.getId().equals(session.getAttribute("key"))){
                response.sendRedirect("index.jsp");
            }
            String adminEmail = request.getParameter("adminEmail");
            String adminPassword = request.getParameter("adminPassword");
            String userEmail = request.getParameter("userEmail");
            String userPassword = request.getParameter("userPassword");

            try {
                // Database connection
//                Class.forName("com.mysql.jdbc.Driver");
//                try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "")) {
                    // Check admin login
                    LmsDbConnection dbcon = new LmsDbConnection();
                    
                    if (adminEmail != null && adminPassword != null) {
//                        PreparedStatement checkActiveP = con.prepareStatement("SELECT * FROM data_table where email_id = ?");
//                        ResultSet checkActiveR = checkActiveP.executeQuery();
//                        if(checkActiveR.next()){
//                            if(checkActiveR.getInt("active") == 1){
//
//                            }
//                        }
                        PreparedStatement psa = dbcon.PsStatment("SELECT * FROM data_table JOIN role_table ON data_table.role_id = role_table.role_id WHERE email_id = ? AND password = ?");
                        psa.setString(1, adminEmail);
                        psa.setString(2, adminPassword);
                        ResultSet rsa = psa.executeQuery();
                        if (rsa.next()) {
                            if (rsa.getInt("role_id") == 1) { // Admin role
                                session.setAttribute("user_id", rsa.getString("id")); // Set user_id in session
                                session.setAttribute("role_id", rsa.getString("role_id")); // Set role_id in session
                                session.setAttribute("user_type", "admin"); // Set user_type in session
                                session.setAttribute("first_name", rsa.getString("first_name")); 
                                session.setAttribute("email_id", rsa.getString("email_id"));
                                if(session.isNew()){
                                    session.setAttribute("email_id", rsa.getString("email_id"));
                                }
                                session.setAttribute("last_name", rsa.getString("last_name"));
                                RequestDispatcher rd = request.getRequestDispatcher("adminHome.jsp");
                                rd.forward(request, response);
                            } else {
                                out.println("<script>alert('Incorrect credentials');</script>");
                                RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
                                rd.include(request, response);
                            }
                        } else {
                            out.println("<script>alert('Incorrect credentials');</script>");
                            RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
                            rd.include(request, response);
                        }
                    }

                    // Check user login
                    if (userEmail != null && userPassword != null) {
                        PreparedStatement psu = dbcon.PsStatment("SELECT * FROM data_table JOIN role_table ON data_table.role_id = role_table.role_id WHERE email_id = ? AND password = ?");
                        psu.setString(1, userEmail);
                        psu.setString(2, userPassword);
                        ResultSet rsu = psu.executeQuery();
                        if (rsu.next()) {
                            if (rsu.getInt("role_id") == 2 || rsu.getInt("role_id") == 1) { // User role
                                if(rsu.getInt("active") == 1){
                                    session.setAttribute("user_id", rsu.getString("id")); // Set user_id in session
                                    session.setAttribute("role_id", rsu.getString("role_id")); // Set role_id in session
                                    session.setAttribute("email_id", rsu.getString("email_id"));
                                    session.setAttribute("password", rsu.getString("password"));
                                    session.setAttribute("mobile_no", rsu.getString("mobile_no"));
                                    session.setAttribute("first_name", rsu.getString("first_name"));
                                    session.setAttribute("last_name", rsu.getString("last_name"));
                                    session.setAttribute("address", rsu.getString("address"));
                                    session.setAttribute("enrollment_no", rsu.getString("enrollment_no"));
                                    session.setAttribute("user_type", "user"); // Set user_type in session
                                    RequestDispatcher rd = request.getRequestDispatcher("userDashboard.jsp");
                                    rd.forward(request, response);
                                }else{
                                    out.println("<script>alert('You are blocked contact admin !!');</script>");
                                    RequestDispatcher rd = request.getRequestDispatcher("userLogin.jsp");
                                    rd.include(request, response);
                                }
                            } else {
                                out.println("<script>alert('Incorrect credentials');</script>");
                                RequestDispatcher rd = request.getRequestDispatcher("userLogin.jsp");
                                rd.include(request, response);
                            }
                        } else {
                            out.println("<script>alert('Incorrect credentials');</script>");
                            RequestDispatcher rd = request.getRequestDispatcher("userLogin.jsp");
                            rd.include(request, response);
                        }
                    }
//                }
            } catch (SQLException e) {
                e.printStackTrace(out);
            }
        }catch(Exception e){
            e.printStackTrace();
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
        return "Short description";
    }

}
