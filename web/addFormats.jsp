<%-- 
    Document   : addFormats
    Created on : 28 Sep, 2024, 8:50:11 AM
    Author     : Darshan
--%>
<%@page import="LmsDB.LmsDbConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Format</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
            overflow: auto;
            height: 100px;
        }

        table th, table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th{
            position: sticky;
            top: 0;
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

        .actions button, .actions input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }

        .actions button:hover, .actions input[type="submit"]:hover {
            background-color: #0056b3;
        }

        /* Adding styles for scrollbar */
        .language-list {
            max-height: 300px; /* Set the desired maximum height for the scrollable section */
            overflow-y: auto; /* Enable vertical scrolling */
            overflow-x: hidden; /* Disable horizontal scrolling */
        }

        .language-list::-webkit-scrollbar {
            width: 8px; /* Width of the vertical scrollbar */
        }

        .language-list::-webkit-scrollbar-track {
            background: #f1f1f1; /* Background of the scrollbar track */
        }

        .language-list::-webkit-scrollbar-thumb {
            background-color: #888; /* Scrollbar thumb color */
            border-radius: 10px; /* Rounded corners for the scrollbar thumb */
        }

        .language-list::-webkit-scrollbar-thumb:hover {
            background-color: #555; /* Scrollbar thumb hover color */
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
        <div class="title">Add Format</div>
        <div class="content">
            <form action="AddFormatServlet" onsubmit="return validation()" method="POST">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">Format Name</span>
                        <input type="text" name="format_name" id="format_name" placeholder="Enter Format name">
                    </div>
                </div>
                <div class="button">
                    <input type="submit" value="Add Format">
                </div>
            </form>

            <!-- Language List Section -->
            <div class="title">Already Added Format</div>
            <div class="language-list">
                <table>
                    <thead>
                        <tr>
                            <th>Format Name</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                LmsDbConnection dbcon = new LmsDbConnection();
                                java.sql.Statement stmt = dbcon.StStatment();
                                String query = "SELECT * FROM format_table"; 
                                java.sql.ResultSet rs = stmt.executeQuery(query);

                                while (rs.next()) {
                                    int format_id = Integer.parseInt(rs.getString("format_id"));
                                    request.setAttribute("format_id", format_id);

                        %>
                        <tr>
                            <td><%= rs.getString("format_name") %></td>
                            <td>
                                <form action="ManageFormatServlet" method="post" class="actions">
                                    <input type="hidden" name="format_id" value="<%= format_id %>">
                                    <input type="hidden" name="action" value="Edit">
                                    <button type="submit" style="background: none; border: none; cursor: pointer; padding: 0;width:50%;">
                                        <i class="fas fa-edit" style="color: #007bff;"></i>
                                    </button>
                                </form>
                            </td>
                            <td>
                                <form action="ManageFormatServlet" method="post" class="actions">
                                    <input type="hidden" name="format_id" value="<%= format_id %>">
                                    <input type="hidden" name="action" value="Delete">
                                    <button type="submit" style="background: none; border: none; cursor: pointer; padding: 0;width:50%;">
                                        <i class="fas fa-trash" style="color: #dc3545;"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                                rs.close();
                                stmt.close();
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
                    <a href="adminHome.jsp"><input type="button" value="Home"></a>
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