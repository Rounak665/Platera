<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delivery Orders</title>
    <link rel="stylesheet" href="Delivery.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>

    <!-- loader -->
    <div class="loader">
        <div id="pl">
          <div>
            <video class="vid" src="../ContactUs/Assets/loader.mp4" autoplay muted loop></video>
          </div>
        </div>
      </div>

      <!-- otp popup -->

      <section class="popup">
        <div class="otp-popup">
            <div class="otp-content">
              <div class="otp-header">
                <ion-icon name="close-circle" class="back-icon"></ion-icon>
              </div>
              <div class="otp-body">
                <ion-icon name="notifications" class="otp-icon"></ion-icon>
                <h2>Verify Delivery Handover</h2>
                <p>We have sent you a one time password to customer's mobile</p>
                <div class="otp-timer">2:00</div>
                <div class="otp-input">
                    <input type="tel" maxlength="1" pattern="[0-9]*">
                    <input type="tel" maxlength="1" pattern="[0-9]*">
                    <input type="tel" maxlength="1" pattern="[0-9]*">
                    <input type="tel" maxlength="1" pattern="[0-9]*">
                </div>
                <p>Didn't receive the OTP? <a href="#">RESEND</a></p>
                <button class="btn-verify">Verify</button>
              </div>
            </div>
          </div>
      </section>

    <div>
        
        <div class="sidebar">
            <div class="sidebar-toggle menu" id="menu">
                <ion-icon name="menu"></ion-icon>
            </div>
            <div class="sidebar-toggle close-btn"><ion-icon name="close-outline" class="ico"></ion-icon></div>
            <div class="sidebar-header">
                <div class="logo">
                    <img src="../../../Public/images/logo.png" alt="">
                </div>
            </div>
            
            <div class="sidebar-menu">
                <ul>
                    <li>
                        <a href="src/pages/DeliveryExecutive/DeliveryDashboard.jsp">
                            <span class="icon"><ion-icon name="home-sharp"></ion-icon></span>
                            <span>Home</span>
                        </a>
                    </li>
                    <li>
                        <a href="src/pages/DeliveryExecutive/DeliveryOrders.jsp">
                            <span class="icon"><ion-icon name="cart"></ion-icon></span>
                            <span>Orders</span>
                        </a>
                    </li>
                    <li class="li_logout">
                        <a href="../AddRestaurent/AddRestaurent.html#Signin-popup">
                            <span class="icon"><ion-icon name="power"></ion-icon></span>
                            <span>Logout</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        
        <div class="main-content">
            <header>
                <div class="headerLogo">
                    <div class="logo">
                        <img src="../../../Public/images/logo.png" alt="">
                    </div>
                </div>
                <div class="search-wrapper">
                    <span class="icon"><ion-icon name="search"></ion-icon></span>
                    <input type="search" placeholder="Search">
                </div>
                
                <div class="social-icons">
                  <div class="logout_btn">
                      <form action="http://localhost:8080/Platera-Main/logout" class="d-flex align-items-center logout">
                          <button type="submit" class="btn d-flex align-items-center">
                              <span class="ml-2">Logout</span>
                              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-power" viewBox="0 0 16 16">
                              <path d="M7.5 1v7h1V1z"></path>
                              <path d="M3 8.812a5 5 0 0 1 2.578-4.375l-.485-.874A6 6 0 1 0 11 3.616l-.501.865A5 5 0 1 1 3 8.812"></path>
                              </svg>
                          </button>
                      </form>
                  </div>
              </div>
            </header>
            
            <main>

                    <div class="main-container">
                    <!------------Order Items  ------------->
                    <div class="order-panel">
                        <div class="order-head">
                            <h2>Orders</h2>
                        </div>
                        <div class="order-tabs">
                            <div class="activate">Order in</div>
                            <div>Delivered</div>
                        </div>
                        <div class="order-list" id="order-list">
                            <!-- Orders will be dynamically added here -->
                        </div>
                    </div>


                <!--------Order item details  -->
                <section class="delivery-order" style="display: none;">
                  <div class="order-header">
                    <h1>Order Details</h1>
                  </div>

                  <div class="order-container">
              
                  <div class="order-info">
                    <div class="order-number">
                      <h3>Order #1</h3>
                      <p>June 1, 2020, 08:22 AM</p>
                    </div>
                    <div class="customer-info">
                      <img src="https://t4.ftcdn.net/jpg/03/68/89/07/360_F_368890785_yPhrRtWYi0eRQkTaehpyAxytx0yX8Arx.jpg" alt="Customer">
                      <div>
                        <h4>Rubina Shah</h4>
                        <p>User since 2020</p>
                      </div>
                    </div>
                  </div><hr>
              
                  <div class="order-dettails">
                    <div class="delivery-address">
                      <p>Delivery Address</p>
                      <p><span class="icon ico">📍</span><strong style="font-size: 15px;">Elm Street, 23</strong></p>
                      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.</p>
                    </div>
                    <div class="detail-grid">
                    <div class="estimation-info">
                      <p>Estimation Time</p>
                      <p><strong>10 Min</strong></p>
                    </div>
                    <div class="payment-info">
                      <p>Payment</p>
                      <p><strong>E-Wallet</strong></p>
                    </div>
                    <div class="distance-info">
                      <p>Distance</p>
                      <p><strong>2.5 Km</strong></p>
                    </div>
                    <div class="payment-status">
                      <p>Payment Status</p>
                      <p><strong>Completed</strong></p>
                    </div>
                </div>
                  </div> <hr>
              
                  <div class="order-items">
                    <div class="order-item">
                      <img src="https://cdn.shopify.com/s/files/1/0274/9503/9079/files/20220211142754-margherita-9920_5a73220e-4a1a-4d33-b38f-26e98e3cd986.jpg?v=1723650067" alt="Pizza" />
                      <div>
                        <p><strong>Pepperoni Pizza</strong></p>
                        <p>x1</p>
                      </div>
                      <div class="item-price">
                        <p>+₹230</p>
                      </div>
                    </div>
                    <div class="order-item">
                      <img src="https://www.sargento.com/assets/Uploads/Recipe/Image/GreatAmericanBurger__FillWzExNzAsNTgzXQ.jpg" alt="Cheese Burger" />
                      <div>
                        <p><strong>Cheese Burger</strong></p>
                        <p>x1</p>
                      </div>
                      <div class="item-price">
                        <p>+₹220</p>
                      </div>
                    </div>
                  </div>
              
                  <div class="order-total">
                    <p>Total</p>
                    <p class="total-amount">₹450</p>
                  </div>
              
                  <div class="order-actions">
                    <button class="reject-order">Reject Order</button>
                    <button class="accept-order">Accept Order</button>
                  </div>

                </div>
                </section>

                <!-------Delivered Order ----------- -->
                <section class="delivered-order">
                  <div class="order-header">
                    <h1>Order Delivery in progress</h1>
                  </div>

                  <div class="order-container">
              
                  <div class="order-info">
                    <div class="order-number">
                      <h3>Order #1</h3>
                      <p>June 1, 2020, 08:22 AM</p>
                    </div>
                    <div class="customer-info">
                      <img src="https://t4.ftcdn.net/jpg/03/68/89/07/360_F_368890785_yPhrRtWYi0eRQkTaehpyAxytx0yX8Arx.jpg" alt="Customer">
                      <div>
                        <h4>Rubina Shah</h4>
                        <p>User since 2020</p>
                      </div>
                    </div>
                  </div><hr>
              
                  <div class="order-dettails">
                    <div class="delivery-address">
                      <p>Delivery Address</p>
                      <p><span class="icon ico">📍</span><strong style="font-size: 15px;">Elm Street, 23</strong></p>
                      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.</p>
                    </div>
                    <div class="detail-grid">
                    <div class="estimation-info">
                      <p>Estimation Time</p>
                      <p><strong>10 Min</strong></p>
                    </div>
                    <div class="payment-info">
                      <p>Payment</p>
                      <p><strong>E-Wallet</strong></p>
                    </div>
                    <div class="distance-info">
                      <p>Distance</p>
                      <p><strong>2.5 Km</strong></p>
                    </div>
                    <div class="payment-status">
                      <p>Payment Status</p>
                      <p><strong>Completed</strong></p>
                    </div>
                </div>
                  </div> <hr>
              
                  <div class="order-items">
                    <div class="order-item">
                      <img src="https://cdn.shopify.com/s/files/1/0274/9503/9079/files/20220211142754-margherita-9920_5a73220e-4a1a-4d33-b38f-26e98e3cd986.jpg?v=1723650067" alt="Pizza" />
                      <div>
                        <p><strong>Pepperoni Pizza</strong></p>
                        <p>x1</p>
                      </div>
                      <div class="item-price">
                        <p>+₹230</p>
                      </div>
                    </div>
                    <div class="order-item">
                      <img src="https://www.sargento.com/assets/Uploads/Recipe/Image/GreatAmericanBurger__FillWzExNzAsNTgzXQ.jpg" alt="Cheese Burger" />
                      <div>
                        <p><strong>Cheese Burger</strong></p>
                        <p>x1</p>
                      </div>
                      <div class="item-price">
                        <p>+₹220</p>
                      </div>
                    </div>
                  </div>
              
                  <div class="order-total">
                    <p>Total</p>
                    <p class="total-amount">₹450</p>
                  </div>
              
                  <div class="order-actions">
                    <button class="handover-order">Confirm Handover</button>
                  </div>

                </div>
                </section>

            </div>
              </main>
              
              
        </div>
    </div>

    <!-- Scripts  -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


    <!-- Icon Scripts -->

    <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

    <!-- main scripts -->


    <!-- Menu toggle -->
    <script>
        document.querySelector("#menu").addEventListener("click", function() {
    document.querySelector(".sidebar").classList.add("activate");
});

document.querySelector(".sidebar .close-btn").addEventListener("click", function() {
    document.querySelector(".sidebar").classList.remove("activate");
});
    </script>
<!-- Logout -->
    <script>
        function signout() {
    localStorage.removeItem('authtoken');
    localStorage.removeItem('admin');
    window.location.href = '../AddRestaurent/AddRestaurent.html#Signin-popup'; // Use a specific ID or identifier
}
    </script>

    <!-- Otp popup -->
    <script>
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
    </script>
    
    

</body>
</html>
