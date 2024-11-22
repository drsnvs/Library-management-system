<%-- 
    Document   : adminHome
    Created on : 21 Jun, 2024, 6:05:03 PM
    Author     : DARSHAN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        /* Hide the scrollbar in WebKit browsers (Chrome, Safari) */
        body::-webkit-scrollbar {
            display: none;
        }
        /* Hide the scrollbar in Firefox */
        body {
            scrollbar-width: none; /* Firefox */
            background-color: #f0f2f5;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            overflow-x: hidden;
            overflow-y: scroll; /* Ensure vertical scrolling is enabled */
        }
        .navbar {
            position: fixed; /* Add this line */
            top: 0; /* Add this line */
            width: 100%;
            background-color: #34495e;
            padding: 20px 0;
            color: white;
            text-align: center;
            font-size: 24px;
            font-weight: 600;
            z-index: 1; /* Add this line to ensure the navbar is on top of other elements */
        }
        .navbar .logout {
            position: absolute;
            right: 20px;
            top: 20px;
            font-size: 18px;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
        }
        .navbar .logout i {
            margin-right: 5px;
        }
        .container {
            display: flex;
            justify-content: space-evenly;
            align-items: center;
            flex-wrap: wrap;
            padding: 100px 0 50px 0; /* Increase the top padding to 100px */
            width: 100%;
            max-width: 1200px;
            flex-grow: 1;
        }
        .card {
            background-color: #fff;
            width: 250px;
            height: 250px;
            margin: 20px;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-10px);
        }
        .card-icon {
            font-size: 50px;
            color: #9b59b6;
            margin-bottom: 20px;
        }
        .card a {
            text-decoration: none;
            color: #34495e;
            font-size: 18px;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        .card a:hover {
            color: #9b59b6;
        }
        .card a {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100%;
            width: 100%;
            text-decoration: none; /* Ensure no underline */
        }
        /* Footer Styles */
        .footer {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: #34495e;
            color: white;
            text-align: center;
            padding: 10px 0;
            font-size: 14px;
        }
    </style>
    <!-- Icons CDN for better visual experience (optional) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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

    <div class="navbar">
        Welcome to Admin Dashboard (<%= session.getAttribute("first_name") %>)
        <a href="logOutServlet" class="logout">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>

    <div class="container">
        <div class="card">
            <a href="register.jsp">
                <i class="fas fa-user-plus card-icon"></i>
                <span>Register User</span>
            </a>
        </div>
        <div class="card">
            <a href="manageUsers.jsp">
                <i class="fas fa-users card-icon"></i>
                <span>Manage Users</span>
            </a>
        </div>
        <div class="card">
            <a href="addBook.jsp">
                <i class="fas fa-book card-icon"></i>
                <span>Add Book</span>
            </a>
        </div>
        <div class="card">
            <a href="manageBooks.jsp">
                <i class="fas fa-book-open card-icon"></i>
                <span>Manage Books</span>
            </a>
        </div>
        <div class="card">
            <a href="bookAttributes.jsp">
                <i class="fas fa-cogs card-icon"></i>
                <span>Book Attributes</span>
            </a>
        </div>
        <div class="card">
            <a href="issueBook.jsp">
                <i class="fas fa-hand-holding card-icon"></i>
                <span>Issue Books</span>
            </a>
        </div>
        <div class="card">
            <a href="returnBook.jsp">
                <i class="fas fa-undo card-icon"></i>
                <span>Return Book</span>
            </a>
        </div>
        <div class="card">
            <a href="manageIssuedBooks.jsp">
                <i class="fas fa-book-reader card-icon"></i>
                <span>Transaction of Books</span>
            </a>
        </div>
        <div class="card">
            <a href="penaltyLog.jsp">
                <i class="fas fa-money-bill card-icon"></i>
                <span>Penalty Logs</span>
            </a>
        </div>
    </div>

    <div class="footer">
        © 2024 Library Management System
    </div>
</body>
</html>
