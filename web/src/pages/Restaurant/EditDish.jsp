<%@ page import="java.util.ArrayList" %>
<%@ page import="Platera.Category" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Dish</title>
        <link rel="stylesheet" href="<%= request.getContextPath()%>/src/pages/Restaurant/RestaurantDashboard.css">
    </head>
    <body>

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
                        <li class="li_logout">
                            <a href="http://localhost:8080/Platera-Main/logout">
                                <span class="icon"><ion-icon name="power"></ion-icon></span>
                                <span>Logout</span>
                            </a>
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

                <main>
                    <!-- Edit Dish Section -->
                    <section id="edit-menu-section" class="recent">
                        <h2 class="dash-title">Edit Dish</h2>
                        <div class="activity-card pad-1">
                            <!-- Form updated for editing -->
                            <form action="http://localhost:8080/Platera-Main/UpdateDish" id="edit-menu-form" method="POST" enctype="multipart/form-data">
                                <!-- Hidden field for item ID -->
                                <input type="hidden" name="dish-id" value="${itemId}">

                                <!-- Dish Name -->
                                <div class="form-group">
                                    <label for="dish-name">Name</label>
                                    <input type="text" id="menu-name" name="dish-name" class="form-control" value="${itemName}" required>
                                </div>

                                <!-- Dish Category -->
                                <div class="form-group">
                                    <label for="dish-category">Category</label>
                                    <select id="menu-category" name="dish-category" class="form-control" required>
                                        <option value="">Choose</option>
                                        <c:forEach var="category" items="${sessionScope.categories}">
                                            <option value="${category.id}" ${category.id == categoryId ? "selected" : ""}>${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Dish Price -->
                                <div class="form-group">
                                    <label for="dish-price">Price</label>
                                    <input type="text" id="menu-price" name="dish-price" class="form-control" value="${price}" required>
                                </div>

                                <!-- Dish Image -->
                                <div class="form-group">
                                    <label for="menu-image">Image</label>
                                    <input type="file" id="menu-image" name="dish-image" class="form-control">
                                    <img src="<%= request.getContextPath() + "/" + session.getAttribute("imagePath") %>" alt="Dish Image" width="100">


                                </div>

                                <!-- Availability -->
                                <div class="form-group">
                                    <label>
                                        <input type="checkbox" id="menu-availability" name="dish-availability" ${"Available".equals(availability) ? "checked" : ""}>
                                        Available
                                    </label>
                                </div>

                                <!-- Submit Button -->
                                <div class="form-group">
                                    <button type="submit" id="edit-menu-submit" class="btn btn-main">Update</button>
                                </div>
                            </form>
                        </div>
                    </section>
                </main>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

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
    </body>
</html>
