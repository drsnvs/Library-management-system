<%-- 
    Document   : viewBooks
    Created on : 24 Jun, 2024, 4:00:24 PM
    Author     : DARSHAN
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@page import="LmsDB.LmsDbConnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Books</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        header {
            background-color: #4CAF50;
            color: white;
            padding: 1em 0;
            text-align: center;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
        }
        nav {
            display: flex;
            justify-content: space-around;
            background-color: #333;
            padding: 1em 0;
        }
        nav a {
            color: white;
            text-decoration: none;
            padding: 0.5em 1em;
            transition: background-color 0.3s ease;
        }
        nav a:hover {
            background-color: #575757;
        }
        main {
            flex: 1;
            padding: 2em;
            overflow-y: auto;
        }
        .card {
            background-color: white;
            margin: 1em 0;
            padding: 2em;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .card h2 {
            margin-top: 0;
        }
        .table-container {
            max-height: 400px; /* Set the desired height */
            overflow-y: auto;
        }
        .book-list {
            width: 100%;
            border-collapse: collapse;
            margin: 1em 0;
        }
        .book-list th, .book-list td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .book-list th {
            background-color: #f2f2f2;
        }
        .no-books {
            text-align: center;
            padding: 2em;
        }
        footer {
            background-color: #333;
            color: white;
            text-align: center;
            /*padding: 1em 0;*/
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
        }
        .available {
            color: lightgreen;
            /*font-weight: bold;*/
        }

        .not-available {
            color: red;
            /*font-weight: bold;*/
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
    </script>
</head>
<body>
    <%
        try {
            if (!session.getId().equals(session.getAttribute("key"))) {
                response.sendRedirect("index.jsp");
                return; // Added return to stop further execution after redirect
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <header>
        <h1>View Books</h1>
    </header>
    <nav>
        <a href="userDashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
        <a href="userProfile.jsp"><i class="fas fa-user"></i> Profile</a>
        <!--<a href="userViewBooks.jsp"><i class="fas fa-book"></i>View Books</a>-->
        <a href="userIssuedBooks.jsp"><i class="fas fa-book-reader"></i>  Issued Books</a>
        <a href="logOutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </nav>
    <main>
        <div class="card">
            <h2>Books Available</h2>
            <div class="search-box">
                <input type="text" id="searchTitle" placeholder="Search by Title" onkeyup="searchBook()">
                <input type="text" id="searchAuthor" placeholder="Search by Author" onkeyup="searchBook()">
            </div>
            <%
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    LmsDbConnection dbcon = new LmsDbConnection();
                    stmt = dbcon.StStatment();
                    String query = "SELECT * FROM book_table ORDER BY book_title ASC";
                    rs = stmt.executeQuery(query);
                    
                    if (rs.next()) {
            %>
                        <div class="table-container">
                            <table class="book-list">
                                <tr>
                                    <!--<th>ID</th>-->
                                    <th>Title</th>
                                    <th>Author</th>
                                    <th>Publisher</th>
                                    <th>Year</th>
                                    <th>Availability</th>
                                </tr>
                                <%
                                    do {
                                %>
                                        <tr class="book-row">
                                            <td class="book-title"><%= rs.getString("book_title") %></td>
                                            <td class="book-author"><%= rs.getString("author_name") %></td>
                                            <td><%= rs.getString("publisher") %></td>
                                            <td><%= rs.getInt("edition_year") %></td>
                                            <td class="<%= (rs.getInt("quantity") > 0) ? "available" : "not-available" %>"><% if(rs.getInt("quantity") > 0) { %> Available <% } else { %> Not Available <% } %></td>
                                        </tr>
                                <%
                                    } while (rs.next());
                                %>
                            </table>
                        </div>
            <%
                    } else {
            %>
                        <div class="no-books">
                            <p>No books available in the library.</p>
                        </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </div>
    </main>
    <footer>
        <p>&copy; 2024 Library Management System</p>
    </footer>
</body>
</html>
