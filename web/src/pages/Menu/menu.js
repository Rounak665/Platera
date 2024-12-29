const track = document.querySelector('.carousel-track');
const slides = Array.from(track.children);
const nextButton = document.querySelector('.carousel-button.next');
const prevButton = document.querySelector('.carousel-button.prev');

const slideWidth = slides[0].getBoundingClientRect().width;

// Arrange the slides next to one another
const setSlidePosition = (slide, index) => {
    slide.style.left = slideWidth * index + 'px';
};
slides.forEach(setSlidePosition);

const moveToSlide = (track, currentSlide, targetSlide) => {
    track.style.transform = 'translateX(-' + targetSlide.style.left + ')';
    currentSlide.classList.remove('current-slide');
    targetSlide.classList.add('current-slide');
};

// When I click left, move slides to the left
prevButton.addEventListener('click', e => {
    const currentSlide = track.querySelector('.current-slide');
    const prevSlide = currentSlide.previousElementSibling;

    if (prevSlide) {
        moveToSlide(track, currentSlide, prevSlide);
    }
});

// When I click right, move slides to the right
nextButton.addEventListener('click', e => {
    const currentSlide = track.querySelector('.current-slide');
    const nextSlide = currentSlide.nextElementSibling;

    if (nextSlide) {
        moveToSlide(track, currentSlide, nextSlide);
    }
});

// Set the initial current slide
slides[0].classList.add('current-slide');


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

// // location in navbar
// function filterLocations() {
//     const searchInput = document.getElementById("location-search").value.toLowerCase();
//     const dropdown = document.getElementById("location-select");
//     const options = dropdown.options;

//     // Iterate through the options and hide those that don't match the search
//     for (let i = 0; i < options.length; i++) {
//         const option = options[i];
//         const locationName = option.text.toLowerCase();

//         if (locationName.includes(searchInput) || searchInput === "") {
//             option.style.display = ""; // Show option
//         } else {
//             option.style.display = "none"; // Hide option
//         }
//     }
// }
// function selectLocation() {
//     const searchInput = document.getElementById("location-search").value;
//     document.getElementById("selected-location").textContent = `Selected Location: ${searchInput || 'None'}`;
//}
