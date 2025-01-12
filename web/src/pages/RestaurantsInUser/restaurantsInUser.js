const profileIcon = document.getElementById('profile-icon');
const cartIcon = document.getElementById('cart-icon');
const profileSection = document.getElementById('profile-section');
const cartSection = document.getElementById('cart-section');
const hamburgerMenu = document.getElementById('hamburger-menu');
const navLinks = document.querySelector('.nav-links');

// Toggle Profile Section
profileIcon.addEventListener('click', () => {
    profileSection.classList.toggle('active');
    cartSection.classList.remove('active');
});

// Toggle Cart Section
cartIcon.addEventListener('click', () => {
    cartSection.classList.toggle('active');
    profileSection.classList.remove('active');
});

// Toggle Hamburger Menu
hamburgerMenu.addEventListener('click', () => {
    navLinks.classList.toggle('active');
});

const profileCloseBtn = document.getElementById('profile-close-btn');
const cartCloseBtn = document.getElementById('cart-close-btn');

// Close Profile Section
profileCloseBtn.addEventListener('click', () => {
    profileSection.classList.remove('active');
});

// Close Cart Section
cartCloseBtn.addEventListener('click', () => {
    cartSection.classList.remove('active');
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

const dots = document.querySelectorAll('.dot');
let currentSlide = 0;

function updateDots() {
    dots.forEach((dot, index) => {
        dot.classList.toggle('active', index === currentSlide);
    });
}

setInterval(() => {
    currentSlide = (currentSlide + 1) % 5; // Loop through 5 images
    updateDots();
}, 5000); // Change image every 3 seconds

const banner = document.querySelector('.banner');
    
let currentIndex = 0;
const images = [
    'image1.jpg',
    'image2.jpg',
    'image3.jpg',
    'image4.jpg',
    'image5.jpg'
];

// Function to change background image with a smooth transition
function changeBannerImage() {
    banner.style.transition = 'background-image 4s ease-in-out'; // Smooth transition
    banner.style.backgroundImage = `linear-gradient(to bottom, rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.7)), url('${images[currentIndex]}')`;

    // Update the index for the next image
    currentIndex = (currentIndex + 1) % images.length;
}

// Call the function every 3 seconds
setInterval(changeBannerImage, 5000);

// Initialize the first image
changeBannerImage();

const searchCategory = document.getElementById('search-category');
const searchInput = document.getElementById('search-input');

// Listen for changes in the search category dropdown
searchCategory.addEventListener('change', function() {
    updatePlaceholder();
});

// Listen for input changes in the search bar
searchInput.addEventListener('input', function() {
    const query = searchInput.value;
    const category = searchCategory.value;

    // Handle search behavior based on category selection
    if (category === 'restaurants') {
        console.log(`Searching for restaurants: ${query}`);
    } else if (category === 'dishes') {
        console.log(`Searching for dishes: ${query}`);
    }
});

// Update the placeholder text based on the selected category
function updatePlaceholder() {
    const category = searchCategory.value;
    if (category === 'restaurants') {
        searchInput.placeholder = 'Search for restaurants...';
    } else {
        searchInput.placeholder = 'Search for dishes...';
    }
}

// Initialize placeholder
updatePlaceholder();

document.addEventListener("DOMContentLoaded", function() {
    const hamburgerMenu = document.getElementById('hamburger-menu');
    const mobileMenu = document.getElementById('mobile-menu');

    hamburgerMenu.addEventListener('click', function() {
        if (mobileMenu.style.display === "block") {
            mobileMenu.style.display = "none";
        } else {
            mobileMenu.style.display = "block";
        }
    });
});