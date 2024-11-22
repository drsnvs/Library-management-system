<%-- 
    Document   : register
    Created on : 21 Jun, 2024, 6:05:03 PM
    Author     : DARSHAN
--%>

<%@page import="java.sql.*"%>
<%@page import="LmsDB.LmsDbConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link rel="stylesheet" href="css/style.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script>
            function showAlert(message) {
                alert(message);
            }
        </script>
        <style>
        /* CSS for styling the dropdown */
        select {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
            background-color: #f8f8f8;
            -webkit-appearance: none; /* Remove default styling on some browsers */
            -moz-appearance: none; /* Remove default styling on some browsers */
            appearance: none; /* Remove default styling */
        }

        /* Optional: add styles for the select element when it is focused */
        select:focus {
            border-color: #007bff;
            outline: none;
        }

        /* Optional: add styles for the select element when it is disabled */
        select:disabled {
            background-color: #e9ecef;
            cursor: not-allowed;
        }

        /* Optional: add styles for the select element when it is invalid */
        select:invalid {
            border-color: #dc3545;
        }

        /* Optional: style for the options within the dropdown */
        select option {
            padding: 10px;
            background-color: #fff;
            color: #333;
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
            <div class="title">Registration</div>
            <div class="content">
                <form action="registerUser" onsubmit="return validation()" method="POST">
                    <div class="user-details">
                        <div class="input-box">
                            <span class="details">First Name</span>
                            <input type="text" name="first_name" id="first_name" placeholder="Enter your First name" >
                        </div>
                        <div class="input-box">
                            <span class="details">Last Name</span>
                            <input type="text" name="last_name" id="last_name" placeholder="Enter your Last name" >
                        </div>
                        <div class="input-box">
                            <span class="details">Mobile Number</span>
                            <input type="number" name="mobile_no" id="mobile_no" placeholder="Enter your Mobile Number" >
                        </div>
                        <div class="input-box">
                            <span class="details">Email</span>
                            <input type="email" name="email_id" id="email_id" placeholder="Enter your email" >
                        </div>
                        <div class="input-box">
                            <span class="details">Enrollment NO</span>
                            <input type="number" name="e_no" id="e_no" placeholder="Enter your Enrollment number" >
                        </div>
                        <div class="input-box">
                            <span class="details">Address</span>
                            <input type="text" name="address" id="address" maxlength="255" placeholder="Enter your address" >
                        </div>
                        <div class="input-box">
                            <span class="details">Password</span>
                            <input type="password" name="password" id="password" placeholder="Enter your password" >
                        </div>
                        <div class="input-box">
                            <span class="details">Confirm Password</span>
                            <input type="password" name="cpassword" id="cpassword" placeholder="Confirm your password" >
                        </div>
                        <div class="input-box">
                            <span class="details">Role</span>
                            <select name="role_id" id="role_id" required>
                                <option value="">Select Role</option>
                                <%
                                    try{
                                        LmsDbConnection dbcon = new LmsDbConnection();
                                        Statement st = dbcon.StStatment();

                                        ResultSet rs = st.executeQuery("SELECT * FROM role_table");
                                        while(rs.next()){
                                %>
                                <option value="<%= rs.getInt("role_id") %>"><%= rs.getString("role_name").toUpperCase() %></option>
                                <% } %>
                            </select>
                                <%
                                    }catch(Exception e){
                                        e.printStackTrace();
                                    }
                                %>
                        </div>
                    </div>
<!--                    <div class="gender-details">
                        <input type="radio" name="gender" id="dot-1" value="Male">
                        <input type="radio" name="gender" id="dot-2" value="Female">
                        <input type="radio" name="gender" id="dot-3" value="Prefer not to say">
                        <span class="gender-title">Gender</span>
                        <div class="category">
                            <label for="dot-1">
                                <span class="dot one"></span>
                                <span class="gender">Male</span>
                            </label>
                            <label for="dot-2">
                                <span class="dot two"></span>
                                <span class="gender">Female</span>
                            </label>
                            <label for="dot-3">
                                <span class="dot three"></span>
                                <span class="gender">Prefer not to say</span>
                            </label>
                        </div>
                    </div>-->
                    <div class="button">
                        <input type="submit" value="Register">
                    </div>
                    <div class="button">
                        <a href="adminHome.jsp"><input type="button" value="Home"></a>
                    </div>
                </form>
            </div>
        </div>

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
        <script>
        function validation(){
            var first_name = document.getElementById("first_name").value;
            var last_name = document.getElementById("last_name").value;
            var mobile_no = document.getElementById("mobile_no").value;
            var email_id = document.getElementById("email_id").value;
            var address = document.getElementById("address").value;
            var password = document.getElementById("password").value;
            var cpassword = document.getElementById("cpassword").value;
            var e_no = document.getElementById("e_no").value;
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
            if(e_no === ""){
                alert("Enter Enrollment no");
                return false;
            }
            if (!/^[0-9]{10}$/.test(mobile_no)) {
                alert("Enter valid mobile number");
                return false;
            }
            if(mobile_no.length !== 10){
                alert("Mobile no is must in 10 numbers");
                return false;
            }
            if(e_no.length !== 9){
                alert("Enrollment no is must be 9 numbers");
                return false;
            }
//            if(email_id == ""){
//                alert("Enter Email id");
//                return false;
//            }
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
            if(cpassword === ""){
                alert("Enter Confirm Password");
                return false;
            }
            
            if(password.length<6){
                    alert("Password should be more than 6");
                    return false;
                }
            
            if (password !== cpassword) {
                alert("Password and Confirm Password do not match");
                return false;
            }
        }
    </script>
    </body>
    
</html>
