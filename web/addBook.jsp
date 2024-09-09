<%-- 
    Document   : AddBook
    Created on : 21 Jun, 2024, 6:05:03 PM
    Author     : DARSHAN
--%>

<%@page import="java.sql.*"%>
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
    <style>
        /* CSS for styling the dropdown */
        select {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
            background-color: #f8f8f8;
            -webkit-appearance: none; /* Remove default styling on some browsers */
            -moz-appearance: none; /* Remove default styling on some browsers */
            appearance: none; /* Remove default styling */
        }

        /* Optional: add styles for the select element when it is focused */
        select:focus {
            border-color: #007bff;
            outline: none;
        }

        /* Optional: add styles for the select element when it is disabled */
        select:disabled {
            background-color: #e9ecef;
            cursor: not-allowed;
        }

        /* Optional: add styles for the select element when it is invalid */
        select:invalid {
            border-color: #dc3545;
        }

        /* Optional: style for the options within the dropdown */
        select option {
            padding: 10px;
            background-color: #fff;
            color: #333;
        }
    </style>
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
                        <span class="details">Pages</span>
                        <input type="number" name="pages" id="pages" placeholder="Enter Number of pages in your book" >
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
                    <div class="input-box">
                        <span class="details">Language</span>
                        <select name="language_id" id="language_id" required>
                            <option value="">Select language</option>
                            <%
                                try{
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
                                    Statement st = con.createStatement();

                                    ResultSet rs = st.executeQuery("SELECT * FROM language_table");
                                    while(rs.next()){
                            %>
                            <option value="<%= rs.getInt("language_id") %>"><%= rs.getString("language_name").toUpperCase() %></option>
                            <% } %>
                        </select>
                            <%
                                }catch(Exception e){
                                    e.printStackTrace();
                                }
                            %>
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
            var pages = document.getElementById("pages").value;
            
            if(title === ""){
                alert("Enter Title");
                return false;
            }
            if(author === ""){
                alert("Enter Author");
                return false;
            }
            if(pages === ""){
                alert("Enter Pages");
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
            
            if(pages === ""){
                alert("Enter Pages");
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
