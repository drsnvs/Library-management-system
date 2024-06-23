<%-- 
    Document   : AddBook
    Created on : 21 Jun, 2024, 6:05:03 PM
    Author     : DARSHAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Book</title>
    <link rel="stylesheet" href="css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script>
        function showAlert(message) {
            alert(message);
        }
    </script>
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
        <div class="title">Add Book</div>
        <div class="content">
            <form action="AddBookServlet" method="POST">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">Title</span>
                        <input type="text" name="title" placeholder="Enter book title" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Author</span>
                        <input type="text" name="author" placeholder="Enter book author" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Price</span>
                        <input type="text" name="price" placeholder="Enter book price" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Quantity</span>
                        <input type="number" name="quantity" placeholder="Enter quantity" required>
                    </div>
<!--                    <div class="input-box">
                        <span class="details">ISBN</span>
                        <input type="text" name="isbn" placeholder="Enter book ISBN" required>
                    </div>-->
                    <div class="input-box">
                        <span class="details">Publisher</span>
                        <input type="text" name="publisher" placeholder="Enter book publisher" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Year</span>
                        <input type="number" name="year" placeholder="Enter publication year" required>
                    </div>
                </div>
                <div class="button">
                    <input type="submit" value="Add Book">
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
