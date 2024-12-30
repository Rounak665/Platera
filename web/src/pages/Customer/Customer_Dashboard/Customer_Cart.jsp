<%@page import="Utilities.CustomerDAO"%>
<%@page import="Utilities.Customer"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Platera - Customer Dashboard</title>
        <link rel="stylesheet" href="Customer_Dashboard.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>

    </head>
    <body>
                <%
            // Retrieve user_id from the session
            int user_id = 201;

            // Initialize necessary variables
            String name = "";
            String email = "";
            int customer_id = 0;
            String image = "";
            String imagepath = "";
            int location_id = 0;
            String location = "";
            String address = "";
            String phone = "";
            boolean twoFA;

            Customer customer = CustomerDAO.getCustomerByUserId(user_id);
            if (customer != null) {
                customer_id = customer.getCustomerId();
                name = customer.getFullName();
                email = customer.getEmail();
                image = customer.getImage();
                location_id = customer.getLocationId();
                location = customer.getLocation();
                address = customer.getAddress();
                phone = customer.getPhone();
                twoFA = customer.isTwoStepVerification();
            }

            // Create image path based on the image file path retrieved
            imagepath = request.getContextPath() + '/' + image;

        %>
        <div class="dashboard-container">
            <aside class="sidebar">
                <div class="sidebar-toggle menu" id="menu">
                    <ion-icon name="menu"></ion-icon>
                </div>
                <div class="sidebar-toggle close-btn">
                    <ion-icon name="close-outline" class="ico"></ion-icon>
                </div>
                <div class="sidebar-header">
                    <div class="logo">
                        <img src="../../../Public/images/logo.png" alt="Logo">
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul>
                        <li>
                            <a href="">
                                <span class="icon"><ion-icon name="cart"></ion-icon></span>
                                <span>Cart</span>
                            </a>
                        </li>
                        <li>
                            <a href="Customer_Order.html">
                                <span class="icon"><ion-icon name="bag-outline"></ion-icon></span>
                                <span>Orders</span>
                            </a>
                        </li>
                        <li>
                            <a href="#membership">
                                <span class="icon"><ion-icon name="card"></ion-icon></span>
                                <span>Membership</span>
                            </a>
                        </li>
                        <li>
                            <a href="Customer_Settings.html">
                                <span class="icon"><ion-icon name="settings"></ion-icon></span>
                                <span>Settings</span>
                            </a>
                        </li>
                        <li class="li_edit">
                            <a href="#">
                                <span class="icon"><ion-icon name="create"></ion-icon></span>
                                <span>Edit Profile</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </aside>

            <div class="content">
            <div class="profile-header">
                <div class="headerLogo">
                    <div class="logo">
                        <img src="../../../Public/images/logo.png" alt="Logo">
                    </div>
                </div>
                <h1>Welcome, Arjun!</h1>
                <button class="edit_btn">Edit Profile</button>
            </div>

            <main class="main-content">
                <div class="cart-container checkout"> 
                    <div class="cart-header">
                        Cart
                        <span class="close">&times;</span>
                    </div>
                    <div class="cart-items">
                        <!-- Example of a dynamically generated cart item -->
                        <div class="cart-item">
                            <!-- Replace img tag with an input field for the image URL -->
                            <input type="text" class="cart-item-image" value="avocado-salad.jpg" disabled>
                            
                            <div class="cart-item-details">
                                <!-- Replace h4 with an input field for the item name -->
                                <input type="text" class="cart-item-name" value="Avocado Salad" disabled>
                                
                                <!-- Replace price p with an input field for the item price -->
                                <input type="text" class="cart-item-price" value="₹12.00" disabled>
                            </div>
                            <div class="price">
                                <div class="cart-item-quantity">
                                    <button class="quantity-btn substract">-</button>
                                    <input type="text" class="quantity-number" value="2" disabled>
                                    <button class="quantity-btn add">+</button>
                                </div>
                                <!-- Replace total price with an input field -->
                                <input type="text" class="total-price" value="₹24.00" disabled>
                            </div>
                        </div>
                
                        <!-- Repeat for other items -->
                        <!-- <div class="cart-item">
                            <input type="text" class="cart-item-image" value="fruits-salad.jpg" disabled>
                            <div class="cart-item-details">
                                <input type="text" class="cart-item-name" value="Fruits Salad" disabled>
                                <input type="text" class="cart-item-price" value="₹11.00" disabled>
                            </div>
                            <div class="price">
                                <div class="cart-item-quantity">
                                    <button class="quantity-btn">-</button>
                                    <input type="text" class="quantity-number" value="2" disabled>
                                    <button class="quantity-btn">+</button>
                                </div>
                                <input type="text" class="total-price" value="₹22.00" disabled>
                            </div>
                        </div> -->
                
                        <!-- Add more items similarly -->
                    </div>
                    <div class="promo-code">
                        <input type="text" placeholder="Promo Code">
                        <button>Apply</button>
                    </div>
                    <div class="cart-summary">
                        <div><span>Subtotal</span><input type="text" class="subtotal" value="₹70.00" disabled></div>
                        <div><span>Delivery</span><input type="text" class="delivery_charges" value="₹30" disabled></div>
                        <div><span>Total</span><input type="text" class="total" value="₹73.50" disabled></div>
                    </div>
                    <button class="checkout-button">CHECKOUT</button>
                </div>
                



                <div class="cart-container paynow" style="display: none;">
                    <div class="cart-header">
                        Checkout
                        <span class="close">&times;</span>
                    </div>
            
                    <div class="payment-options">
                        <div class="payment-option">
                            <input type="radio" name="payment" id="debit-credit" checked>
                            <label for="debit-credit">
                                <img src="https://img.icons8.com/color/48/visa.png" alt="Visa"> Debit/Credit card
                            </label>
                        </div>
            
                        <div class="payment-option">
                            <input type="radio" name="payment" id="net-banking">
                            <label for="net-banking">
                                <img src="https://img.icons8.com/color/48/bank.png" alt="Bank"> Net banking
                            </label>
                        </div>
            
                        <div class="payment-option">
                            <input type="radio" name="payment" id="paypal">
                            <label for="paypal">
                                <img src="https://img.icons8.com/color/48/paypal.png" alt="PayPal"> Paypal
                            </label>
                        </div>
            
                        <div class="payment-option">
                            <input type="radio" name="payment" id="google-pay">
                            <label for="google-pay">
                                <img src="https://img.icons8.com/color/48/google-pay.png" alt="Google Pay"> Google pay
                            </label>
                        </div>
                    </div>
            
                    <div class="cart-summary">
                        <div><span>Subtotal</span><input type="text" class="subtotal" value="₹70.00" disabled></div>
                        <div><span>Delivery</span><input type="text" class="delivery_charges" value="₹30" disabled></div>
                        <div><span>Total</span><input type="text" class="total" value="₹73.50" disabled></div>
                    </div>
            
                    <button class="pay-btn">Pay Now</button>
                </div>


            </main>
        </div>
        </div>
        <script src="script.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    </body>
</html>
