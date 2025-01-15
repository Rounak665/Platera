<%@page import="Utilities.CustomerDAO"%>
<%@page import="Utilities.Customer"%>
<%@page import="Utilities.CartDAO"%>
<%@page import="Utilities.MenuItemsDAO"%>
<%@page import="Utilities.MenuItems"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Platera - Search Result for Menu Items</title>
        <link rel="shortcut icon" href="../../../Public/favicon.png" type="image/x-icon">
        <!-- <link rel="stylesheet" href="./restaurantsInUser.css"> -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/src/pages/search/style.css">

    </head>
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
                </div>
                <ul class="nav-links">
                    <li><a href="../Customer/Home.jsp" target="_blank">Home</a></li>
                    <li ><a href="./restaurantsInUser.jsp" target="_blank">Restaurants</a></li>
                    <li id="active"><a href="../Menu/menu.jsp" target="_blank">Menu</a></li>
                    <li><a href="../ContactUs/ContactUs.html" target="_blank">Contact Us</a></li>
                </ul>

                <div class="hamburger-menu" id="hamburger-menu">
                    <i class="fa-solid fa-bars"></i>
                </div>
            </nav>

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
            <%                //Dynamic values from session//
//                String keyword = (String) session.getAttribute("keyword");
                //               String locationIdString = (String) session.getAttribute("locationId");
                //              int locationId = locationIdString != null ? Integer.parseInt(locationIdString) : 0;
//                 Static values for keyword and location
                String keyword = "paneer";
                int locationId = 1;
            %>
            <div class="banner-content">
                <h2>Search results for <%= keyword%></h2>
            </div>
        </section>

        <section class="restaurants-section">
            <div class="restaurants-container">
                <%

                    // Create a MenuItemsDAO instance and fetch menu items based on keyword and location
                    MenuItemsDAO menuItemsDAO = new MenuItemsDAO();
                    List<MenuItems> menuItemsList = menuItemsDAO.getMenuItemsByKeyword(keyword, locationId);

                    // Check if results are not empty and display them
                    if (!menuItemsList.isEmpty()) {
                        for (MenuItems menuItem : menuItemsList) {
                %>
                <!-- Menu Item Card -->
                <a href="../Customer/RestaurantDetails/RestaurantDetails.jsp?restaurantId=<%= menuItem.getRestaurantId()%>" class="restaurant-card-link">                             
                    <div class="restaurant-card">
                        <img src="<%=request.getContextPath()%>/<%= menuItem.getImage()%>" alt="<%= menuItem.getItemName()%>" />
                        <h3><%= menuItem.getItemName()%></h3>
                        <p>Price: ₹<%= menuItem.getPrice()%></p>
                        <p>Type: <%= menuItem.getCategoryName()%></p>
                        <p>Restaurant: <%= menuItem.getRestaurantName()%></p>
                        <%
                            CartDAO cartDAO = new CartDAO();
                            boolean isInCart = cartDAO.isItemInCart(customer_id, menuItem.getItemId());
                        %>

                        <form action="http://localhost:8080/Platera-Main/AddToCart" method="POST" style="<%= isInCart ? "display:none;" : " "%>">
                            <input type="hidden" name="customerId" value="<%= customer_id%>" />
                            <input type="hidden" name="restaurantId" value="<%= menuItem.getRestaurantId()%>" />
                            <input type="hidden" name="itemId" value="<%= menuItem.getItemId()%>" />
                            <button type="submit" class="add-to-cart-btn">Add to Cart</button>
                        </form>
                        <button onclick="return toCartpage();" style="<%= isInCart ? "" : "display:none;"%>" class="view-cart-btn">Go to Cart</button>
                    </div>
                </a>
                <%
                    }
                } else {
                %>
                <p>No menu items found for your search criteria.</p>
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

        <script>
            function toCartpage() {
                // Redirect to the cart page
                window.location.href = "../Customer/Home.jsp#cartSection";
                return false; // Prevents default behavior if needed
            }
        </script>
        <script src="./restaurantsInUser.js"></script>
        <script src="../../../error.js"></script>
    </body>
</html>
