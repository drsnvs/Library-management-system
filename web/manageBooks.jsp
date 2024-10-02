<%-- 
    Document   : manageBooks
    Created on : 21 Jun, 2024, 10:47:27 AM
    Author     : DARSHAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*"%>
<%@page import="javax.servlet.http.*, javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Manage Books</title>
    <link rel="stylesheet" href="css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensure the page takes up at least the viewport height */
        }

        .container {
            width: 80%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
            flex: 1; /* Grow to take remaining vertical space */
            overflow: auto; /* Add scrollbar when content exceeds height */
        }

        .title {
            font-size: 28px;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .content {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table th, table td {
            padding: 5px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        #cnt, table th{
            text-align: center;
        }
        thead th {
            position: sticky;
            top: 0;
            background-color: #f2f2f2;
            z-index: 10;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        table th {
            background-color: #f2f2f2;
        }

        action form {
            display: inline-block;
            margin-right: 5px; /* Adjust spacing between forms */
        }

        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .actions {
            display: flex;
            justify-content: space-between;
        }

        .actions form {
            display: inline-block;
            margin-right: 5px; /* Adjust spacing between forms */
        }

        .actions button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }

        .actions button:hover {
            background-color: #0056b3;
        }
        .search-box {
            margin-bottom: 20px;
            display: flex; /* Use flexbox for alignment */
            justify-content: flex-start; /* Align to the left */
        }

        .search-box input {
            padding: 10px;
            font-size: 16px;
            width: 50%;
            margin-right: 10px;
            border: 1px solid #ddd; /* Add border for definition */
            border-radius: 4px; /* Rounded corners */
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
        }

        .search-box input:focus {
            outline: none; /* Remove default focus outline */
            border-color: #007bff; /* Change border color on focus */
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* Highlight shadow on focus */
        }

    </style>
    <script>
        // Function to search books by title or author
        function searchBook() {
            var titleInput = document.getElementById("searchTitle").value.toLowerCase();
            var authorInput = document.getElementById("searchAuthor").value.toLowerCase();
            var bookRows = document.querySelectorAll(".book-row");

            bookRows.forEach(function (row) {
                var title = row.querySelector(".book-title").innerText.toLowerCase();
                var author = row.querySelector(".book-author").innerText.toLowerCase();

                // If either title or author matches, display the row
                if ((title.includes(titleInput) || titleInput === "") && (author.includes(authorInput) || authorInput === "")) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }

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
        <div class="title">Manage Books</div>
        <div class="search-box">
            <input type="text" id="searchTitle" placeholder="Search by Title" onkeyup="searchBook()">
            <input type="text" id="searchAuthor" placeholder="Search by Author" onkeyup="searchBook()">
        </div>

        <div class="content">
            <table>
                <thead>
                    <tr>
                        <!--<th>ID</th>-->
                        <th>Title</th>
                        <th>Author</th>
                        <!--<th>Price</th>-->
                        <th>Quantity</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT book_id, book_title, author_name, price, quantity FROM book_table");

                            while (rs.next()) {
                                int bookId = rs.getInt("book_id");
                                String bookTitle = rs.getString("book_title");
                                String authorName = rs.getString("author_name");
                                int quantity = rs.getInt("quantity");
                                
                                String displayBookTitle = bookTitle.length() > 25 ? bookTitle.substring(0, 25) + "..." : bookTitle;
                                String displayAuthorName = authorName.length() > 20 ? authorName.substring(0, 20) + "..." : authorName;
                    %>
                    <tr class="book-row">
                        <td class="book-title"><%= displayBookTitle %></td>
                        <td class="book-author"><%= displayAuthorName %></td>
                        <td id="cnt"><%= quantity %></td>
                        <td>
                            <form action="ManageBooksServlet" method="post" style="display:inline;">
                                <input type="hidden" name="book_id" value="<%= bookId %>">
                                <input type="submit" name="action" value="Edit">
                            </form>
                            <form action="ManageBooksServlet" method="post" style="display:inline;">
                                <input type="hidden" name="book_id" value="<%= bookId %>">
                                <input type="submit" name="action" value="Delete">
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                            con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
            
                
        </div>
    </div>
    <div class="actions">
        <button onclick="location.href='adminHome.jsp'">Go to Home</button>
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
