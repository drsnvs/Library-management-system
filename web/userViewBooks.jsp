<%-- 
    Document   : viewBooks
    Created on : 24 Jun, 2024, 4:00:24 PM
    Author     : DARSHAN
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Books</title>
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
            padding: 1em 0;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
        }
    </style>
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
        <a href="userDashboard.jsp">Dashboard</a>
        <a href="userProfile.jsp">Profile</a>
        <!--<a href="userViewBooks.jsp">View Books</a>-->
        <a href="userIssuedBooks.jsp">Issued Books</a>
        <a href="logOutServlet">Logout</a>
    </nav>
    <main>
        <div class="card">
            <h2>Books Available</h2>
            <%
                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
                    stmt = con.createStatement();
                    String query = "SELECT * FROM book_table";
                    rs = stmt.executeQuery(query);
                    
                    if (rs.next()) {
            %>
                        <div class="table-container">
                            <table class="book-list">
                                <tr>
                                    <th>ID</th>
                                    <th>Title</th>
                                    <th>Author</th>
                                    <th>Publisher</th>
                                    <th>Year</th>
                                    <th>Availability</th>
                                </tr>
                                <%
                                    do {
                                %>
                                        <tr>
                                            <td><%= rs.getInt("book_id") %></td>
                                            <td><%= rs.getString("book_title") %></td>
                                            <td><%= rs.getString("author_name") %></td>
                                            <td><%= rs.getString("publisher") %></td>
                                            <td><%= rs.getInt("edition_year") %></td>
                                            <td><%= rs.getInt("quantity") %></td>
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
                    try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </div>
    </main>
    <footer>
        <p>&copy; 2024 Library Management System</p>
    </footer>
</body>
</html>
