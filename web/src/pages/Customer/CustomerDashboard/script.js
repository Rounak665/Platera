// ----------------Sidebar----------------------------
// Toggle the sidebar menu visibility
const menuToggle = document.querySelector('#menu');
const closeButton = document.querySelector('.close-btn');
const sidebar = document.querySelector('.sidebar');

menuToggle.addEventListener('click', () => {
    sidebar.classList.add('activate');
});

closeButton.addEventListener('click', () => {
    sidebar.classList.remove('activate');
});




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
const checkoutButton = document.querySelector('.checkout-button');
if (checkoutButton) {
    checkoutButton.addEventListener('click', function () {
        // Hide the cart checkout container
        document.querySelector('.checkout').style.display = 'none';

        // Show the payment checkout container
        document.querySelector('.paynow').style.display = 'block';
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
  const updateCartSummary = () => {
      let subtotal = 0;

      // Loop through all visible cart items and sum up their total prices
      document.querySelectorAll(".checkout .cart-item").forEach(cartItem => {
          const totalPriceInput = cartItem.querySelector(".total-price");
          if (cartItem.style.display !== "none") {
              const totalPrice = parseFloat(totalPriceInput.value.replace("₹", ""));
              subtotal += totalPrice;
          }
      });

      // Update subtotal in checkout
      subtotalInputCheckout.value = `₹${subtotal.toFixed(2)}`;

      // Calculate total (subtotal + delivery charges)
      const deliveryCharges = parseFloat(deliveryChargesInput.value.replace("₹", ""));
      const total = subtotal + deliveryCharges;

      // Update total in checkout
      totalInputCheckout.value = `₹${total.toFixed(2)}`;

      // Sync the values with the paynow section
      subtotalInputPaynow.value = subtotalInputCheckout.value;
      totalInputPaynow.value = totalInputCheckout.value;
      deliveryChargesInputPaynow.value = deliveryChargesInput.value;
  };

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







document.addEventListener('DOMContentLoaded', () => {
  // ----------------Settings Section Script------------------------

  // Toggle for Account Tab
  document.getElementById('account-tab').addEventListener('click', () => {
      document.getElementById('account-section').style.display = 'block';
      document.getElementById('notifications-section').style.display = 'none';
      document.getElementById('privacy-policy').style.display = 'none';
      document.getElementById('help-section').style.display = 'none';
      document.getElementById('security-section').style.display = 'none';
  });

  // Toggle for Notification Tab
  document.getElementById('notification-tab').addEventListener('click', () => {
      document.getElementById('notifications-section').style.display = 'block';
      document.getElementById('account-section').style.display = 'none';
      document.getElementById('privacy-policy').style.display = 'none';
      document.getElementById('help-section').style.display = 'none';
      document.getElementById('security-section').style.display = 'none';
  });

  // Toggle for Privacy Policy Tab
  document.getElementById('privacy-policy-tab').addEventListener('click', () => {
      document.getElementById('privacy-policy').style.display = 'block';
      document.getElementById('account-section').style.display = 'none';
      document.getElementById('notifications-section').style.display = 'none';
      document.getElementById('help-section').style.display = 'none';
      document.getElementById('security-section').style.display = 'none';
  });

  // Toggle for Help Tab
  document.getElementById('help-tab').addEventListener('click', () => {
      document.getElementById('help-section').style.display = 'block';
      document.getElementById('account-section').style.display = 'none';
      document.getElementById('notifications-section').style.display = 'none';
      document.getElementById('privacy-policy').style.display = 'none';
      document.getElementById('security-section').style.display = 'none';
  });

  // Toggle for Security Tab
  document.getElementById('security-tab').addEventListener('click', () => {
      document.getElementById('security-section').style.display = 'flex';
      document.getElementById('account-section').style.display = 'none';
      document.getElementById('notifications-section').style.display = 'none';
      document.getElementById('privacy-policy').style.display = 'none';
      document.getElementById('help-section').style.display = 'none';
  });
});




// Two-Factor Authentication Toggles
document.getElementById('authenticator-toggle').addEventListener('change', (e) => {
  if (e.target.checked) {
    alert('Authenticator App Enabled!');
  } else {
    alert('Authenticator App Disabled!');
  }
});

document.getElementById('sms-toggle').addEventListener('change', (e) => {
  if (e.target.checked) {
    alert('Text Message Authentication Enabled!');
  } else {
    alert('Text Message Authentication Disabled!');
  }
});

// Cancel Button Action
document.getElementById('cancel-btn').addEventListener('click', () => {
  alert('Changes were canceled.');
});

// Save Changes Action
document.getElementById('save-btn').addEventListener('click', () => {
  alert('Changes saved successfully!');
});


// -------------------Order Section Script-------------------
function cancelOrder(orderId) {
  if (confirm("Are you sure you want to cancel this order?")) {
      // Perform AJAX request or redirect to cancel order endpoint
      console.log("Order cancelled: " + orderId);
  }
}


