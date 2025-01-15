<%@page import="Utilities.Restaurant"%>
<%@page import="Utilities.RestaurantDAO"%>
<%@ page import="java.util.List" %>
<%@ page import="Utilities.Category" %>
<%@ page import="Utilities.CategoryDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Platera - Restaurant Add Menu Item</title>
        <link rel="shortcut icon" href="../../../Public/favicon.png" type="image/x-icon">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/src/pages/Restaurant/RestaurantDashboard.css">
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
                <div class="sidebar-toggle close-btn"><ion-icon name="close-outline" class="icon"></ion-icon></div>
                <div class="sidebar-header">
                    <div class="logo">
                        <img src="../../../Public/images/logo.png" alt="">
                    </div>
                </div>

                <div class="sidebar-menu">
                    <ul>
                        <li>
                            <a href="">
                                <span class="icon"><ion-icon name="home-sharp"></ion-icon></span>
                                <span>Home</span>
                            </a>
                        </li>
                        <li>
                            <a href="./Category.jsp">
                                <span class="icon"><ion-icon name="grid"></ion-icon></span>
                                <span>Categories</span>
                            </a>
                        </li>
                        <li>
                            <a href="./Menu.jsp">
                                <span class="icon"><ion-icon name="book"></ion-icon></span>
                                <span>Menu</span>
                            </a>
                        </li>
                        <li>
                            <a href="./Orders.jsp">
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
                    <div class="headerLogo">
                        <div class="logo">
                            <img src="../../../Public/images/logo.png" alt="">
                        </div>
                    </div>

                    <div class="social-icons">
                        <div class="logout_btn" onclick="signout()">
                            <span class="logout">Logout</span>
                            <span class="icon"><ion-icon name="power"></ion-icon></span>
                        </div>
                    </div>
                </header>
                <%
                    // Simulate session attributes for debugging
                    // int user_id = (Integer) session.getAttribute("user_id");
                    int user_id = 185;

                    int restaurantId = 0; // Default value for int
                    String name = null;
                    String address = null;
                    String phone = null;
                    String locationName = null;
                    double minPrice = 0.0; // Default value for double
                    double maxPrice = 0.0; // Default value for double
                    double avgRating = 0.0; // Default value for double
                    String category1 = null;
                    String category2 = null;
                    String category3 = null;
                    String imagePath = null;

                    // Owner details
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
                        locationName = restaurant.getLocation();
                        minPrice = restaurant.getMinPrice();
                        maxPrice = restaurant.getMaxPrice();
                        avgRating = restaurant.getRating();
                        category1 = restaurant.getCategory1();
                        category2 = restaurant.getCategory2();
                        category3 = restaurant.getCategory3();
                        imagePath = request.getContextPath() + '/' + restaurant.getImage();

                        // Owner details
                        ownerPhone = restaurant.getOwnerPhone();
                        ownerAddress = restaurant.getOwnerAddress();
                        ownerEmail = restaurant.getOwnerEmail();
                        twoFA = restaurant.isTwoStepVerification();
                    }
                %>
                <main>
                    <!-- Menu Section -->
                    <section id="add-menu-section" class="recent">
                        <h2 class="dash-title">Add Menu Item</h2>
                        <div class="activity-card pad-1">
                            <!-- Fetch categories using DAO -->
                            <%
                                CategoryDAO categoryDAO = new CategoryDAO();
                                List<Category> categories = categoryDAO.getCategories();
                                session.setAttribute("categories", categories);
                            %>

                            <form action="http://localhost:8080/Platera-Main/RestaurantAddDish" id="add-menu-form" method="POST" enctype="multipart/form-data">
                                <!-- Menu Name -->
                                <div class="form-group">
                                    <label for="dish-name">Name</label>
                                    <input type="text" id="menu-name" name="dish-name" class="form-control" placeholder="Item name" required>
                                </div>
                                <input type="hidden" name="restaurant_id" value="<%=restaurantId%>">

                                <!-- Menu Category -->
                                <div class="form-group">
                                    <label for="dish-category">Category</label>
                                    <select id="menu-category" name="dish-category" class="form-control" required>
                                        <option value="">Choose</option>
                                        <c:forEach var="category" items="${sessionScope.categories}">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Menu Price -->
                                <div class="form-group">
                                    <label for="dish-price">Price</label>
                                    <input type="text" id="menu-price" name="dish-price" min="1" class="form-control" placeholder="Item price" required>
                                </div>

                                <!-- Menu Image (optional) -->
                                <div class="form-group">
                                    <label for="menu-image">Image</label>
                                    <input type="file" id="menu-image" name="dish-image" class="form-control" required>
                                </div>

                                <!-- Availability -->
                                <div class="form-group">
                                    <label>
                                        <input type="checkbox" id="menu-availability" name="dish-availability" checked>
                                        Available
                                    </label>
                                </div>

                                <!-- Submit Button -->
                                <div class="form-group">
                                    <button type="submit" id="add-menu-submit" class="btn btn-main">Submit</button>
                                </div>
                            </form>
                        </div>
                    </section>
                </main>
            </div>
        </div>

        <!-- Scripts  -->
        <!-- Icon Scripts -->
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

        <!-- Main JavaScript -->
        <script>
                            document.querySelector("#menu").addEventListener("click", function () {
                                document.querySelector(".sidebar").classList.add("activate");
                            });

                            document.querySelector(".sidebar .close-btn").addEventListener("click", function () {
                                document.querySelector(".sidebar").classList.remove("activate");
                            });

                            function signout() {
                                localStorage.removeItem('authtoken');
                                localStorage.removeItem('admin');
                                window.location.href = '../AddRestaurent/AddRestaurent.html#Signin-popup';
                            }
        </script>
        <script src="../../../error.js"></script>
    </body>
</html>