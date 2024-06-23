<%-- 
    Document   : EditBook
    Created on : 21 Jun, 2024, 6:07:45 PM
    Author     : DARSHAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit Book</title>
    <link rel="stylesheet" href="css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        <div class="title">Edit Book</div>
        <div class="content">
            <form action="UpdateBookServlet" method="POST">
                <input type="hidden" name="id" value="<%= request.getAttribute("book_id") %>">
                <div class="user-details">
<!--                    <div class="input-box">
                        <span class="details">Title</span>
                        <input type="text" name="id" value="<%= request.getAttribute("book_id") %>" required>
                    </div>-->
                    <div class="input-box">
                        <span class="details">Title</span>
                        <input type="text" name="book_title" value="<%= request.getAttribute("book_title") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Author</span>
                        <input type="text" name="author_name" value="<%= request.getAttribute("author_name") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Price</span>
                        <input type="text" name="price" value="<%= request.getAttribute("price") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Quantity</span>
                        <input type="text" name="quantity" value="<%= request.getAttribute("quantity") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">ISBN</span>
                        <input type="text" name="isbn" value="<%= request.getAttribute("isbn") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Publisher</span>
                        <input type="text" name="publisher" value="<%= request.getAttribute("publisher") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Year</span>
                        <input type="text" name="edition_year" value="<%= request.getAttribute("edition_year") != null ? request.getAttribute("edition_year") : "" %>" required>
                    </div>
                </div>
                <div class="button">
                    <input type="submit" value="Save Changes">
                </div>
            </form>
        </div>
    </div>
</body>
</html>
