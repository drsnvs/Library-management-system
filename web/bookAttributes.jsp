<%-- 
    Document   : bookAttributes
    Created on : 7 Sep, 2024, 9:33:33 AM
    Author     : Darshan
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Attributes</title>
    <link rel="stylesheet" href="style.css">
    <!-- Embed the CSS directly or link to an external stylesheet -->
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 10px;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
            overflow: hidden;
        }
        .container {
            max-width: 700px;
            width: 100%;
            background-color: #fff;
            padding: 25px 30px;
            border-radius: 5px;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.15);
            overflow-y: auto;
            max-height: 90vh;
        }
        .container .title {
            font-size: 25px;
            font-weight: 500;
            position: relative;
            margin-bottom: 20px;
        }
        .container .title::before {
            content: "";
            position: absolute;
            left: 0;
            bottom: 0;
            height: 3px;
            width: 30px;
            border-radius: 5px;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
        }
        .content .button {
            height: 45px;
            margin: 10px 0;
            display: flex;
            justify-content: center;
        }
        .content .button a,
        .content .button input {
            display: block;
            height: 100%;
            width: 200px;
            text-align: center;
            line-height: 45px;
            border-radius: 5px;
            border: none;
            color: #fff;
            font-size: 18px;
            font-weight: 500;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
            text-decoration: none;
        }
        .content .button a:hover,
        .content .button input:hover {
            background: linear-gradient(-135deg, #71b7e6, #9b59b6);
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
        <div class="title">Book Attributes (<%= session.getAttribute("first_name") %>)</div>
        <div class="content">
            <div class="button">
                <a href="addLanguage.jsp">Add Language</a>
            </div>
        </div>
        <div class="content">
            <div class="button">
                <a href="addFormats.jsp">Add Formats</a>
            </div>
        </div>
        <div class="content">
            <div class="button">
                <a href="adminHome.jsp">Home</a>
            </div>
        </div>
    </div>
</body>
</html>
