<%-- 
    Document   : editUser
    Created on : 21 Jun, 2024, 10:53:14 AM
    Author     : DARSHAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit User</title>
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
        <div class="title">Edit User</div>
        <div class="content">
            
            <form action="UpdateUserServlet" method="POST">
                <input type="hidden" name="id" value="<%= request.getAttribute("id") %>">
                <div class="user-details">
                    
                    <div class="input-box">
                        <span class="details">First Name</span>
                        <input type="text" name="first_name" value="<%= request.getAttribute("first_name") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Last Name</span>
                        <input type="text" name="last_name" value="<%= request.getAttribute("last_name") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Email</span>
                        <input type="email" name="email_id" value="<%= request.getAttribute("email_id") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Mobile Number</span>
                        <input type="text" name="mobile_no" value="<%= request.getAttribute("mobile_no") != null ? request.getAttribute("mobile_no") : "" %>" required>
                    </div>

                    <div class="input-box">
                        <span class="details">Address</span>
                        <input type="text" name="address" value="<%= request.getAttribute("address") %>" required>
                    </div>
                </div>
                <div class="button">
                    <input type="submit" value="Save Changes">
                </div>
            </form>
            
        </div>
    </div>
</body>
</html>
