<%-- 
    Document   : penaltyLog
    Created on : 3 Oct, 2024, 9:16:37 PM
    Author     : Darshan
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*"%>
<%@page import="javax.servlet.http.*, javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Penalty Log</title>
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .container {
            width: 80%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
            flex: 1;
            overflow: auto;
        }

        .title {
            font-size: 28px;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .content {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table th, table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        table th {
            background-color: #f2f2f2;
        }

        .paid-status {
            font-weight: bold;
        }

        .paid {
            color: green;
        }

        .not-paid {
            color: red;
        }

        .actions form {
            display: inline-block;
        }

        .actions button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }

        .actions button:hover {
            background-color: #0056b3;
        }

        .action-icons {
            font-size: 16px;
            cursor: pointer;
        }

        .action-icons a {
            color: #007bff;
            margin-right: 10px;
            text-decoration: none;
        }

        .action-icons a:hover {
            color: #0056b3;
        }

        .pay-penalty-icon {
            color: #e0a800;
        }

        .pay-penalty-icon:hover {
            color: #C72010;
        }

        .view-transaction-icon {
            color: #ffc107;
        }

        .view-transaction-icon:hover {
            color: #e0a800;
        }

    </style>
</head>
<body>
    <%
        try {
            if (!session.getId().equals(session.getAttribute("key"))) {
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <div class="container">
        <div class="title">Penalty Log</div>
        <div class="content">
            <table>
                <thead>
                    <tr>
                        <th>Enrollment No</th>
                        <th>User Name</th>
                        <th>Book Title</th>
                        <th>Fine Amount</th>
                        <th>Paid Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
                            Statement stmt = con.createStatement();
                            String query = "SELECT data_table.enrollment_no, data_table.first_name, data_table.last_name, book_table.book_title, book_fine_table.fine_amount, book_fine_table.paid, book_fine_table.fine_id " +
                                           "FROM book_fine_table " +
                                           "JOIN book_rent_table ON book_fine_table.rent_id = book_rent_table.rent_id " +
                                           "JOIN book_table ON book_rent_table.book_id = book_table.book_id " +
                                           "JOIN data_table ON book_rent_table.id = data_table.id " +
                                           "ORDER BY book_fine_table.fine_id DESC";
                            ResultSet rs = stmt.executeQuery(query);
                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("enrollment_no") %></td>
                        <td><%= rs.getString("first_name") + " " + rs.getString("last_name") %></td>
                        <td><%= rs.getString("book_title") %></td>
                        <td><%= rs.getDouble("fine_amount") %></td>
                        <td class="paid-status">
                            <%
                                int paid = rs.getInt("paid");
                                if (paid == 1) {
                                    out.print("<span class='paid'>Paid</span>");
                                } else {
                                    // Directly showing "Pay Penalty" icon instead of "Not Paid"
                            %>
                                    <a href="returnBook.jsp?fine_id=<%= rs.getInt("fine_id") %>" class="pay-penalty-icon">
                                        <i class="fas fa-credit-card"></i> 
                                    </a>
                            <%
                                }
                            %>
                        </td>

                        <td>
                            <div class="action-icons">
                                <!-- View Transaction Icon -->
                                <a href="viewTransaction.jsp?fine_id=<%= rs.getInt("fine_id") %>" class="view-transaction-icon">
                                    <i class="fas fa-info-circle"></i> View Transaction
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%
                            }
                            con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <div class="actions">
        <button onclick="location.href='adminHome.jsp'">Go to Home</button>
    </div>
</body>
</html>
