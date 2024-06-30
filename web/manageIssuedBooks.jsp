<%-- 
    Document   : manageIssuedBooks
    Created on : 23 Jun, 2024, 3:04:44 PM
    Author     : DARSHAN
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*"%>
<%@page import="javax.servlet.http.*, javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Manage Issued Books</title>
    <link rel="stylesheet" href="css/index.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensure the page takes up at least the viewport height */
        }

        .container {
            width: 80%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
            flex: 1; /* Grow to take remaining vertical space */
            overflow: auto; /* Add scrollbar when content exceeds height */
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

        .actions {
            display: flex;
            justify-content: space-between;
        }

        .actions form {
            display: inline-block;
            margin-right: 5px; /* Adjust spacing between forms */
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
    <script>
        function showAlert(message) {
            alert(message);
        }
    </script>
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
        <div class="title">Manage Issued Books</div>
        <div class="content">
            <table>
                <thead>
                    <tr>
                        <th>Enrollment No</th>
                        <th>Issue Date</th>
                        <th>Return Date</th>
                        <th>Book Title</th>
                        <!--<th>User ID</th>-->
                        <!--<th>Due Date</th>-->
                        <!--<th>Fine</th>-->
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
                            Statement stmt = con.createStatement();
                            String query = "SELECT book_rent_table.*,book_table.*, data_table.* FROM book_rent_table JOIN book_table ON book_rent_table.book_id = book_table.book_id JOIN data_table ON book_rent_table.id = data_table.id";
                            ResultSet rs = stmt.executeQuery(query);
                            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("enrollment_no") %></td>
                        <td><%= formatter.format(rs.getDate("date_out")) %></td>
                        <td>
                            <% 
                            java.sql.Date returnDate = (java.sql.Date) rs.getDate("return_date");
                            if(returnDate == (null)){
                                out.print("Not yet");
                            }else{
                                out.print(formatter.format(returnDate));
                            }
                            %>
                        </td>
                        <td><%= rs.getString("book_title") %></td>
                        <!--<td><%= rs.getInt("id") %></td>-->
                        
                        
                        <td class="actions">
                            <form action="ManageIssuedBooksServlet" method="post">
                                <input type="hidden" name="action" value="Edit">
                                <input type="hidden" name="rent_id" value="<%= rs.getInt("rent_id") %>">
                                <button type="submit">Edit</button>
                            </form>
                            <form action="ManageIssuedBooksServlet" method="post">
                                <input type="hidden" name="action" value="Delete">
                                <input type="hidden" name="rent_id" value="<%= rs.getInt("rent_id") %>">
                                <button type="submit">Delete</button>
                            </form>
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
    <%
        String message = request.getParameter("message");
        if (message != null) {
            out.println("<script>showAlert('" + message + "');</script>");
        }
    %>
</body>
</html>
