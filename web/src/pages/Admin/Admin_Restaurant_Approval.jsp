<%@page import="javax.servlet.jsp.jstl.sql.Result"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Platera.Database"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin</title>
        <link rel="stylesheet" href="Admin.css"> 
    </head>
    <body>
        <!-- Sidebar and Header Section -->
        <div>
            <div class="sidebar">
                <!-- Sidebar content omitted for brevity -->
            </div>
            
            <div class="main-content">
                <header>
                    <!-- Header content omitted for brevity -->
                </header>

                <main>
                    <!-- Pending Restaurants Section -->
                    <section class="pending-restaurants">

                        <h1>Pending Restaurant Approvals</h1>

                        <table border="1" id="restaurant-table">
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
                                    Connection conn = null;
                                    PreparedStatement stmt = null;
                                    ResultSet rs = null;

                                    try {
                                        conn = Database.getConnection(); // Assuming getConnection method works with Java 1.5
                                        String sql = "SELECT * FROM restaurant_requests";
                                        stmt = conn.prepareStatement(sql);
                                        rs = stmt.executeQuery();

                                        while (rs.next()) {
                                            int request_id = rs.getInt("request_id");
                                            String restaurant_name = rs.getString("restaurant_name");
                                            String owner_name = rs.getString("owner_name");
                                            String email = rs.getString("email");
                                            String phone = rs.getString("phone");
                                            String bank_acc_name = rs.getString("bank_acc_name");
                                            String bank_acc_number = rs.getString("bank_acc_number");
                                            String gst_in = rs.getString("gst_in");
                                            String fssai_lic_no = rs.getString("fssai_lic_no");
                                %>
                                <tr>
                                    <td> <%=request_id%> </td>
                                    <td> <%=restaurant_name%> </td>
                                    <td> <%=owner_name%> </td>
                                    <td> <%=email%> </td>
                                    <td> <%=phone%> </td>
                                    <td> <%=bank_acc_name%> </td>
                                    <td> <%=bank_acc_number%> </td>
                                    <td> <%=gst_in%> </td>
                                    <td> <%=fssai_lic_no%> </td>
                                    <td>
                                        <form action='http://localhost:8080/Platera-Main/approveRestaurant' method='post' style='display:inline;'>
                                            <input type='hidden' name='request_id' value='<%=request_id%>'/>
                                            <input type='submit' class="button approve-btn" value='Approve'/>
                                        </form>
                                        <form action='http://localhost:8080/Platera-Main/rejectRestaurant' method='post' style='display:inline;'>
                                            <input type='hidden' name='request_id' value='<%=request_id%>'/>
                                            <input type='submit' class="button reject-btn" value='Reject'/>
                                        </form>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } catch (SQLException e) {
                                        out.println("Error connecting to the database: " + e.getMessage());
                                        e.printStackTrace();
                                    } finally {
                                        // Close resources manually to avoid resource leak
                                        try {
                                            if (rs != null) {
                                                rs.close();
                                            }
                                            if (stmt != null) {
                                                stmt.close();
                                            }
                                            if (conn != null) {
                                                conn.close();
                                            }
                                        } catch (SQLException ex) {
                                            out.println("Error closing resources: " + ex.getMessage());
                                        }
                                    }
                                %>
                        </table>

                    </section>
                </main>
            </div>
        </div>

        <!-- Scripts Section -->
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

        <script>
            document.querySelector("#menu").addEventListener("click", function () {
                document.querySelector(".sidebar").classList.add("activate");
            });

            document.querySelector(".sidebar .close-btn").addEventListener("click", function () {
                document.querySelector(".sidebar").classList.remove("activate");
            });

            function signout() {
                localStorage.removeItem('authtoken');
                localStorage.removeItem('admin');
                window.location.href = '../AddRestaurent/AddRestaurent.html#Signin-popup';
            }
        </script>

    </body>
</html>
