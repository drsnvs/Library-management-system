<%-- 
    Document   : userDashboard
    Created on : 24 Jun, 2024, 3:00:24 PM
    Author     : DARSHAN
--%>

<%@page import="java.sql.*"%>
<%@page import="LmsDB.LmsDbConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        header {
            background-color: #4CAF50;
            color: white;
            padding: 1em 0;
            text-align: center;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
        }
        nav {
            display: flex;
            justify-content: space-around;
            background-color: #333;
            padding: 1em 0;
        }
        nav a {
            color: white;
            text-decoration: none;
            padding: 0.5em 1em;
            transition: background-color 0.3s ease;
            display: flex;
            align-items: center;
        }
        nav a i {
            margin-right: 8px;
        }
        nav a:hover {
            background-color: #575757;
        }
        main {
            padding: 2em;
        }
        .card {
            background-color: white;
            margin: 1em;
            padding: 2em;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .card h2 {
            margin-top: 0;
        }
        .penalty {
            color: red;
            font-weight: bold;
        }
        footer {
            background-color: #333;
            color: white;
            text-align: center;
            position: fixed;
            width: 100%;
            bottom: 0;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
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

        // Initialize variables for database connection and result
        
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int pendingBooksCount = 0;
        int penaltyBooksCount = 0;
        String userId = (String) session.getAttribute("user_id"); // Assuming user ID is stored in session

        try {
            LmsDbConnection dbcon = new LmsDbConnection();

            // Query to get the count of pending books (books not yet returned)
            String pendingQuery = "SELECT COUNT(*) AS pending_count " +
                                  "FROM book_rent_table " +
                                  "WHERE id = ? AND return_date IS NULL";
            pstmt = dbcon.PsStatment(pendingQuery);
            pstmt.setInt(1, Integer.parseInt(userId));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                pendingBooksCount = rs.getInt("pending_count");
            }

            // Query to get the count of books with penalties
            String penaltyQuery = "SELECT COUNT(*) AS penalty_count " +
                                  "FROM book_fine_table bf " +
                                  "JOIN book_rent_table br ON bf.rent_id = br.rent_id " +
                                  "WHERE br.id = ? AND bf.active = 1";
            pstmt = dbcon.PsStatment(penaltyQuery);
            
            pstmt.setInt(1, Integer.parseInt(userId));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                penaltyBooksCount = rs.getInt("penalty_count");
                System.out.println(rs.getInt("penalty_count"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
    <header>
        <h1>Dashboard</h1>
    </header>
    <nav>
        <a href="userProfile.jsp">
            <i class="fas fa-user"></i> Profile
        </a>
        <a href="userViewBooks.jsp">
            <i class="fas fa-book"></i> View Books
        </a>
        <a href="userIssuedBooks.jsp">
            <i class="fas fa-book-reader"></i> Issued Books
        </a>
        <a href="logOutServlet">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </nav>
    <main>
        <div class="card">
            <h2>Welcome, <%= session.getAttribute("first_name") %>!</h2>
            <p>This is your dashboard where you can view and manage your library activities.</p>
            <% if (pendingBooksCount > 0) { %><p>You currently have <%= pendingBooksCount %> book(s) pending to return.</p><% } %>
            <% if (penaltyBooksCount > 0) { %><p>
                    You have <span class="penalty"><%= penaltyBooksCount %></span> book(s) with a penalty. Please return these as soon as possible.
                </p>
            <% } %>
        </div>
        
        
    </main>
    <footer>
        <p>&copy; 2024 Library Management System</p>
    </footer>
    <script>
        function showAlert(message) {
            alert(message);
        }
    </script>
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
