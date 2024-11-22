<%-- 
    Document   : EditBook
    Created on : 21 Jun, 2024, 6:07:45 PM
    Author     : DARSHAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="LmsDB.LmsDbConnection"%>
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
    <script>
        function handleCheckbox() {
            var checkbox = document.getElementById("activeCheckbox");
            var hiddenInput = document.getElementById("activeHidden");

            if (checkbox.checked) {
                hiddenInput.value = "1";
            } else {
                hiddenInput.value = "0";
            }
        }
    </script>
    <style>
        .input-box input[type="checkbox"] {
            width: 20px; /* Adjust width as needed */
            height: 20px; /* Adjust height as needed */
            margin-right: 10px;
        }
        .input-box input[type="checkbox"] + label {
            font-size: 16px;
        }
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
        <div class="title">Edit Book</div>
        <div class="content">
            <form action="UpdateBookServlet" onsubmit="return validation()" method="POST">
                <input type="hidden" name="id" value="<%= request.getAttribute("book_id") %>">
                <div class="user-details">
<!--                    <div class="input-box">
                        <span class="details">Title</span>
                        <input type="text" name="id" value="<%= request.getAttribute("book_id") %>" required>
                    </div>-->
                    <div class="input-box">
                        <span class="details">Title</span>
                        <input type="text" name="book_title" id="book_title" value="<%= request.getAttribute("book_title") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Author</span>
                        <input type="text" name="author_name" id="author_name" value="<%= request.getAttribute("author_name") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Pages</span>
                        <input type="text" name="pages" id="pages" value="<%= request.getAttribute("pages") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Price</span>
                        <input type="text" name="price" id="price" value="<%= request.getAttribute("price") %>">
                    </div>
                    <div class="input-box">
                        <span class="details">Quantity</span>
                        <input type="text" name="quantity" id="quantity" value="<%= request.getAttribute("quantity") %>" readonly>
                    </div>
                    <div class="input-box">
                        <span class="details">ISBN</span>
                        <input type="text" name="isbn" id="isbn" value="<%= request.getAttribute("isbn") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Publisher</span>
                        <input type="text" name="publisher" id="publisher" value="<%= request.getAttribute("publisher") %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Edition year</span>
                        <input type="text" name="edition_year" id="edition_year" value="<%= request.getAttribute("edition_year") != null ? request.getAttribute("edition_year") : "" %>" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Language</span>
                        <select name="language_id" id="language_id" required>
                            <% 
                                // Fetch the selected language from request attributes
                                // int selectedLanguageId = 0;
                                // selectedLanguageId =Integer.parseInt(request.getAttribute("language_id").toString());
                                
                                try {
                                    // Database connection to fetch all available languages
                                    LmsDbConnection dbcon = new LmsDbConnection();
                                    Statement st = dbcon.StStatment();
                                    ResultSet rs = st.executeQuery("SELECT * FROM language_table");
                                    int id = (request.getParameter("id") != null) ? Integer.parseInt(request.getParameter("id")) : 0;

                                    while (rs.next()) {
//                                        int selectedLanguageId = 0;
                                        String s = "SELECT * FROM book_table WHERE book_id = ?";
                                        PreparedStatement ps = dbcon.PsStatment(s);
                                        ps.setInt(1, Integer.parseInt(request.getParameter("book_id").toString()));
                                        ResultSet rs1 = ps.executeQuery();
                                        rs1.next();
                                        
                                        int selectedLanguageId = (rs1.getString("language") != null) ? Integer.parseInt(rs1.getString("language")) : 0;
//                                        System.out.println("language: "+selectedLanguageId);
                                        
                                        int languageId = Integer.parseInt(rs.getString("language_id"));
                                        String languageName = rs.getString("language_name").toUpperCase();
                                        request.setAttribute("language_id", rs.getInt("language_id"));
//                                        System.out.println("languageId: "+languageId);
//                                        System.out.println("selectedLanguageId: "+selectedLanguageId);
//                                        System.out.println(languageId == selectedLanguageId ? "checked" : "" );
                            %>
                                        <!-- Mark the current option as selected if it matches the selected language -->
                                        <option value="<%= languageId %>" <%= (languageId == selectedLanguageId) ? "selected" : "" %> >
                                            <%= languageName %>
                                        </option>
                            <% 
                                    }
                                    rs.close();
                                    st.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </select>
                    </div>
                    <div class="input-box">
                        <span class="details">Format</span>
                        <select name="format_id" id="format_id" required>
                            <% 
                                try {
                                    LmsDbConnection dbcon = new LmsDbConnection();
                                    Statement st = dbcon.StStatment();
                                    ResultSet rs = st.executeQuery("SELECT * FROM format_table");
                                    int id = (request.getParameter("id") != null) ? Integer.parseInt(request.getParameter("id")) : 0;

                                    while (rs.next()) {
                                        String s = "SELECT * FROM book_table WHERE book_id = ?";
                                        PreparedStatement ps = dbcon.PsStatment(s);
                                        ps.setInt(1, Integer.parseInt(request.getParameter("book_id").toString()));
                                        ResultSet rs1 = ps.executeQuery();
                                        rs1.next();
                                        
                                        int selectedFormatId = (rs1.getString("format") != null) ? Integer.parseInt(rs1.getString("format")) : 0;
                                        
                                        int formatId = Integer.parseInt(rs.getString("format_id"));
                                        String formatName = rs.getString("format_name").toUpperCase();
                                        request.setAttribute("format_id", rs.getInt("format_id"));
                            %>
                                        <!-- Mark the current option as selected if it matches the selected language -->
                                        <option value="<%= formatId %>" <%= (formatId == selectedFormatId) ? "selected" : "" %> >
                                            <%= formatName %>
                                        </option>
                            <% 
                                    }
                                    rs.close();
                                    st.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </select>
                    </div>
                    <div class="input-box">
                        <span class="details">Active</span>
                        <input type="hidden" id="activeHidden" name="active" value="<%= request.getAttribute("active") %>">
                        <input type="checkbox" id="activeCheckbox" onclick="handleCheckbox()" <%= "1".equals(request.getAttribute("active").toString()) ? "checked" : "" %>>
                    </div>
                    
                </div>
                <div class="button">
                    <input type="submit" value="Save Changes">
                </div>
                <div class="button">
                    <a href="adminHome.jsp"><input type="button" value="Home"></a>
                </div>
            </form>
        </div>
    </div>
    <script>
        
        function validation(){
            var book_title = document.getElementById("book_title").value;
            var author_name = document.getElementById("author_name").value;
            var price = document.getElementById("price").value;
            var quantity = document.getElementById("quantity").value;
            var publisher = document.getElementById("publisher").value;
            var edition_year = document.getElementById("edition_year").value;
            var isbn = document.getElementById("isbn").value;
            if(book_title === ""){
                alert("Enter Book title");
                return false;
            }
            if(author_name === ""){
                alert("Enter Author name");
                return false;
            }
            if(price === ""){
                alert("Enter Price");
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
            if(quantity === ""){
                alert("Enter Quantity");
                return false;
            }
            if(publisher === ""){
                alert("Enter Publisher");
                return false;
            }
            if(edition_year === ""){
                alert("Enter Edition year");
                return false;
            }    
            
            return true;
        }
    </script>
</body>
</html>
