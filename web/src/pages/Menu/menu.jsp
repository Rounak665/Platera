<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery Menu</title>
    <link rel="stylesheet" href="./menu.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <header>
        <nav class="navbar">
            <div class="nav-left">
                <img src="./Assets/PlateraLogo-red.png" alt="Logo" class="logo">
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
                <li><a href="../RestaurantsInUser/restaurantsInUser.jsp">Restaurants</a></li>
                <li id="active"><a href="./menu.jsp">Menu</a></li>
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
            <h2>Welcome to Our Menu and Cuisines</h2>
            <div class="search-bar">
                <select id="search-category">
                    <option value="dishes">Dishes</option>
                    <option value="cuisines">Cuisines</option>
                </select>
                <input type="text" id="search-input" placeholder="Search for Dishes or Cuisines..." />
                <button id="search-button">Search</button>
            </div>
        </div>
    </section>

    <div class="dishes">
        <h2>Our Dishes</h2>
        <div class="carousel-container">
            <button class="carousel-button prev">❮</button>
            <div class="carousel-track-container">
                <ul class="carousel-track">
                    <li class="carousel-slide">
                        <img src="https://via.placeholder.com/200x150" alt="Dish 1">
                        <h3>Dish 1</h3>
                    </li>
                    <li class="carousel-slide">
                        <img src="https://via.placeholder.com/200x150" alt="Dish 2">
                        <h3>Dish 2</h3>
                    </li>
                    <li class="carousel-slide">
                        <img src="https://via.placeholder.com/200x150" alt="Dish 3">
                        <h3>Dish 3</h3>
                    </li>
                    <li class="carousel-slide">
                        <img src="https://via.placeholder.com/200x150" alt="Dish 4">
                        <h3>Dish 4</h3>
                    </li>
                </ul>
            </div>
            <button class="carousel-button next">❯</button>
        </div>
    </div>

    <div class="cuisines">
        <h2>Our Cuisines</h2>
        <div class="cuisine-list">
            <div class="cuisine">
                <img src="https://via.placeholder.com/200x150" alt="Cuisine 1">
                <h3>Cuisine 1</h3>
            </div>
            <div class="cuisine">
                <img src="https://via.placeholder.com/200x150" alt="Cuisine 2">
                <h3>Cuisine 2</h3>
            </div>
            <div class="cuisine">
                <img src="https://via.placeholder.com/200x150" alt="Cuisine 3">
                <h3>Cuisine 3</h3>
            </div>
            <div class="cuisine">
                <img src="https://via.placeholder.com/200x150" alt="Cuisine 4">
                <h3>Cuisine 4</h3>
            </div>
        </div>
    </div>

    <div class="popular-dishes">
        <h2>Popular Dishes</h2>
        <div class="dish-cards">
            <div class="dish-card">
                <img src="../../../Public/images/Cuisine (zipp)/Burgers/pic1.jpeg" alt="Popular Dish 1">
                <h3>Popular Dish 1</h3>
                <p>Restaurant: Restaurant 1</p>
                <p>Price: $10.00</p>
                <p>Rating: 4.5</p>
                <p>Quantity: 1</p>
                <button class="add-to-cart">Add to Cart</button>
                <button class="view-cart">View Cart</button>
            </div>
            <div class="dish-card">
                <img src="../../../Public/images/Cuisine (zipp)/chinese food/As a Vegetarian In China.jpeg" alt="Popular Dish 2">
                <h3>Popular Dish 2</h3>
                <p>Restaurant: Restaurant 2</p>
                <p>Price: $12.00</p>
                <p>Rating: 4.7</p>
                <p>Quantity: 1</p>
                <button class="add-to-cart">Add to Cart</button>
                <button class="view-cart">View Cart</button>
            </div>
            <div class="dish-card">
                <img src="https://via.placeholder.com/200x150" alt="Popular Dish 3">
                <h3>Popular Dish 3</h3>
                <p>Restaurant: Restaurant 3</p>
                <p>Price: $8.00</p>
                <p>Rating: 4.3</p>
                <p>Quantity: 1</p>
                <button class="add-to-cart">Add to Cart</button>
                <button class="view-cart">View Cart</button>
            </div>
            <div class="dish-card">
                <img src="https://via.placeholder.com/200x150" alt="Popular Dish 4">
                <h3>Popular Dish 4</h3>
                <p>Restaurant: Restaurant 4</p>
                <p>Price: $15.00</p>
                <p>Rating: 4.8</p>
                <p>Quantity: 1</p>
                <button class="add-to-cart">Add to Cart</button>
                <button class="view-cart">View Cart</button>
            </div>
        </div>
    </div>

    <footer>
        <div class="container_footer">
            <div class="row">
                <div class="col">
                    <img src="./assets/PlateraLogo-red.png" alt="" />
                    <p>
                        Platera delivers delicious meals from your favorite local
                        restaurants straight to your door, combining speed and convenience
                        with every order. From quick bites to gourmet dishes, enjoy a
                        world of flavors anytime, anywhere!
                    </p>
                </div>
                <div class="col">
                    <h3>
                        Office
                        <div class="underline"><span></span></div>
                    </h3>
                    <p>ITFL Road</p>
                    <p>Whitefield, Bangalore</p>
                    <p>Karnatak, PIN 568629, INDIA</p>
                    <p class="email_id">support@platera.in</p>
                    <h4>+91 - 1234567891</h4>
                </div>
                <div class="col">
                    <h3>
                        Links
                        <div class="underline"><span></span></div>
                    </h3>
                    <ul>
                        <li>
                            <a
                                href="../FooterLinkPages/Terms&Conditions/Terms&Conditions.html"
                                >Terms & Conditions</a
                            >
                        </li>
                        <li>
                            <a href="../FooterLinkPages/PrivacyPolicy/PrivacyPolicy.html"
                               >Privacy Policy</a
                            >
                        </li>
                        <li><a href="../FooterLinkPages/Help/Help.html">Help</a></li>
                    </ul>
                </div>
                <div class="col promotion">
                    <h3>
                        Newsletter
                        <div class="underline"><span></span></div>
                    </h3>
                    <form>
                        <img id="mail" src="./Public/images/mail.png" alt="" />
                        <input
                            id="newsletter-email"
                            type="email"
                            name=""
                            id=""
                            placeholder="Enter Your Email Address"
                            />
                        <button type="submit">
                            <img id="send" src="./Public/images/send.png" alt="" />
                        </button>
                    </form>
                    <div class="social_icon">
                        <i class="fa-brands fa-facebook"></i>
                        <i class="fa-brands fa-instagram"></i>
                        <i class="fa-brands fa-pinterest"></i>
                        <i class="fa-brands fa-x-twitter"></i>
                    </div>
                </div>
            </div>
        </div>
        <hr />
        <p class="copyright">Platera @2024 - All Rights Reserved</p>
    </footer>

    <script src="./menu.js"></script>
</body>
</html>