<%@page import="FetchingClasses.Database"%>
<%@page import="javax.servlet.jsp.jstl.sql.Result"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
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
                <div class="sidebar-toggle menu" id="menu">
                    <ion-icon name="menu"></ion-icon>
                </div>
                <div class="sidebar-toggle close-btn"><ion-icon name="close-outline" class="ico"></ion-icon></div>
                <div class="sidebar-header">
                    <div class="logo">
                        <img src="../../../Public/images/logo.png" alt="">
                    </div>
                </div>
                
                <div class="sidebar-menu">
                    <ul>
                        <li>
                            <a href="">
                                <span class="icon"><ion-icon name="bar-chart"></ion-icon></span>
                                <span>Dashboard Overview</span>
                            </a>
                        </li>
                        <li>
                            <a href="./Admin_Order_Management.jsp">
                                <span class="icon"><ion-icon name="wine"></ion-icon></span>
                                <span>Order Management</span>
                            </a>
                        </li>
                        <li>
                            <a href="./Admin_Restaurant_Approval.jsp">
                                <span class="icon"><ion-icon name="restaurant"></ion-icon></span>
                                <span>Restaurant Approval</span>
                            </a>
                        </li>
                        <li>
                            <a href="./Admin_Delivery_Executive_Approval.jsp">
                                <span class="icon"><ion-icon name="bicycle"></ion-icon></span>
                                <span>Delivery Executive Management</span>
                            </a>
                        </li>
                        
                    </ul>
                </div>
            </div>
            
            <div class="main-content">
                <header>
                    <div class="headerLogo">
                        <div class="logo">
                            <img src="../../../Public/images/logo.png" alt="">
                        </div>
                    </div>
                    <div class="search-wrapper">
                        <span class="icon"><ion-icon name="search"></ion-icon></span>
                        <input type="search" placeholder="Search">
                    </div>
                    
                    <div class="social-icons">
                        <div class="logout_btn">
                            <form action="http://localhost:8080/Platera-Main/logout" class="d-flex align-items-center">
                                <button type="submit" class="btn d-flex align-items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-power" viewBox="0 0 16 16">
                                    <path d="M7.5 1v7h1V1z"></path>
                                    <path d="M3 8.812a5 5 0 0 1 2.578-4.375l-.485-.874A6 6 0 1 0 11 3.616l-.501.865A5 5 0 1 1 3 8.812"></path>
                                    </svg>
                                    <span class="ml-2">Logout</span>
                                </button>
                            </form>
                        </div>
                    </div>
                </header>

                <main>
                    <!-- Pending Restaurants Section -->
                    <section class="pending-restaurants">

                        <h1>Pending Delivery Executive Approvals</h1>
                        
                        <table border="1" id="restaurant-table">
                            <thead>
                                <tr>
                                    <th>Request ID</th>
                                    <th>Applicant Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                    <th>Aadhar</th>
                                    <th>Pan Number</th>
                                    <th>Driving License</th>
                                    <th>Bank Account Number</th>
                                    <th>Vehicle Number</th>
                                    <th>Vehicle Type</th>
                                    <th>Age</th>
                                    <th>Gender</th>   
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
                                        String sql = "SELECT * FROM delivery_executive_requests";
                                        stmt = conn.prepareStatement(sql);
                                        rs = stmt.executeQuery();

                                        while (rs.next()) {
                                            int request_id = rs.getInt("request_id");
                                            String name = rs.getString("name");
                                            String email = rs.getString("email");
                                            String phone = rs.getString("phone");
                                            String bank_acc_number = rs.getString("bank_account_number");
                                            String aadhar_number = rs.getString("aadhar_number");
                                            String address = rs.getString("address");
                                            String vehicle_number = rs.getString("vehicle_number");
                                            String driving_license_number = rs.getString("driving_license_number");
                                            String age = rs.getString("age");
                                            String gender = rs.getString("gender");
                                            String vehcile_type = rs.getString("vehicle_type");
                                            String pan_number = rs.getString("pan_number");
                                %>
                                <tr>
                                    <td> <%=request_id%> </td>
                                    <td> <%=name%> </td>>
                                    <td> <%=email%> </td>
                                    <td> <%=phone%> </td>
                                    <td> <%=address%> </td>
                                    <td> <%=aadhar_number%> </td>
                                    <td> <%=pan_number%> </td>
                                    <td> <%=driving_license_number%> </td>
                                    <td> <%=bank_acc_number%> </td>
                                    <td> <%=vehicle_number%> </td>
                                    <td> <%=vehcile_type%> </td>
                                    <td> <%=age%> </td>
                                    <td> <%=gender%> </td>                                   
                                    <td>
                                        <form action='http://localhost:8080/Platera-Main/ApproveDeliveryExecutive' method='post' style='display:inline;'>
                                            <input type='hidden' name='request_id' value='<%=request_id%>'/>
                                            <input type='submit' class="button approve-btn" value='Approve'/>
                                        </form>
                                        <form action='http://localhost:8080/Platera-Main/RejectDeliveryExecutive' method='post' style='display:inline;'>
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
