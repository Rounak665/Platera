<%@page import="Utilities.Restaurant"%>
<%@page import="Utilities.RestaurantDAO"%>
<%@page import="Utilities.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>PLatera - Restaurant Categories</title>
        <link rel="shortcut icon" href="../../../Public/favicon.png" type="image/x-icon">
        <link rel="stylesheet" href="RestaurantDashboard.css"> <!-- Use the same CSS as the home page -->
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
                    <h2 class="dash-title">Categories</h2>

                    <div class="page-action">
                        <button class="btn btn-main" onclick="location.href = './UpdateCategory.jsp'">
                            <span class="icon1"><ion-icon name="add-circle"></ion-icon></span> Update Category
                        </button>
                    </div>
                    <h4>Add three categories that suits your restaurant the best.</h4>
                    <section class="recent">
                        <div>
                            <div class="activity-card">
                                <h3>Assigned Categories</h3>

                                <div class="table-responsive">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Name</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody id="category-table-body">
                                            <%
                                                // Simulate session attributes for debugging
 //                                               int user_id = (Integer) session.getAttribute("user_id");
                                                int user_id = 311;

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
                                                String restaurantImagePath = null;

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
                                                    restaurantImagePath = request.getContextPath() + '/' + restaurant.getImage();

                                                    // Owner details
                                                    ownerPhone = restaurant.getOwnerPhone();
                                                    ownerAddress = restaurant.getOwnerAddress();
                                                    ownerEmail = restaurant.getOwnerEmail();
                                                    twoFA = restaurant.isTwoStepVerification();
                                                }
                                            %>
                                            <%
                                                Connection conn = null;
                                                PreparedStatement ps = null;
                                                ResultSet rs = null;

                                                if (restaurantId == 0) {
                                            %>
                                            <tr>
                                                <td colspan="3">Restaurant not found. Please log in again.</td>
                                            </tr>
                                            <%
                                            } else {
                                                try {
                                                    String query = "SELECT c.category_id, c.category_name "
                                                            + "FROM restaurant_categories rc "
                                                            + "JOIN categories c ON c.category_id IN (rc.category_1, rc.category_2, rc.category_3) "
                                                            + "WHERE rc.restaurant_id = ?";

                                                    conn = Utilities.Database.getConnection();

                                                    ps = conn.prepareStatement(query);
                                                    ps.setInt(1, restaurantId);
                                                    rs = ps.executeQuery();

                                                    boolean categoriesExist = false;
                                                    while (rs.next()) {
                                                        categoriesExist = true;
                                                        int categoryId = rs.getInt("category_id");
                                                        String categoryName = rs.getString("category_name");
                                                        System.out.println(categoryId);
                                            %>
                                            <tr>
                                                <td><%= categoryId%></td>
                                                <td><%= categoryName%></td>
                                                <td>
                                                    <form action="http://localhost:8080/Platera-Main/RestaurantDeleteCategories" method="POST" onsubmit="return confirm('Are you sure you want to delete this category?');">
                                                        <input type="hidden" name="restaurant_id" value="<%=restaurantId%>">
                                                               <input type="hidden" name="category_id" value="<%= categoryId%>">
                                                        <button type="submit" class="btn-delete">Delete</button>
                                                    </form>
                                                </td>
                                            </tr>
                                            <%
                                                }
                                                if (!categoriesExist) {
                                            %>
                                            <tr>
                                                <td colspan="3">No categories assigned. Please add categories.</td>
                                            </tr>
                                            <%
                                                        }
                                                    } catch (SQLException e) {
                                                        e.printStackTrace();
                                                    } finally {
                                                        try {
                                                            if (rs != null) {
                                                                rs.close();
                                                            }
                                                            if (ps != null) {
                                                                ps.close();
                                                            }
                                                            if (conn != null) {
                                                                conn.close();
                                                            }
                                                        } catch (SQLException ignored) {
                                                            ignored.printStackTrace();
                                                        }
                                                    }
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
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

        <!-- main scripts -->

        <script>
                                                        document.querySelector("#menu").addEventListener("click", function () {
                                                            document.querySelector(".sidebar").classList.add("activate");
                                                        });

                                                        document.querySelector(".sidebar .close-btn").addEventListener("click", function () {
                                                            document.querySelector(".sidebar").classList.remove("activate");
                                                        });
        </script>
        script src="../../../error.js"></script>
    </body>
</html>
