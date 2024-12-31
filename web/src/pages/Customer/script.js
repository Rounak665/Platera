
// JavaScript for Welcome Popup
document.addEventListener("DOMContentLoaded", function() {
    const welcomePopup = document.getElementById("welcomePopup");
    const closePopupBtn = document.getElementById("closePopupBtn");

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
// let cart = [];
// function addToCart(itemName, price) {
//     cart.push({ name: itemName, price });
//     updateCartDisplay();
// }

// function updateCartDisplay() {
//     const cartCount = document.getElementById("cart-count");
//     cartCount.textContent = cart.length;

//     const cartItems = document.getElementById("cart-items");
//     const cartTotal = document.getElementById("cart-total");
//     cartItems.innerHTML = cart.map(item => `<li>${item.name} - $${item.price.toFixed(2)}</li>`).join('');
//     cartTotal.textContent = cart.reduce((sum, item) => sum + item.price, 0).toFixed(2);
// }

// -------------------Cart Section Script-------------------
function toggleDetails(row) {
    // Toggle the background color
    row.classList.toggle('active');
    // Find the next row (details row)
    const nextRow = row.nextElementSibling;
    nextRow.classList.toggle('show');
    // Toggle the dropdown icon
    const icon = row.querySelector('.dropdown');
    icon.classList.toggle('rotate');
  }
  
  // checkout to paynow transfer
  const checkoutButton = document.querySelector('.checkout-btn');
  if (checkoutButton) {
      checkoutButton.addEventListener('click', function () {
          // Hide the cart checkout container
          document.querySelector('.checkout').style.display = 'none';
  
          // Show the payment checkout container
          document.querySelector('.paynow').style.display = 'block';
      });
  }

//   Paynow to checkout
  const backToCheckoutButton = document.getElementById("backToCheckout");
if (backToCheckoutButton) {
    backToCheckoutButton.addEventListener("click", function () {
        // Hide the payment checkout container
        document.querySelector('.paynow').style.display = 'none';

        // Show the cart checkout container
        document.querySelector('.checkout').style.display = 'block';
    });
}

  
  // cart quantity and total price update
  
  document.addEventListener("DOMContentLoaded", () => {
    const deliveryChargesInput = document.querySelector(".checkout .delivery_charges"); // Delivery charges in checkout
    const subtotalInputCheckout = document.querySelector(".checkout .subtotal"); // Subtotal in checkout
    const totalInputCheckout = document.querySelector(".checkout .total"); // Total in checkout
  
    const subtotalInputPaynow = document.querySelector(".paynow .subtotal"); // Subtotal in paynow
    const totalInputPaynow = document.querySelector(".paynow .total"); // Total in paynow
    const deliveryChargesInputPaynow = document.querySelector(".paynow .delivery_charges"); // Delivery charges in paynow
  
    // Function to update the cart summary for the checkout and sync it with paynow
//    const updateCartSummary = () => {
//        let subtotal = 0;
//  
//        // Loop through all visible cart items and sum up their total prices
//        document.querySelectorAll(".checkout .cart-item").forEach(cartItem => {
//            const totalPriceInput = cartItem.querySelector(".total-price");
//            if (cartItem.style.display !== "none") {
//                const totalPrice = parseFloat(totalPriceInput.value.replace("₹", ""));
//                subtotal += totalPrice;
//            }
//        });
//  
//        // Update subtotal in checkout
//        subtotalInputCheckout.value = `₹${subtotal.toFixed(2)}`;
//  
//        // Calculate total (subtotal + delivery charges)
//        const deliveryCharges = parseFloat(deliveryChargesInput.value.replace("₹", ""));
//        const total = subtotal + deliveryCharges;
//  
//        // Update total in checkout
//        totalInputCheckout.value = `₹${total.toFixed(2)}`;
//  
//        // Sync the values with the paynow section
//        subtotalInputPaynow.value = subtotalInputCheckout.value;
//        totalInputPaynow.value = totalInputCheckout.value;
//        deliveryChargesInputPaynow.value = deliveryChargesInput.value;
//    };
  
    // Add event listeners to quantity buttons
    document.querySelectorAll(".checkout .quantity-btn").forEach(button => {
        button.addEventListener("click", () => {
            const cartItem = button.closest(".cart-item"); // Find the parent cart item
            const quantityInput = cartItem.querySelector(".quantity-number"); // Quantity display
            const priceInput = cartItem.querySelector(".cart-item-price"); // Price per item
            const totalPriceInput = cartItem.querySelector(".total-price"); // Total price display
  
            // Parse values
            let quantity = parseInt(quantityInput.value);
            const price = parseFloat(priceInput.value.replace("₹", ""));
  
            // Check which button was clicked
            if (button.textContent === "+") {
                // Increase quantity
                quantity += 1;
                quantityInput.value = quantity;
  
                // Update total price for the item
                const newTotal = (price * quantity).toFixed(2);
                totalPriceInput.value = `₹${newTotal}`;
            } else if (button.textContent === "-") {
                // Decrease quantity
                if (quantity > 1) {
                    quantity -= 1;
                    quantityInput.value = quantity;
  
                    // Update total price for the item
                    const newTotal = (price * quantity).toFixed(2);
                    totalPriceInput.value = `₹${newTotal}`;
                } else {
                    // Hide the cart item if quantity is less than 1
                    cartItem.style.display = "none";
                }
            }
  
            // Update cart summary (subtotal and total) and sync
            updateCartSummary();
        });
    });
  
    // Initial calculation of the cart summary (in case page loads with pre-filled values)
    updateCartSummary();
  });

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
const closeCartSectionCheckout = document.getElementById("closeCartSectionCheckout");
const closeCartSectionPaynow = document.getElementById("closeCartSectionPaynow");

// Debugging logs
console.log('profileIcon:', profileIcon);
console.log('userSection:', userSection);
console.log('closeUserSection:', closeUserSection);
console.log('cartIcon:', cartIcon);
console.log('cartSection:', cartSection);
console.log('closeCartSectionCheckout:', closeCartSectionCheckout);
console.log('closeCartSectionPaynow:', closeCartSectionPaynow);

profileIcon.addEventListener('click', () => {
    console.log('profileIcon clicked');
    if (userSection.style.right === '0%') {
        userSection.style.right = '-50%'; // Slide out user section
    } else {
        userSection.style.right = '0%'; // Slide in user section
        cartSection.style.right = '-50%'; // Ensure cart is hidden
    }
    console.log('userSection.style.right:', userSection.style.right);
    console.log('cartSection.style.right:', cartSection.style.right);
});

cartIcon.addEventListener('click', () => {
    console.log('cartIcon clicked');
    if (cartSection.style.right === '0%') {
        cartSection.style.right = '-50%'; // Slide out cart section
    } else {
        cartSection.style.right = '0%'; // Slide in cart section
        userSection.style.right = '-50%'; // Ensure user section is hidden
    }
    console.log('cartSection.style.right:', cartSection.style.right);
    console.log('userSection.style.right:', userSection.style.right);
});

// Close buttons functionality
if (closeCartSectionCheckout) {
    closeCartSectionCheckout.addEventListener("click", () => {
        console.log('closeCartSectionCheckout clicked');
        document.getElementById("cartSection").style.right = "-50%";
    });
}

if (closeCartSectionPaynow) {
    closeCartSectionPaynow.addEventListener("click", () => {
        console.log('closeCartSectionPaynow clicked');
        document.getElementById("cartSection").style.right = "-50%";
    });
}

if (closeUserSection) {
    closeUserSection.addEventListener("click", () => {
        console.log('closeUserSection clicked');
        userSection.style.right = "-50%"; // Slide out user section
    });
}

window.onload = function() {
    console.log('window.onload');
    // Check if the URL contains the hash for the cart section
    if (window.location.hash === '#cartSection') {
        console.log('URL contains #cartSection');
        // Slide in the cart section
        document.querySelector('.cart-section').style.right = '0%';
        // Ensure user section is hidden
        document.querySelector('.user-section').style.right = '-50%';
    }

    // Display profile setup popup after a delay
    setTimeout(function () {
        document.getElementById('profileSetupPopup').style.display = 'flex';
    }, 0); // Adjust the delay as needed

    // Handle profile setup button click
    document.getElementById('profileSetupBtn').addEventListener('click', function () {
        window.location.href = './CustomerDashboard/CustomerProfile.jsp';
    });
};