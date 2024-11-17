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
                <h2 class="dash-title">Categories</h2>

                <div class="page-action">
                    <button class="btn btn-main" onclick="location.href='AddCategory.html'">
                        <span class="icon"><ion-icon name="add-circle"></ion-icon></span> Add Category
                    </button>
                </div>
                
                <section class="recent">
                    <div>
                        <div class="activity-card">
                            <h3>Added Categories</h3>
                            
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
                                        <!-- Categories will be populated here using JavaScript -->
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
            window.location.href = '../AddRestaurent/AddRestaurent.html#Signin-popup'; 
        }
    </script>

    <script>
       // Function to initialize default categories if not already in local storage
function initializeCategories() {
    const defaultCategories = [
        { id: 1, name: "Main Course" },
        { id: 2, name: "Snacks" },
        { id: 3, name: "Desserts" },
    ];
    
    // Check if categories exist in local storage
    if (!localStorage.getItem('categories')) {
        console.log("Initializing default categories.");
        localStorage.setItem('categories', JSON.stringify(defaultCategories));
    } else {
        console.log("Categories already exist in local storage.");
    }
}

// Function to render categories in the table
function renderCategories() {
    const tbody = document.getElementById('category-table-body');
    tbody.innerHTML = ''; // Clear previous entries

    // Load categories from local storage
    const categories = JSON.parse(localStorage.getItem('categories')) || [];
    console.log("Loaded categories:", categories); // Debugging line

    categories.forEach((category, index) => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>#${index + 1}</td>
            <td>${category.name}</td>
            <td>
                <button class="btn btn-main-gradient" onclick="removeCategory(${index})">
                    <span class="icon"><ion-icon name="trash"></ion-icon></span>
                </button>
            </td>
        `;
        tbody.appendChild(row);
    });
}

// Function to remove a category
function removeCategory(index) {
    const categories = JSON.parse(localStorage.getItem('categories')) || []; // Load existing categories
    categories.splice(index, 1); // Remove the category
    localStorage.setItem('categories', JSON.stringify(categories)); // Update local storage
    renderCategories(); // Re-render the table
}

// Initialize categories on page load
window.onload = () => {
    initializeCategories(); // Set default categories if none exist
    renderCategories(); // Render categories
};




    </script>
</body>
</html>
