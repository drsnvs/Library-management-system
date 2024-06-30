<%-- 
    Document   : bookPenalty
    Created on : 30 Jun, 2024, 10:12:21 AM
    Author     : DARSHAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Calculate Penalty</title>
    <link rel="stylesheet" href="css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
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

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        select, input[type="submit"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="title">Calculate Penalty</div>
        <form action="CalculatePenaltyServlet" method="post">
            <label for="enrollment_no">Select Enrollment Number</label>
            <select id="enrollment_no" name="enrollment_no" required>
                <option value="">Select Enrollment Number</option>
                <%
                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");
                        String query = "SELECT DISTINCT dt.enrollment_no FROM data_table dt " +
                                       "JOIN book_fine_table bf ON dt.id = bf.id " +
                                       "JOIN book_rent_table brt ON dt.id = brt.id " +
                                       "WHERE bf.paid = 0 AND (brt.return_date IS NULL OR brt.return_date > brt.date_due)";
                        ps = con.prepareStatement(query);
                        rs = ps.executeQuery();
                        while (rs.next()) {
                            String enrollmentNo = rs.getString("enrollment_no");
                            out.println("<option value='" + enrollmentNo + "'>" + enrollmentNo + "</option>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
                        if (ps != null) try { ps.close(); } catch (Exception e) { e.printStackTrace(); }
                        if (con != null) try { con.close(); } catch (Exception e) { e.printStackTrace(); }
                    }
                %>
            </select>
            <input type="submit" value="Calculate Penalty">
        </form>
    </div>
</body>
</html>
