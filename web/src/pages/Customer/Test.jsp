<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="Utilities.Database" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Items</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>
    <h1>Menu Items</h1>
    <table>
        <thead>
            <tr>
                <th>Item ID</th>
                <th>Item Name</th>
                <th>Price</th>
                <th>Image</th>
                <th>Restaurant ID</th>
                <th>Category ID</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    // Get the database connection
                    conn = Database.getConnection();

                    // Create the statement
                    stmt = conn.createStatement();

                    // Execute the query
                    String query = "SELECT mi.* " +
                                   "FROM menu_items mi " +
                                   "JOIN restaurants r ON mi.restaurant_id = r.restaurant_id " +
                                   "JOIN locations l ON r.location_id = l.location_id " +
                                   "WHERE mi.image LIKE 'DatabaseImages/Categories%' AND r.location_id = 1";
                    rs = stmt.executeQuery(query);

                    // Iterate through the result set and display the data
                    while (rs.next()) {
                        int itemId = rs.getInt("item_id");
                        String itemName = rs.getString("item_name");
                        double price = rs.getDouble("price");
                        String image = rs.getString("image");
                        int restaurantId = rs.getInt("restaurant_id");
                        int categoryId = rs.getInt("category_id");
            %>
            <tr>
                <td><%= itemName %></td>

            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </tbody>
    </table>
</body>
</html>