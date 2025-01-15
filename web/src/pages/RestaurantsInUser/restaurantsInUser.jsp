<%@page import="Utilities.Restaurant"%>
<%@page import="java.util.List"%>
<%@page import="Utilities.RestaurantDAO"%>
<%@page import="Utilities.CustomerDAO"%>
<%@page import="Utilities.Customer"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Platera - Popular Restaurants Near You</title>
        <link rel="shortcut icon" href="../../../Public/favicon.png" type="image/x-icon">
        <link rel="stylesheet" href="./restaurantsInUser.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">
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
        <%
            // Retrieve user_id from the session
//            Integer user_id = (Integer) session.getAttribute("user_id");
            int user_id = 201;

            // Initialize necessary variables
            String name = "";
            String email = "";
            int customer_id = 0;
            String image = "";
            String imagepath = "";
            int locationId = 0;
            String location = "";
            String address = "";
            String phone = "";
            boolean twoFA;

            Customer customer = CustomerDAO.getCustomerByUserId(user_id);
            if (customer != null) {
                customer_id = customer.getCustomerId();
                name = customer.getFullName();
                email = customer.getEmail();
                image = customer.getImage();
                locationId = customer.getLocationId();
                location = customer.getLocation();
                address = customer.getAddress();
                phone = customer.getPhone();
                twoFA = customer.isTwoStepVerification();
            }

            // Create image path based on the image file path retrieved
            imagepath = request.getContextPath() + '/' + image;

        %>

        <!-- Add this section for the mobile menu -->

        <div class="mobile-menu" id="mobile-menu">
            <ul class="mobile-nav-links">
                <li><a href="../Customer/Home.jsp" target="_blank">Home</a></li>
                <li id="active"><a href="./restaurantsInUser.jsp" target="_blank">Restaurants</a></li>
                <li><a href="../Menu/menu.jsp" target="_blank">Menu</a></li>
                <li><a href="../ContactUs/ContactUs.html" target="_blank">Contact Us</a></li>
            </ul>
        </div>

        <section class="banner">
            <div class="banner-content">
                <h2>Best restaurants Near You</h2>
                <form action="http://localhost:8080/Platera-Main/Search">
                    <div class="search-bar">
                        <select name="keywordType" id="search-category">
                            <option value="restaurants">Restaurants</option>
                            <option value="dishes">Dishes</option>
                        </select>
                        <input type="text" name="keyword" id="search-input" placeholder="Search for restaurants or dishes..." />
                        <button id="search-button">Search</button>
                    </div>
                </form>
            </div>
        </section>

        <section class="restaurants-section">
            <h2>Popular Restaurants</h2>
            <div class="restaurants-container">
                <%                                                // Instantiate the DAO and fetch the list of restaurants
                    RestaurantDAO restaurantDAO = new RestaurantDAO();
                    List<Restaurant> restaurants = restaurantDAO.getRestaurantsByLocation(locationId);

                    if (restaurants != null && !restaurants.isEmpty()) {
                        for (Restaurant restaurant : restaurants) {
                %>
                <a href="../Customer/RestaurantDetails/RestaurantDetails.jsp?restaurantId=<%= restaurant.getRestaurantId()%>" class="restaurant-card-link">
                    <div class="restaurant-card">

                        <img src="<%= request.getContextPath()%>/<%= restaurant.getImage()%>"
                             alt="<%= restaurant.getName()%>"
                             class="restaurant-image"
                             />
                        <h3><%= restaurant.getName()%></h3>
                        <p>⭐ <%= restaurant.getRating()%> | ₹<%= restaurant.getMinPrice()%>-₹<%= restaurant.getMaxPrice()%></p>
                        <p><%= restaurant.getCategory1()%>, <%= restaurant.getCategory2()%>, <%= restaurant.getCategory3()%></p>
                        <p class="location"><%= restaurant.getLocation()%></p>
                    </div>
                </a>
                <%
                    }
                } else {
                %>
                <p>No restaurants found or there was an error fetching data.</p>
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
