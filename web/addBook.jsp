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
            if (session != null) {
    session.invalidate(); // Invalidate the session
}
response.sendRedirect("index.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <div class="container">
        <div class="title">Add Book</div>
        <div class="content">
            <form action="AddBookServlet" onsubmit="return validation()" method="POST">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">Title</span>
                        <input type="text" name="title" id="title" placeholder="Enter book title" >
                    </div>
                    <div class="input-box">
                        <span class="details">Author</span>
                        <input type="text" name="author" id="author" placeholder="Enter book author" >
                    </div>
                    <div class="input-box">
                        <span class="details">Price</span>
                        <input type="text" name="price" id="price" placeholder="Enter book price" >
                    </div>
                    <div class="input-box">
                        <span class="details">Quantity</span>
                        <input type="number" name="quantity" id="quantity" placeholder="Enter quantity" >
                    </div>
                    <div class="input-box">
                        <span class="details">ISBN</span>
                        <input type="text" name="isbn" id="isbn" placeholder="Enter book ISBN" >
                    </div>
                    <div class="input-box">
                        <span class="details">Publisher</span>
                        <input type="text" name="publisher" id="publisher" placeholder="Enter book publisher" >
                    </div>
                    <div class="input-box">
                        <span class="details">Year</span>
                        <input type="number" name="year" id="year" placeholder="Enter publication year" >
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
    <script>
        function validation(){
            var title = document.getElementById("title").value;
            var author = document.getElementById("author").value;
            var price = document.getElementById("price").value;
            var quantity = document.getElementById("quantity").value;
            var publisher = document.getElementById("publisher").value;
            var year = document.getElementById("year").value;
            var isbn = document.getElementById("isbn").value;
            
            if(title === ""){
                alert("Enter Title");
                return false;
            }
            if(author === ""){
                alert("Enter Author");
                return false;
            }
            if(price === ""){
                alert("Enter Price");
                return false;
            }
            
            if(quantity === ""){
                alert("Enter Quantity");
                return false;
            }
            
            if(isbn === ""){
                alert("Enter ISBN");
                return false;
            }
            
            if(isbn.length != 13){
                alert("ISBN should be 13 ");
                return false;
            }
            
            if(publisher === ""){
                alert("Enter Publisher");
                return false;
            }
            if(year === ""){
                alert("Enter Year");
                return false;
            }
        }
    </script>
</body>
</html>
