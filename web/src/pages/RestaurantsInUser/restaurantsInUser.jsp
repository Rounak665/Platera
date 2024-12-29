<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Navbar</title>
    <link rel="stylesheet" href="./restaurantsInUser.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <nav class="navbar">
            <div class="nav-left">
                <img src="./assets/PlateraLogo-red.png" alt="Logo" class="logo">
                <!-- <div class="search-container">
                    <input
                        type="text"
                        id="location-search"
                        class="location-search"
                        placeholder="Search for a location..."
                        /> 
                    <button class="select-location-btn" onclick="selectLocation()">
                        &#x2192;
                    </button>
                     Arrow button -->
                <!-- </div>
                <span id="selected-location" class="selected-location">Selected Location: None</span> -->
            </div>
            <ul class="nav-links">
                <li><a href="../Customer/Home.jsp">Home</a></li>
                <li id="active"><a href="./restaurantsInUser.jsp">Restaurants</a></li>
                <li><a href="../Menu/menu.jsp">Menu</a></li>
                <li><a href="#contact">Contact Us</a></li>
            </ul>
            <div class="nav-icons">
                <i class="profile-icon fa-solid" id="profile-icon">&#128100;</i>
                <i class="cart-icon fa-solid" id="cart-icon">&#128722;</i>
            </div>
            <div class="hamburger-menu" id="hamburger-menu">
                <i class="fa-solid fa-bars"></i>
            </div>
        </nav>
        <section class="side-section profile-section" id="profile-section">
            <button class="close-btn" id="profile-close-btn">&times;</button>
            <p>Profile Section</p>
        </section>
        <section class="side-section cart-section" id="cart-section">
            <button class="close-btn" id="cart-close-btn">&times;</button>
            <p>Cart Section</p>
        </section>
    </header>

    <section class="banner">
        <div class="banner-content">
            <h2>Best restaurants Near You</h2>
            <div class="search-bar">
                <select id="search-category">
                    <option value="restaurants">Restaurants</option>
                    <option value="dishes">Dishes</option>
                </select>
                <input type="text" id="search-input" placeholder="Search for restaurants or dishes..." />
                <button id="search-button">Search</button>
            </div>
        </div>
    </section>
    
    <section class="restaurants-section">
        <h2>Popular Restaurants</h2>
        <div class="restaurants-container">
            <!-- Restaurant Card 1 -->
            <div class="restaurant-card">
                <img src="./assets/product1.png" alt="Restaurant 1" />
                <h3>Restaurant 1</h3>
                <p>Type: Italian</p>
                <p>Location: New York, NY</p>
                <p>Rating: ★★★★☆</p>
            </div>
            <!-- Restaurant Card 2 -->
            <div class="restaurant-card">
                <img src="./assets/product2.png" alt="Restaurant 2" />                <h3>Restaurant 2</h3>
                <p>Type: Mexican</p>
                <p>Location: Los Angeles, CA</p>
                <p>Rating: ★★★☆☆</p>
            </div>
            <!-- Restaurant Card 3 -->
            <div class="restaurant-card">
                <img src="./assets/product3.png" alt="Restaurant 3" />                <h3>Restaurant 3</h3>
                <p>Type: Chinese</p>
                <p>Location: Chicago, IL</p>
                <p>Rating: ★★★★★</p>
            </div>
            <!-- Restaurant Card 4 -->
            <div class="restaurant-card">
                <img src="./assets/product4.png" alt="Restaurant 4" />                <h3>Restaurant 4</h3>
                <p>Type: Indian</p>
                <p>Location: San Francisco, CA</p>
                <p>Rating: ★★★★☆</p>
            </div>
            <!-- Restaurant Card 5 -->
            <div class="restaurant-card">
                <img src="./assets/product5.png" alt="Restaurant 5" />                <h3>Restaurant 5</h3>
                <p>Type: Thai</p>
                <p>Location: Miami, FL</p>
                <p>Rating: ★★★★☆</p>
            </div>
            <!-- Restaurant Card 6 -->
            <div class="restaurant-card">
                <img src="./assets/product6.avif" alt="Restaurant 6" />                <h3>Restaurant 6</h3>
                <p>Type: French</p>
                <p>Location: Boston, MA</p>
                <p>Rating: ★★★★☆</p>
            </div>
        </div>
    </section>
    

    <script src="./restaurantsInUser.js"></script>
</body>
</html>
