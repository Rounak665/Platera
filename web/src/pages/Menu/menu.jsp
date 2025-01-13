<%@page import="Utilities.CartDAO"%>
<%@page import="Utilities.CustomerDAO"%>
<%@page import="Utilities.Customer"%>
<%@ page import="java.util.*, Utilities.MenuItemsDAO, Utilities.MenuItems" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Food Delivery Menu</title>
        <link rel="stylesheet" href="./menu.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
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

            System.out.println(location_id);

        %>

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
                    <img src="./Assets/PlateraLogo-red.png" alt="Logo" class="logo">
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
                    <li><a href="../Customer/Home.jsp">Home</a></li>
                    <li><a href="../RestaurantsInUser/restaurantsInUser.jsp">Restaurants</a></li>
                    <li id="active"><a href="./menu.jsp">Menu</a></li>
                    <li><a href="#contact">Contact Us</a></li>
                </ul>
                <div class="nav-icons">
                    <i class="profile-icon fa-solid" id="profile-icon">&#128100;</i>
                    <i class="cart-icon fa-solid" id="cart-icon">&#128722;</i>
                </div>
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

        <section class="banner">
            <div class="banner-content">
                <h2>Welcome to Our Menu and Cuisines</h2>
                <div class="search-bar">
                    <select id="search-category">
                        <option value="dishes">Dishes</option>
                        <option value="cuisines">Cuisines</option>
                    </select>
                    <input type="text" id="search-input" placeholder="Search for Dishes or Cuisines..." />
                    <button id="search-button">Search</button>
                </div>
            </div>
        </section>

        <div class="dishes">
            <h2>Our Dishes</h2>
            <div class="carousel-container">
                <button class="carousel-button prev"><i class="fa-solid fa-angle-left"></i></button>
                <div class="carousel-track-container">
                    <ul class="carousel-track">
                        <%            MenuItemsDAO menuItemsDAO = new MenuItemsDAO();
                            List<MenuItems> menuItems = menuItemsDAO.getMenuItemsByLocation(location_id);
                        %>
                        <% for (MenuItems item : menuItems) {%>
                        <li class="carousel-slide">
                            <img src="<%=request.getContextPath()%>/<%= item.getImage()%>" alt="<%= item.getItemName()%>">
                            <h3><%= item.getItemName()%></h3>
                        </li>
                        <% } %>
                    </ul>
                </div>

                <button class="carousel-button next"><i class="fa-solid fa-angle-right"></i></button>
            </div>
        </div>

        <div class="cuisines">
            <h2>Our Cuisines</h2>
            <div class="cuisine-list">
                <%            Utilities.CategoryDAO categoryDAO = new Utilities.CategoryDAO();
                    List<Utilities.Category> categories = categoryDAO.getAllCategories();

                    for (Utilities.Category category : categories) {
                %>
                <div class="cuisine">
                    <img src="<%= request.getContextPath() + "/" + category.getImage()%>" alt="<%= category.getName()%>">
                    <h3><%= category.getName()%></h3>
                </div>
                <% } %>
            </div>
        </div>


        <div class="popular-dishes">
            <h2>Popular Dishes</h2>
            <%
                MenuItemsDAO menuItemsDAORandom = new MenuItemsDAO();
                List<MenuItems> menuItemsRandom = menuItemsDAORandom.getMenuItemsByLocation(location_id);
                Collections.shuffle(menuItemsRandom); // Randomize the list
            %>

            <div class="dish-cards">
                <%
                    int count = 0; // Counter to track the number of displayed dishes
                    for (MenuItems item : menuItemsRandom) {
                        if (count == 4) {
                            break; // Stop after displaying 4 dishes
                        }
                        count++;
                %>
                <div class="dish-card">
                    <img src="<%=request.getContextPath()%>/<%= item.getImage()%>" alt="<%= item.getItemName()%>">
                    <h3><%= item.getItemName()%></h3>
                    <p>Restaurant: <%= item.getRestaurantName()%></p>
                    <p>Price: $<%= item.getPrice()%></p>
                    <p>Quantity: 1</p>
                    <%
                        CartDAO cartDAO = new CartDAO();
                        boolean isInCart = cartDAO.isItemInCart(customer_id, item.getItemId());
                    %>
                    <form action="http://localhost:8080/Platera-Main/AddToCart" method="POST" style="<%= isInCart ? "display:none;" : ""%>">
                        <input type="hidden" name="customerId" value="<%= customer_id%>" />
                        <input type="hidden" name="itemId" value="<%= item.getItemId()%>" />
                        <button type="submit" class="add-to-cart">Add to Cart</button>
                    </form>

                    <!-- Go to Cart button -->
                    <a href="../Home.jsp#cartSection" style="<%= isInCart ? "" : "display:none;"%>">
                        <button class="view-cart">Go to Cart</button>
                    </a>
                </div>
                <% }%>
            </div>
        </div>



        <section class="blank-section">

        </section>

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
                            <img id="mail" src="../../../Public/images/mail.png" alt="" />
                            <input
                                id="newsletter-email"
                                type="email"
                                name=""
                                id=""
                                placeholder="Enter Your Email Address"
                                />
                            <button type="submit">
                                <img id="send" src="../../../Public/images/send.png" alt="" />
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

        <script src="./menu.js"></script>
    </body>
</html>