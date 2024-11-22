<%-- 
    Document   : returnBook
    Created on : 23 Jun, 2024, 5:09:24 PM
    Author     : DARSHAN
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="LmsDB.LmsDbConnection"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Return Book</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* CSS for styling the dropdown */
        select {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
            background-color: #f8f8f8;
            -webkit-appearance: none; /* Remove default styling on some browsers */
            -moz-appearance: none; /* Remove default styling on some browsers */
            appearance: none; /* Remove default styling */
        }

        /* Optional: add styles for the select element when it is focused */
        select:focus {
            border-color: #007bff;
            outline: none;
        }

        /* Optional: add styles for the select element when it is disabled */
        select:disabled {
            background-color: #e9ecef;
            cursor: not-allowed;
        }

        /* Optional: add styles for the select element when it is invalid */
        select:invalid {
            border-color: #dc3545;
        }

        /* Optional: style for the options within the dropdown */
        select option {
            padding: 10px;
            background-color: #fff;
            color: #333;
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
        <div class="title">Return Book</div>
        <div class="content">
            <form action="ReturnBookServlet" method="post">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">User ID</span>
                        <select name="user_id" required>
                            <option value="">Select User ID</option>
                            <% 
                                Statement stmt = null;
                                ResultSet rs = null;
                                try {
                                    LmsDbConnection dbcon = new LmsDbConnection();
                                    stmt = dbcon.StStatment();
                                    String query = "SELECT id, enrollment_no FROM data_table";
                                    rs = stmt.executeQuery(query);
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getString("id") %>"><%= rs.getString("enrollment_no") %></option>
                            <% 
                                    }
                                } catch(Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    if (rs != null) rs.close();
                                    if (stmt != null) stmt.close();
                                }
                            %>
                        </select>
                    </div>
                    <div class="input-box">
                        <span class="details">Book</span>
                        <select name="book_id" required>
                            <option value="">Select Book</option>
                            <% 
                                try {
                                    LmsDbConnection dbcon = new LmsDbConnection();
                                    stmt = dbcon.StStatment();
                                    String bookQuery = "SELECT book_id, book_title FROM book_table";
                                    rs = stmt.executeQuery(bookQuery);
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getInt("book_id") %>"><%= rs.getString("book_title") %></option>
                            <% 
                                    }
                                } catch(Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    if (rs != null) rs.close();
                                    if (stmt != null) stmt.close();
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="button">
                    <input type="submit" value="Return Book">
                </div>
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
</body>
</html>
