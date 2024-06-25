<%-- 
    Document   : issueBook
    Created on : 23 Jun, 2024, 11:15:01 AM
    Author     : DARSHAN
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Issue Book</title>
    <link rel="stylesheet" href="css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script>
        function showAlert(message) {
            alert(message);
        }
    </script>
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
</head>
<body>
    <div class="container">
        <div class="title">Issue Book</div>
        <div class="content">
            <form action="IssueBookServlet" method="POST">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">Enrollment Number</span>
                        <select name="user_id" id="user_id" required>
                            <option value="">Select Enrollment Number</option>
                            <%
                                Connection con = null;
                                Statement stmt = null;
                                ResultSet rs = null;
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
                                    stmt = con.createStatement();
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
                                    if (con != null) con.close();
                                }
                            %>
                        </select>
                    </div>
                    <div class="input-box">
                        <span class="details">Book ID</span>
                        <select name="book_id" id="book_id" required>
                            <option value="">Select Book ID</option>
                            <%
                                try {
                                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
                                    stmt = con.createStatement();
                                    String bookQuery = "SELECT book_id, isbn FROM book_table";
                                    rs = stmt.executeQuery(bookQuery);
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getString("book_id") %>"><%= rs.getString("isbn") %></option>
                            <%
                                    }
                                } catch(Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    if (rs != null) rs.close();
                                    if (stmt != null) stmt.close();
                                    if (con != null) con.close();
                                }
                            %>
                        </select>
                    </div>
                    <div class="input-box">
                        <span class="details">Issue Date</span>
                        <input type="date" name="issue_date">
                    </div>
                </div>
                <div class="button">
                    <input type="submit" value="Issue Book">
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
