<%@page import="FetchingClasses.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Delivery Executive Dashboard Overview</title>
        <link rel="stylesheet" href="Delivery.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>

        <!--Java Scriplets-->
        <%

            //        Integer user_id=(Integer) session.getAttribute("user_id");
            //        String name=(String) session.getAttribute("name");       
            //        String email=(String) session.getAttribute("email");
            //        Integer delivery_executive_id=(Integer) session.getAttribute("delivery_executive_id");
            //        String image=(String) session.getAttribute("image");
            //        String imagepath=request.getContextPath()+ '/' + image;
            //For debugging
            int user_id = 2;
            String name = "Arthur Morgan";
            String email = "ArthurMorgan1863@gmail.com";
            int delivery_executive_id = 49;
            String image = "DatabaseImages/Delivery_Executives/Arthur_Morgan.jpeg";
            String imagepath = request.getContextPath() + '/' + image;

        %>
        <!-- Welcome Popup -->


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
                                <span class="icon"><ion-icon name="home-sharp"></ion-icon></span>
                                <span>Home</span>
                            </a>
                        </li>
                        <li>
                            <a href="DeliveryOrders.jsp">
                                <span class="icon"><ion-icon name="cart"></ion-icon></span>
                                <span>Orders</span>
                            </a>
                        </li>
                        <li class="li_logout">
                            <a href="../AddRestaurent/AddRestaurent.html#Signin-popup">
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
                        <div class="logout_btn">
                            <span class="logout">Logout</span>
                            <span class="icon"><ion-icon name="power"></ion-icon></span>
                        </div>
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
                    <h2 class="dash-title">Hello, <%=name%></h2>

                    <div class="container">

                        <div class="profile">
                            <div class="personal-details">
                                <div class="personal-image"><img src="<%=imagepath%>" alt="Your-image"></div>
                                <div class="personal-description">
                                    <h5><%=name%></h5>
                                    <h6><span>&#9733;5.0</span><span>â¬¤1K+ Reviews</span></h6>
                                    <p>Joined June 2024</p>
                                    <button type="button" class="btn btn-primary">  Edit  </button>
                                </div>
                            </div>
                            <div class="order-details">
                                <div class="order-cards">
                                    <span class="icon" style="color: rgb(0, 200, 0);"><ion-icon name="checkmark-done-outline"></ion-icon></span>
                                    <h5>932</h5>
                                    <p>Finish Order</p>
                                </div>
                                <div class="order-cards">
                                    <span class="icon" style="color: rgb(255, 140, 0);"><ion-icon name="checkmark-circle"></ion-icon></span>
                                    <h5>1032</h5>
                                    <p>Order Delivered</p>
                                </div>
                                <div class="order-cards">
                                    <span class="icon" style="color: rgb(255, 0, 0);"><ion-icon name="close-circle"></ion-icon></span>
                                    <h5>103</h5>
                                    <p>Order Canceled</p>
                                </div>
                            </div>
                            <div class="earning">
                                <div class="earning-details">
                                    <div class="details-left">
                                        <span class="icon"><ion-icon name="wallet-outline"></ion-icon></span>
                                        <div>
                                            <p>Today's Earnings</p>
                                            <h5>â¹2,530</h5>
                                        </div>
                                    </div>
                                    <div class="details-right">
                                        <button class="start-delivery">Ready to Deliver</button>
                                        <button class="end-delivery">Call it a Day</button>
                                    </div>
                                </div>
                                <hr>
                                <div class="distance-details">
                                    <div class="distance-head">
                                        <span>Total Trip</span>
                                        <span>Total Distance</span>
                                        <span>Total Time</span>
                                    </div>
                                    <div class="distance-values">
                                        <span>15</span>
                                        <span>15Km</span>
                                        <span>90 Min</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="dash-performance">
                            <div class="dash-cards">
                                <div class="card-single">
                                    <span class="icon" style="color: rgb(153, 255, 1);"><ion-icon name="timer"></ion-icon></span>
                                    <h5>50%</h5>
                                    <p>Performance</p>
                                </div>
                                <div class="card-single">
                                    <span class="icon" style="color: rgb(255, 183, 1);"><ion-icon name="trending-up-outline"></ion-icon></span>
                                    <h5>80%</h5>
                                    <p>Min. Performance</p>
                                </div>
                                <div class="card-single">
                                    <span class="icon"><ion-icon name="podium"></ion-icon></span>
                                    <h5>75%</h5>
                                    <p>Avg. Performance</p>
                                </div>
                            </div>
                            <div class="statistics">
                                <h2>Your Orders</h2>
                                <div class="legend">
                                    <!--                              <span><span class="dot yellow"></span> Upcoming Orders</span>-->
                                </div>                
                            </div>
                        </div>

                    </div>

                </main>
            </div>
        </div>

        <!-- Scripts  -->

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


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


            document.addEventListener("DOMContentLoaded", function () {
                const startDeliveryBtn = document.querySelector('.start-delivery');
                const endDeliveryBtn = document.querySelector('.end-delivery');

                startDeliveryBtn.addEventListener('click', function () {
                    startDeliveryBtn.style.display = 'none'; // Hide start button
                    endDeliveryBtn.style.display = 'block';  // Show end button
                });

                endDeliveryBtn.addEventListener('click', function () {
                    endDeliveryBtn.style.display = 'none';  // Hide end button
                    startDeliveryBtn.style.display = 'block'; // Show start button
                });
            });

        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const startDeliveryBtn = document.querySelector('.start-delivery');
                const endDeliveryBtn = document.querySelector('.end-delivery');

                // Check the current delivery status from localStorage
                const deliveryStatus = localStorage.getItem('deliveryStatus');

                // If delivery is already started, show the end button and hide the start button
                if (deliveryStatus === 'started') {
                    startDeliveryBtn.style.display = 'none';
                    endDeliveryBtn.style.display = 'block';
                } else {
                    startDeliveryBtn.style.display = 'block';
                    endDeliveryBtn.style.display = 'none';
                }

                // When the 'Ready to Deliver' button is clicked
                startDeliveryBtn.addEventListener('click', function () {
                    startDeliveryBtn.style.display = 'none'; // Hide start button
                    endDeliveryBtn.style.display = 'block';  // Show end button

                    // Save the delivery status in localStorage
                    localStorage.setItem('deliveryStatus', 'started');
                });

                // When the 'Call it a Day' button is clicked
                endDeliveryBtn.addEventListener('click', function () {
                    endDeliveryBtn.style.display = 'none';  // Hide end button
                    startDeliveryBtn.style.display = 'block'; // Show start button

                    // Save the delivery status in localStorage
                    localStorage.setItem('deliveryStatus', 'ended');
                });
            });


            const ctx = document.getElementById('myChart').getContext('2d');
            const myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    datasets: [{
                            label: 'This Week',
                            data: [40, 60, 80, 20, 40, 70, 90], // Sample data
                            borderColor: '#f4c542',
                            borderWidth: 2,
                            fill: false,
                            tension: 0.4,
                            pointBackgroundColor: '#f4c542'
                        }, {
                            label: 'Last Week',
                            data: [30, 50, 60, 40, 30, 50, 70], // Sample data
                            borderColor: '#f54242',
                            borderWidth: 2,
                            fill: false,
                            tension: 0.4,
                            pointBackgroundColor: '#f54242'
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false, // Important for fitting the canvas within the div
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 100
                        }
                    },
                    plugins: {
                        legend: {
                            display: false // Hide default legend as you already have custom legend in HTML
                        },
                        tooltip: {
                            enabled: true, // Ensure tooltips appear
                            backgroundColor: '#333',
                            bodyColor: '#fff',
                            callbacks: {
                                label: function (context) {
                                    return context.parsed.y + ' Orders';  // Tooltip content
                                }
                            }
                        }
                    }
                }
            });


        </script>

    </body>
</html>
