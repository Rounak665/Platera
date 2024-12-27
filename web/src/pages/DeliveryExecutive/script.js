document.addEventListener("DOMContentLoaded", function () {
    // Handle the order list visibility
    const orderListElem = document.getElementById('order-list'); // Get the order list container
    const deliveryOrderSection = document.querySelector('.delivery-order');
    const deliveredOrderSection = document.querySelector('.delivered-order');
    
    // Initially hide the delivery and delivered order sections
//    deliveryOrderSection.style.display = 'none';
//    deliveredOrderSection.style.display = 'none';

    // Function to remove active class from all order slabs
    function removeActiveClass() {
        const slabs = document.querySelectorAll('.order-slab');
        slabs.forEach(slab => slab.classList.remove('active'));
    }

    // Handle the order slab click to toggle the active state and show order details
    function handleSlabClick(event) {
        removeActiveClass(); // Remove active class from all elements
        event.currentTarget.classList.add('active'); // Add active class to the clicked slab

        // Show the delivery-order section only if the order has not been accepted yet
        deliveryOrderSection.style.display = 'block';  // Show the delivery order section
        deliveredOrderSection.style.display = 'none';  // Ensure the delivered order section is hidden
    }

    // Dynamically generate and append order slabs (simulate order data fetching)

    // Append order slabs to the order list
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
        orderListElem.appendChild(orderItem);
    });

    // Handling the Accept and Reject Order Buttons
    const acceptOrderButton = document.querySelector('.accept-order');
    const rejectOrderButton = document.querySelector('.reject-order');
    
    acceptOrderButton.addEventListener('click', () => {
        deliveryOrderSection.style.display = 'none'; // Hide the delivery order section
        deliveredOrderSection.style.display = 'block'; // Show the delivered order section
    });

    rejectOrderButton.addEventListener('click', () => {
        deliveryOrderSection.style.display = 'none'; // Hide the delivery order section
        deliveredOrderSection.style.display = 'none'; // Ensure delivered section is hidden
        // You may want to reset the active class and state here
        removeActiveClass();
    });
});



// -------------------Delivery dashboard codes-------------------

document.querySelector("#menu").addEventListener("click", function () {
    document.querySelector(".sidebar").classList.add("activate");
});

document.querySelector(".sidebar .close-btn").addEventListener("click", function () {
    document.querySelector(".sidebar").classList.remove("activate");
});

function toggleDetailsGeneral(row) {
    // Toggle the background color
    row.classList.toggle('active');
    // Find the next row (details row)
    const nextRow = row.nextElementSibling;
    nextRow.classList.toggle('show');
    // Toggle the dropdown icon
    const icon = row.querySelector('.dropdown');
    icon.classList.toggle('rotate');
}

function toggleCurrentOrderDetails(row) {
    // Toggle the background color
    row.classList.toggle('active');
    // Find the next sibling (details row)
    const nextRow = row.closest('.current-order').querySelector('.details-row');
    nextRow.classList.toggle('show');
    // Toggle the dropdown icon
    const icon = row.querySelector('.dropdown-current');
    icon.classList.toggle('rotate');
}
