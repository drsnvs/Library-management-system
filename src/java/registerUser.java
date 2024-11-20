import com.mysql.jdbc.Connection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

public class registerUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                HttpSession session = request.getSession();
                LmsDbConnection dbcon = new LmsDbConnection();
//                Class.forName("com.mysql.jdbc.Driver");
//                Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
                if(!session.getId().equals(session.getAttribute("key"))){
                    response.sendRedirect("index.jsp");
                }
                String firstName = request.getParameter("first_name");
                String lastName = request.getParameter("last_name");
                String email = request.getParameter("email_id");
                String mobileNo = request.getParameter("mobile_no");
                String password = request.getParameter("password");
                String confirmPassword = request.getParameter("cpassword");
                String address = request.getParameter("address");
                String e_no = request.getParameter("e_no");
                int role_id = Integer.parseInt(request.getParameter("role_id"));

                if (!password.equals(confirmPassword)) {
                    response.sendRedirect("register.jsp?message=Passwords do not match!");
                    return;
                }

                // Check if user already exists
                String checkUserQuery = "SELECT * FROM data_table WHERE email_id = ? or enrollment_no = ?";
                PreparedStatement checkUserStmt = dbcon.PsStatment(checkUserQuery);
                checkUserStmt.setString(1, email);
                checkUserStmt.setString(2, e_no);
                ResultSet rs = checkUserStmt.executeQuery();
                
                int createdBy = Integer.parseInt((String) session.getAttribute("user_id"));
                
                if (rs.next()) {
                    response.sendRedirect("register.jsp?message=User already exists!");
                    return;
                }

                try {
                    long millis = System.currentTimeMillis();
                    java.sql.Date date = new java.sql.Date(millis);

                    String query = "INSERT INTO data_table (role_id, email_id, enrollment_no, password, mobile_no, first_name, last_name, address, allocated_book, active, createdBy, createdOn) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement ps = dbcon.PsStatment(query);
                    ps.setInt(1, role_id); // Replace with actual role_id if applicable
                    ps.setString(2, email);
                    ps.setString(3, e_no);
                    ps.setString(4, password);
                    ps.setString(5, mobileNo);
                    ps.setString(6, firstName);
                    ps.setString(7, lastName);
                    ps.setString(8, address);
                    ps.setInt(9, 0);
                    ps.setInt(10, 1);
                    ps.setInt(11, createdBy);
                    ps.setDate(12, date);

                    int result = ps.executeUpdate();
                    if (result > 0) {
                        String to = email; // change accordingly
                        String from = "sarvaiyadarshan50@gmail.com"; // change accordingly
                        String host = "smtp.gmail.com";

                        // Get the session object
                        Properties properties = System.getProperties();
                        properties.put("mail.smtp.host", host);
                        properties.put("mail.smtp.port", "587");
                        properties.put("mail.smtp.auth", "true");
                        properties.put("mail.smtp.starttls.enable", "true");

                        Session ssn = Session.getInstance(properties, new javax.mail.Authenticator() {
                            protected PasswordAuthentication getPasswordAuthentication() {
                                return new PasswordAuthentication(dbcon.getEmailId(),dbcon.getEmailProtect()); // change accordingly
                            }
                        });

                        // compose the message
                        try {
                            MimeMessage message = new MimeMessage(ssn);
                            message.setFrom(new InternetAddress(from));
                            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                            message.setSubject("LMS Registration");
                            message.setText("Hello, "+firstName+" "+lastName+". \nYou are successfully Rgistered in LMS\n\nRegistered Email id : "+email+"\nPassword : "+password+"\n\nThank you...\nHave a nice day !!!");
                            

                            // Send message
                            Transport.send(message);
                            System.out.println("User registered successfully!....");

                        } catch (MessagingException mex) {
                            mex.printStackTrace();
                        }
                        response.sendRedirect("register.jsp?message=User registered successfully!");
                    } else {
                        response.sendRedirect("register.jsp?message=User registration failed!");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("register.jsp?message=Database error!");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("register.jsp?message=An error occurred!");
            }
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
