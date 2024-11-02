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

