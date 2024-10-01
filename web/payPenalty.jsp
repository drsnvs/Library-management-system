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
            <% 
                String paymentStatus = request.getParameter("paymentStatus");
                String message = request.getParameter("message");
                
                if (paymentStatus != null) {
                    if (paymentStatus.equals("success")) { 
            %>
                        <h3>Payment Status: Payment Successful!</h3>
            <% 
                    } else { 
            %>
                        <h3>Payment Status: Payment not accepted!</h3>
            <% 
                    }
                }
            %>
            <p>Fine Amount: ₹<%= session.getAttribute("fineAmount") %></p>
            <p>You have an overdue penalty. Please confirm to pay the penalty.</p>
            <form action="PayPenaltyServlet" method="post">
                <input type="hidden" name="user_id" value="<%= request.getParameter("user_id") %>">
                <input type="hidden" name="rent_id" value="<%= request.getAttribute("rent_id").toString() %>"> <!-- Added rent_id -->
                <input type="hidden" name="fineAmount" value="<%= session.getAttribute("fineAmount") %>">
                <input type="hidden" name="book_id" value="<%= request.getParameter("book_id") %>">
                <button type="submit">Accept Payment</button>
            </form>
            <% if (message != null) { %>
                <p style="color: red;"><%= message %></p>
            <% } %>
        </div>
    </body>
</html>
