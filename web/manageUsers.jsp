<%-- 
    Document   : manageUsers
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
        <title>Manage Users</title>
        <link rel="stylesheet" href="css/style.css">
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
                flex: 1;
                overflow: auto;
            }

            .title {
                font-size: 28px;
                font-weight: 500;
                margin-bottom: 20px;
              }

            .content {
                overflow-x: scroll;
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

            action form {
                display: inline-block;
                margin-right: 5px; /* Adjust spacing between forms */
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
            <div class="title">Manage Users</div>
            <div class="content">
                <table>
                    <thead>
                        <tr>
                            <th>Enrollment No</th>
                            <th>First Name</th>
                            <th>Email</th>
                            <th>Allocate Books</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
                                Statement stmt = con.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT allocated_book ,id, first_name, enrollment_no, email_id, mobile_no FROM data_table");

                                while (rs.next()) {
                                    int id = rs.getInt("id");
                                    String book_allocated = rs.getString("allocated_book");
                                    String enrollment_no = rs.getString("enrollment_no");
                                    String firstName = rs.getString("first_name");
//                                    String lastName = rs.getString("last_name");
                                    String email = rs.getString("email_id");
                        %>
                        <tr>
                            <td><%= enrollment_no %></td>
                            <td><%= firstName %></td>
                            <td><%= email %></td>
                            <td><%= book_allocated %></td>
                            <td>
                                <form action="ManageUsersServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= id %>">
                                    <input type="submit" name="action" value="Edit">
                                </form>
                                <form action="ManageUsersServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= id %>">
                                    <input type="hidden" name="email_id" value="<%= email %>">
                                    <input type="hidden" name="enrollment_no" value="<%= enrollment_no %>">
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
                
            </div>
        </div>
        <div class="actions">
            <button onclick="location.href='adminHome.jsp'">Go to Home</button>
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
