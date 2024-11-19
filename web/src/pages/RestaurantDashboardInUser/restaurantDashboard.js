// script.js

// Tab Switching
document.querySelectorAll('.tab').forEach((tab) => {
    tab.addEventListener('click', () => {
      document.querySelector('.tab.active').classList.remove('active');
      tab.classList.add('active');
    });
  });
  
  // Carousel Navigation
  const dealsContainer = document.querySelector('.deals');
  const prevBtn = document.querySelector('.prev');
  const nextBtn = document.querySelector('.next');
  
  let scrollAmount = 0;
  
  prevBtn.addEventListener('click', () => {
    dealsContainer.scrollLeft -= 200;
  });
  
  nextBtn.addEventListener('click', () => {
    dealsContainer.scrollLeft += 200;
  });
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
  