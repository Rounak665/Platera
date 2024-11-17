<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Dashboard Overview</title>
    <link rel="stylesheet" href="./RestaurantDashboard.css"> <!-- Link to your CSS -->
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
                <h2 class="dash-title">Overview</h2>
                        
                <div class="dash-cards">
                    <div class="card-single">
                        <div class="card-body">
                            <span class="icon"><ion-icon name="card"></ion-icon></span>
                            <div>
                                <h5>Account Balance</h5>
                                <h4>₹30,659.45</h4>
                            </div>
                        </div>
                        <div class="card-footer">
                            <a href="">View all</a>
                        </div>
                    </div>
                    
                    <div class="card-single">
                        <div class="card-body">
                            <span class="icon"><ion-icon name="sync"></ion-icon></span>
                            <div>
                                <h5>Pending</h5>
                                <h4>₹19,500.45</h4>
                            </div>
                        </div>
                        <div class="card-footer">
                            <a href="">View all</a>
                        </div>
                    </div>
                    
                    <div class="card-single">
                        <div class="card-body">
                            <span class="icon"><ion-icon name="checkbox"></ion-icon></span>
                            <div>
                                <h5>Processed</h5>
                                <h4>₹20,659</h4>
                            </div>
                        </div>
                        <div class="card-footer">
                            <a href="">View all</a>
                        </div>
                    </div>
                </div>
                
                <section class="recent">
                    <div class="activity-card">
                        <h3>Recent menu items</h3>
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
                                    </tr>
                                </thead>
                                <tbody id="recent-menu-table">
                                    <!-- Recent menu items will be inserted here by JS -->
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

    <!-- main scripts -->

    <script>
        document.querySelector("#menu").addEventListener("click", function() {
    document.querySelector(".sidebar").classList.add("activate");
});

document.querySelector(".sidebar .close-btn").addEventListener("click", function() {
    document.querySelector(".sidebar").classList.remove("activate");
});
    </script>
    <script>
        function signout() {
    localStorage.removeItem('authtoken');
    localStorage.removeItem('admin');
    window.location.href = '../AddRestaurent/AddRestaurent.html#Signin-popup'; // Use a specific ID or identifier
}
    </script>


</body>
</html>
