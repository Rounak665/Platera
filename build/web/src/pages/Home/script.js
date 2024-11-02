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
}, 5000);

function moveSlide(step) {
    showSlide(currentSlide + step);
}

// Initial display
showSlide(0);

document.getElementById("location-dropdown").addEventListener("change", function() {
    const selectedLocation = this.value;
    console.log("Selected location:", selectedLocation);
    // Add functionality as needed for the selected location
});

document.querySelector(".search-bar button").addEventListener("click", function() {
    const searchTerm = document.querySelector(".search-bar input").value;
    console.log("Searching for:", searchTerm);
    // Add search functionality as needed
});
