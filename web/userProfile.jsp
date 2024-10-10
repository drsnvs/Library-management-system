<%-- 
    Document   : editProfile
    Created on : 24 Jun, 2024, 3:29:51 PM
    Author     : DARSHAN
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
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
            margin-right: 8px; /* Add margin between icon and text */
        }
        nav a:hover {
            background-color: #575757;
        }
        main {
            padding: 2em;
            display: flex;
            justify-content: center;
            align-items: center;
            flex: 1;
        }
        .card {
            background-color: white;
            padding: 2em;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 700px;
        }
        .card h2 {
            margin-top: 0;
        }
        .user-details {
            display: flex;
            flex-direction: column;
            margin: 20px 0;
        }
        .input-box {
            margin-bottom: 15px;
        }
        .input-box span.details {
            display: block;
            font-weight: 500;
            margin-bottom: 5px;
        }
        .input-box input[type="checkbox"] {
            width: 20px; /* Adjust width as needed */
            height: 20px; /* Adjust height as needed */
            margin-right: 10px;
        }
        .input-box input[type="checkbox"] + label {
            font-size: 16px;
        }
        .input-box input {
            height: 45px;
            width: calc(100% - 30px); /* Adjust width to accommodate checkbox */
            outline: none;
            font-size: 16px;
            border-radius: 5px;
            padding-left: 15px;
            border: 1px solid #ccc;
            border-bottom-width: 2px;
            transition: all 0.3s ease;
        }
        .input-box input:focus,
        .input-box input:valid {
            border-color: #9b59b6;
        }
        .button {
            margin: 35px 0;
        }
        .button input {
            height: 45px;
            width: 100%;
            border-radius: 5px;
            border: none;
            color: #fff;
            font-size: 18px;
            font-weight: 500;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
        }
        .button input:hover {
            background: linear-gradient(-135deg, #71b7e6, #9b59b6);
        }
        .back-button {
            display: block;
            text-align: center;
            margin-top: 20px;
        }
        .back-button a {
            text-decoration: none;
            color: #fff;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
            padding: 10px 20px;
            border-radius: 5px;
            transition: background 0.3s ease;
        }
        .back-button a:hover {
            background: linear-gradient(-135deg, #71b7e6, #9b59b6);
        }
        footer {
            background-color: #333;
            color: white;
            text-align: center;
            /*padding: 1em 0;*/
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
        <h1>Edit Profile</h1>
    </header>
    <nav>
        <a href="userDashboard.jsp">
            <i class="fas fa-home"></i> Dashboard
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
            <h2>Update Your Profile</h2>
            <form action="editUserProfileServlet" onsubmit="return validation()" method="post">
                <input type="hidden" name="id" value="<%= session.getAttribute("user_id") %>">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">Enrollment Number</span>
                        <input type="text" name="enrollment_no" id="enrollment_no" value="<%= session.getAttribute("enrollment_no") %>" readonly>
                    </div>
                    <div class="input-box">
                        <span class="details">Email ID</span>
                        <input type="email" name="email_id" id="email_id" value="<%= session.getAttribute("email_id") %>" readonly>
                    </div>
                    <div class="input-box">
                        <span class="details">Mobile Number</span>
                        <input type="text" name="mobile_no" id="mobile_no" value="<%= session.getAttribute("mobile_no") %>" >
                    </div>
                    <div class="input-box">
                        <span class="details">First Name</span>
                        <input type="text" name="first_name" id="first_name" value="<%= session.getAttribute("first_name") %>" >
                    </div>
                    <div class="input-box">
                        <span class="details">Last Name</span>
                        <input type="text" name="last_name" id="last_name" value="<%= session.getAttribute("last_name") %>" >
                    </div>
                    <div class="input-box">
                        <span class="details">Address</span>
                        <input type="text" id="address" name="address" value="<%= session.getAttribute("address") %>" >
                    </div>
                    <div class="input-box">
                        <span class="details">Password</span>
                        <input type="password" name="password" id="password" value="<%= session.getAttribute("password") %>" >
                    </div>
                    <div class="input-box">
                        <input type="checkbox" id="show-password" onclick="myFunction()" name="show_password">
                        <label for="show-password">Show Password</label>
                    </div>
                </div>
                <div class="button">
                    <input type="submit" value="Update Profile">
                </div>
            </form>
        </div>
    </main>
    <footer>
        <p>&copy; 2024 Library Management System</p>
    </footer>
    
    <script>
        function myFunction() {
          var x = document.getElementById("password");
          if (x.type === "password") {
            x.type = "text";
          } else {
            x.type = "password";
          }
        }
        function validation(){
            // Add your validation logic here
        }
        function showAlert(message) {
            alert(message);
        }
    </script>
    <% 
        String message = request.getParameter("message");
        if (message != null) { 
        %>
        <script>showAlert('<%= message %>');</script>
    <% } %>
</body>
</html>
