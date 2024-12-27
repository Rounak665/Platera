
<%@page import="Utilities.Restaurant"%>
<%@page import="Utilities.RestaurantDAO"%>
<%@page import="Utilities.Orders"%>
<%@page import="java.util.List"%>
<%@page import="Utilities.OrdersDAO"%>
<%@page import="Utilities.OrderItem"%>
<%@page import="java.sql.SQLException"%>
<%@page import="Utilities.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Delivery Executive Dashboard Overview</title>
        <link rel="stylesheet" href="Delivery.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>

        <!--Java Scriplets-->
        <%
            //Actual code
//            int user_id = (Integer) session.getAttribute("user_id");
//            String name = (String) session.getAttribute("name");
//            String email = (String) session.getAttribute("email");
//            int delivery_executive_id = (Integer) session.getAttribute("delivery_executive_id");
//            String image = (String) session.getAttribute("image");
//            String imagepath = request.getContextPath() + '/' + image;
//            int location_id = (Integer) session.getAttribute("location_id");
//            String location = "";

            //For debugging
            int user_id = 257;
            String name = "Arthur Morgan";
            String email = "ArthurMorgan1863@gmail.com";
            int delivery_executive_id = 35;
            String image = "DatabaseImages/Delivery_Executives/Arthur_Morgan.jpeg";
            String imagepath = request.getContextPath() + '/' + image;
            int location_id = 1;
            String location = "";

            Connection conn = null;
            PreparedStatement selectLocationPstmt = null;
            ResultSet selectLocationSqlRs = null;

            try {
                // Get connection
                conn = Database.getConnection();

                try {

                    String selectLocationSql = "SELECT location_name FROM locations WHERE location_id=?";
                    selectLocationPstmt = conn.prepareStatement(selectLocationSql);
                    selectLocationPstmt.setInt(1, location_id); // Set parameter before executing the query

                    selectLocationSqlRs = selectLocationPstmt.executeQuery(); // Execute the query

                    if (selectLocationSqlRs.next()) {
                        location = selectLocationSqlRs.getString("location_name"); // Retrieve the location name
                    } else {
                        out.println("Unexpected Error: No location found for location_id.");
                        return;
                    }
                } catch (SQLException e) {
                    out.println("Error executing the second query: " + e.getMessage());
                    e.printStackTrace();
                    return; // Return after logging the error
                }

            } catch (SQLException e) {
                out.println("Error connecting to the database: " + e.getMessage());
                e.printStackTrace();
            } finally {
                // Close resources manually to avoid resource leak
                try {

                    if (selectLocationSqlRs != null) {
                        selectLocationSqlRs.close();
                    }
                    if (selectLocationPstmt != null) {
                        selectLocationPstmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException ex) {
                    out.println("Error closing resources: " + ex.getMessage());
                }
            }


        %>


        <!-- Welcome Popup -->


        <!-- loader -->
        <div class="loader">
            <div id="pl">
                <div>
                    <video class="vid" src="../ContactUs/Assets/loader.mp4" autoplay muted loop></video>
                </div>
            </div>
        </div>     

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
                                <span class="icon"><ion-icon name="home-sharp"></ion-icon></span>
                                <span>Home</span>
                            </a>
                        </li>
                        <li>
                            <a href="DeliveryOrders.jsp">
                                <span class="icon"><ion-icon name="cart"></ion-icon></span>
                                <span>Orders</span>
                            </a>
                        </li>
                        <li class="li_logout">
                            <a href="../AddRestaurent/AddRestaurent.html#Signin-popup">
                                <span class="icon"><ion-icon name="power"></ion-icon></span>
                                <span>Logout</span>
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
                            <form action="http://localhost:8080/Platera-Main/logout" class="d-flex align-items-center logout">
                                <button type="submit" class="btn d-flex align-items-center">
                                    <span class="ml-2">Logout</span>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-power" viewBox="0 0 16 16">
                                    <path d="M7.5 1v7h1V1z"></path>
                                    <path d="M3 8.812a5 5 0 0 1 2.578-4.375l-.485-.874A6 6 0 1 0 11 3.616l-.501.865A5 5 0 1 1 3 8.812"></path>
                                    </svg>
                                </button>
                            </form>
                        </div>
                    </div>
                </header>

                <main>
                    <h2 class="dash-title">Hello, <%=name%></h2>

                    <div class="container">

                        <div class="profile">
                            <div class="personal-details">
                                <div class="personal-image">
                                    <img src="<%=imagepath%>" alt="Your-image">
                                </div>
                                <div class="personal-description">
                                    <h5><%=name%></h5>
                                    <h6><span>&#9733; 5.0</span><span><%=location%></span></h6>
                                    <p>Joined June 2024</p>
                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editProfileModal">Edit</button>
                                </div>
                            </div>
                            <div class="order-details">
                                <div class="order-card">
                                    <span class="icon" style="color: rgb(0, 200, 0);">
                                        <ion-icon name="checkmark-done-outline"></ion-icon>
                                    </span>
                                    <h5>932</h5>
                                    <p>Finished Orders</p>
                                </div>
                                <div class="order-card">
                                    <span class="icon" style="color: rgb(255, 140, 0);">
                                        <ion-icon name="checkmark-circle"></ion-icon>
                                    </span>
                                    <h5>1032</h5>
                                    <p>Delivered Orders</p>
                                </div>
                                <div class="order-card">
                                    <span class="icon" style="color: rgb(255, 0, 0);">
                                        <ion-icon name="close-circle"></ion-icon>
                                    </span>
                                    <h5>103</h5>
                                    <p>Cancelled Orders</p>
                                </div>
                            </div>
                            <div class="earning">
                                <div class="earning-details">
                                    <div class="details-left">
                                        <span class="icon"><ion-icon name="wallet-outline"></ion-icon></span>
                                        <div>
                                            <p>Today's Earnings</p>
                                            <h5>₹2,530</h5>
                                        </div>
                                    </div>
                                    <div class="details-right">
                                        <button class="start-delivery">Ready to Deliver</button>
                                        <button class="end-delivery">Call it a Day</button>
                                    </div>
                                </div>
                                <hr />
                                <div class="distance-details">
                                    <div class="distance-head">
                                        <span>Total Trip</span>
                                        <span>Total Distance</span>
                                        <span>Total Time</span>
                                    </div>
                                    <div class="distance-values">
                                        <span>15</span>
                                        <span>15 Km</span>
                                        <span>90 Min</span>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="dash-performance">
                            <!-- Current Order Section -->
                            <div class="current-order">
                                <%
                                    OrdersDAO ordersDAO = new OrdersDAO();
                                    List<Orders> ordersList = null;

                                    try {
                                        // Fetch orders using OrdersDAO
                                        ordersList = ordersDAO.getAcceptedOrdersByDeliveryExecutiveId(delivery_executive_id);

                                        if (ordersList.isEmpty()) {
                                            out.println("No orders found for the delivery executive.");
                                            return;
                                        }

                                        Orders currentOrder = ordersList.get(0); // Assuming we are displaying the first order for simplicity

                                        // Fetch the restaurantId from the current order
                                        int restaurantId = currentOrder.getRestaurantId();

                                        // Use RestaurantDAO to get restaurant details including reviews and rating
                                        RestaurantDAO restaurantDAO = new RestaurantDAO();
                                        Restaurant restaurant = restaurantDAO.getRestaurantById(restaurantId); // Fetch restaurant details by ID

                                        // Initialize the review count variable
                                        int reviewCount = 0;

                                        // Database connection setup
                                        String query = "SELECT COUNT(*) AS review_count FROM reviews WHERE restaurant_id = ?";

                                        // Establish the database connection and execute the query
                                        Connection con = null;
                                        PreparedStatement ps = null;
                                        ResultSet rs = null;

                                        try {
                                            // Get the connection
                                            con = Database.getConnection();

                                            // Prepare the query
                                            ps = con.prepareStatement(query);
                                            ps.setInt(1, restaurantId);

                                            // Execute the query
                                            rs = ps.executeQuery();

                                            // Retrieve the review count
                                            if (rs.next()) {
                                                reviewCount = rs.getInt("review_count");
                                            }
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        } finally {
                                            // Close the ResultSet, PreparedStatement, and Connection
                                            try {
                                                if (rs != null) {
                                                    rs.close();
                                                }
                                                if (ps != null) {
                                                    ps.close();
                                                }
                                                if (con != null) {
                                                    con.close();
                                                }
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            }
                                        }
                                %>

                                <!-- Displaying the current order details -->
                                <div class="current-order">
                                    <h2><ion-icon name="receipt-outline"></ion-icon> Current Order</h2>
                                    <div class="order-details" onclick="toggleCurrentOrderDetails(this)">
                                        <div class="order-row">
                                            <span class="icon"><ion-icon name="document-outline"></ion-icon></span>
                                            <strong>Order #<%= currentOrder.getOrderId()%></strong>
                                            <span class="arrow"><i class="fas fa-chevron-down dropdown-current"></i></span>
                                        </div>
                                        <div class="order-row">
                                            <span class="icon"><ion-icon name="restaurant-outline"></ion-icon></span>
                                                    <%= currentOrder.getRestaurantName()%>
                                        </div>
                                        <div class="order-row">
                                            <span class="icon"><ion-icon name="pricetag-outline"></ion-icon></span>
                                                    <%= currentOrder.getAmountPayable()%>
                                        </div>
                                        <div class="order-row">
                                            <span class="icon"><ion-icon name="location-outline"></ion-icon></span>
                                                    <%= currentOrder.getAddress()%>
                                        </div>
                                        <div class="order-row">
                                            <span class="icon"><ion-icon name="checkmark-circle-outline"></ion-icon></span>
                                            Status: <strong class="status">Accepted</strong>
                                        </div>
                                    </div>

                                    <div class="details-row">
                                        <div class="details-container">
                                            <div class="order-menu">
                                                <h4>Order Menu</h4>
                                                <%
                                                    // You can loop through the order items list from the current order object
                                                    for (OrderItem item : currentOrder.getOrderItems()) {
                                                %>
                                                <p><img src="<%=request.getContextPath()%>/<%=item.getImage()%>" alt="<%= item.getItemName()%>"> <%= item.getItemName()%> (x<%=item.getQuantity()%>)</p>
                                                    <%
                                                        }
                                                    %>
                                            </div>

                                            <div class="restaurant-info">
                                                <h4><%= currentOrder.getRestaurantName()%></h4>

                                                <!-- Display restaurant rating dynamically -->
                                                <p><i class="fas fa-star"></i> <%= restaurant.getRating()%> | <%= reviewCount%> Reviews</p> <!-- Display the review count -->

                                                <p>Delivery Time: <strong>30 Min</strong></p>
                                                <p>Address: <strong><%= currentOrder.getRestaurantAddress()%></strong></p>
                                            </div>

                                            <div class="order-summary">
                                                <div class="order-summary-details">
                                                    <span>
                                                        <h4>Status</h4>
                                                        <p><%= currentOrder.getPaymentStatus()%></p>
                                                    </span>
                                                    <span>
                                                        <h4>Date Paid</h4>
                                                        <p><%= currentOrder.getPaymentDate()%></p>
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="order-amt">
                                                <h4>Total</h4>
                                                <p class="total-amount">₹<%= currentOrder.getAmountPayable()%></p>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <%
                                    } catch (Exception e) {
                                        out.println("Error: " + e.getMessage());
                                        e.printStackTrace();
                                    }
                                %>
                            </div>





                            <!-- Statistics Section -->
                            <div class="statistics">
                                <h2><ion-icon name="list-outline"></ion-icon> Delivered Orders</h2>
                                <div class="yourOrders">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Menu</th>
                                                <th>Status</th>
                                                <th>Date</th>
                                                <th>Address</th>
                                                <th>Total</th>
                                                <th>Payment Method</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Row 1 -->
                                            <tr class="order-row" onclick="toggleDetailsGeneral(this)">
                                                <td class="menu">Order #1</td>
                                                <td><span class="status completed">Completed</span></td>
                                                <td class="date">June 1, 2020,<br> 08:22 AM</td>
                                                <td class="address"><i class="fas fa-map-marker-alt"></i> Elm Street, 23 Yogyakarta</td>
                                                <td class="total"><span>$ 5.59</span></td>
                                                <td class="payment-method">Cash</td>
                                                <td class="arrow"><i class="fas fa-chevron-down dropdown"></i></td>
                                            </tr>
                                            <tr class="details-row">
                                                <td colspan="7">
                                                    <div class="details-container">
                                                        <div class="order-menu">
                                                            <h4>Order Menu</h4>
                                                            <p><img src="https://via.placeholder.com/50" alt="Pizza"> Pepperoni Pizza <span>+ $5.59</span></p>
                                                            <p><img src="https://via.placeholder.com/50" alt="Burger"> Cheese Burger <span>+ $5.59</span></p>
                                                        </div>
                                                        <div class="restaurant-info">
                                                            <h4>Fast Food Resto</h4>
                                                            <p><i class="fas fa-star"></i> 5.0 | 1k+ Reviews</p>
                                                            <p>Delivery Time: <strong>10 Min</strong></p>
                                                            <p>Distance: <strong>2.5 Km</strong></p>
                                                        </div>
                                                        <div class="order-summary">
                                                            <div class="order-summary-details">
                                                                <span>
                                                                    <h4>Status</h4>
                                                                    <p>Completed</p>
                                                                </span>
                                                                <span>
                                                                    <h4>Date</h4>
                                                                    <p>June 1, 2020</p></span>
                                                            </div>
                                                            <div class="order-summary-details">
                                                                <span>
                                                                    <h4>Bills</h4>
                                                                    <p>Order #1</p></span>
                                                                <span>
                                                                    <h4>Date Paid</h4>
                                                                    <p>June 1, 2020</p></span>
                                                            </div>
                                                        </div>
                                                        <div class="order-amt">
                                                            <h4>Total</h4>
                                                            <p class="total-amount">$202.00</p>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </main>
            </div>
        </div>

        <!-- Edit Profile Modal -->
        <div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <form action="UpdateDeliveryExecutive" method="post" enctype="multipart/form-data">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editProfileModalLabel">Edit Profile</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Name</label>
                                        <input type="text" class="form-control" id="name" name="name" value="<%= request.getAttribute("name")%>" placeholder="Enter your full name">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email" name="email" value="<%= request.getAttribute("email")%>" placeholder="Enter your email address">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="number" class="form-label">Number</label>
                                        <input type="text" class="form-control" id="number" name="number" value="<%= request.getAttribute("number")%>" placeholder="Enter your phone number">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="address" class="form-label">Address</label>
                                        <input type="text" class="form-control" id="address" name="address" value="<%= request.getAttribute("address")%>" placeholder="Enter your address">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="deliveryArea" class="form-label">Delivery Area Address</label>
                                        <input type="text" class="form-control" id="deliveryArea" name="deliveryArea" value="<%= request.getAttribute("deliveryArea")%>" placeholder="Enter delivery area">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="emergencyContact" class="form-label">Emergency Contact Number</label>
                                        <input type="text" class="form-control" id="emergencyContact" name="emergencyContact" value="<%= request.getAttribute("emergencyContact")%>" placeholder="Enter emergency contact">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="profileImage" class="form-label">Profile Image</label>
                                        <input type="file" class="form-control file-input" id="profileImage" name="profileImage">
                                        <small class="form-text text-muted">Choose a clear, professional image.</small>
                                    </div>
                                </div>
                                <div class="col-md-6 d-flex align-items-center">
                                    <div class="preview-container">
                                        <img id="previewImage" src="https://via.placeholder.com/100" alt="Profile Preview" class="img-thumbnail">
                                        <small class="form-text text-muted">Preview your profile image here.</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Scripts  -->

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


        <!-- Icon Scripts -->

        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <script src="script.js"></script>
    </body>
</html>
