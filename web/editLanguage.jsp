<%-- 
    Document   : editLanguage
    Created on : 8 Sep, 2024, 3:02:31 PM
    Author     : Darshan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit Language</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <% 
        String languageId = request.getParameter("language_id");
        String languageName = "";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", ""); 
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM language_table WHERE language_id = ?");
            pstmt.setString(1, languageId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                languageName = rs.getString("language_name");
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
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
        <div class="title">Edit Language</div>
        <form action="ManageLanguagesServlet" method="post">
            <input type="hidden" name="language_id" value="<%= languageId %>">
                <div class="user-details">
                    <div class="input-box">
                        <label for="language_name">Language Name:</label>
                        <input type="text" name="language_name" id="language_name" value="<%= languageName %>">
                    </div>
            </div>
            <div class="button">
                <input type="submit" name="action" value="Update">
            </div>
            <div class="button">
                <a href="adminHome.jsp"><input type="button" value="Home"></a>
            </div>
        </form>
        
    </div>
</body>
</html>
