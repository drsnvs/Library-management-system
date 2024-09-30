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
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="css/style.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
          <form action="loginServlet" method="POST">
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
        </div>
      </div>
    </body>
</html>
