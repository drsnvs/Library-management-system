<%-- 
    Document   : returnBook
    Created on : 23 Jun, 2024, 5:09:24 PM
    Author     : DARSHAN
--%>

<%-- returnBook.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Return Book</title>
    <link rel="stylesheet" href="css/style.css">
    <script>
        function showAlert(message) {
            alert(message);
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="title">Return Book</div>
        <div class="content">
            <form action="ReturnBookServlet" method="post">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">User ID</span>
                        <input type="text" name="user_id" placeholder="Enter User ID" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Book ID</span>
                        <input type="text" name="book_id" placeholder="Enter Book ID" required>
                    </div>
                </div>
                <div class="button">
                    <input type="submit" value="Return Book">
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
</body>
</html>
