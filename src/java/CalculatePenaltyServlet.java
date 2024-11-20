/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
//import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DARSHAN
 */
public class CalculatePenaltyServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String enrollment_no = request.getParameter("enrollment_no");
        double finePerDay = 5.0; // Example fine amount per day

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try (PrintWriter out = response.getWriter()) {
            
            LmsDbConnection dbcon = new LmsDbConnection();
//            Class.forName("com.mysql.jdbc.Driver");
//            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
            HttpSession session = request.getSession();
            String query = "SELECT rent_id, date_due, return_date, book_rent_table.id FROM book_rent_table JOIN data_table ON book_rent_table.id = data_table.id WHERE data_table.enrollment_no = ? AND book_rent_table.active = 1";
            ps = dbcon.PsStatment(query);
            ps.setString(1, enrollment_no);
            rs = ps.executeQuery();

            if (rs.next()) {
                int rent_id = rs.getInt("rent_id");
                LocalDate dateDue = rs.getDate("date_due").toLocalDate();
                LocalDate returnDate = rs.getDate("return_date") != null ? rs.getDate("return_date").toLocalDate() : LocalDate.now();

                long daysLate = ChronoUnit.DAYS.between(dateDue, returnDate);
                double fineAmount = daysLate > 0 ? daysLate * finePerDay : 0.0;

                if (fineAmount > 0) {
                    query = "INSERT INTO book_fine_table (rent_id, id, fine_amount, paid, active, createdBy, createdOn) " +
                            "VALUES (?, ?, ?, 0, 1, ?, ?)";
                    ps = dbcon.PsStatment(query);
                    ps.setInt(1, rent_id);
                    ps.setInt(2, rs.getInt("id")); // Specify the table alias to avoid ambiguity
                    ps.setDouble(3, fineAmount);
                    ps.setInt(4, Integer.parseInt(session.getAttribute("user_id").toString())); // Assuming the createdBy ID is 1
                    ps.setDate(5, java.sql.Date.valueOf(LocalDate.now()));
                    ps.executeUpdate();
                }

                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Servlet CalculatePenaltyServlet</title>");            
                out.println("</head>");
                out.println("<body>");
                out.println("<h1>Penalty Amount: $" + fineAmount + "</h1>");
                out.println("<a href='index.jsp'><button>Back to Home</button></a>");
                out.println("</body>");
                out.println("</html>");
            } else {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Servlet CalculatePenaltyServlet</title>");            
                out.println("</head>");
                out.println("<body>");
                out.println("<h1>No active rentals found for the given enrollment number</h1>");
                out.println("<a href='index.jsp'><button>Back to Home</button></a>");
                out.println("</body>");
                out.println("</html>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
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
