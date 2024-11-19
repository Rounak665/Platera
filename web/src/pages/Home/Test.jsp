<%@ page import="java.util.*, Platera.RestaurantDAO, Platera.Restaurant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Restaurant Data Fetch Test</title>
    <style>
        .restaurant-card {
            border: 1px solid #ddd;
            padding: 10px;
            margin: 10px;
            width: 200px;
        }
        .restaurant-image {
            width: 100%;
            height: auto;
        }
        .restaurant-info {
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>Testing Restaurant Data Fetch</h1>
    <%
        // Instantiate the DAO and fetch the list of restaurants
        RestaurantDAO restaurantDAO = new RestaurantDAO();
        List<Restaurant> restaurants = restaurantDAO.getAllRestaurants();

        // Check if restaurants are fetched
        if (restaurants != null && !restaurants.isEmpty()) {
    %>
        <p>Number of restaurants fetched: <%= restaurants.size() %></p>

        <!-- Loop through and display restaurant data -->
        <div class="restaurant-slider">
            <%
                for (Restaurant restaurant : restaurants) {
            %>
                <div class="restaurant-card">
                    <img src="<%= request.getContextPath()%>/<%=restaurant.getImage() %>" alt="<%= restaurant.getName() %>" class="restaurant-image" />
                    <div class="restaurant-info">
                        <h3><%= restaurant.getName() %></h3>
                        <p>⭐ 4.7 | ₹₹</p>
                        <!-- Static Ratings & Price Range: Update this if dynamic values are available -->
                        <p>Burgers, Fast Food, Rolls & Wraps</p>
                        <!-- Static Cuisine: Update dynamically if available -->
                        <p class="location">Location ID: <%= restaurant.getLocation() %></p>
                    </div>
                </div>
            <%
                }
            %>
        </div>
    <%
        } else {
    %>
        <p>No restaurants found or there was an error fetching data.</p>
    <%
        }
    %>
</body>
</html>
