<%-- 
    Document   : manageUsers
    Created on : 21 Jun, 2024, 10:47:27 AM
    Author     : DARSHAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*"%>
<%@page import="javax.servlet.http.*, javax.servlet.*"%>
<%@page import="LmsDB.LmsDbConnection"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Users</title>
        <link rel="stylesheet" href="css/style.css">
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
                padding: 5px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            table th {
                background-color: #f2f2f2;
            }

            #cnt, table th{
                text-align: center;
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

            .search-box {
                margin-bottom: 20px;
                display: flex; /* Use flexbox for alignment */
                justify-content: flex-start; /* Align to the left */
            }

            .search-box input {
                padding: 10px;
                font-size: 16px;
                width: 50%;
                margin-right: 10px;
                border: 1px solid #ddd; /* Add border for definition */
                border-radius: 4px; /* Rounded corners */
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
            }

            .search-box input:focus {
                outline: none; /* Remove default focus outline */
                border-color: #007bff; /* Change border color on focus */
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* Highlight shadow on focus */
            }
        </style>
        <script>
            // Function to search users by enrollment number or first name
            function searchUser() {
                var enrollmentInput = document.getElementById("searchEnrollment").value.toLowerCase();
                var nameInput = document.getElementById("searchName").value.toLowerCase();
                var userRows = document.querySelectorAll(".user-row");

                userRows.forEach(function (row) {
                    var enrollmentNo = row.querySelector(".enrollment-no").innerText.toLowerCase();
                    var firstName = row.querySelector(".first-name").innerText.toLowerCase();

                    // If either enrollment number or name matches, display the row
                    if ((enrollmentNo.includes(enrollmentInput) || enrollmentInput === "") && 
                        (firstName.includes(nameInput) || nameInput === "")) {
                        row.style.display = "";
                    } else {
                        row.style.display = "none";
                    }
                });
            }

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
            <div class="search-box">
                <input type="text" id="searchEnrollment" placeholder="Search by Enrollment No" onkeyup="searchUser()">
                <input type="text" id="searchName" placeholder="Search by Name" onkeyup="searchUser()">
            </div>
            <div class="content">
                <table>
                    <thead>
                        <tr>
                            <th>Enrollment</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Books</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                LmsDbConnection dbcon = new LmsDbConnection();
                                Statement stmt = dbcon.StStatment();
                                ResultSet rs = stmt.executeQuery("SELECT allocated_book ,id, first_name, enrollment_no, email_id, mobile_no FROM data_table");

                                while (rs.next()) {
                                    int id = rs.getInt("id");
                                    String book_allocated = rs.getString("allocated_book");
                                    String enrollment_no = rs.getString("enrollment_no");
                                    String firstName = rs.getString("first_name");
                                    String email = rs.getString("email_id");
                                    String displayFirstName = firstName.length() > 8 ? firstName.substring(0, 8) + "..." : firstName;
                                    String displayEmail = email.length() > 25 ? email.substring(0, 25) + ".." : email;
                        %>
                        <tr class="user-row">
                            <td class="enrollment-no" id="cnt"><%= enrollment_no %></td>
                            <td class="first-name"><%= displayFirstName %></td>
                            <td><%= displayEmail %></td>
                            <td id="cnt"><%= book_allocated %></td>
                            <td>
                                <form action="ManageUsersServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= id %>">
                                    <input type="hidden" name="action" value="Edit">
                                    <button type="submit" style="background: none; border: none; cursor: pointer; padding: 0;width:50%;">
                                        <i class="fas fa-edit" style="color: #007bff;"></i>
                                    </button>
                                </form>
                                <form action="ManageUsersServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= id %>">
                                    <input type="hidden" name="email_id" value="<%= email %>">
                                    <input type="hidden" name="enrollment_no" value="<%= enrollment_no %>">
                                    <input type="hidden" name="action" value="Delete">
                                    <button type="submit" style="background: none; border: none; cursor: pointer; padding: 0;">
                                        <i class="fas fa-trash" style="color: #dc3545;"></i>
                                    </button>
                                </form>
                            </td>
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
        %>
            <script>
                showAlert("<%= message %>");
            </script>
        <% 
        } 
        %>
    </body>
</html>
