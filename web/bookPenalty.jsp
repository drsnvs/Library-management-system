<%-- 
    Document   : bookPenalty
    Created on : 2 Oct, 2024, 12:23:02 AM
    Author     : Darshan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Payment Status</title>
    
    <!-- Meta tag to redirect after 7 seconds -->
    <meta http-equiv="refresh" content="7;url=returnBook.jsp">

    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }
        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            width: 100%;
        }
        .container h1 {
            margin: 0;
            font-size: 24px;
            color: #333;
            padding-bottom: 15px;
        }
        .container p {
            font-size: 16px;
            color: #666;
            margin: 10px 0;
        }
        .success {
            color: #28a745; /* Green color for success */
        }
        .failed {
            color: #dc3545; /* Red color for failed */
        }
        .icon {
            font-size: 60px;
            margin-bottom: 20px;
        }
        /* Button style */
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <% 
            // Get the payment status and message from the request attributes
            String paymentStatus = (String) request.getAttribute("paymentStatus");
            String message = (String) request.getAttribute("message");
        %>
        
        <% if ("success".equals(paymentStatus)) { %>
            <div class="icon">&#10003;</div> <!-- Check mark icon -->
            <h1 class="success">Payment Successful!</h1>
            <p><%= message != null ? message : "Your penalty has been paid successfully." %></p>
        <% } else { %>
            <div class="icon">&#10008;</div> <!-- Cross mark icon -->
            <h1 class="failed">Payment Failed!</h1>
            <p><%= message != null ? message : "There was an error processing your payment." %></p>
        <% } %>
        
        <p>You will be redirected to the admin home page in 7 seconds...</p>
        <!--<a href="adminHome.jsp" class="btn">Go to Admin Home</a>-->
    </div>
</body>
</html>
