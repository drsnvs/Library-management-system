<%-- 
    Document   : penaltyLog
    Created on : 12 Nov, 2024
    Author     : DARSHAN
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*"%>
<%@page import="LmsDB.LmsDbConnection"%>
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

        .filter {
            margin-bottom: 20px;
        }

        .filter form {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .filter label {
            font-size: 16px;
        }

        .filter select {
            padding: 5px;
            font-size: 14px;
        }

        .filter button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }

        .filter button:hover {
            background-color: #0056b3;
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

        .actions {
            text-align: center;
            margin-top: 20px;
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

        <!-- Filter by Return Status -->
        <div class="filter">
            <form method="get" action="penaltyLog.jsp">
                <label for="returnStatus">Status:</label>
                <select id="returnStatus" name="returnStatus">
                    <option value="all" <%= request.getParameter("returnStatus") != null && request.getParameter("returnStatus").equals("all") ? "selected" : "" %>>All</option>
                    <option value="returned" <%= request.getParameter("returnStatus") != null && request.getParameter("returnStatus").equals("returned") ? "selected" : "" %>>Paid</option>
                    <option value="notReturned" <%= request.getParameter("returnStatus") != null && request.getParameter("returnStatus").equals("notReturned") ? "selected" : "" %>>Unpaid</option>
                </select>
                <button type="submit">Apply</button>
            </form>
        </div>

        <div class="content">
            <table>
                <thead>
                    <tr>
                        <th>Enrollment No</th>
                        <th>Return Date</th>
                        <th>Book Title</th>
                        <th>Penalty Amount</th>
                        <th>Paid</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            LmsDbConnection dbcon = new LmsDbConnection();
                            Statement stmt = dbcon.StStatment();
                            
                            // Get filter parameters from the request
                            String returnStatusParam = request.getParameter("returnStatus");

                            // Base query
                            String query = "SELECT book_rent_table.*, book_table.*, data_table.*, book_fine_table.fine_amount, book_fine_table.paid " +
                                           "FROM book_rent_table " +
                                           "JOIN book_table ON book_rent_table.book_id = book_table.book_id " +
                                           "JOIN data_table ON book_rent_table.id = data_table.id " +
                                           "JOIN book_fine_table ON book_rent_table.rent_id = book_fine_table.rent_id";

                            // Apply filters based on return status
                            if (returnStatusParam != null) {
                                if (returnStatusParam.equals("notReturned")) {
                                    query += " WHERE book_rent_table.return_date IS NULL";
                                } else if (returnStatusParam.equals("returned")) {
                                    query += " WHERE book_rent_table.return_date IS NOT NULL";
                                }
                            }

                            query += " ORDER BY book_rent_table.rent_id DESC";
                            ResultSet rs = stmt.executeQuery(query);
                            
                            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("enrollment_no") %></td>
                        <td>
                            <% 
                            java.sql.Date returnDate = rs.getDate("return_date");
                            if (returnDate == null) {
                                out.print("Not yet");
                            } else {
                                out.print(formatter.format(returnDate));
                            }
                            %>
                        </td>
                        <td><%= rs.getString("book_title") %></td>
                        <td><%= rs.getInt("fine_amount") %> ₹</td>
                        <td><%= rs.getInt("paid") == 1 ? "Paid" : "No" %></td>
                    </tr>
                    <%
                            }
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
    <%
        String message = request.getParameter("message");
        if (message != null) {
            out.println("<script>alert('" + message + "');</script>");
        }
    %>
</body>
</html>
