<%@page import="Utilities.CartDAO"%>
<%@page import="java.util.List"%>
<%@page import="Utilities.CustomerDAO"%>
<%@page import="Utilities.Customer"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Platera - Categories</title>
        <link rel="shortcut icon" href="../../../Public/favicon.png" type="image/x-icon">
        <link rel="stylesheet" href="./categories.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <%
        // Retrieve user_id from the session
            Integer user_id = (Integer) session.getAttribute("user_id");
//        int user_id = 201;

        // Initialize necessary variables
        String name = "";
        String email = "";
        int customer_id = 0;
        String image = "";
        String imagepath = "";
        int location_id = 0;
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
            location_id = customer.getLocationId();
            location = customer.getLocation();
            address = customer.getAddress();
            phone = customer.getPhone();
            twoFA = customer.isTwoStepVerification();
        }

        // Create image path based on the image file path retrieved
        imagepath = request.getContextPath() + '/' + image;

    %>
    <body>
        <!-- Error Popup -->
        <div class="error-popup" id="errorPopup">
            <div class="error-content">
                <h2>Error</h2>
                <p id="errorMessage">An error has occurred. Please try again later.</p>
                <button id="closeErrorPopup">Go Back</button>
            </div>
        </div>

        <!-- Header section -->
        <header>
            <nav class="navbar">
                <div class="nav-left">
                    <img src="../Assets/PlateraLogo-red.png" alt="Logo" class="logo">
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
                    <li><a href="../../Customer/Home.jsp">Home</a></li>
                    <li><a href="../../RestaurantsInUser/restaurantsInUser.jsp">Restaurants</a></li>
                    <li id="active"><a href="">Menu</a></li>
                    <li><a href="../../ContactUs/ContactUs.html">Contact Us</a></li>
                </ul>
                <!--                <div class="nav-icons">
                                    <i class="profile-icon fa-solid" id="profile-icon">&#128100;</i>
                                    <i class="cart-icon fa-solid" id="cart-icon">&#128722;</i>
                                </div>-->
                <div class="hamburger-menu" id="hamburger-menu">
                    <i class="fa-solid fa-bars"></i>
                </div>
            </nav>
            <section class="side-section profile-section" id="profile-section">
                <button class="close-btn" id="profile-close-btn">&times;</button>
                <p>Profile Section</p>
            </section>
            <section class="side-section cart-section" id="cart-section">
                <button class="close-btn" id="cart-close-btn">&times;</button>
                <p>Cart Section</p>
            </section>
        </header>


        <!-- Banner section -->
        <section class="banner">
            <%        // Static category ID for demonstration
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
//                int categoryId = 14; 
                Utilities.MenuItemsDAO menuItemsDAO = new Utilities.MenuItemsDAO();
                List<Utilities.MenuItems> menuItemsList = menuItemsDAO.getMenuItemsByCategoryIdAndLocation(categoryId, location_id);

                // Initialize category name with a default message
                String categoryName = "Unknown Category";

                // Check if menuItemsList is not empty before accessing its first element
                if (menuItemsList != null && !menuItemsList.isEmpty()) {
                    categoryName = menuItemsList.get(0).getCategoryName();
                }
            %>
            <div class="banner-content">
                <h2>Top Menu Items for <%= categoryName%></h2>
            </div>
        </section>

        <div class="popular-dishes">
            <div class="dish-cards">
                <%
                    // Check if menu items exist for the category
                    if (menuItemsList != null && !menuItemsList.isEmpty()) {
                        for (Utilities.MenuItems menuItem : menuItemsList) {
                %>
                <div class="dish-card">
                    <img src="<%= request.getContextPath()%>/<%= menuItem.getImage()%>" alt="<%= menuItem.getItemName()%>">
                    <h3><%= menuItem.getItemName()%></h3>
                    <p>Restaurant: <%= menuItem.getRestaurantName()%></p>
                    <p>Price: ₹<%= menuItem.getPrice()%></p>
                    <p>Category: <%= menuItem.getCategoryName() != null ? menuItem.getCategoryName() : "N/A"%></p>
                    <p>Availability: <%= menuItem.isAvailability() ? "Available" : "Not Available"%></p>
                    <%
                        CartDAO cartDAO = new CartDAO();
                        boolean isInCart = cartDAO.isItemInCart(customer_id, menuItem.getItemId());
                    %>
                    <form action="http://localhost:8080/Platera-Main/AddToCart" method="POST" style="<%= isInCart ? "display:none;" : ""%>">
                        <input type="hidden" name="customerId" value="<%= customer_id%>" />
                        <input type="hidden" name="restaurantId" value="<%= menuItem.getRestaurantId()%>" />
                        <input type="hidden" name="itemId" value="<%= menuItem.getItemId()%>" />
                        <button type="submit" class="add-to-cart">Add to Cart</button>
                    </form>
                    <a href="../Home.jsp#cartSection" style="<%= isInCart ? "" : "display:none;"%>">
                        <button class="view-cart">Go to Cart</button>
                    </a>
                </div>
                <%
                    }
                } else {
                %>
                <p>No menu items available for this category.</p>
                <%
                    }
                %>
            </div>
        </div>



        <section class="blank-section">

        </section>

        <footer>
            <div class="container_footer">
                <div class="row">
                    <div class="col">
                        <img src="../Assets/PlateraLogo-red.png" alt="" />
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
                                    >Terms & Conditions</a
                                >
                            </li>
                            <li>
                                <a href="../FooterLinkPages/PrivacyPolicy/PrivacyPolicy.html"
                                   >Privacy Policy</a
                                >
                            </li>
                            <li><a href="../FooterLinkPages/Help/Help.html">Help</a></li>
                        </ul>
                    </div>
                    <div class="col promotion">
                        <h3>
                            Newsletter
                            <div class="underline"><span></span></div>
                        </h3>
                        <form>
                            <img id="mail" src="./Public/images/mail.png" alt="" />
                            <input
                                id="newsletter-email"
                                type="email"
                                name=""
                                id=""
                                placeholder="Enter Your Email Address"
                                />
                            <button type="submit">
                                <img id="send" src="./Public/images/send.png" alt="" />
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


    </body>
</html>