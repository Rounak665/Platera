<%@page import="java.util.Collections"%>
<%@page import="Utilities.Category"%>
<%@page import="Utilities.CategoryDAO"%>
<%@page import="Utilities.CustomerDAO"%>
<%@page import="Utilities.Customer"%>
<%@page import="Utilities.CartDAO"%>
<%@page import="Utilities.Cart"%>
<%@page import="java.sql.SQLException"%>
<%@page import="Utilities.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="Utilities.RestaurantDAO" %>
<%@ page import="Utilities.Restaurant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Platera | Discover & Order Food</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
            />
        <link rel="shortcut icon" href="./assets/favicon.png" type="image/x-icon" />

        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
            integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap"
            rel="stylesheet"
            />
        <link rel="stylesheet" href="./style.css" />
    </head>
    <body>
        <%
            // Retrieve user_id from the session
            Integer user_id = (Integer) session.getAttribute("user_id");
//            int user_id = 201;

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

        <!-- Profile Setup Popup -->
        <% if (location_id == 0) {%>
        <div class="profile-setup-popup" id="profileSetupPopup">
            <div class="popup-content">
                <h3>Thank you <%= name%> for signing up. Please set up your profile for a better experience.</h3>
                <button id="profileSetupBtn" class="btn btn-primary">Go to Profile Settings</button>
            </div>
        </div>
        <% }%>

        <!-- Error Popup -->
        <div class="error-popup" id="errorPopup">
            <div class="error-content">
                <h2>Error</h2>
                <p id="errorMessage">An error has occurred. Please try again later.</p>
                <button id="closeErrorPopup">Go Back</button>
            </div>
        </div>


        <!-- Welcome Popup -->
        <%
            // Retrieve the session attribute before modification
            Boolean welcomePopup = (Boolean) session.getAttribute("welcomePopup");

            // Check if the popup should be displayed
            if (welcomePopup == null || !welcomePopup) {
                // Print the session value before showing the popup
                System.out.println("Before showing popup: " + welcomePopup);
        %>
        <div class="welcome-popup active" id="welcomePopup">
            <div class="popup-content">
                <h3>Welcome, <%= name%>!</h3>
                <p>Thanks for visiting our website.</p>
                <button id="closePopupBtn">Close</button>
            </div>
        </div>
        <%
                // Set the session attribute to true after showing the popup
                session.setAttribute("welcomePopup", true);

                // Print the session value after setting it
                System.out.println("After setting popup shown: " + session.getAttribute("welcomePopup"));
            }
        %>



        <!-- Navigation Bar -->
        <header>
            <nav class="navbar">
                <div class="logo">
                    <a href="./Home.html"
                       ><img src="./assets/PlateraLogo-red.png" alt=""
                          /></a>
                </div>

                <ul class="nav-links">
                    <li id="active"><a href="./Home.jsp">Home</a></li>
                    <li><a href="../RestaurantsInUser/restaurantsInUser.jsp">Restaurants</a></li>
                    <li><a href="../Menu/menu.jsp">Dishes</a></li>
                    <li><a href="../ContactUs/ContactUs.html">Contact</a></li>

                </ul>
                <div class="navbar-icons">
                    <!-- <button class="profile-btn" onclick="toggleProfileModal()"><i class="fas fa-user"></i></button>
                      <button class="cart-btn" onclick="toggleCartModal()"><i class="fas fa-shopping-cart"></i><span id="cart-count">0</span></button> -->

                    <div class="profile-icon" id="profileIcon">
                        <i class="fas fa-user"></i>
                    </div>
                    <!-- Profile Icon -->
                    <div class="cart-icon" id="cartIcon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                </div>
            </nav>
        </header>

        <!-- Sliding User Section -->
        <section class="user-section" id="userSection">
            <button class="close-btn" id="closeUserSection">&times;</button>
            <!-- Close Button -->
            <div class="user-profile">
                <h2>Dashboard</h2>
                <ul class="dashboard-options">
                    <li id="welcomeMessage">Hi, <%=name%></li>
                    <li id="profileSettings"><a href="./CustomerDashboard/CustomerProfile.jsp">Profile Settings</a></li>
                    <li id="orderHistory"><a href="./CustomerDashboard/CustomerOrder.jsp">Order History</a></li>
                    <li id="orderHistory"><a href="../FooterLinkPages/Terms&Conditions/Terms&Conditions.html">Terms & Conditions</a></li>
                    <li id="orderHistory"><a href="../FooterLinkPages/PrivacyPolicy/PrivacyPolicy.html">Privacy Policy</a></li>
                    <li id="orderHistory"><a href="../FooterLinkPages/Help/Help.html">Help</a></li>
                </ul>
                <!-- Logout Button -->
                <form action="http://localhost:8080/Platera-Main/logout" method="get">
                    <button type="submit" class="btn btn-outline-danger" id="logout-btn">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="16"
                            height="16"
                            fill="currentColor"
                            class="bi bi-power"
                            viewBox="0 0 16 16"
                            >
                        <path d="M7.5 1v7h1V1z"></path>
                        <path
                            d="M3 8.812a5 5 0 0 1 2.578-4.375l-.485-.874A6 6 0 1 0 11 3.616l-.501.865A5 5 0 1 1 3 8.812"
                            ></path>
                        </svg>
                        Logout
                    </button>
                </form>

            </div>
        </section>

        <!-- Sliding Cart Section -->
        <section class="cart-section" id="cartSection">
            <!-- Cart section -->
            <div class="cart-container checkout"> 
                <div class="cart-header">
                    Cart
                    <span class="close-btn" id="closeCartSectionCheckout">&times;</span>
                </div>



                <%
                    // Replace with the actual user/customer ID fetched from the session or request
                    CartDAO cartDAO = new CartDAO();
                    List<Cart> cartItems = cartDAO.getCartItems(customer_id);
                    double promotion = 0;
                    double subtotal = 0;
                    double deliveryCharges = 0;
                    double total = 0;

                    if (cartItems.isEmpty()) {
                %>

                <div class="heading-for-empty-cart">
                    <video src="./assets/cartEmptyAnimation.mp4" autoplay muted loop></video>
                </div>
                <%
                } else {
                %>
                <div class="cart-items">
                    <%
                        for (Cart cart : cartItems) {
                    %>
                    <div class="cart-item">
                        <img src="<%=request.getContextPath()%>/<%= cart.getItemImage()%>" alt="<%= cart.getItemName()%>" class="cart-item-image">

                        <div class="cart-item-details">
                            <p class="cart-item-name"><%= cart.getItemName()%></p>
                            <p class="cart-item-price">₹<%=cart.getItemPrice()%></p>
                        </div>
                        <div class="price">
                            <div class="cart-item-quantity-trash">
                                <div class="cart-item-quantity">
                                    <form action="http://localhost:8080/Platera-Main/UpdateCartQuantity" method="POST">
                                        <input type="hidden" name="cart_id" value="<%= cart.getCartId()%>">
                                        <button type="submit" name="action" value="subtract" class="quantity-btn subtract">-</button>
                                        <input type="text" name="quantity" class="quantity-number" value="<%= cart.getQuantity()%>" disabled>
                                        <button type="submit" name="action" value="add" class="quantity-btn add">+</button>
                                    </form>
                                </div>
                                <form action="http://localhost:8080/Platera-Main/DeleteFromCart" method="post">
                                    <input type="hidden" name="cart_id" value="<%= cart.getCartId()%>">
                                    <button type="submit"><i class="fa-solid fa-trash-can"></i></button>
                                </form>
                            </div>
                            <p class="total-price">₹<%=cart.getItemPrice() * cart.getQuantity()%></p>
                        </div>
                    </div>
                    <%
                                promotion = cart.getCouponDiscount();
                            }
                        }
                    %>
                </div>

                <% if (!cartItems.isEmpty()) {%>
                <div class="promo-code">
                    <form action="http://localhost:8080/Platera-Main/ApplyCoupon" method="post">
                        <input type="text" name="coupon_code" placeholder="Promo Code">
                        <input type="number" name="customerId" value="<%=customer_id%>" hidden>
                        <button type="submit">Apply</button>
                    </form>
                </div>
                <div class="cart-summary">
                    <%
                        // Calculate subtotal and total

                        for (Cart cart : cartItems) {
                            subtotal += cart.getItemPrice() * cart.getQuantity();
                        }

                        // Apply delivery charges conditionally
                        deliveryCharges = (subtotal < 199) ? 30 : 0;  // Delivery charges are 30 if subtotal is less than 199

                        // Calculate total
                        total = subtotal + deliveryCharges - promotion;
                    %>

                    <div><span>Subtotal</span><p class="subtotal">₹<%=subtotal%></p></div>
                    <div><span>Delivery</span><p class="delivery_charges">+₹<%=deliveryCharges%></p></div>
                    <div><span>Promotions</span><p class="delivery_charges">-₹<%=promotion%></p></div>
                    <div><span>Total</span><p class="total">₹<%=total%></p></div>
                </div>

                <button class="checkout-btn">CHECKOUT</button>
                <% }%>
            </div>



            <!-- Checkout Scetion -->

            <div class="cart-container paynow" style="display: none;">
                <div class="cart-header">
                    <span class="back-btn" id="backToCheckout"><b>&#8592;</b></span>
                    Checkout
                    <span class="close-btn" id="closeCartSectionPaynow">&times;</span>
                </div>
                <form action="http://localhost:8080/Platera-Main/Checkout" method="post">
                    <div class="payment-options">
                        <div class="payment-option">
                            <input type="radio" name="payment" id="debit-credit" value="cards" checked>
                            <label for="debit-credit">
                                <img src="https://img.icons8.com/color/48/visa.png" alt="Visa"> Debit/Credit card
                            </label>
                        </div>

                        <div class="payment-option">
                            <input type="radio" name="payment" id="net-banking" value="netBanking">
                            <label for="net-banking">
                                <img src="https://img.icons8.com/color/48/bank.png" alt="Bank"> Net banking
                            </label>
                        </div>

                        <div class="payment-option">
                            <input type="radio" name="payment" id="cash-on-delivery" value="cod">
                            <label for="cash-on-delivery">
                                <img src="https://img.icons8.com/color/48/cash.png" alt="Cash on Delivery"> Cash on Delivery
                            </label>
                        </div>                    

                    </div>

                    <div class="cart-summary">
                        <div><span>Subtotal</span><p  class="subtotal">₹<%=subtotal%></p></div>
                        <div><span>Delivery</span><p class="delivery_charges">+₹<%=deliveryCharges%></p></div>
                        <div><span>Promotions</span><p class="delivery_charges">-₹<%=promotion%></p></div>
                        <div><span>Total</span><p  class="total">₹<%=total%></p></div>
                    </div>

                    <button class="pay-btn">Pay Now</button>
                </form>
            </div>

        </section>

        <!-- Profile Modal -->
        <!-- <div class="profile-modal" id="profileModal">
        <div class="modal-content">
            <span class="close" onclick="toggleProfileModal()">&times;</span>
            <h2>User Profile</h2>
            <p>Name: John Doe</p>
            <p>Email: johndoe@example.com</p>
            <button class="logout-btn">Logout</button>
        </div>
    </div> -->

        <!-- Cart Modal -->
        <!-- <div class="cart-modal" id="cartModal">
        <div class="modal-content">
            <span class="close" onclick="toggleCartModal()">&times;</span>
            <h2>Your Cart</h2>
            <ul id="cart-items"></ul>
            <p>Total: $<span id="cart-total">0.00</span></p>
            <button class="checkout-btn">Checkout</button>
        </div>
    </div> -->

        <!-- Carousel Section -->
        <section class="carousel" id="home">
            <div class="carousel-container">
                <div class="carousel-slide">
                    <img src="./assets/slide1.png" alt="Slide 1" />
                    <img src="./assets/slide2.png" alt="Slide 2" />
                    <img src="./assets/slide3.png" alt="Slide 3" />
                    <img src="./assets/slide4.png" alt="Slide 4" />
                    <img src="./assets/slide5.png" alt="Slide 5" />
                </div>
            </div>

            <!-- Search Bar -->
            <div class="search-bar">
                <form action="http://localhost:8080/Platera-Main/Search">
                    <select name="keywordType" id="search-category">
                        <option value="restaurants">Restaurants</option>
                        <option value="dishes">Dishes</option>
                    </select>
                    <input type="text" name="keyword" id="search-input" placeholder="Search for restaurants or dishes..." />
                    <input type="hidden" name="location" value="<%=location_id%>">
                    <button id="search-button">Search</button>
                </form>
            </div>

            <!-- Dots Indicator -->
            <div class="dots" id="dots"></div>

            <!-- Floating Product Cards -->
            <div class="product-cards-container">
                <%
                    // Initialize the categories list
                    CategoryDAO categoryDAO = new CategoryDAO();
                    List<Category> categories = categoryDAO.getAllCategories();

                    // Shuffle the categories list to randomize it
                    Collections.shuffle(categories);

                    int count = 0; // Counter to track the number of displayed categories
                    for (Category category : categories) {
                        if (count == 4) {
                            break; // Stop after displaying 4 categories
                        }
                        count++;
                %>
                <div class="product-card">
                    <a href="../Menu/Categories/categories.jsp?categoryId=<%=category.getId()%>" class="restaurant-card-link">
                        <img src="<%= request.getContextPath()%>/<%= category.getImage()%>" alt="<%= category.getName()%>" />
                        <h4><%= category.getName()%></h4>
                        <p>Explore our <%= category.getName().toLowerCase()%> menu</p>
                    </a>
                </div>
                <% }%>
            </div>

        </section>

        <!-- Spacer Section -->
        <section class="spacer-section"></section>

        <!-- Popular Restaurants Section -->
        <section class="popular-restaurants">
            <h3>Popular Restaurants with online food delivery</h3>
            <!-- Filter Buttons -->
            <div class="filter-buttons">
                <button class="filter-btn" onclick="filterRestaurants('ratings')">
                    Ratings
                </button>
                <button class="filter-btn" onclick="filterRestaurants('nonveg')">
                    Non-Veg
                </button>
                <button class="filter-btn" onclick="filterRestaurants('offers')">
                    Offers
                </button>
                <button class="filter-btn" onclick="filterRestaurants('under300')">
                    Less than ₹300
                </button>
                <button class="filter-btn" onclick="filterRestaurants('300to700')">
                    ₹300-₹700
                </button>
            </div>
            <!-- Changed Slider -->
            <!-- New Restaurant Carousel Section -->
            <section class="restaurant-carousel-section">
                <div class="restaurant-carousel-container">
                    <div class="restaurant-carousel">
                        <div class="restaurant-carousel-inner" id="restaurantCarouselInner">
                            <%-- Dynamic Content Begins --%>
                            <%
                                // Instantiate the DAO and fetch the list of restaurants
                                RestaurantDAO restaurantDAO = new RestaurantDAO();
                                List<Restaurant> restaurants = restaurantDAO.getRestaurantsByLocation(location_id);

                                if (restaurants != null && !restaurants.isEmpty()) {
                                    for (Restaurant restaurant : restaurants) {
                            %>
                            <div class="restaurant-carousel-item">
                                <a href="./RestaurantDetails/RestaurantDetails.jsp?restaurantId=<%= restaurant.getRestaurantId()%>" class="restaurant-card-link">
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
                            </div>
                            <%
                                }
                            } else {
                            %>
                            <p>No restaurants found or there was an error fetching data.</p>
                            <%
                                }
                            %>
                            <%-- Dynamic Content Ends --%>
                        </div>
                    </div>
                </div>
            </section>

        </section>




        <!-- Spacer Section -->
        <section class="spacer-section"></section>

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
        <!-- bootstrap import -->
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"
        ></script>
        <script>
                    if (window.location.hash === '#cartSection') {
                        let cartSection = document.querySelector('.cart-section');

                        // Disable transition temporarily for instant effect
                        cartSection.style.transition = 'none'; // Disable transition
                        cartSection.style.position = 'absolute';

                        // Set the cart section's position instantly to make it appear
                        cartSection.style.right = '0%';

                        // Set visibility and opacity for smooth future transitions
                        cartSection.style.visibility = 'visible';
                        cartSection.style.opacity = '1';

                        // Re-enable the transition after a short delay to ensure smooth animation for future interactions
                        setTimeout(function () {
                            cartSection.style.tran
                            // Set the cart section's position instantly to make it appear
                            cartSection.style.right = '0%';

                            // Set visibility and opacity for smooth future transitions
                            cartSection.style.visibility = 'visible';
                            cartSection.style.opacitsition = 'right 0.3s ease'; // Re-enable smooth transition
                        }, 10); // Short delay to re-enable transition without noticeable flicker
                    }

        </script>
        <script>
            // Enable horizontal scrolling with mouse wheel
            const restaurantCarousel = document.querySelector('.restaurant-carousel');
            restaurantCarousel.addEventListener('wheel', (event) => {
                if (event.deltaY > 0) {
                    restaurantCarousel.scrollLeft += 300;
                } else {
                    restaurantCarousel.scrollLeft -= 300;
                }
                event.preventDefault();
            });

        </script>
        <script src="./script.js"></script>

        <script src="../../../error.js"></script>
    </body>
</html>
