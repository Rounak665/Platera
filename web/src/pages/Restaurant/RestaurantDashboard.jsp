<%@page import="Utilities.Location"%>
<%@page import="Utilities.LocationDAO"%>
<%@page import="Utilities.OrderItem"%>
<%@page import="Utilities.OrderDetails"%>
<%@page import="Utilities.OrderDetailsDAO"%>
<%@page import="Utilities.RestaurantDAO"%>
<%@page import="Utilities.Restaurant"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="Utilities.Database"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.SQLException"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Platera - Restaurant Dashboard Overview</title>
        <link rel="shortcut icon" href="../../../Public/favicon.png" type="image/x-icon">
        <link rel="stylesheet" href="./RestaurantDashboard.css"> 
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            th{
                text-align: center;
            }
        </style>
    </head>
    <body>
        <%
            // Simulate session attributes for debugging
            int user_id = (Integer) session.getAttribute("user_id");
//            int user_id = 311;

            int restaurantId = 0; // Default value for int
            String name = null;
            String address = null;
            String phone = null;
            String locationName = null;
            int locationId = 0;
            double minPrice = 0.0; // Default value for double
            double maxPrice = 0.0; // Default value for double
            double avgRating = 0.0; // Default value for double
            String category1 = null;
            String category2 = null;
            String category3 = null;
            String imagePath = null;

            // Owner details
            String ownerName = null;
            String ownerPhone = null;
            String ownerAddress = null;
            String ownerEmail = null;
            boolean twoFA = false; // Default value for boolean

            Restaurant restaurant = null;

            RestaurantDAO restaurantDAO = new RestaurantDAO();
            restaurant = restaurantDAO.getRestaurantByUserId(user_id);

            if (restaurant != null) {
                restaurantId = restaurant.getRestaurantId();
                name = restaurant.getName();
                address = restaurant.getAddress();
                phone = restaurant.getPhone();
                locationId = restaurant.getLocationId();
                locationName = restaurant.getLocation();
                minPrice = restaurant.getMinPrice();
                maxPrice = restaurant.getMaxPrice();
                avgRating = restaurant.getRating();
                category1 = restaurant.getCategory1();
                category2 = restaurant.getCategory2();
                category3 = restaurant.getCategory3();
                imagePath = request.getContextPath() + '/' + restaurant.getImage();

                // Owner details
                ownerName = restaurant.getOwnerName();
                ownerPhone = restaurant.getOwnerPhone();
                ownerAddress = restaurant.getOwnerAddress();
                ownerEmail = restaurant.getOwnerEmail();
                twoFA = restaurant.isTwoStepVerification();

            }
        %>
        <!-- Error Popup -->
        <div class="error-popup" id="errorPopup">
            <div class="error-content">
                <h2>Error</h2>
                <p id="errorMessage">An error has occurred. Please try again later.</p>
                <button id="closeErrorPopup">Go Back</button>
            </div>
        </div>

        <!-- loader -->
        <div class="loader">
            <div id="pl">
                <div>
                    <video class="vid" src="../ContactUs/Assets/loader.mp4" autoplay muted loop></video>
                </div>
            </div>
        </div>

        <!-- Two step Verification -->

        <div id="security-section" class="security-container" style="display: none;">
            <div class="security-card">
                <span class="sec-close-btn" id="closeSecuritySection">&times;</span>
                <div class="security-header">
                    <i class="fas fa-lock lock-icon"></i>
                    <h2>Two-factor Authentication</h2>
                </div>
                <p class="security-description">
                    Enhance your security by setting up two-factor authentication (2FA) on your registered email.
                </p>
                <form id="twoFAForm" method="post" action="http://localhost:8080/Platera-Main/UpdateTwoFAStatus">
                    <input type="hidden" value="<%=user_id%>" name="userId">
                    <div class="security-option">
                        <div class="security-description">
                            <label class="option-title">
                                <span>Text Message</span> <span class="option-subtitle">EMAIL</span>
                            </label>
                            <p class="option-description">
                                Get a one-time passcode through email.
                            </p>
                        </div>
                        <label class="switch">
                            <!-- Dynamically set the 'checked' attribute based on the 'twoFA' variable -->
                            <input type="checkbox" id="email-toggle" name="twoFA" <%=twoFA ? "checked" : ""%> />
                            <span class="slider round"></span>
                        </label>
                    </div>
                    <div class="security-footer">
                        <button type="button" id="cancel-btn" class="btn cancel-btn">Cancel</button>
                        <button type="submit" id="save-btn" class="btn save-btn">Save changes</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- sliding profile settings -->

        <section class="setting-section" id="setSection">
            <div class="setting-container" id="settingContainer">
                <span class="close-btn" id="closeSetSection">&times;</span>
                <div class="setting-header">
                    Profile Setttings
                </div>
                <ul class="setting-options">
                    <li id="editProfile"><i class="fas fa-user-edit"></i> Edit your profile</li>
                    <li><i class="fas fa-key"></i><a href="../ForgotPassword/ForgotPassword.jsp"> Change Password</a></li>
                    <li id="setSecure"><i class="fas fa-shield-alt"></i> Security</li>
                    <li><i class="fas fa-file-alt"></i> <a href="../FooterLinkPages/PrivacyPolicy/PrivacyPolicy.html">Privacy Policy</a></li>
                    <li><i class="fas fa-file-contract"></i> <a href="../FooterLinkPages/Terms&Conditions/Terms&Conditions.html">Terms and Conditions</a></li>
                    <li><i class="fa-solid fa-circle-info"></i><a href="../FooterLinkPages/Help/Help.html">Help</a></li>
                    <li id="delete-acc">
                        <i class="fas fa-trash-alt"></i>
                        <form action="http://localhost:8080/Platera-Main/DeleteUser" method="POST" onsubmit="return confirmDelete()">
                            <input type="hidden" name="userId" value="<%=user_id%>">
                            <button type="submit" class="delete-btn">
                                <span>Delete Account</span>
                            </button>
                        </form>
                    </li>
                </ul>
            </div>

            <!-- edit section -->
            <div class="modal-content" id="modalContent" style="display: none;">
                <span class="close-btn" id="closeEditSection">&times;</span>

                <div class="modal-header">
                    Edit Profile
                </div>
                <div class="modal-body">
                    <form action="http://localhost:8080/Platera-Main/UpdateRestaurantProfile" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="user_id" value="<%=user_id%>">
                        <input type="hidden" name="restaurant_id" value="<%=restaurantId%>">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="profileImage" class="form-label">Profile Image</label>
                                    <input type="file" class="form-control file-input" id="photo-input" name="profileImage" accept="image/*">
                                    <small class="form-text text-muted">Choose a clear image.</small>
                                </div>
                            </div>
                            <div class="col-md-6 d-flex align-items-center">
                                <div class="preview-container">
                                    <img id="profile-photo-preview" src="<%= imagePath%>" alt="Profile Preview" class="img-thumbnail">
                                    <small class="form-text text-muted">Preview your restaurant image here.</small>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Restaurant Name</label>
                                    <input type="text" class="form-control" id="name" name="restaurant-name" value="<%=name%>" placeholder="Enter your full name">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Owner Name</label>
                                    <input type="text" class="form-control" id="name" name="owner-name" value="<%=ownerName%>" placeholder="Enter your full name">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="number" class="form-label">Restaurant Phone No.</label>
                                    <input type="text" class="form-control" id="number" name="restaurant-phone" value="<%=phone%>" placeholder="Enter your phone number">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="number" class="form-label">Owner Phone No.</label>
                                    <input type="text" class="form-control" id="number" name="owner-phone" value="<%=ownerPhone%>" placeholder="Enter your phone number">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="address" class="form-label">Restaurant Address</label>
                                    <input type="text" class="form-control" id="address" name="restaurant-address" value="<%=address%>" placeholder="Enter your address">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="address" class="form-label">Owner Address</label>
                                    <input type="text" class="form-control" id="address" name="owner-address" value="<%=ownerAddress%>" placeholder="Enter your address">
                                </div>
                            </div>
                            <!-- Vehicle Type Dropdown -->
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" id="cancelModal" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>

                </div>
            </div>
        </section>

        <div>
            <div class="sidebar">
                <div class="sidebar-toggle menu" id="menu">
                    <ion-icon name="menu"></ion-icon>
                </div>
                <div class="sidebar-toggle close-btn"><ion-icon name="close-outline" class="icon"></ion-icon></div>
                <div class="sidebar-header">
                    <div class="logo">
                        <img src="../../../Public/images/logo.png" alt="">
                    </div>
                </div>

                <div class="sidebar-menu">
                    <ul>
                        <li>
                            <a href="./RestaurantDashboard.jsp">
                                <span class="icon"><ion-icon name="home-sharp"></ion-icon></span>
                                <span>Home</span>
                            </a>
                        </li>
                        <li>
                            <a href="./RestaurantCategory.jsp">
                                <span class="icon"><ion-icon name="grid"></ion-icon></span>
                                <span>Categories</span>
                            </a>
                        </li>
                        <li>
                            <a href="./RestaurantMenu.jsp">
                                <span class="icon"><ion-icon name="book"></ion-icon></span>
                                <span>Menu</span>
                            </a>
                        </li>
                        <li>
                            <a href="./RestaurantOrders.jsp">
                                <span class="icon"><ion-icon name="cart"></ion-icon></span>
                                <span>Orders</span>
                            </a>
                        </li>

                        <li class="logoutOption">
                            <form action="http://localhost:8080/Platera-Main/logout" method="POST">                          
                                <button type="submit"><span class="icon"><ion-icon name="log-out-outline"></ion-icon></span>Logout</button>
                            </form>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="main-content">
                <header>

                    <div class="log-set">
                        <div class="social-icons">
                            <a href="http://localhost:8080/Platera-Main/logout" class="logout-link">
                                <div class="logout_btn">
                                    <span class="logout">Logout</span>
                                    <span class="icon"><ion-icon name="power"></ion-icon></span>
                                </div>
                            </a>
                        </div>
                        <i class="fas fa-cog settings-icon" id="setIcon" style="margin-top: 9px;"></i>
                    </div>
                </header>

                <main>
                    <h2 class="dash-title">Overview</h2>

                    <div class="dash-cards">
                        <div class="card-single">
                            <div class="card-body">
                                <span class="icon"><ion-icon name="card"></ion-icon></span>
                                <div>
                                    <h5>Account Balance</h5>
                                    <h4>₹30,659.45</h4>
                                </div>
                            </div>
                            <div class="card-footer">
                                <a href="">View all</a>
                            </div>
                        </div>

                        <div class="card-single">
                            <div class="card-body">
                                <span class="icon"><ion-icon name="sync"></ion-icon></span>
                                <div>
                                    <h5>Pending</h5>
                                    <h4>₹19,500.45</h4>
                                </div>
                            </div>
                            <div class="card-footer">
                                <a href="">View all</a>
                            </div>
                        </div>

                        <div class="card-single">
                            <div class="card-body">
                                <span class="icon"><ion-icon name="checkbox"></ion-icon></span>
                                <div>
                                    <h5>Processed</h5>
                                    <h4>₹20,659</h4>
                                </div>
                            </div>
                            <div class="card-footer">
                                <a href="">View all</a>
                            </div>
                        </div>
                    </div>


                    <section class="recent">
                        <div class="activity-card">
                            <h3>Recent Orders</h3>
                            <div class="table-responsive">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Order ID</th>
                                            <th>Customer Name</th>
                                            <th>Order Date</th>
                                            <th>Items</th>
                                            <th>Total Amount</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            // Initialize DAO and fetch order details
                                            OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
                                            List<OrderDetails> recentOrders = orderDetailsDAO.getOrderDetailsByRestaurantId(restaurantId); // Fetch data dynamically

                                            // Loop through fetched orders and display them
                                            if (recentOrders != null && !recentOrders.isEmpty()) {
                                                for (OrderDetails order : recentOrders) {
                                        %>
                                        <tr>
                                            <td><%= order.getOrderId()%></td>
                                            <td><%= order.getCustomerName()%></td>
                                            <td><%= order.getOrderDate()%></td>
                                            <td>
                                                <%
                                                    // Display all items for the current order
                                                    List<OrderItem> items = order.getItems(); // Assuming getItems() returns a list of OrderItem
                                                    if (items != null && !items.isEmpty()) {
                                                        for (OrderItem item : items) {
                                                            String itemName = item.getItemName();
                                                            int quantity = item.getQuantity();
                                                            String itemImage = item.getImage(); // Assuming this returns the image path
%>
                                                <%= itemName%> (x<%= quantity%>),                                                    
                                                <%
                                                        }
                                                    }
                                                %>

                                            </td>
                                            <td><%= order.getTotalAmount()%></td>
                                            <td><%= order.getOrderStatus()%></td>
                                        </tr>
                                        <%
                                            }
                                        } else {
                                        %>
                                        <tr>
                                            <td colspan="6">No recent orders available.</td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </section>

                </main>
            </div>
        </div>

        <!-- Scripts  -->

        <!-- Icon Scripts -->

        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

        <!-- main scripts -->

        <script src="RestaurantDashboard.js"></script>
        <script>
                            // Confirmation for deleting account
                            function confirmDelete() {
                                return confirm("Are you sure you want to delete your account? This action cannot be undone.");
                            }
        </script>
        <script>
            document.querySelector("#menu").addEventListener("click", function () {
                document.querySelector(".sidebar").classList.add("activate");
            });

            document.querySelector(".sidebar .close-btn").addEventListener("click", function () {
                document.querySelector(".sidebar").classList.remove("activate");
            });
        </script>
        <script>
            // JavaScript to handle the photo preview
            document.getElementById('photo-input').addEventListener('change', function (event) {
                const file = event.target.files[0]; // Get the selected file
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        // Update the img src in the preview div
                        document.getElementById('profile-photo-preview').src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            });
        </script>


        <script src="../../../error.js"></script>
    </body>
</html>
