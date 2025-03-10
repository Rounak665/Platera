<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Utilities.Location" %>
<%@ page import="Utilities.LocationDAO" %>
<%@ page import="Utilities.Category" %>
<%@ page import="Utilities.CategoryDAO" %>
<%@ page import="Utilities.CategoryDAO" %> 
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Restaurant Details | Platera</title>

        <!-- Favicon -->
        <link rel="shortcut icon" href="./assets/favicon.png" type="image/x-icon">

        <!-- Styles -->
        <link rel="stylesheet" href="./Restaurant_public_info.css">

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">

        <!-- Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.0/css/all.min.css" integrity="sha512-9xKTRVabjVeZmc+GUW8GgSmcREDunMM+Dt/GrzchfN8tkwHizc5RP4Ok/MXFFy5rIjJjzhndFScTceq5e6GvVQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>

        <!-- Error Popup -->
        <div class="error-popup" id="errorPopup">
            <div class="error-content">
                <h2>Error</h2>
                <p id="errorMessage">An error has occurred. Please try again later.</p>
                <button id="closeErrorPopup">Go Back</button>
            </div>
        </div>
        <!-- Navbar -->
        <header>
            <div class="nav_bar">
                <div class="logo">
                    <img src="./assets/PlateraLogo-red.png" alt="logo" height="70px" >
                </div>
                <div class="nav_links">
                    <ul class="nav_list">
                        <li><a href="../../../index.html">Home</a></li>
                        <li><a href="../ContactUs/ContactUs.html">Contact Us</a></li>
                    </ul>
                </div>
                <a href="#"><button class="signin" id="signin">Sign In</button></a>
            </div>
        </header>

        <!-- Hero Section -->
        <section class="hero">
            <div class="hero-content">
                <h1>Welcome to Platera</h1>
                <p>Fill out this form to Get Started !</p>
            </div>
        </section>

        <!-- Form Section -->
        <div class="form-container">
            <form id="profile-form" action="http://localhost:8080/Platera-Main/RestaurantPublicInfo" method="POST" enctype="multipart/form-data">
                <h2>Profile Form</h2>

                <!-- Profile Photo -->
                <label for="profile-photo">Restaurant Image/Logo :</label>
                <input type="file" id="profile-photo" accept="image/*" name="image" required>       

                <!-- Phone Number -->
                <label for="phone">Restaurant Phone Number :</label>
                <input type="text" id="phone" name="restaurant-phone" placeholder="Enter your phone number" required>

                <!-- Address -->
                <label for="address">Restaurant Address :</label>
                <textarea id="address" name="restaurant-address" rows="3" placeholder="Enter your address" required></textarea>

                <!-- Location Dropdown -->
                <label for="location">Location:</label>
                <select id="location" name="restaurant-location" required>
                    <option value="" disabled selected>Select a location</option>
                    <%
                        LocationDAO locationDAO = new LocationDAO();
                        List<Location> locations = locationDAO.getLocations();
                        for (Location location : locations) {
                    %>
                        <option value="<%= location.getId() %>"><%= location.getName() %></option>
                    <%
                        }
                    %>
                </select>

                <h2>Categories</h2>
                <p>Choose the three categories that fit your restaurant the best</p>
                <!-- Cuisine 1 -->
                <label for="cuisine1">Category 1 :</label>
                <select id="cuisine1" name="category1" required>
                    <option value="" disabled selected>Select a cuisine</option>
                    <%
                        CategoryDAO categoryDAO = new CategoryDAO();
                        List<Category> categories = categoryDAO.getCategories();
                        for (Category category : categories) {
                    %>
                        <option value="<%= category.getId() %>"><%= category.getName() %></option>
                    <%
                        }
                    %>
                </select>

                <!-- Cuisine 2 -->
                <label for="cuisine2">Category 2:</label>
                <select id="cuisine2" name="category2" required>
                    <option value="" disabled selected>Select a cuisine</option>
                    <%
                        for (Category category : categories) {
                    %>
                        <option value="<%= category.getId() %>"><%= category.getName() %></option>
                    <%
                        }
                    %>
                </select>

                <!-- Cuisine 3 -->
                <label for="cuisine3">Category 3:</label>
                <select id="cuisine3" name="category3" required>
                    <option value="" disabled selected>Select a cuisine</option>
                    <%
                        for (Category category : categories) {
                    %>
                        <option value="<%= category.getId() %>"><%= category.getName() %></option>
                    <%
                        }
                    %>
                </select>

                <h2>Pricing</h2>

                <!-- Price Fields (Side by Side) -->
                <div class="price-container">
                    <div class="price-field">
                        <label for="min-price">Minimum Price:</label>
                        <input type="number" id="min-price" name="min-price" placeholder="Min price" required>
                    </div>

                    <div class="price-field">
                        <label for="max-price">Maximum Price:</label>
                        <input type="number" id="max-price" name="max-price" placeholder="Max price" required>
                    </div>
                </div>

                <!-- Submit Button -->
                <button type="submit">Submit</button>
            </form>
        </div>

        <!--<script src="./afterSigningUp.js"></script>-->
    </body>
</html>
