<%@page import="Utilities.Restaurant"%>
<%@page import="Utilities.RestaurantDAO"%>
<%@page import="Utilities.CategoryDAO"%>
<%@page import="Utilities.Category"%>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Platera - Restaurant Add Category</title>
    <link rel="shortcut icon" href="../../../Public/favicon.png" type="image/x-icon">
    <link rel="stylesheet" href="./RestaurantDashboard.css"> <!-- Use the same CSS as the home page -->
</head>
<body>
            <%
            // Simulate session attributes for debugging
            int user_id = (Integer) session.getAttribute("user_id");
//            int user_id = 311;

            int restaurantId = 0; // Default value for int
            String name = null;
            String address = null;
            String phone = null;
            String locationName = null;
            int locationId = 0;
            double minPrice = 0.0; // Default value for double
            double maxPrice = 0.0; // Default value for double
            double avgRating = 0.0; // Default value for double
            String category1 = null;
            String category2 = null;
            String category3 = null;
            String imagePath = null;

            // Owner details
            String ownerName = null;
            String ownerPhone = null;
            String ownerAddress = null;
            String ownerEmail = null;
            boolean twoFA = false; // Default value for boolean

            Restaurant restaurant = null;

            RestaurantDAO restaurantDAO = new RestaurantDAO();
            restaurant = restaurantDAO.getRestaurantByUserId(user_id);

            if (restaurant != null) {
                restaurantId = restaurant.getRestaurantId();
                name = restaurant.getName();
                address = restaurant.getAddress();
                phone = restaurant.getPhone();
                locationId = restaurant.getLocationId();
                locationName = restaurant.getLocation();
                minPrice = restaurant.getMinPrice();
                maxPrice = restaurant.getMaxPrice();
                avgRating = restaurant.getRating();
                category1 = restaurant.getCategory1();
                category2 = restaurant.getCategory2();
                category3 = restaurant.getCategory3();
                imagePath = request.getContextPath() + '/' + restaurant.getImage();

                // Owner details
                ownerName = restaurant.getOwnerName();
                ownerPhone = restaurant.getOwnerPhone();
                ownerAddress = restaurant.getOwnerAddress();
                ownerEmail = restaurant.getOwnerEmail();
                twoFA = restaurant.isTwoStepVerification();

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
    <!-- loader -->
    <div class="loader">
        <div id="pl">
            <div>
                <video class="vid" src="../ContactUs/Assets/loader.mp4" autoplay muted loop></video>
            </div>
        </div>
    </div>

    <div>
        <div class="sidebar">
            <div class="sidebar-toggle menu" id="menu">
                <ion-icon name="menu"></ion-icon>
            </div>
            <div class="sidebar-toggle close-btn"><ion-icon name="close-outline" class="ico"></ion-icon></div>
            <div class="sidebar-header">
                <div class="logo">
                    <img src="../../../Public/images/logo.png" alt="">
                </div>
            </div>
            
            <div class="sidebar-menu">
                <ul>
                    <li>
                        <a href="./RestaurantDashboard.html">
                            <span class="icon"><ion-icon name="home-sharp"></ion-icon></span>
                            <span>Home</span>
                        </a>
                    </li>
                    <li>
                        <a href="./Category.html">
                            <span class="icon"><ion-icon name="grid"></ion-icon></span>
                            <span>Categories</span>
                        </a>
                    </li>
                    <li>
                        <a href="./Menu.html">
                            <span class="icon"><ion-icon name="book"></ion-icon></span>
                            <span>Menu</span>
                        </a>
                    </li>
                    <li>
                        <a href="./Orders.html">
                            <span class="icon"><ion-icon name="cart"></ion-icon></span>
                            <span>Orders</span>
                        </a>
                    </li>
                        <li class="logoutOption">
                            <form action="http://localhost:8080/Platera-Main/logout" method="POST">                          
                                <button type="submit"><span class="icon"><ion-icon name="log-out-outline"></ion-icon></span>Logout</button>
                            </form>
                        </li>
                </ul>
            </div>
        </div>

        <div class="main-content">
            <header>
                <div class="search-wrapper">
                    <span class="icon"><ion-icon name="search"></ion-icon></span>
                    <input type="search" placeholder="Search">
                </div>
                <div class="social-icons">
                    <div class="logout_btn" onclick="signout()">
                        <span class="logout">Logout</span>
                        <span class="icon"><ion-icon name="power"></ion-icon></span>
                    </div>
                </div>
            </header>



<%
    // Fetch the categories from the database
    CategoryDAO categoryDAO = new CategoryDAO();
    List<Category> categories = categoryDAO.getCategories();
    session.setAttribute("categories", categories);
%>

<main>
    <h2 class="dash-title">Add Category</h2>
    <section class="recent">
        <div class="activity-card pad-1">
            <form id="add-category-form" action="http://localhost:8080/Platera-Main/RestaurantUpdateCategories" method="post">
                <input type="hidden" name="restaurantId" value="<%=restaurantId%>"
                <!-- Category Dropdown 1 -->
                <div class="form-group">
                    <label for="category-1">Category 1</label>
                    <select id="category-1" name="category-1" class="form-control" required>
                        <option value="">Choose Category 1</option>
                        <c:forEach var="category" items="${sessionScope.categories}">
                            <option value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Category Dropdown 2 -->
                <div class="form-group">
                    <label for="category-2">Category 2</label>
                    <select id="category-2" name="category-2" class="form-control" required>
                        <option value="">Choose Category 2</option>
                        <c:forEach var="category" items="${sessionScope.categories}">
                            <option value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Category Dropdown 3 -->
                <div class="form-group">
                    <label for="category-3">Category 3</label>
                    <select id="category-3" name="category-3" class="form-control" required>
                        <option value="">Choose Category 3</option>
                        <c:forEach var="category" items="${sessionScope.categories}">
                            <option value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <button type="submit" id="submit-category" class="btn btn-main">Submit</button>
                </div>
            </form>
        </div>
    </section>
</main>

    </div>

    <!-- Scripts  -->

    <!-- Icon Scripts -->

    <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

    <!-- main scripts -->

    <script>
        document.querySelector("#menu").addEventListener("click", function() {
    document.querySelector(".sidebar").classList.add("activate");
});

document.querySelector(".sidebar .close-btn").addEventListener("click", function() {
    document.querySelector(".sidebar").classList.remove("activate");
});
    </script>
    <script src="../../../error.js"></script>

</body>
</html>
