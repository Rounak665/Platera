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
            //Actual code
    //        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
            //For debugging
            int restaurantId = 101;
        %>

        <%
            RestaurantDAO restaurantDAO = new RestaurantDAO();
            Restaurant restaurant = restaurantDAO.getRestaurantById(restaurantId);
        %>

        <%
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
            <div class="rating-price">
                <span class="rating">⭐<%=restaurant.getRating()%> (<%=reviewCount%> ratings)</span>
                <span class="dot"></span>
                <span class="price">₹<%=restaurant.getPriceForTwo()%> for two</span>
            </div>

            <div class="details">
                <span class="cuisines"><%=restaurant.getCategory1()%>, <%=restaurant.getCategory2()%>, <%=restaurant.getCategory3()%></span> <!-- cuisines -->
                <span><i class="fa-regular fa-circle-dot"></i>Outlet: <%=restaurant.getLocation()%></span> 
                <span class>25-30 mins</span>
            </div>
        </section>

        <!-- Deals Carousel -->
        <section class="deals-carousel">
            <h1>Deals for you</h1>
            <button class="carousel-btn prev">&lt;</button>
            <div class="deals">
                <div class="deal">Extra ₹25 Off</div>
                <div class="deal">Items At ₹99</div>
                <div class="deal">Deal of Day</div>
            </div>
            <button class="carousel-btn next">&gt;</button>
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
                <div class="menu-item">
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




        <script src="./restaurantDashboard.js"></script>
    </body>
</html>
