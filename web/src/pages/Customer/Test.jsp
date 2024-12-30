<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Random Category Images</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .card {
            background: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            width: 220px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }
        .card h3 {
            margin: 10px;
            text-align: center;
            color: #555;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Random Category Images</h1>
        <div class="grid">
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                try {
                    // Establish database connection
                    conn = Utilities.Database.getConnection(); // Adjust this to your connection method
                    
                    // Query to fetch 4 random categories using DBMS_RANDOM.VALUE
                    String sql = "SELECT category_name, image FROM " +
                                 "(SELECT category_name, image FROM categories ORDER BY DBMS_RANDOM.VALUE) " +
                                 "WHERE ROWNUM <= 4";
                    stmt = conn.prepareStatement(sql);
                    rs = stmt.executeQuery();
                    
                    // Iterate through result set
                    while (rs.next()) {
                        String categoryName = rs.getString("category_name");
                        String imagePath = rs.getString("image");
            %>
            <div class="card">
                <img src="<%= request.getContextPath() + "/" + imagePath %>" alt="<%= categoryName %>">
                <h3><%= categoryName %></h3>
            </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close resources
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </div>
    </div>
</body>
</html>
