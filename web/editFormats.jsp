<%-- 
    Document   : editFormats
    Created on : 28 Sep, 2024, 9:12:20 AM
    Author     : Darshan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="LmsDB.LmsDbConnection"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit Formats</title>
    <link rel="stylesheet" href="css/style.css">
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
    <% 
        String formatId = request.getParameter("format_id");
        String formatName = "";

        try {
            LmsDbConnection dbcon = new LmsDbConnection();
            PreparedStatement pstmt = dbcon.PsStatment("SELECT * FROM format_table WHERE format_id = ?");
            pstmt.setString(1, formatId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                formatName = rs.getString("format_name");
            }

            rs.close();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <div class="container">
        <div class="title">Edit Language</div>
        <form action="ManageFormatServlet" method="post">
            <input type="hidden" name="format_id" value="<%= formatId %>">
                <div class="user-details">
                    <div class="input-box">
                        <label for="format_name">Format Name:</label>
                        <input type="text" name="format_name" id="format_name" value="<%= formatName %>">
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