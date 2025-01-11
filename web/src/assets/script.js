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

// Menu Section Carousal
const images = document.querySelectorAll(".carousel-image");
let currentImageIndex = 0;

// Function to show the next image
function showNextImage() {
    images[currentImageIndex].classList.remove("active");
    currentImageIndex = (currentImageIndex + 1) % images.length;
    images[currentImageIndex].classList.add("active");
}

// Change image every 3 seconds
setInterval(showNextImage, 3000);


// Show Error Popup
// function showErrorPopup(message) {
//     document.getElementById('errorMessage').innerText = message;
//     document.getElementById('errorPopup').style.display = 'flex';
// }

// // Close Error Popup
// document.getElementById('closeErrorPopup').addEventListener('click', function() {
//     document.getElementById('errorPopup').style.display = 'none';
// });