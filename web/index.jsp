<%-- 
    Document   : index
    Created on : 20 May, 2024, 9:36:28 AM
    Author     : DARSHAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LMS</title>
        <link rel="stylesheet" href="css/index.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <%
            try{
                HttpSession ssn = request.getSession();
                ssn.setAttribute("key", ssn.getId());
            }catch(Exception e){
                e.printStackTrace();
            }
        %>
        <div class="container">
            <div class="main-title">Library Management System</div>
            <div class="button-group">
                <a href="adminLogin.jsp" class="btn">Admin Login</a>
                <a href="userLogin.jsp" class="btn">User Login</a>
            </div>
        </div>
    </body>
</html>
