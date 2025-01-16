<%@page import="Utilities.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Utilities.Restaurant"%>
<%@page import="java.util.List"%>
<%@page import="Utilities.RestaurantDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Platera - Search Result for Restaurants</title>
        <link rel="shortcut icon" href="../../../Public/favicon.png" type="image/x-icon">
        <!-- <link rel="stylesheet" href="./restaurantsInUser.css"> -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="./style.css">

    </head>
    <body>


        <!-- Loader -->
        <div class="loader">
            <div id="pl">
                <div>
                    <video class="vid" src="../ContactUs/Assets/loader.mp4" autoplay muted loop></video>
                </div>
            </div>
        </div>

        <!-- Error Popup -->
        <div class="error-popup" id="errorPopup">
            <div class="error-content">
                <h2>Error</h2>
                <p id="errorMessage">An error has occurred. Please try again later.</p>
                <button id="closeErrorPopup">Go Back</button>
            </div>
        </div>

        <header>
            <nav class="navbar">
                <div class="nav-left">
                    <a href="../Customer/Home.jsp"><img src="./assets/PlateraLogo-red.png" alt="Logo" class="logo"></a>
                    <!-- <div class="search-container">
                        <input
                            type="text"
                            id="location-search"
                            class="location-search"
                            placeholder="Search for a location..."
                            /> 
                        <button class="select-location-btn" onclick="selectLocation()">
                            &#x2192;
                        </button>
                         Arrow button -->
                    <!-- </div>
                    <span id="selected-location" class="selected-location">Selected Location: None</span> -->
                </div>
                <ul class="nav-links">
                    <li><a href="../Customer/Home.jsp" target="_blank">Home</a></li>
                    <li id="active"><a href="./restaurantsInUser.jsp" target="_blank">Restaurants</a></li>
                    <li><a href="../Menu/menu.jsp" target="_blank">Menu</a></li>
                    <li><a href="../ContactUs/ContactUs.html" target="_blank">Contact Us</a></li>
                </ul>
                <!-- <div class="nav-icons">
                    <i class="profile-icon fa-solid" id="profile-icon">&#128100;</i>
                    <i class="cart-icon fa-solid" id="cart-icon">&#128722;</i>
                </div> -->
                <div class="hamburger-menu" id="hamburger-menu">
                    <i class="fa-solid fa-bars"></i>
                </div>
            </nav>
            <!-- <section class="side-section profile-section" id="profile-section">
                <button class="close-btn" id="profile-close-btn">&times;</button>
                <p>Profile Section</p>
            </section>
            <section class="side-section cart-section" id="cart-section">
                <button class="close-btn" id="cart-close-btn">&times;</button>
                <p>Cart Section</p>
            </section> -->
        </header>


        <!-- Add this section for the mobile menu -->
        <!--      
            <div class="mobile-menu" id="mobile-menu">
                <ul class="mobile-nav-links">
                    <li><a href="../Customer/Home.jsp" target="_blank">Home</a></li>
                    <li id="active"><a href="./restaurantsInUser.jsp" target="_blank">Restaurants</a></li>
                    <li><a href="../Menu/menu.jsp" target="_blank">Menu</a></li>
                    <li><a href="../ContactUs/ContactUs.html" target="_blank">Contact Us</a></li>
                </ul>
            </div> -->

        <section class="banner">
            <%
                // Fetch session values for keyword and locationId

               String keyword = (String) session.getAttribute("keyword");
                String locationIdString = (String) session.getAttribute("locationId");
                int locationId = locationIdString != null ? Integer.parseInt(locationIdString) : 1;
//                String keyword = "c";
//                int locationId = 1;
            %>
            <div class="banner-content">
                <h2>Search Results For <%=keyword%></h2>
            </div>
        </section>

        <section class="restaurants-section">
            <div class="restaurants-container">
                <%
                    // Check if both keyword and locationId are available
                    if (keyword != null && locationId != 0) {
                        // Create a RestaurantDAO instance and fetch restaurant details based on keyword and location
                        RestaurantDAO restaurantDAO = new RestaurantDAO();
                        List<Restaurant> restaurantList = restaurantDAO.getRestaurantsByKeyword(keyword, locationId);

                        // Check if results are not empty and display them
                        if (!restaurantList.isEmpty()) {
                            for (Restaurant restaurant : restaurantList) {
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
                                    ps.setInt(1, restaurant.getRestaurantId());

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
                <!-- Restaurant Card -->
                <a href="../Customer/RestaurantDetails/RestaurantDetails.jsp?restaurantId=<%= restaurant.getRestaurantId()%>" class="restaurant-card-link">
                    <div class="restaurant-card">
                        <img src="<%=request.getContextPath()%>/<%= restaurant.getImage()%>" alt="<%= restaurant.getName()%>" />
                        <h3><%= restaurant.getName()%></h3>
                        <p><%= restaurant.getCategory1()%>,<%= restaurant.getCategory2()%>,<%= restaurant.getCategory3()%></p>
                        <p>Location: <%= restaurant.getAddress()%></p>
                        <p>⭐ <%= restaurant.getRating()%>(<%=reviewCount%>) | ₹<%= restaurant.getMinPrice()%>-₹<%= restaurant.getMaxPrice()%></p>
                    </div>
                </a>
                <%
                    }
                } else {
                %>
                <p>No restaurants found for your search criteria.</p>
                <%
                    }
                } else {
                %>
                <p>Invalid search parameters.</p>
                <%
                    }
                %>
            </div>
        </section>

        <!-- Footer Section -->

        <footer>
            <div class="container_footer">
                <div class="row">
                    <div class="col">
                        <img src="./assets/PlateraLogo-red.png" alt="" />
                        <p>
                            Platera delivers delicious meals from your favorite local
                            restaurants straight to your door, combining speed and convenience
                            with every order. From quick bites to gourmet dishes, enjoy a
                            world of flavors anytime, anywhere!
                        </p>
                    </div>
                    <div class="col">
                        <h3>
                            Office
                            <div class="underline"><span></span></div>
                        </h3>
                        <p>ITFL Road</p>
                        <p>Whitefield, Bangalore</p>
                        <p>Karnatak, PIN 568629, INDIA</p>
                        <p class="email_id">support@platera.in</p>
                        <h4>+91 - 1234567891</h4>
                    </div>
                    <div class="col">
                        <h3>
                            Links
                            <div class="underline"><span></span></div>
                        </h3>
                        <ul>
                            <li>
                                <a
                                    href="../FooterLinkPages/Terms&Conditions/Terms&Conditions.html"
                                    target="_blank">Terms & Conditions</a
                                >
                            </li>
                            <li>
                                <a href="../FooterLinkPages/PrivacyPolicy/PrivacyPolicy.html"
                                   target="_blank">Privacy Policy</a
                                >
                            </li>
                            <li><a href="../FooterLinkPages/Help/Help.html" target="_blank">Help</a></li>
                        </ul>
                    </div>
                    <div class="col">
                        <h3>
                            Newsletter
                            <div class="underline"><span></span></div>
                        </h3>
                        <form>
                            <i class="fa-solid fa-envelope"></i>
                            <input
                                type="email"
                                name=""
                                id=""
                                placeholder="Enter Your Email Address"
                                />
                            <button type="submit">
                                <i class="fa-solid fa-arrow-right"></i>
                            </button>
                        </form>
                        <div class="social_icon">
                            <i class="fa-brands fa-facebook"></i>
                            <i class="fa-brands fa-instagram"></i>
                            <i class="fa-brands fa-pinterest"></i>
                            <i class="fa-brands fa-x-twitter"></i>
                        </div>
                    </div>
                </div>
            </div>
            <hr />
            <p class="copyright">Platera @2024 - All Rights Reserved</p>
        </footer>


        <script src="./restaurantsInUser.js"></script>
        <script src="../../../error.js"></script>
    </body>
</html>
