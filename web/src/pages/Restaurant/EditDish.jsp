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
        <title>Platera - Restaurant Edit Dish</title>
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
                            <a href="./RestaurantDashboard.jsp">
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

                <main>
                    <!-- Edit Dish Section -->
                    <section id="edit-menu-section" class="recent">
                        <h2 class="dash-title">Edit Dish</h2>
                        <div class="activity-card pad-1">

                            <!-- Fetch categories using CategoryDAO -->
                            <%
                                CategoryDAO categoryDAO = new CategoryDAO();
                                List<Category> categories = categoryDAO.getCategories();
                                String itemId = request.getParameter("item_id");
                                String itemName = request.getParameter("item_name");
                                String categoryId = request.getParameter("category_id");
                                String price = request.getParameter("price");
                                boolean availability = Boolean.parseBoolean(request.getParameter("availability"));
                                String imagePath = request.getParameter("image");
                            %>


                            <!-- Form updated for editing -->
                            <form action="http://localhost:8080/Platera-Main/RestaurantUpdateDish" id="edit-menu-form" method="POST" enctype="multipart/form-data">
                                <!-- Hidden field for item ID -->
                                <input type="hidden" name="item_id" value="<%= itemId%>">

                                <!-- Dish Name -->
                                <div class="form-group">
                                    <label for="dish-name">Name</label>
                                    <input type="text" id="dish-name" name="dish-name" class="form-control" value="<%= itemName%>" required>
                                </div>

                                <!-- Dish Category -->
                                <div class="form-group">
                                    <label for="dish-category">Category</label>
                                    <select id="dish-category" name="dish-category" class="form-control" required>
                                        <option value="">Choose</option>
                                        <%
                                            for (Category category : categories) {
                                                boolean selected = category.getId() == Integer.parseInt(categoryId);
                                        %>
                                        <option value="<%= category.getId()%>" <%= selected ? "selected" : ""%>><%= category.getName()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>

                                <!-- Dish Price -->
                                <div class="form-group">
                                    <label for="dish-price">Price</label>
                                    <input type="text" id="dish-price" name="dish-price" class="form-control" value="<%= price%>" required>
                                </div>

                                <!-- Dish Image -->
                                <div class="form-group">
                                    <p>Keep the image empty if you want to remove the image. Upload the previous image if you don't want to update the image.</p>
                                    <label for="menu-image">Image</label>
                                    <input type="file" id="menu-image" name="dish-image" class="form-control">
                                    <!-- If the image path exists in the session, display it -->
                                    <img src="<%= request.getContextPath() + "/" + imagePath%>" alt="Dish Image" width="100">
                                </div>

                                <!-- Availability -->
                                <div class="form-group">
                                    <label>
                                        <!-- Check availability based on boolean -->
                                        <input type="checkbox" id="menu-availability" name="dish-availability" <%= availability ? "checked" : ""%>>
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
        <script src="../../../error.js"></script>
    </body>
</html>
