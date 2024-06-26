<%-- 
    Document   : login
    Created on : 15 Jun, 2024, 9:44:08 AM
    Author     : DARSHAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Login</title>
        <link rel="stylesheet" href="css/style.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        <div class="title">User Login</div>
        <div class="content">
          <form action="loginServlet" id="loginForm" method="POST">
            <div class="user-details">
              
              <div class="input-box">
                <span class="details">Email</span>
                <input type="text" name="userEmail" id="email" placeholder="Enter your email" required>
              </div>
              
              <div class="input-box">
                <span class="details">Password</span>
                <input type="password" name="userPassword" id="password" placeholder="Enter your password" required>
              </div>
<!--              <div class="input-box">
                <span class="details">Confirm Password</span>
                <input type="text" name="cpassword" id="cpassword" placeholder="Confirm your password" required>
              </div>-->
                <div class="input-box">
                    <a href="adminLogin.jsp"><span class="details">Click Here for Admin Login?</span></a>
                </div>
            </div>
            
            <div class="button">
              <input type="submit" value="Login">
            </div>
          </form>
          <div id="message"></div>
        </div>
      </div>
        <script>
            $(document).ready(function() {
                $('#loginForm').on('submit', function(event) {
                    event.preventDefault(); // Prevent the form from submitting via the browser

                    $.ajax({
                        type: 'POST',
                        url: 'loginServlet', // URL to the servlet
                        data: $(this).serialize(), // Serialize form data
                        success: function(response) {
                            // Handle successful response
                            $('#message').html('<p>' + response.message + '</p>');

                            if (response.status === 'success') {
                                window.location.href = 'userDashboard.jsp'; // Redirect on successful login
                            }
                        },
                        error: function() {
                            // Handle error response
                            $('#message').html('<p>An error occurred. Please try again.</p>');
                        }
                    });
                });
            });
        </script>
    </body>
</html>
