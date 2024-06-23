<%-- 
    Document   : issueBook
    Created on : 23 Jun, 2024, 11:15:01 AM
    Author     : DARSHAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Issue Book</title>
    <link rel="stylesheet" href="css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <div class="container">
        <div class="title">Issue Book</div>
        <div class="content">
            <form action="IssueBookServlet" method="POST">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">User ID</span>
                        <input type="text" name="user_id" placeholder="Enter User ID" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Book ID</span>
                        <input type="text" name="book_id" placeholder="Enter Book ID" required>
                    </div>
<!--                    <div class="input-box">
                        <span class="details">Date Due</span>
                        <input type="date" name="date_due" required>
                    </div>-->
                </div>
                <div class="button">
                    <input type="submit" value="Issue Book">
                </div>
            </form>
        </div>
    </div>
</body>
</html>
