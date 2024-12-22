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
        <title>Categories</title>
        <link rel="stylesheet" href="RestaurantDashboard.css"> <!-- Use the same CSS as the home page -->
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
                            <span class="icon"><ion-icon name="add-circle"></ion-icon></span> Update Category
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
                                                Connection conn = null;
                                                PreparedStatement ps = null;
                                                ResultSet rs = null;

                                                // Get the restaurant_id from session
                    //                          Integer restaurantId = (Integer) session.getAttribute("restaurant_id");
                                                Integer restaurantId = 101;

                                                if (restaurantId == null) {
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
                                            %>
                                            <tr>
                                                <td><%= categoryId%></td>
                                                <td><%= categoryName%></td>
                                                <td>
                                                    <form action="http://localhost:8080/Platera-Main/RestaurantDeleteCategories" method="POST" onsubmit="return confirm('Are you sure you want to delete this category?');">
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

    </body>
</html>
