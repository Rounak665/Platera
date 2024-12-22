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
                            <a href="src/pages/Restaurant/AddDish.jsp">
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
                                            <th>ID</th>
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
                                            Connection conn = null;
                                            PreparedStatement stmt = null;
                                            ResultSet rs = null;

                                            // Get restaurant_id from session
//                                            Integer restaurantId= (Integer) session.getAttribute("restaurant_id");
                                            Integer restaurantId = 101; 

                                            if (restaurantId == null) {
                                        %>
                                        <tr>
                                            <td colspan="7">Restaurant not found. Please log in again.</td>
                                        </tr>
                                        <%
                                        } else {
                                            try {
                                                String query = "SELECT mi.item_id, mi.item_name, mi.price, mi.availability, c.category_name, mi.image "
                                                        + "FROM menu_items mi "
                                                        + "JOIN categories c ON mi.category_id = c.category_id "
                                                        + "WHERE mi.restaurant_id = ?";

                                                conn = Database.getConnection();
                                                stmt = conn.prepareStatement(query);
                                                stmt.setInt(1, restaurantId);
                                                rs = stmt.executeQuery();

                                                while (rs.next()) {
                                                    int itemId = rs.getInt("item_id");
                                                    String itemName = rs.getString("item_name");
                                                    String categoryName = rs.getString("category_name");
                                                    double price = rs.getDouble("price");
                                                    String availability = rs.getString("availability").equalsIgnoreCase("Y") ? "Yes" : "No";
                                                    String imagePath = rs.getString("image"); // Image path from DB

//                                                        System.out.println(request.getContextPath());
                                                    String imageDirectory = request.getContextPath() + '/' + imagePath;


                                        %>
                                        <tr>
                                            <td><%= itemId%></td>
                                            <td>
                                                <img src="<%= imageDirectory%>" alt="Dish Image" width="50">                                              
                                            </td>
                                            <td><%= itemName%></td>
                                            <td><%= categoryName%></td>
                                            <td><%= price%></td>
                                            <td><%= availability%></td>
                                            <td>
                                                <form action="http://localhost:8080/Platera-Main/RestaurantEditDish" method="POST">
                                                    <input type="hidden" name="id" value="<%= itemId%>">
                                                    <button type="submit" class="btn-edit">Edit</button>
                                                </form>
                                                <form action="http://localhost:8080/Platera-Main/DeleteDish" method="POST" onsubmit="return confirm('Are you sure you want to delete this dish?');">
                                                    <input type="hidden" name="id" value="<%= itemId%>">
                                                    <button type="submit" class="btn-delete">Delete</button>
                                                </form>
                                            </td>

                                        </tr>

                                        <%
                                            }
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        %>
                                        <tr>
                                            <td colspan="7">An error occurred while fetching menu items.</td>
                                        </tr>
                                        <%
                                                } finally {
                                                    if (rs != null) {
                                                        try {
                                                            rs.close();
                                                        } catch (SQLException ignored) {
                                                        }
                                                    }
                                                    if (stmt != null) {
                                                        try {
                                                            stmt.close();
                                                        } catch (SQLException ignored) {
                                                        }
                                                    }
                                                    if (conn != null) {
                                                        try {
                                                            conn.close();
                                                        } catch (SQLException ignored) {
                                                        }
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

                                                    function signout() {
                                                        localStorage.removeItem('authtoken');
                                                        localStorage.removeItem('admin');
                                                        window.location.href = '../AddRestaurent/AddRestaurent.html#Signin-popup';
                                                    }
        </script>



    </body>
</html>
