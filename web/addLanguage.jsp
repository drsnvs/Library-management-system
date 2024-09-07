<%-- 
    Document   : addLanguage
    Created on : 21 Jun, 2024, 7:00:00 PM
    Author     : DARSHAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Language</title>
    <link rel="stylesheet" href="css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script>
        function showAlert(message) {
            alert(message);
        }
    </script>
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
        <div class="title">Add Language</div>
        <div class="content">
            <form action="AddLanguageServlet" onsubmit="return validation()" method="POST">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">Language Name</span>
                        <input type="text" name="language_name" id="language_name" placeholder="Enter language name" >
                    </div>
                </div>
                <div class="button">
                    <input type="submit" value="Add Language">
                </div>
            </form>

            <!-- Language List Section -->
            <div class="title">Already Added Languages</div>
            <div class="language-list">
                <table>
                    <thead>
                        <tr>
                            <th>Language Name</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Class.forName("com.mysql.jdbc.Driver"); // Load MySQL JDBC Driver
                                java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", ""); // Adjust database name, user, and password
                                java.sql.Statement stmt = conn.createStatement();
                                String query = "SELECT * FROM language_table"; // Adjust table name accordingly
                                java.sql.ResultSet rs = stmt.executeQuery(query);
                                
                                while (rs.next()) {
                                int language_id = Integer.parseInt(rs.getString("language_id"));
                        %>
                        <tr>
                            <td><%= rs.getString("language_name") %></td>
                            <td>
                                <form action="ManageUsersServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= language_id %>" >
                                    <input type="submit" name="action" value="Edit">
                                </form>
                                <form action="ManageUsersServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= language_id %>">
                                    <input type="submit" name="action" value="Delete">
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                                rs.close();
                                stmt.close();
                                conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <!-- End of Language List Section -->
            <form>
                <div class="button">
                    <input type="submit" value="Home">
                </div>
            </form>
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
    <script>
        function validation(){
            var language_name = document.getElementById("language_name").value;
            
            if(language_name === ""){
                alert("Enter Language Name");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
