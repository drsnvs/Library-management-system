<%-- 
    Document   : editIssuedBook
    Created on : 23 Jun, 2024, 3:05:51 PM
    Author     : DARSHAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*, javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit Issued Book</title>
    <link rel="stylesheet" href="css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 50%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }

        .title {
            font-size: 28px;
            font-weight: 500;
            margin-bottom: 20px;
        }

        form {
            width: 100%;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        input[type="text"], input[type="date"], input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        input[type="submit"],input[type="button"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 4px;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
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
        <div class="title">Edit Issued Book</div>
        <form action="UpdateIssuedBookServlet" onsubmit="return validation()" method="post">
            <input type="hidden" name="rent_id" value="<%= request.getAttribute("rent_id") %>">
            
            <!--<label for="book_id">Book ID</label>-->
            <input type="hidden" id="book_id" name="book_id" value="<%= request.getAttribute("book_id") %>" >

            <label for="user_id">User ID</label>
            <input type="text" id="user_id" name="user_id" value="<%= request.getAttribute("user_id") %>" readonly>

            <label for="issue_date">Issue Date</label>
            <input type="text" id="date_out" name="date_out" value="<%= request.getAttribute("date_out") %>" required>

            <label for="due_date">Due Date</label>
            <input type="text" id="date_due" name="date_due" value="<%= request.getAttribute("date_due") %>" required>

            <label for="return_date">Return Date</label>
            <input type="text" id="return_date" name="return_date" placeholder="YYYY-MM-DD" value="<% 
                    Date returnDate = (Date) request.getAttribute("return_date");
                    if (returnDate == null) {
                        out.print("Not yet");
                    } else {
                        out.print(returnDate.toString());
                    }
                   %>" readonly >
            
            <label for="active">Book issued</label>
            <input type="text" id="active" name="active" value="<%= request.getAttribute("active") %>" readonly>
            
            

            

            <input type="submit" value="Update">
            <a href="manageIssuedBooks.jsp"><input type="button" value="Back"></a>
        </form>
    </div>
    <script>
        
        function validation(){
            var book_id = document.getElementById("book_id").value;
            var user_id = document.getElementById("user_id").value;
            var date_out = document.getElementById("date_out").value;
            var date_due = document.getElementById("date_due").value;
            
            if(book_id === ""){
                alert("Enter Book id");
                return false;
            }
            if(user_id === ""){
                alert("Enter User id");
                return false;
            }
            if(date_out === ""){
                alert("Enter Issue date");
                return false;
            }
            if(date_due === ""){
                alert("Enter Due date");
                return false;
            }  
            
            return true;
        }
    </script>
</body>
</html>
