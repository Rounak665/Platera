// -----Delivery Dashboard-----------------------------------------------

document.addEventListener("DOMContentLoaded", function () {
    const startDeliveryBtn = document.querySelector('.start-delivery');
    const endDeliveryBtn = document.querySelector('.end-delivery');

    // Check the current delivery status from localStorage
    const deliveryStatus = localStorage.getItem('deliveryStatus');

    // If delivery is already started, show the end button and hide the start button
    if (deliveryStatus === 'started') {
        startDeliveryBtn.style.display = 'none';
        endDeliveryBtn.style.display = 'block';
    } else {
        startDeliveryBtn.style.display = 'block';
        endDeliveryBtn.style.display = 'none';
    }

    // When the 'Ready to Deliver' button is clicked
    startDeliveryBtn.addEventListener('click', function () {
        startDeliveryBtn.style.display = 'none'; // Hide start button
        endDeliveryBtn.style.display = 'block';  // Show end button

        // Save the delivery status in localStorage
        localStorage.setItem('deliveryStatus', 'started');
    });

    // When the 'Call it a Day' button is clicked
    endDeliveryBtn.addEventListener('click', function () {
        endDeliveryBtn.style.display = 'none';  // Hide end button
        startDeliveryBtn.style.display = 'block'; // Show start button

        // Save the delivery status in localStorage
        localStorage.setItem('deliveryStatus', 'ended');
    });
});

document.querySelector("#menu").addEventListener("click", function () {
    document.querySelector(".sidebar").classList.add("activate");
});

document.querySelector(".sidebar .close-btn").addEventListener("click", function () {
    document.querySelector(".sidebar").classList.remove("activate");
});


document.addEventListener("DOMContentLoaded", function () {
    const startDeliveryBtn = document.querySelector('.start-delivery');
    const endDeliveryBtn = document.querySelector('.end-delivery');

    startDeliveryBtn.addEventListener('click', function () {
        startDeliveryBtn.style.display = 'none'; // Hide start button
        endDeliveryBtn.style.display = 'block';  // Show end button
    });

    endDeliveryBtn.addEventListener('click', function () {
        endDeliveryBtn.style.display = 'none';  // Hide end button
        startDeliveryBtn.style.display = 'block'; // Show start button
    });
});

// -------------Delivery Orders------------------------

document.querySelector("#menu").addEventListener("click", function() {
    document.querySelector(".sidebar").classList.add("activate");
});

document.querySelector(".sidebar .close-btn").addEventListener("click", function() {
    document.querySelector(".sidebar").classList.remove("activate");
});




document.addEventListener('DOMContentLoaded', () => {
    // Checking Delivery Status
    const orderListElem = document.getElementById('order-list'); // Get the order list container

// Check the delivery status from localStorage
const deliveryStatus = localStorage.getItem('deliveryStatus');

// Initially hide or show the order slabs based on delivery status
if (deliveryStatus === 'started') {
  orderListElem.style.display = 'block'; // Show the order slabs
} else {
  orderListElem.style.display = 'none';  // Hide the order slabs
}


      // Timer Script
      let timerElement = document.querySelector('.otp-timer');
      let timeLeft = 120; // 2 minutes = 120 seconds
      let timerInterval; // Declare the timer interval variable

      // Get the verify button and OTP input fields
      const verifyButton = document.querySelector('.btn-verify');
      const otpInputs = document.querySelectorAll('.otp-input input');

      // Function to check if all OTP inputs are filled
      const checkOtpInputs = () => {
          const allFilled = Array.from(otpInputs).every(input => input.value.length === 1);
          verifyButton.disabled = !allFilled; // Enable button if all inputs are filled, otherwise disable it
      };

      // Add event listeners to each OTP input field
      otpInputs.forEach(input => {
          input.addEventListener('input', checkOtpInputs); // Call the check function on input change
      });

      // Initially disable the verify button
      verifyButton.disabled = true;

      const updateTimer = () => {
          let minutes = Math.floor(timeLeft / 60);
          let seconds = timeLeft % 60;

          // Add leading zero to seconds if less than 10
          seconds = seconds < 10 ? '0' + seconds : seconds;

          // Update the timer display
          timerElement.textContent = `${minutes}:${seconds}`;

          // Stop the timer when it reaches 0
          if (timeLeft > 0) {
              timeLeft--;
          } else {
              clearInterval(timerInterval); // Stop the interval when timer reaches 0
          }
      };

      // Start the timer when the handover-order button is clicked
      document.querySelector(".handover-order").addEventListener("click", function() {
          document.querySelector(".popup").classList.add("otp");

          // Reset the timer to 2 minutes whenever the popup is opened
          timeLeft = 120;

          // Start the timer if it isn't already running
          clearInterval(timerInterval); // Clear any previous interval to avoid multiple timers
          timerInterval = setInterval(updateTimer, 1000); // Start the interval
          updateTimer(); // Run it immediately to display the initial value
      });

      // Order Handling Script
      const orders = [
          { orderNumber: 1, date: 'June 1, 2020, 08:22 AM', price: 202.00, active: true },
          { orderNumber: 2, date: 'June 1, 2020, 08:22 AM', price: 202.00, active: false },
          { orderNumber: 3, date: 'June 1, 2020, 08:22 AM', price: 202.00, active: false },
          { orderNumber: 4, date: 'June 1, 2020, 08:22 AM', price: 202.00, active: false },
          { orderNumber: 5, date: 'June 1, 2020, 08:22 AM', price: 202.00, active: false }
      ];

      let orderAccepted = false; // Tracks if the order is accepted

      // Get the buttons and sections
      const acceptOrderButton = document.querySelector('.accept-order');
      const rejectOrderButton = document.querySelector('.reject-order');
      const handoverOrderButton = document.querySelector('.handover-order');
      const deliveryOrderSection = document.querySelector('.delivery-order');
      const deliveredOrderSection = document.querySelector('.delivered-order');
      const orderListElement = document.getElementById('order-list');

      // Initially hide the delivery and delivered order sections
      deliveryOrderSection.style.display = 'none';
      deliveredOrderSection.style.display = 'none';

      // Function to remove the active class from all order-slab divs
      function removeActiveClass() {
          const slabs = document.querySelectorAll('.order-slab');
          slabs.forEach(slab => slab.classList.remove('active'));
      }

     // Function to handle slab click
function handleSlabClick(event) {
removeActiveClass(); // Remove active class from all elements
event.currentTarget.classList.add('active'); // Add active class to the clicked slab

// Show the delivery-order section only if the order has not been accepted yet
if (!orderAccepted) {
  deliveryOrderSection.style.display = 'block';  // Show the delivery order section
  deliveredOrderSection.style.display = 'none';  // Ensure the delivered order section is hidden
}
}
      // Handle Accept Order Button click
      acceptOrderButton.addEventListener('click', () => {
          deliveryOrderSection.style.display = 'none'; // Hide the delivery order section
          deliveredOrderSection.style.display = 'block'; // Show the delivered order section
          orderAccepted = true; // Set orderAccepted to true, preventing delivery-order from showing again on slab click
      });

      // Handle Reject Order Button click
rejectOrderButton.addEventListener('click', () => {
deliveryOrderSection.style.display = 'none'; // Hide the delivery order section
orderAccepted = false; // Reset orderAccepted so the delivery order can be shown again on slab click

// Find the currently active order-slab
const activeOrderSlab = document.querySelector('.order-slab.active');

if (activeOrderSlab) {
  // Remove the active order-slab from the DOM
  const nextOrderSlab = activeOrderSlab.nextElementSibling; // Get the next sibling

  // Remove the active class from the current slab and remove it from DOM
  activeOrderSlab.remove();

  // If there is a next order slab, make it active
  if (nextOrderSlab) {
      nextOrderSlab.classList.add('active'); // Add active class to the next slab
  }
}
});

      // Dynamically create and append order slabs (your order data)
      orders.forEach(order => {
          const orderItem = document.createElement('div');
          orderItem.classList.add('order-slab');

          // Add order information to the created order slab
          orderItem.innerHTML = `
              <div class="order-information">
                  <span class="order-num">Order #${order.orderNumber}</span>
                  <span class="order-date">${order.date}</span>
              </div>
              <div>
                  <span class="order-price">₹${order.price.toFixed(2)}</span>
              </div>
              <button class="order-button">
                  <img src="https://img.icons8.com/ios-filled/50/000000/forward.png" alt="Go">
              </button>
          `;

          // Attach the click event listener to each order slab
          orderItem.addEventListener('click', handleSlabClick);

          // Append the created slab to the order list
          orderListElement.appendChild(orderItem);
      });

      // Close the popup and remove the active order-slab when the Verify button is clicked
verifyButton.addEventListener("click", function() {
// Find the currently active order-slab
const activeOrderSlab = document.querySelector('.order-slab.active');

if (activeOrderSlab) {
  // Remove the active order-slab from the DOM
  const nextOrderSlab = activeOrderSlab.nextElementSibling; // Get the next sibling

  // Remove the active class from the current slab
  activeOrderSlab.remove();
  
  // If there is a next order slab, transfer the active class to it
  if (nextOrderSlab) {
      nextOrderSlab.classList.add('active'); // Add active class to the next slab
  }
  // Hide the delivery order section
}

// Ensure the delivered order section is also hidden
deliveredOrderSection.style.display = 'none'; 
orderAccepted = false; 

// Close the popup
document.querySelector(".popup").classList.remove("otp");

// Clear the timer when the popup is closed
clearInterval(timerInterval);

// Clear all OTP inputs
document.querySelectorAll('.otp-input input').forEach(input => {
  input.value = ''; // Reset the input value
});
});


      // Close the popup when the back-icon is clicked
      document.querySelectorAll(".back-icon, .btn-verify").forEach(element => {
          element.addEventListener("click", function() {
              document.querySelector(".popup").classList.remove("otp");

              // Clear the timer when the popup is closed
              clearInterval(timerInterval);

              // Clear all OTP inputs
              document.querySelectorAll('.otp-input input').forEach(input => {
                  input.value = ''; // Reset the input value
              });
          });
      });

      // OTP input logic for auto-focus and preventing non-numeric input
      document.querySelectorAll('.otp-input input').forEach((input, index, inputs) => {
          input.addEventListener('input', (e) => {
              // Ensure only one digit is entered
              if (e.target.value.length > 1) {
                  e.target.value = e.target.value.slice(0, 1);
              }

              // Move to the next input field when a digit is entered
              if (e.target.value !== '' && index < inputs.length - 1) {
                  inputs[index + 1].focus();
              }
          });

          input.addEventListener('keydown', (e) => {
              if (e.key !== 'Backspace' && isNaN(Number(e.key))) {
                  e.preventDefault(); // Prevent non-numeric keys
              }

              // Move to the previous input field when Backspace is pressed
              if (e.key === 'Backspace' && e.target.value === '' && index > 0) {
                  inputs[index - 1].focus();
              }
          });
      });
  });