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