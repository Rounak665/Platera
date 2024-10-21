<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Approval Page</title>
</head>
<body>
    <h1>Pending Restaurant Approvals</h1>

    <table border="1">
        <thead>
            <tr>
                <th>Request ID</th>
                <th>Restaurant Name</th>
                <th>Owner Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Bank Account Name</th>
                <th>Bank Account Number</th>
                <th>GSTIN</th>
                <th>FSSAI License</th>
                <th>Actions</th> 
            </tr>
        </thead>
        <tbody>

        <%
            // Database connection details
            String jdbcUrl = "jdbc:oracle:thin:@Rounak:1521:orcl"; // Replace with your Oracle DB URL
            String dbUser = "ROUNAK"; // Replace with your DB username
            String dbPassword = "CHAKRABORTY"; // Replace with your DB password

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // Load Oracle JDBC Driver
                Class.forName("oracle.jdbc.driver.OracleDriver");

                // Establish the connection
                conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                // Create a statement
                stmt = conn.createStatement();

                // Query to select pending restaurant approvals
                String sql = "SELECT * FROM restaurant_requests"; // Adjust the table name as needed
                rs = stmt.executeQuery(sql);

                // Iterate through the result set and display each entry
                while (rs.next()) {
                    int request_id = rs.getInt("request_id");
                    String restaurant_name = rs.getString("restaurant_name");
                    String owner_name = rs.getString("owner_name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String bank_acc_name = rs.getString("bank_acc_name");
                    String bank_acc_number = rs.getString("bank_acc_number");
                    String gst_in = rs.getString("gst_in");
                    String fssai_lic_no=rs.getString("fssai_lic_no");

                    %>
                   <%out.println("<tr>");
                    out.println("<td>" + request_id + "</td>");
                    out.println("<td>" + restaurant_name + "</td>");
                    out.println("<td>" + owner_name + "</td>");
                    out.println("<td>" + email + "</td>");
                    out.println("<td>" + phone + "</td>");
                    out.println("<td>" + bank_acc_name + "</td>");
                    out.println("<td>" + bank_acc_number + "</td>");
                    out.println("<td>" + gst_in + "</td>");
                    out.println("<td>" + fssai_lic_no + "</td>");
                    out.println("<td>");
                    out.println("<form action='http://localhost:8080/Platera-Main/approveRestaurant' method='post' style='display:inline;'>");
                    out.println("<input type='hidden' name='request_id' value='" + request_id + "'/>");
                    out.println("<input type='submit' value='Approve'/>");
                    out.println("</form>");
                    out.println("<form action='rejectRestaurant' method='post' style='display:inline;'>");
                    out.println("<input type='hidden' name='request_id' value='" + request_id + "'/>");
                    out.println("<input type='submit' value='Reject'/>");
                    out.println("</form>");
                    out.println("</td>");
                    out.println("</tr>");
                   %>
                    <%
                }
            } catch (ClassNotFoundException e) {
                out.println("Oracle JDBC Driver not found.");
                e.printStackTrace();
            } catch (SQLException e) {
                out.println("Error connecting to the database."+ e.getMessage());
                e.printStackTrace();
            } finally {
                // Close resources
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </table>
</body>
</html>
