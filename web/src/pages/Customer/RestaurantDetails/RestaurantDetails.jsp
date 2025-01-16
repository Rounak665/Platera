<%@page import="Utilities.CustomerDAO"%>
<%@page import="Utilities.CartDAO"%>
<%@page import="Utilities.Customer"%>
<%@page import="Utilities.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Utilities.MenuItems"%>
<%@page import="Utilities.MenuItemsDAO"%>
<%@page import="Utilities.Restaurant"%>
<%@page import="java.util.List"%>
<%@page import="Utilities.RestaurantDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Platera | Discover & Order Food</title>
        <link rel="stylesheet" href="./restaurantDashbord.css">
        <link rel="shortcut icon" href="./assets/favicon.png" type="image/x-icon">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.0/css/all.min.css" integrity="sha512-9xKTRVabjVeZmc+GUW8GgSmcREDunMM+Dt/GrzchfN8tkwHizc5RP4Ok/MXFFy5rIjJjzhndFScTceq5e6GvVQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">
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


        <%            //Actual code
            int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
            //For debugging
//            int restaurantId = 211;

            RestaurantDAO restaurantDAO = new RestaurantDAO();
            Restaurant restaurant = restaurantDAO.getRestaurantById(restaurantId);

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


        <!-- Error Popup -->
        <div class="error-popup" id="errorPopup">
            <div class="error-content">
                <h2>Error</h2>
                <p id="errorMessage">An error has occurred. Please try again later.</p>
                <button id="closeErrorPopup">Go Back</button>
            </div>
        </div>

        <!-- Navigation Bar -->
        <header>
            <nav class="navbar">
                <div class="logo">
                    <a href="./Home.html"><img src="./assets/image.png" alt=""/></a>
                </div>

                <ul class="nav-links">
                    <li><a href="./Home.jsp">Home</a></li>
                    <li><a href="./restaurantDashboard.jsp">Restaurants</a></li>
                    <li><a href="#Menu">Dishes</a></li>
                    <li><a href="#contact">Contact</a></li>
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

        <!--     <div class="hero-section">
                <div class="hero-image">
                    <img src="./assets/hero-section.png" alt="Hero Image" />
                </div>
            </div> -->

        <!-- Restaurant Header -->
        <header class="restaurant-header">
            <h1><%=restaurant.getName()%></h1> <!--name variable -->

        </header>

        <!-- Restaurant Info -->
        <section class="restaurant-info">
            <!-- <h1>Burger King</h1> -->
            <div class="restaurant-details">
                <div class="rating-price">
                    <span class="rating">⭐<%=restaurant.getRating()%> (<%=reviewCount%> ratings)</span>
                    <span class="dot"></span>
                    <span class="price">₹<%=restaurant.getPriceForTwo()%> for two</span>

                </div>
                <div class="details">
                    <span class="cuisines"><%=restaurant.getCategory1()%>, <%=restaurant.getCategory2()%>, <%=restaurant.getCategory3()%></span>
                    <span><i class="fa-regular fa-circle-dot"></i>Outlet: <%=restaurant.getLocation()%></span> 
                    <span class>25-30 mins</span>
                    <span class="phone"><i class="fa-solid fa-phone"></i><%=restaurant.getPhone()%></span>
                    <span class="address"><i class="fa-solid fa-location-dot"></i><%=restaurant.getAddress()%></span>
                </div>
            </div>

            <div class="restaurant-image">
                <img src="<%=request.getContextPath()%>/<%=restaurant.getImage()%>" alt="Restaurant Image">
            </div>
        </section>

        <!-- Deals Slider Carousel -->
        <section class="deals-slider-carousel">
            <h1>Deals for you</h1>
            <div class="deals-slider">
                <div class="deal-slide">
                    <img src="./assets/d07196b25b85d1fd9951e10c255ab737.avif" alt="Deal 1">
                    <div class="offer-text">
                        <h4>Extra ₹25 Off</h4>
                        <p>Use code: DEAL25</p>
                    </div>
                </div>
                <div class="deal-slide">
                    <img src="./assets/d07196b25b85d1fd9951e10c255ab737.avif" alt="Deal 2">
                    <div class="offer-text">
                        <h4>Extra ₹25 Off</h4>
                        <p>Use code: DEAL25</p>
                    </div>
                </div>
                <div class="deal-slide">
                    <img src="./assets/d07196b25b85d1fd9951e10c255ab737.avif" alt="Deal 3">
                    <div class="offer-text">
                        <h4>Extra ₹25 Off</h4>
                        <p>Use code: DEAL25</p>
                    </div>
                </div>
            </div>
        </section>

        <%
            // Get the restaurant ID from request parameter

            // Create an instance of the MenuItemsDAO
            MenuItemsDAO menuItemsDAO = new MenuItemsDAO();

            // Get the list of menu items for the restaurant
            List<MenuItems> menuItemsList = menuItemsDAO.getMenuItemsByRestaurant(restaurantId);
        %>

        <div class="menu-section">
            <h2>Recommended (<%= menuItemsList.size()%>)</h2>
            <div class="menu-list">
                <%
                    // Loop through the menu items list
                    for (MenuItems item : menuItemsList) {
                %>
                <div class="menu-item" id="item<%= item.getItemId()%>">
                    <div class="item-details">
                        <!-- Bestseller tag logic can be added as needed -->
                        <span class="bestseller-tag"><%= item.getPrice() < 100 ? "⭐ Bestseller" : ""%></span>
                        <h3><%= item.getItemName()%></h3>
                        <p class="price">₹<%= item.getPrice()%></p>
                        <!-- Static Rating -->
                        <p class="rating">⭐ 4.0 (651 ratings)</p>
                        <!-- Static Description -->
                        <p class="description">
                            Masaledar Veg Patty, Onion & Our Signature Tomato Herby Sauce. Qty: 1<br />
                            37 Gms | Kcal: 362 | Carbs: 53.4 Gms | Sugar: 6.5 Gms | Fat: 12.8 Gms
                        </p>
                        <%
                            CartDAO cartDAO = new CartDAO();
                            boolean isInCart = cartDAO.isItemInCart(customer_id, item.getItemId());
                        %>
                        <!-- Add to Cart and View Cart Buttons -->
                        <div class="item-buttons">
                            <!-- Add to Cart button inside a form -->
                            <form action="http://localhost:8080/Platera-Main/AddToCart" method="POST" style="<%= isInCart ? "display:none;" : ""%>">
                                <input type="hidden" name="customerId" value="<%= customer_id%>" />
                                <input type="hidden" name="restaurantId" value="<%= restaurantId%>" />
                                <input type="hidden" name="itemId" value="<%= item.getItemId()%>" />
                                <button type="submit" class="add-to-cart-btn">Add to Cart</button>
                            </form>

                            <!-- Go to Cart button -->
                            <a href="../Home.jsp#cartSection" style="<%= isInCart ? "" : "display:none;"%>">
                                <button class="view-cart-btn">Go to Cart</button>
                            </a>
                        </div>

                    </div>
                    <div class="item-actions">
                        <img src="<%=request.getContextPath()%>/<%=item.getImage()%>" alt="<%= item.getItemName()%>" />
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>

        <!-- Review Section -->
        <section class="review-section">
            <h2>Reviews</h2>
            <div class="reviews">
                <%
                    // Updated query to fetch reviews with customer and user details
                    String reviewQuery = "SELECT r.rating, r.review_text, r.review_date, u.name "
                            + "FROM reviews r "
                            + "JOIN customers c ON r.customer_id = c.customer_id "
                            + "JOIN users u ON c.user_id = u.user_id "
                            + "WHERE r.restaurant_id = ?";
                    try {
                        con = Database.getConnection();
                        ps = con.prepareStatement(reviewQuery);
                        ps.setInt(1, restaurantId);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            int rating = rs.getInt("rating");
                            String reviewText = rs.getString("review_text");
                            String reviewDate = rs.getString("review_date");
                            String reviewerName = rs.getString("name");
                %>
                <div class="review">
                    <h4><%= reviewerName%> - ⭐<%= rating%></h4>
                    <p><%= reviewText%></p>
                    <small>Reviewed on: <%= reviewDate%></small>
                </div>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
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
            </div>

            <div class="review-form">
                <h3>Leave a Review</h3>
                <form action="http://localhost:8080/Platera-Main/SubmitReview" method="POST">
                    <input type="hidden" name="restaurantId" value="<%= restaurantId%>">
                    <input type="hidden" name="customerId" value="<%= customer_id%>">
                    <label for="reviewText">Your Review:</label>
                    <textarea name="reviewText" id="reviewText" rows="4" required></textarea>
                    <label for="rating">Rating:</label>
                    <select name="rating" id="rating" required>
                        <option value="5">5 - Excellent</option>
                        <option value="4">4 - Very Good</option>
                        <option value="3">3 - Good</option>
                        <option value="2">2 - Fair</option>
                        <option value="1">1 - Poor</option>
                    </select>
                    <button type="submit">Submit Review</button>
                </form>
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

        <script src="./restaurantDashboard.js"></script>
    </body>
</html>
