<%-- 
    Document   : userDashboard
    Created on : 24 Jun, 2024, 3:00:24 PM
    Author     : DARSHAN
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap">
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
        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 1em 0;
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
    %>
    <header>
        <h1>Dashboard</h1>
    </header>
    <nav>
        <a href="userProfile.jsp">Profile</a>
        <a href="userViewBooks.jsp">View Books</a>
        <a href="userIssuedBooks.jsp">Issued Books</a>
        <a href="logOutServlet">Logout</a>
    </nav>
    <main>
        <div class="card">
            <h2>Welcome, <%= session.getAttribute("first_name") %>..</h2>
            <p>This is your dashboard where you can view and manage your library activities.</p>
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
