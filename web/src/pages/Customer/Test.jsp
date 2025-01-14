<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="Utilities.Database" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menu Items</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
        }
        .menu-item {
            background: #fff;
            margin: 20px 0;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .menu-item h2 {
            margin: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Menu Items</h1>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                conn = Database.getConnection();
                String query = "SELECT mi.item_name FROM menu_items mi JOIN restaurants r ON mi.restaurant_id = r.restaurant_id WHERE r.location_id = 1";
                stmt = conn.prepareStatement(query);
                rs = stmt.executeQuery();
                while (rs.next()) {
        %>
                    <div class="menu-item">
                        <h2><%= rs.getString("item_name") %></h2>
                    </div>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
</body>
</html>