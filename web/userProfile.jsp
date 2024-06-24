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
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 10px;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
            overflow: hidden;
        }
        .container {
            max-width: 700px;
            width: 100%;
            background-color: #fff;
            padding: 25px 30px;
            border-radius: 5px;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.15);
            overflow-y: auto;
            max-height: 90vh; /* Ensure the container height for scrolling */
        }
        .title {
            font-size: 25px;
            font-weight: 500;
            position: relative;
            margin-bottom: 20px;
        }
        .title::before {
            content: "";
            position: absolute;
            left: 0;
            bottom: 0;
            height: 3px;
            width: 30px;
            border-radius: 5px;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
        }
        .user-details {
            display: flex;
            flex-direction: column;
            margin: 20px 0 12px 0;
        }
        .input-box {
            margin-bottom: 15px;
            width: 100%; /* Make the input boxes full width */
        }
        .input-box span.details {
            display: block;
            font-weight: 500;
            margin-bottom: 5px;
        }
        .input-box input {
            height: 45px;
            width: 100%; /* Make the input fields full width */
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
            height: 45px;
            margin: 35px 0;
        }
        .button input {
            height: 100%;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="title">Edit Profile</div>
        <div class="content">
            <form action="editProfileServlet" method="post">
                <input type="hidden" name="id" value="${user.id}">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">Email ID</span>
                        <input type="email" name="email_id" value="${user.email_id}" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Password</span>
                        <input type="password" name="password" value="${user.password}" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Mobile Number</span>
                        <input type="text" name="mobile_no" value="${user.mobile_no}" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Name</span>
                        <input type="text" name="name" value="${user.name}" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Address</span>
                        <input type="text" name="address" value="${user.address}" required>
                    </div>
                </div>
                <div class="button">
                    <input type="submit" value="Update Profile">
                </div>
            </form>
        </div>
    </div>
</body>
</html>
