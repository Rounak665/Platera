<%@page import="Utilities.Cart"%>
<%@page import="java.util.List"%>
<%@page import="Utilities.CartDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Payment Gateway</title>
        <link rel="stylesheet" href="./paymentGateway.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />


    </head>
    <body>
        <%
        // Retrieve session attributes
//           Integer customer_id = (Integer) session.getAttribute("customerId");
            int customer_id = 30;
            // Replace with the actual user/customer ID fetched from the session or request
            CartDAO cartDAO = new CartDAO();
            List<Cart> cartItems = cartDAO.getCartItems(customer_id);
            double promotion = 0;
            // Calculate subtotal and total
            double subtotal = 0;
            for (Cart cart : cartItems) {
                subtotal += cart.getItemPrice() * cart.getQuantity();
                promotion = cart.getCouponDiscount();
            }

            // Apply delivery charges conditionally
            double deliveryCharges = (subtotal < 199) ? 30 : 0;  // Delivery charges are 30 if subtotal is less than 199

            // Calculate total
            double total = subtotal + deliveryCharges - promotion;
        %>
        <nav class="navbar">
            <div class="logo"><a href=""><img src="./Assets/PlateraLogo-red.png" alt="" width="150px"></a></div>
            <button class="back-button" onClick="goBack()">Back</button>
        </nav>


        <div class="container">
            <!-- Left Section: Product Summary -->
            <div class="product-summary">
                <header>
                    <p>All <span>Platera</span> Payments are asured by <a href="">Salford <span>payments bank</span><sup>TM</sup></a></p>
                </header>
                <h1>Checkout</h1>
                <p class="price"><span>Your Total is</span> ₹<%=total%></p>
                <div class="items">
                    <div class="item">
                        <span>Subtotal</span>
                        <span>₹<%=subtotal%></span>
                    </div>
                    <div class="item">
                        <span>Delivery</span>
                        <span>-₹<%=deliveryCharges%></span>
                    </div>
                    <div class="item">
                        <span>Discounts</span>
                        <span>-₹<%=promotion%></span>
                    </div>
                </div>  
                <hr>
                <div class="total">
                    <span>Total is</span>
                    <span>₹<%=total%></span>
                </div>
            </div>

            <!-- Right Section: Payment Form -->
            <div class="payment-form">
                <header>
                    <a href=""><img src="./Assets/salford-payments-bank.png" alt=""></a>
                </header>
                <form action="http://localhost:8080/Platera-Main/PaymentConfirmation" method="post">
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" placeholder="customer@supermail.com" required>
                    </div>
                    <div class="form-group">
                        <label for="paymentMethod">Payment method</label>
                        <div class="payment-methods">
                            <button type="button" class="method" id="cardMethod">Credit/Debit Card</button>
                            <button type="button" class="method" id="codMethod">COD</button>
                            <button type="button" class="method" id="netBankingMethod">Net Banking</button>
                        </div>
                    </div>

                    <!-- Card Payment Details -->
                    <div id="cardDetails" class="payment-details">
                        <div class="form-group">
                            <label for="cardNumber">Card Information</label>
                            <input name="cardNumber" type="text" id="cardNumber" placeholder="1234 1234 1234 1234" maxlength="16" required>
                        </div>
                        <div class="form-row">
                            <input name="cardExpiry" type="text" placeholder="MM/YY" maxlength="5" required>
                            <input name="cardCvv" type="text" placeholder="CVV" maxlength="3" required>
                        </div>
                        <div class="form-group">
                            <label for="cardName">Name on card</label>
                            <input name="cardName" type="text" id="cardName" placeholder="John Doe" required>
                        </div>
                        <button type="submit" class="submit-button">Place Order</button>
                    </div>
                    
                </form>

                <!-- COD Payment Details -->
                <div id="codDetails" class="payment-details" style="display: none;">
                    <form action="http://localhost:8080/Platera-Main/PaymentConfirmation" method="post">
                        <button type="submit" class="submit-button">Place Order</button>
                    </form>
                </div>


                <div id="netBankingDetails" class="payment-details" style="display: none;">
                    <form action="http://localhost:8080/Platera-Main/PaymentConfirmation" method="post">
                        <div class="form-group">
                            <label for="bankName">Select Bank</label>
                            <select id="bankName" required>
                                <option value="" disabled selected>Select your bank</option>
                                <option value="hdfc">HDFC Bank</option>
                                <option value="icici">ICICI Bank</option>
                                <option value="sbi">State Bank of India</option>
                                <option value="axis">Axis Bank</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="accountHolderName">Account Holder's Name</label>
                            <input name="accountHolderName" type="text" id="accountHolderName" placeholder="John Doe" required>
                        </div>
                        <div class="form-group">
                            <label for="accountNumber">Account Number</label>
                            <input name="accountNumber" type="text" id="accountNumber" placeholder="123456789012" maxlength="12" required>
                        </div>
                        <div class="form-group">
                            <label for="ifscCode">IFSC Code</label>
                            <input name="ifscCode" type="text" id="ifscCode" placeholder="SBIN0001234" maxlength="11" required>
                        </div>
                        <button type="submit" class="submit-button">Place Order</button>
                    </form>
                </div>


                <div class="footer">
                    <p>
                        <span>&copy; 2023 Salford Payments. All rights reserved.</span>
                    </p>
                </div>
            </div>
        </div>
        <section id="blank-section">

        </section>
        <footer>
            <div class="container_footer">
                <div class="row">
                    <div class="col">
                        <img src="./assets/PlateraLogo-red.png" alt="" />
                        <p>
                            Platera delivers delicious meals from your favorite local
                            restaurants straight to your door, combining speed and convenience
                            with every order. From quick bites to gourmet dishes, enjoy a
                            world of flavors anytime, anywhere!
                        </p>
                    </div>
                    <div class="col">
                        <h3>
                            Office
                            <div class="underline"><span></span></div>
                        </h3>
                        <p>ITFL Road</p>
                        <p>Whitefield, Bangalore</p>
                        <p>Karnatak, PIN 568629, INDIA</p>
                        <p class="email_id">support@platera.in</p>
                        <h4>+91 - 1234567891</h4>
                    </div>
                    <div class="col">
                        <h3>
                            Links
                            <div class="underline"><span></span></div>
                        </h3>
                        <ul>
                            <li>
                                <a
                                    href="../FooterLinkPages/Terms&Conditions/Terms&Conditions.html"
                                    >Terms & Conditions</a
                                >
                            </li>
                            <li>
                                <a href="../FooterLinkPages/PrivacyPolicy/PrivacyPolicy.html"
                                   >Privacy Policy</a
                                >
                            </li>
                            <li><a href="../FooterLinkPages/Help/Help.html">Help</a></li>
                        </ul>
                    </div>
                    <div class="col promotion">
                        <h3>
                            Newsletter
                            <div class="underline"><span></span></div>
                        </h3>
                        <form>
                            <i class="fa-solid fa-envelope"></i>
                            <input
                                id="newsletter-email"
                                type="email"
                                name=""
                                id=""
                                placeholder="Enter Your Email Address"
                                />
                            <button type="submit">
                                <i class="fa-solid fa-arrow-right"></i>
                            </button>
                        </form>
                        <div class="social_icon">
                            <i class="fa-brands fa-facebook"></i>
                            <i class="fa-brands fa-instagram"></i>
                            <i class="fa-brands fa-pinterest"></i>
                            <i class="fa-brands fa-x-twitter"></i>
                        </div>
                    </div>
                </div>
            </div>
            <hr />
            <p class="copyright">Platera @2024 - All Rights Reserved</p>
        </footer>
        <script>
            
            function goBack() {
                window.location.href = "../DeliveryDetailsPage/deliverydetailspage.jsp";
            }
        </script>
        <script src="./paymentGateway.js"></script>
    </body>
</html>
