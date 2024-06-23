<%-- 
    Document   : manageBooks
    Created on : 21 Jun, 2024, 10:47:27 AM
    Author     : DARSHAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*"%>
<%@page import="javax.servlet.http.*, javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Manage Books</title>
    <link rel="stylesheet" href="css/style.css">
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
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
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

        form {
            display: inline-block;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
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
        <div class="title">Manage Books</div>
        <div class="content">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT book_id, book_title, author_name, price, quantity FROM book_table");

                            while (rs.next()) {
                                int bookId = rs.getInt("book_id");
                                String bookTitle = rs.getString("book_title");
                                String authorName = rs.getString("author_name");
                                double price = rs.getDouble("price");
                                int quantity = rs.getInt("quantity");
                    %>
                    <tr>
                        <td><%= bookId %></td>
                        <td><%= bookTitle %></td>
                        <td><%= authorName %></td>
                        <td><%= price %></td>
                        <td><%= quantity %></td>
                        <td>
                            <form action="ManageBooksServlet" method="post" style="display:inline;">
                                <input type="hidden" name="book_id" value="<%= bookId %>">
                                <input type="submit" name="action" value="Edit">
                            </form>
                            <form action="ManageBooksServlet" method="post" style="display:inline;">
                                <input type="hidden" name="book_id" value="<%= bookId %>">
                                <input type="submit" name="action" value="Delete">
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
            <div class="button">
                <a href="adminHome.jsp"><input type="button" value="Home"></a>
            </div>
                
        </div>
    </div>
    <% 
    String message = request.getParameter("message");
    if (message != null) { 
    %>
        <script>
            showAlert("<%= message %>");
        </script>
    <% 
    } 
    %>
</body>
</html>
