<%@page import="Utilities.MenuItems"%>
<%@page import="Utilities.MenuItemsDAO"%>
<%@page import="java.util.List"%>
<%@page import="Utilities.Database"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Menu</title>
        <link rel="stylesheet" href="RestaurantDashboard.css"> <!-- Link to your CSS -->
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
                            <a href="./RestaurantDashboard.jsp">
                                <span class="icon"><ion-icon name="home-sharp"></ion-icon></span>
                                <span>Home</span>
                            </a>
                        </li>
                        <li>
                            <a href="./RestaurantCategory.jsp">
                                <span class="icon"><ion-icon name="grid"></ion-icon></span>
                                <span>Categories</span>
                            </a>
                        </li>
                        <li>
                            <a href="./RestaurantMenu.jsp">
                                <span class="icon"><ion-icon name="book"></ion-icon></span>
                                <span>Menu</span>
                            </a>
                        </li>
                        <li>
                            <a href="./RestaurantOrders.jsp">
                                <span class="icon"><ion-icon name="cart"></ion-icon></span>
                                <span>Orders</span>
                            </a>
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
                        <a href="http://localhost:8080/Platera-Main/logout" class="logout-link">
                            <div class="logout_btn">
                                <span class="logout">Logout</span>
                                <span class="icon"><ion-icon name="power"></ion-icon></span>
                            </div>
                        </a>
                    </div>
                </header>

                <main>
                    <!-- Menu Section -->
                    <h2 class="dash-title">Menu</h2>

                    <div class="page-action">
                        <button class="btn btn-main" id="add-menu-btn" onclick="location.href = './EditDish.jsp'"><span class="icon"><ion-icon name="add-circle"></ion-icon></span> Add menu item</button>
                    </div>

                    <section class="recent">
                        <div class="activity-card">
                            <h3>Added Menu Items</h3>
                            <div class="table-responsive">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Image</th>
                                            <th>Name</th>
                                            <th>Category</th>
                                            <th>Price</th>
                                            <th>Available?</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody id="menu-table">
                                        <%
                                            MenuItemsDAO menuItemsDAO = new MenuItemsDAO();

                                            // Get restaurant_id from session
//                                            Integer restaurantId = (Integer) session.getAttribute("restaurant_id");
                                            Integer restaurantId = 101;

                                            if (restaurantId == null) {
                                        %>
                                        <tr>
                                            <td colspan="7">Restaurant not found. Please log in again.</td>
                                        </tr>
                                        <%
                                        } else {
                                            // Fetch menu items using MenuItemsDAO
                                            List<MenuItems> menuItems = menuItemsDAO.getMenuItemsByRestaurant(restaurantId);

                                            if (menuItems.isEmpty()) {
                                        %>
                                        <tr>
                                            <td colspan="7">No menu items found.</td>
                                        </tr>
                                        <%
                                        } else {
                                            for (MenuItems item : menuItems) {
                                                String imagePath = item.getImage();
                                                String imageDirectory = request.getContextPath() + '/' + imagePath;
                                                String availability = item.isAvailability() ? "Yes" : "No";
                                        %>
                                        <tr>
                                            <td>
                                                <img src="<%= imageDirectory%>" alt="Dish Image" width="50">
                                            </td>
                                            <td><%= item.getItemName()%></td>
                                            <td><%= item.getCategoryName()%></td>
                                            <td><%= item.getPrice()%></td>
                                            <td><%= availability%></td>
                                            <td>
                                                <form action="http://localhost:8080/Platera-Main/RestaurantEditDish" method="POST">
                                                    <input type="hidden" name="id" value="<%= item.getItemId()%>">
                                                    <button type="submit" class="btn-edit">Edit</button>
                                                </form>
                                                <form action="http://localhost:8080/Platera-Main/DeleteDish" method="POST" onsubmit="return confirm('Are you sure you want to delete this dish?');">
                                                    <input type="hidden" name="id" value="<%= item.getItemId()%>">
                                                    <button type="submit" class="btn-delete">Delete</button>
                                                </form>
                                            </td>
                                        </tr>
                                        <%
                                                    }
                                                }
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
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
        </script>



    </body>
</html>
