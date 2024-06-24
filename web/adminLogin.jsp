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
        <title>Admin Login Page</title>
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
        <div class="title">Admin Login</div>
        <div class="content">
          <form action="loginServlet" method="POST">
            <div class="user-details">
              
              <div class="input-box">
                <span class="details">Email</span>
                <input type="text" name="adminEmail" id="email" placeholder="Enter your email" required>
              </div>
              
              <div class="input-box">
                <span class="details">Password</span>
                <input type="password" name="adminPassword" id="password" placeholder="Enter your password" required>
              </div>
            <div class="input-box">
                <a href="userLogin.jsp"><span class="details">Click Here for User Login?</span></a>
            </div>
<!--              <div class="input-box">
                <span class="details">Confirm Password</span>
                <input type="text" name="cpassword" id="cpassword" placeholder="Confirm your password" required>
              </div>-->
            </div>
            
            <div class="button">
              <input type="submit" value="Login">
            </div>
          </form>
        </div>
      </div>
    </body>
</html>
