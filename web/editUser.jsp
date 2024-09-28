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
    <script>
        function handleCheckbox() {
            var checkbox = document.getElementById("activeCheckbox");
            var hiddenInput = document.getElementById("activeHidden");

            if (checkbox.checked) {
                hiddenInput.value = "1";
            } else {
                hiddenInput.value = "0";
            }
        }
        function showAlert(message) {
            alert(message);
        }
    </script>
    <style>
        .input-box input[type="checkbox"] {
            width: 20px; /* Adjust width as needed */
            height: 20px; /* Adjust height as needed */
            margin-right: 10px;
        }
        .input-box input[type="checkbox"] + label {
            font-size: 16px;
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
    
    <div class="container">
        <div class="title">Edit User</div>
        <div class="content">
            
            <form action="UpdateUserServlet" onsubmit="return validation()" method="POST">
                <input type="hidden" name="id" value="<%= request.getAttribute("id") %>">
                <div class="user-details">
                    
                    <div class="input-box">
                        <span class="details">Enrollment Number</span>
                        <input type="text" name="e_no" id="e_no" value="<%= request.getAttribute("enrollment_no") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">First Name</span>
                        <input type="text" name="first_name" id="first_name" value="<%= request.getAttribute("first_name") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Last Name</span>
                        <input type="text" name="last_name" id="last_name" value="<%= request.getAttribute("last_name") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Email</span>
                        <input type="email" name="email_id" id="email_id" value="<%= request.getAttribute("email_id") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Mobile Number</span>
                        <input type="text" name="mobile_no" id="mobile_no" value="<%= request.getAttribute("mobile_no") != null ? request.getAttribute("mobile_no") : "" %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Allocated Book</span>
                        <input type="text" name="allocated_book" id="allocated_book" value="<%= request.getAttribute("allocated_book") %>" readonly>
                    </div>
                    <div class="input-box">
                        <span class="details">Address</span>
                        <input type="text" name="address" id="address" value="<%= request.getAttribute("address") %>" required >
                    </div>
                    
                    <div class="input-box">
                        <span class="details">Password</span>
                        <input type="password" name="password" id="password" value="<%= request.getAttribute("password") %>" required>
                    </div>
                    <div class="input-box">
                        <input type="checkbox" id="show-password" onclick="myFunction()" name="show_password">
                        <label for="show-password">Show Password</label>
                    </div>
<!--                    <div class="input-box">
                        <span class="details">Active</span>
                        <input type="text" name="address" value="<%= request.getAttribute("active") %>" required>
                    </div>-->
                    <div class="input-box">
                        <span class="details">Active</span>
                        <input type="hidden" id="activeHidden" name="active" value="<%= request.getAttribute("active") %>">
                        <input type="checkbox" id="activeCheckbox" onclick="handleCheckbox()" <%= "1".equals(request.getAttribute("active")) ? "checked" : "" %>>
                    </div>


                </div>
                <div class="button">
                    <input type="submit" value="Save Changes">
                </div>
                <div class="button">
                    <a href="adminHome.jsp"><input type="button" value="Home"></a>
                </div>
            </form>
            
        </div>
    </div>
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
            var first_name = document.getElementById("first_name").value;
            var last_name = document.getElementById("last_name").value;
            var mobile_no = document.getElementById("mobile_no").value;
            var email_id = document.getElementById("email_id").value;
            var address = document.getElementById("address").value;
            var password = document.getElementById("password").value;
            var e_no = document.getElementById("e_no").value;
            var allocated_book = document.getElementById("allocated_book").value;
            if(first_name === ""){
                alert("Enter First name");
                return false;
            }
            if(last_name === ""){
                alert("Enter Last name");
                return false;
            }
            if(mobile_no === ""){
                alert("Enter Mobile no");
                return false;
            }
            if (!/^[0-9]{10}$/.test(mobile_no)) {
                alert("Enter valid mobile number");
                return false;
            }
            if(mobile_no.length != 10){
                alert("Mobile no is must in 10 numbers");
                return false;
            }
            if(email_id === ""){
                alert("Enter Email id");
                return false;
            }
            if(!(allocated_book >= 0 & allocated_book <=2)){
                alert("Allocated book must must be between 0 and 2 ");
                return false;
            }
            if(allocated_book === ""){
                alert("Enter Allocated book");
                return false;
            }
            if(e_no.length != 9){
                alert("Enrollment no is must in 9 numbers");
                return false;
            }
            if(e_no == ""){
                alert("Enter Enrollment Number");
                return false;
            }
            if (!email_id.match(/^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/)) {
                alert("Enter valid email address");
                return false;
            }else if(email_id === "" | email_id === null){
                alert("Enter email address");
                return false;
            }
            if(address === ""){
                alert("Enter Address");
                return false;
            }
            if(password === ""){
                alert("Enter Password");
                return false;
            }
            
            
            if(password.length<6){
                alert("Password should be more than 6");
                return false;
            }
            
            
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
