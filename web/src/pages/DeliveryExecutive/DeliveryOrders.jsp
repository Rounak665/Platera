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
  <script src="Delivery.js"></script>

</body>
</html>
