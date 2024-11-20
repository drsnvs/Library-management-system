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

public class ManageUsersServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            LmsDbConnection dbcon = new LmsDbConnection();
            String action = request.getParameter("action");
            int userId = Integer.parseInt(request.getParameter("id"));
            HttpSession session = request.getSession();
            if(!session.getId().equals(session.getAttribute("key"))){
                response.sendRedirect("index.jsp");
            }
//            Class.forName("com.mysql.jdbc.Driver");
//            Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
            
            if ("Delete".equals(action)) {
                String deleteQuery = "DELETE FROM data_table WHERE id=?";
                PreparedStatement ps = dbcon.PsStatment(deleteQuery);
                ps.setInt(1, userId);
                int result = ps.executeUpdate();
                if (result > 0) {
                    response.sendRedirect("manageUsers.jsp?message=User deleted successfully!");
                } else {
                    response.sendRedirect("manageUsers.jsp?message=User deletion failed!");
                }
            } else if ("Edit".equals(action)) {
                
                
                // Fetch user details and forward to edit page
                String fetchQuery = "SELECT * FROM data_table WHERE id=?";
                PreparedStatement ps = dbcon.PsStatment(fetchQuery);
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    // User found, forward to editUser.jsp with user details
                    request.setAttribute("id", rs.getInt("id"));
                    request.setAttribute("first_name", rs.getString("first_name"));
                    request.setAttribute("last_name", rs.getString("last_name"));
                    request.setAttribute("email_id", rs.getString("email_id"));
                    request.setAttribute("mobile_no", rs.getString("mobile_no"));
                    request.setAttribute("address", rs.getString("address"));
                    request.setAttribute("active", rs.getString("active"));
                    request.setAttribute("enrollment_no", rs.getString("enrollment_no"));
                    request.setAttribute("password", rs.getString("password"));
                    request.setAttribute("allocated_book", rs.getString("allocated_book"));
                    RequestDispatcher rd = request.getRequestDispatcher("editUser.jsp");
                    rd.forward(request, response);
                } else {
                    // User not found, redirect with error message
                    out.println("User not found for ID: " + userId); // Debugging output
                    response.sendRedirect("manageUsers.jsp?message=User not found!");
                }
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
        return "Servlet for managing users";
    }
}
