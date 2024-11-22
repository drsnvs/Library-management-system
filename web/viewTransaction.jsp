<%-- 
    Document   : viewTransaction
    Created on : 3 Oct, 2024, 10:04:32 PM
    Author     : Darshan
--%>

<%@page import="java.sql.*, java.util.*, java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Transaction</title>
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h1 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 20px;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table th, table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        table th {
            background-color: #f2f2f2;
            text-align: left;
        }
        .action-icons {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        .action-icons a {
            background-color: #007bff;
            color: white;
            padding: 10px;
            border-radius: 5px;
            text-decoration: none;
            text-align: center;
            font-size: 16px;
            display: inline-block;
        }
        .action-icons a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Transaction Details</h1>
    <table>
        <thead>
            <tr>
                <th>Enrollment No</th>
                <th>User Name</th>
                <th>Book Title</th>
                <th>Fine Amount</th>
                <th>Paid Status</th>
                <th>Rent Date</th>
                <th>Due Date</th>
                <th>Return Date</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    // Get fine_id from URL parameter
                    int fine_id = Integer.parseInt(request.getParameter("fine_id"));
                    
                    // Database connection
                    LmsDbConnection dbcon = new LmsDbConnection();

                    // SQL query to get the transaction details
                    String query = "SELECT dt.enrollment_no, dt.first_name, dt.last_name, bt.book_title, bf.fine_amount, bf.paid, br.date_out, br.date_due, br.return_date " +
                                   "FROM book_fine_table bf " +
                                   "JOIN book_rent_table br ON bf.rent_id = br.rent_id " +
                                   "JOIN book_table bt ON br.book_id = bt.book_id " +
                                   "JOIN data_table dt ON br.id = dt.id " +
                                   "WHERE bf.fine_id = ?";
                    PreparedStatement ps = dbcon.PsStatment(query);
                    ps.setInt(1, fine_id);
                    ResultSet rs = ps.executeQuery();
                    
                    // Date formatter
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    if (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("enrollment_no") %></td>
                <td><%= rs.getString("first_name") + " " + rs.getString("last_name") %></td>
                <td><%= rs.getString("book_title") %></td>
                <td><%= rs.getDouble("fine_amount") %></td>
                <td>
                    <%
                        int paid = rs.getInt("paid");
                        if (paid == 1) {
                            out.print("<span style='color:green;'>Paid</span>");
                        } else {
                            out.print("<span style='color:red;'>Not Paid</span>");
                        }
                    %>
                </td>
                <td><%= rs.getDate("date_out") != null ? dateFormat.format(rs.getDate("date_out")) : "Not Available" %></td>
                <td><%= rs.getDate("date_due") != null ? dateFormat.format(rs.getDate("date_due")) : "Not Available" %></td>
                <td><%= rs.getDate("return_date") != null ? dateFormat.format(rs.getDate("return_date")) : "Not Returned" %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>
    <div class="action-icons">
        <!-- Back to Penalty Log Button -->
        <a href="penaltyLog.jsp"><i class="fas fa-arrow-left"></i> Back to Penalty Log</a>
        <!-- Pay Penalty Button if not paid -->
    </div>
</div>
</body>
</html>