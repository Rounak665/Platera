
// JavaScript for Welcome Popup
document.addEventListener("DOMContentLoaded", function() {
    const welcomePopup = document.getElementById("welcomePopup");
    const closePopupBtn = document.getElementById("closePopupBtn");

    // Show popup when page reloads
    welcomePopup.classList.add("active");

    // Close popup when the "Close" button is clicked
    closePopupBtn.addEventListener("click", function() {
        welcomePopup.classList.remove("active");
    });
});

// Toggle Modals
function toggleProfileModal() {
    const modal = document.getElementById("profileModal");
    modal.style.display = modal.style.display === "flex" ? "none" : "flex";
}

function toggleCartModal() {
    const modal = document.getElementById("cartModal");
    modal.style.display = modal.style.display === "flex" ? "none" : "flex";
}

// Cart Functionality
let cart = [];
function addToCart(itemName, price) {
    cart.push({ name: itemName, price });
    updateCartDisplay();
}

function updateCartDisplay() {
    const cartCount = document.getElementById("cart-count");
    cartCount.textContent = cart.length;

    const cartItems = document.getElementById("cart-items");
    const cartTotal = document.getElementById("cart-total");
    cartItems.innerHTML = cart.map(item => `<li>${item.name} - $${item.price.toFixed(2)}</li>`).join('');
    cartTotal.textContent = cart.reduce((sum, item) => sum + item.price, 0).toFixed(2);
}

// Close modals on outside click
window.onclick = function(event) {
    if (event.target == document.getElementById("profileModal")) toggleProfileModal();
    if (event.target == document.getElementById("cartModal")) toggleCartModal();
};

// Close modals on Escape key
document.addEventListener("keydown", function(event) {
    if (event.key === "Escape") {
        if (document.getElementById("profileModal").style.display === "flex") toggleProfileModal();
        if (document.getElementById("cartModal").style.display === "flex") toggleCartModal();
    }
});

let currentSlide = 0;
const slides = document.querySelectorAll(".carousel-slide img");
const totalSlides = slides.length;

// Initialize dots
const dotsContainer = document.getElementById("dots");
for (let i = 0; i < totalSlides; i++) {
    const dot = document.createElement("span");
    dot.addEventListener("click", () => showSlide(i));
    dotsContainer.appendChild(dot);
}
const dots = document.querySelectorAll(".dots span");

function showSlide(index) {
    currentSlide = (index + totalSlides) % totalSlides;
    const offset = -currentSlide * 100;
    document.querySelector(".carousel-slide").style.transform = `translateX(${offset}vw)`;
    
    // Update active dot
    dots.forEach((dot, i) => {
        dot.classList.toggle("active", i === currentSlide);
    });
}

// Auto-slide every 5 seconds
setInterval(() => {
    moveSlide(1);
}, 3000);

function moveSlide(step) {
    showSlide(currentSlide + step);
}

// Initial display
showSlide(0);

document.querySelector(".search-bar button").addEventListener("click", function() {
    const searchTerm = document.querySelector(".search-bar input").value;
    console.log("Searching for:", searchTerm);
    // Add search functionality as needed
});


// location in navbar

function filterLocations() {
    const searchInput = document.getElementById("location-search").value.toLowerCase();
    const dropdown = document.getElementById("location-select");
    const options = dropdown.options;

    // Iterate through the options and hide those that don't match the search
    for (let i = 0; i < options.length; i++) {
        const option = options[i];
        const locationName = option.text.toLowerCase();

        if (locationName.includes(searchInput) || searchInput === "") {
            option.style.display = ""; // Show option
        } else {
            option.style.display = "none"; // Hide option
        }
    }
}

function selectLocation() {
    const searchInput = document.getElementById("location-search").value;
    document.getElementById("selected-location").textContent = `Selected Location: ${searchInput || 'None'}`;
}

// Restaurant slider
function moveSlider(direction) {
    const slider = document.querySelector(".restaurant-slider");
    const cardWidth = document.querySelector(".restaurant-card").offsetWidth;
    slider.scrollLeft += direction * (cardWidth + 20); // Move by one card width plus gap
}

// Restaurants section
function filterRestaurants(criteria) {
    console.log("Filtering by:", criteria);
    // Logic to filter restaurants goes here
    // Example: Adjust slider items based on the selected criteria
}


// Sliding User Section and cart section

// JavaScript to handle the sliding effect for user and cart sections
const profileIcon = document.getElementById('profileIcon');
const userSection = document.getElementById('userSection');
const closeUserSection = document.getElementById('closeUserSection');

const cartIcon = document.getElementById('cartIcon');
const cartSection = document.getElementById('cartSection');
const closeCartSection = document.getElementById('closeCartSection');

profileIcon.addEventListener('click', () => {
    if (userSection.style.right === '0%') {
        userSection.style.right = '-50%'; // Slide out user section
    } else {
        userSection.style.right = '0%'; // Slide in user section
        cartSection.style.right = '-50%'; // Ensure cart is hidden
    }
});

cartIcon.addEventListener('click', () => {
    if (cartSection.style.right === '0%') {
        cartSection.style.right = '-50%'; // Slide out cart section
    } else {
        cartSection.style.right = '0%'; // Slide in cart section
        userSection.style.right = '-50%'; // Ensure user section is hidden
    }
});

// Close buttons functionality
closeUserSection.addEventListener('click', () => {
    userSection.style.right = '-50%'; // Slide out user section
});

closeCartSection.addEventListener('click', () => {
    cartSection.style.right = '-50%'; // Slide out cart section
});


