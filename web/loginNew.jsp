<%-- 
    Document   : loginNew
    Created on : 13 Oct, 2024, 12:19:48 PM
    Author     : Darshan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System - Login</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
        }
        .container {
            max-width: 700px;
            width: 100%;
            background-color: #fff;
            padding: 25px 30px;
            border-radius: 5px;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.15);
        }
        .container .title {
            font-size: 25px;
            font-weight: 500;
            position: relative;
        }
        .container .title::before {
            content: "";
            position: absolute;
            left: 0;
            bottom: 0;
            height: 3px;
            width: 30px;
            border-radius: 5px;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
        }
        .content form .user-details {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin: 20px 0 12px 0;
        }
        form .user-details .input-box {
            margin-bottom: 15px;
            width: calc(100% - 20px);
        }
        form .input-box span.details {
            display: block;
            font-weight: 500;
            margin-bottom: 5px;
        }
        .user-details .input-box input {
            height: 45px;
            width: 100%;
            outline: none;
            font-size: 16px;
            border-radius: 5px;
            padding-left: 15px;
            border: 1px solid #ccc;
            border-bottom-width: 2px;
            transition: all 0.3s ease;
        }
        .user-details .input-box input:focus,
        .user-details .input-box input:valid {
            border-color: #9b59b6;
        }
        form .button {
            height: 45px;
            margin: 35px 0;
        }
        form .button input {
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
        form .button input:hover {
            background: linear-gradient(-135deg, #71b7e6, #9b59b6);
        }
        @media(max-width: 584px) {
            .container {
                max-width: 100%;
            }
            form .user-details .input-box {
                margin-bottom: 15px;
                width: 100%;
            }
            .content form .user-details {
                max-height: 300px;
                overflow-y: scroll;
            }
            .user-details::-webkit-scrollbar {
                width: 5px;
            }
        }
        @media(max-width: 459px) {
            .container .content .category {
                flex-direction: column;
            }
        }
        #message {
            text-align: center;
            margin-top: 10px;
            font-weight: bold;
        }
        .toggle-link {
            text-align: center;
            margin-top: 15px;
        }
        .toggle-link a {
            color: #9b59b6;
            text-decoration: none;
        }
        .toggle-link a:hover {
            text-decoration: underline;
        }
        /* Hide the admin login form by default */
        #admin-login-form {
            display: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="title" id="form-title">User Login</div>
        <div class="content">
            <!-- User Login Form -->
            <form id="user-login-form">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">Email</span>
                        <input type="text" name="userEmail" id="email" placeholder="Enter your email" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Password</span>
                        <input type="password" name="userPassword" id="password" placeholder="Enter your password" required>
                    </div>
                </div>
                <div class="button">
                    <input type="button" value="Login" onclick="submitForm('user-login-form')">
                </div>
            </form>

            <!-- Admin Login Form -->
            <form id="admin-login-form">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">Email</span>
                        <input type="text" name="adminEmail" id="admin-email" placeholder="Enter your email" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Password</span>
                        <input type="password" name="adminPassword" id="admin-password" placeholder="Enter your password" required>
                    </div>
                </div>
                <div class="button">
                    <input type="button" value="Login" onclick="submitForm('admin-login-form')">
                </div>
            </form>
            <p id="message"></p>
            <div class="toggle-link">
                <a href="#" id="toggle-form">Switch to Admin Login</a>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const userLoginForm = document.getElementById('user-login-form');
            const adminLoginForm = document.getElementById('admin-login-form');
            const message = document.getElementById('message');
            const toggleFormLink = document.getElementById('toggle-form');
            const formTitle = document.getElementById('form-title');

            function showMessage(text, isError = false) {
                message.textContent = text;
                message.style.color = isError ? 'red' : 'green';
            }

            function toggleForms() {
                if (userLoginForm.style.display !== 'none') {
                    userLoginForm.style.display = 'none';
                    adminLoginForm.style.display = 'block';
                    formTitle.textContent = 'Admin Login';
                    toggleFormLink.textContent = 'Switch to User Login';
                } else {
                    userLoginForm.style.display = 'block';
                    adminLoginForm.style.display = 'none';
                    formTitle.textContent = 'User Login';
                    toggleFormLink.textContent = 'Switch to Admin Login';
                }
                showMessage('');
            }

            toggleFormLink.addEventListener('click', (e) => {
                e.preventDefault();
                toggleForms();
            });
        });

        function submitForm(formId) {
            const form = document.getElementById(formId);
            const formData = new FormData(form);

            fetch('loginServlet', {
                method: 'POST',
                body: formData,
            })
            .then(response => response.json()) // Expecting JSON from the server
            .then(data => {
                if (data.success) {
                    window.location.href = 'dashboard.jsp'; // Redirect to dashboard on success
                } else {
                    showMessage(data.message, true); // Display error message
                }
            })
            .catch(error => {
                showMessage('Login failed. Please try again.', true);
            });
        }
    </script>
</body>
</html>
