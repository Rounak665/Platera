<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="Admin.css">
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
                <div class="sidebar-toggle close-btn"><ion-icon name="close-outline" class="ico"></ion-icon></div>
                <div class="sidebar-header">
                    <div class="logo">
                        <img src="../../../Public/images/logo.png" alt="">
                    </div>
                </div>

                <div class="sidebar-menu">
                    <ul>
                        <li>
                            <a href="">
                                <span class="icon"><ion-icon name="bar-chart"></ion-icon></span>
                                <span>Dashboard Overview</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="icon"><ion-icon name="wine"></ion-icon></span>
                                <span>Order Management</span>
                            </a>
                        </li>
                        <li>
                            <a href="./Admin_Restaurant_Approval.jsp">
                                <span class="icon"><ion-icon name="restaurant"></ion-icon></span>
                                <span>Restaurant Approval</span>
                            </a>
                        </li>
                        <li>
                            <a href="./Admin_Delivery_Executive_Approval.jsp">
                                <span class="icon"><ion-icon name="bicycle"></ion-icon></span>
                                <span>Delivery Executive Management</span>
                            </a>
                        </li>
                        <!--                    <li class="li_logout">
                                                <form action="http://localhost:8080/Platera-Main/logout">
                                                    <span class="icon"><ion-icon name="power"></ion-icon></span>
                                                    <button type="submit">Logout</button>
                                                </form>
                                            </li>-->
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
                        <div class="logout_btn">
                            <form action="http://localhost:8080/Platera-Main/logout" class="d-flex align-items-center">
                                <button type="submit" class="btn d-flex align-items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-power" viewBox="0 0 16 16">
                                    <path d="M7.5 1v7h1V1z"></path>
                                    <path d="M3 8.812a5 5 0 0 1 2.578-4.375l-.485-.874A6 6 0 1 0 11 3.616l-.501.865A5 5 0 1 1 3 8.812"></path>
                                    </svg>
                                    <span class="ml-2">Logout</span>
                                </button>
                            </form>
                        </div>

                    </div>
                </header>

                <main>
                    <h2 class="dash-title">Order Management</h2>

                    <!-- Pending Orders Section -->
                    <section id="pending-orders">
                        <h2>Pending Orders</h2>
                        <table>
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Restaurant Name</th>
                                    <th>Customer Name</th>
                                    <th>Items Ordered</th>
                                    <th>Total Amount</th>
                                    <th>Order Status</th>
                                    <th>Assign Delivery Executive</th>
                                </tr>
                            </thead>
                            <tbody id="pending-orders-body">
                                <!-- Populate with JavaScript -->
                            </tbody>
                        </table>
                    </section>

                    <!-- Pending Delivery Section -->
                    <section id="pending-delivery">
                        <h2>Pending Delivery</h2>
                        <table>
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Restaurant Name</th>
                                    <th>Customer Name</th>
                                    <th>Items Ordered</th>
                                    <th>Total Amount</th>
                                    <th>Delivery Executive</th>
                                    <th>Delivery Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody id="pending-delivery-body">
                                <!-- Populate with JavaScript -->
                            </tbody>
                        </table>
                    </section>

                    <!-- Order History Section -->
                    <section id="order-history">
                        <h2>Order History</h2>
                        <table>
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Restaurant Name</th>
                                    <th>Customer Name</th>
                                    <th>Items Ordered</th>
                                    <th>Total Amount</th>
                                    <th>Delivery Executive</th>
                                    <th>Delivery Status</th>
                                </tr>
                            </thead>
                            <tbody id="order-history-body">
                                <!-- Populate with JavaScript -->
                            </tbody>
                        </table>
                    </section>
                </main>
            </div>
        </div>

        <!-- Scripts -->

        <!-- Icon Scripts -->
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <!--Bootstrap-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

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





