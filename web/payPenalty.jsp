<%-- 
    Document   : bookPenalty
    Created on : 30 Jun, 2024, 10:12:21 AM
    Author     : DARSHAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pay Penalty</title>
        <style>
<%
    String message = request.getParameter("message");
    double fineAmount = 0.0;
    int user_id = 0;
    int rent_id = 0;
    
    // Default message if null
    if (message == null) {
        message = "No message provided.";
    }
    
    // Parse parameters with error handling
    try {
        fineAmount = Double.parseDouble(request.getParameter("fine_amount"));
    } catch (NumberFormatException | NullPointerException e) {
        fineAmount = 0.0;
        message = "Fine amount is missing or invalid.";
    }
    
    try {
        user_id = Integer.parseInt(request.getParameter("user_id"));
    } catch (NumberFormatException | NullPointerException e) {
        user_id = 0;
        message = "User ID is missing or invalid.";
    }
    
    try {
        rent_id = Integer.parseInt(request.getParameter("rent_id"));
    } catch (NumberFormatException | NullPointerException e) {
        rent_id = 0;
        message = "Rent ID is missing or invalid.";
    }
%>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
            .container h1 {
                color: #333;
            }
            .container p {
                color: #666;
            }
            .container button {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }
            .container button:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <p>Fine Amount: $<%= session.getAttribute("fineAmount") %></p>
            <p>You have an overdue penalty. Please confirm to pay the penalty.</p>
            <form action="PayPenaltyServlet" method="post">
                <input type="hidden" name="user_id" value="<%= request.getParameter("user_id") %>">
                <input type="hidden" name="book_id" value="<%= request.getParameter("book_id") %>">
                <button type="submit">Pay Penalty</button>
            </form>
        </div>
    </body>
</html>
