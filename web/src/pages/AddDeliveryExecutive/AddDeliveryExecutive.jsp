<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Utilities.Location" %>
<%@ page import="Utilities.LocationDAO" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Platera - Be Our CAPTAIN</title>
    <link rel="stylesheet" href="./AddDeliveryExecutive.css">
    <link rel="shortcut icon" href="./assets/favicon.png" type="image/x-icon">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>


    <!-- Error Popup -->
    <div class="error-popup" id="errorPopup">
        <div class="error-content">
            <h2>Error</h2>
            <p id="errorMessage">An error has occurred. Please try again later.</p>
            <button id="closeErrorPopup">Go Back</button>
        </div>
    </div>

    
    <!-- loader -->
    <div class="loader">
        <div id="pl">
          <div>
            <video class="vid" src="../ContactUs/Assets/loader.mp4" autoplay muted loop></video>
          </div>
        </div>
      </div>

    <!-- Signup Popup -->
    <section class="popup Signup-popup">
        <div class="container">
            <div class="close-btn"><ion-icon name="close-outline" class="ico"></ion-icon></div>
            <h1>Delivery Executive Registration</h1>
            <form action="http://localhost:8080/Platera-Main/DeliveryExecutiveSignUp" id="restaurantRegistrationForm" class="contact_form" enctype="multipart/form-data" method="POST">
                <div class="input_container">
                    <input type="text" name="name" class="input" required>
                    <label for="name">Name</label>
                    <span>Name</span>
                </div>
                <div class="input_container">
                    <input type="email" name="email" class="input" required>
                    <label for="email">Email</label>
                    <span>Email</span>
                </div>
                <div class="input_container">
                    <input type="text" name="phone" class="input" required>
                    <label for="phone">Phone Number</label>
                    <span>Phone Number</span>
                </div>
                <div class="input_container">
                    <input type="text" name="address" class="input" required>
                    <label for="address">Enter Your Address</label>
                    <span>Enter Your Address</span>
                </div>
                <div class="input_container">
                    <input type="text" name="age" class="input" required>
                    <label for="age">Age</label>
                    <span>Age</span>
                </div>
                <div class="input_container" id="gender">
                    <select name="gender" class="input" style="color: rgb(0, 153, 153);" required>
                        <option value="" disabled selected>Select Gender</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Others">Others</option>
                    </select>
                    <span>Gender</span>
                </div>
                <div class="input_container">
                    <input type="file" name="profile_image" class="input" accept="image/*" required>
                    <label for="profile_image" style="color: rgb(0, 153, 153);">Upload Profile Image</label>
                </div>
                <div class="input_container">
                    <select name="location" class="input" required>
                    <option value="" disabled selected>Select a location</option>
                    <%
                        LocationDAO locationDAO = new LocationDAO();
                        List<Location> locations = locationDAO.getLocations();
                        for (Location location : locations) {
                    %>
                        <option value="<%= location.getId() %>"><%= location.getName() %></option>
                    <%
                        }
                    %>
                </select>
                    <span>Location</span>
                </div>
                <div class="input_container">
                    <input type="text" name="aadhar_number" class="input" required>
                    <label for="aadhar_number">Aadhar Number</label>
                    <span>Aadhar Number</span>
                </div>
                <div class="input_container">
                    <input type="text" name="bank_account_name" class="input" required>
                    <label for="bank_account_name">Bank Account Name</label>
                    <span>Bank Account Name</span>
                </div>
                <div class="input_container">
                    <input type="text" name="bank_account_number" class="input" required>
                    <label for="bank_account_number">Bank Account Number</label>
                    <span>Bank Account Number</span>
                </div>
                <div class="input_container">
                    <input type="text" name="pan_number" class="input" required>
                    <label for="pan_number">Enter PAN Card Number</label>
                    <span>PAN Card Number</span>
                </div>
                <div class="input_container">
                    <input type="text" name="driving_license_number" class="input" required>
                    <label for="driving_license_number">Driving License Number</label>
                    <span>Driving License Number</span>
                </div>
                <div class="input_container">
                    <input type="text" name="vehicle_number" class="input" required>
                    <label for="vehicle_number">Vehicle Number</label>
                    <span>Vehicle Number</span>
                </div>
                <div class="input_container">
                    <input type="text" name="vehicle_type" class="input" required>
                    <label for="vehicle_type">Vehicle Type</label>
                    <span>Vehicle Type</span>
                </div>
                <div class="input_container">
                    <input type="password" name="password" class="input" required>
                    <label for="password">Password</label>
                    <span>Password</span>
                </div>
                <div class="input_container">
                    <input type="password" name="re_password" class="input" required>
                    <label for="re_password">Re-enter Password</label>
                    <span>Re-enter Password</span>
                </div>
                <div class="remember-forgot">
                    <label><input type="checkbox" required>I agree to Platera's <b><span style="color: #F12630;"><a href="src/pages/FooterLinkPages/Terms&Conditions/Terms&Conditions.html">Terms of Service</a></span></b> & <b><span style="color: #F12630;"><a href="../FooterLinkPages/PrivacyPolicy/PrivacyPolicy.html">Privacy Policies</a></span></b></label>
                </div>
    
                <button type="submit" class="btn">Register Yourself</button>

            </form>
        </div>
    </section>
    

    <!-- Signin Popup -->
    <section class="popup" id="Signin-popup">
        <div class="container1">
            <div class="close-btn"><ion-icon name="close-outline" class="icon"></ion-icon></div>
            <h1>Login</h1>
            <form action="http://localhost:8080/Platera-Main/sign_in" method="POST">
                <div class="input_container">
                    <input type="email" name="email_signin" class="input" id="emailInput" required>
                    <label for="Email">Email</label>
                    <span>Email</span>
                </div>
                <div class="input_container">
                    <input type="password" name="password_signin" class="input" id="passwordInput" required>
                    <label for="Password">Password</label>
                    <span>Password</span>
                </div>
                
                <div class="remember-forgot">
                    <label><input type="checkbox">Remember me</label>
                    <a href="../ForgotPassword/ForgotPassword.jsp" target="_blank">Forgot password?</a>
                </div>

                <button type="submit" class="btn">Login</button>

                <div class="login-register">
                    <p>Don't have an account? <a href="#" class="register-link" id="link-Signup" target="_blank">Sign Up</a></p>
                </div>
            </form>
        </div>
</section>

    <!-- Hero Section -->

<div class="hero">
    <header>
        <div class="nav_bar">
            <div class="logo">
                <img src="./assets/PlateraLogo-red.png" alt="logo">
            </div>
            <div class="nav_links">
                <ul class="nav_list">
                    <li><a href="../../../index.html" target="_blank">Home</a></li>
                    <li><a href="../ContactUs/ContactUs.html" target="_blank">Contact Us</a></li>
                </ul>
            </div>
            <a href="#"><button class="signin" id="signin">Sign In</button></a>
            <span class="menu" style="color: rgb(255, 255, 255);">
                <i class="fa-solid fa-bars fa-xl"></i>
            </span>
        </div>
    </header>
    <div class="hero_section">
    </div>
    <div class="overlapping-div">
    <div class="restaurant_add_restaurant">
            <div class="restaurant_Container">
                <h1 id="heading">Join Platera!</h1>
                <h1>India's <span>Fastest growing</span> Delivery Platform</h1>
                <p>Register to Become Platera Partner and get called as <strong>Captains</strong></p>
        
                <div class="flex btun">
                    <button class="restaurant_Btn restaurant_register_Btn" id="register">Register yourself  on Platera</button>
                    <button class="restaurant_Btn restaurant_register_Btn" id="login">Login to view your profile</button>
                </div>
        
                <div class="restaurant_GetStart">
                    <div class="flex restaurant_GetStart_heading" >
                        <h2>Get started with Platera</h2>
                        <p>Please keep the documents ready for a smooth signup</p>
                    </div>
        
                    <ul>
                        <li>
                            <i class="fa-solid fa-circle-check"></i>
                            Aadhaar Card Copy
                        </li>
                        <li>
                            <i class="fa-solid fa-circle-check"></i>
                            Pan Card Copy
                        </li>
                        <li>
                            <i class="fa-solid fa-circle-check"></i>
                            Driving License Copy
                        </li>
                        <li>
                            <i class="fa-solid fa-circle-check"></i>
                            Bank account details
                        </li>
                        <li>
                            <i class="fa-solid fa-circle-check"></i>
                            Your Vehicle Type
                        </li>
                        <li>
                            <i class="fa-solid fa-circle-check"></i>
                            Your Vehicle Number
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>



    <!-- Body Section -->
    <div class="restaurnat_partner_platera">
        <div class="restaurant_Container restaurnat_partner_platera_content">
        <h1>Perks of becoming Platera Partner ?</h1>
        <p>Regular payout with exiciting bonuses & Incentives, Flexible timings, Insurance coverage upto Rs 5 lakh</p>
        <div class="restaurant_partner_content">
            <div class="restaurnat_partner_content_item">
                <div class="restaurant_partner_icon_image">
                    <img src="https://b.zmtcdn.com/merchant-onboarding/d2bcadb70abdd99811cceda4cc757f5a1600670711.png" alt="">
                </div>
                <div style="padding-left: 28px;">
                    <div class="restaurant_bigText">500+ Cities</div>
                    <div class="restaurant_small_text">in India</div>
                </div>
            </div>

            <div class="restaurnat_partner_content_item">
                <div class="restaurant_partner_icon_image">
                    <img src="https://b.zmtcdn.com/merchant-onboarding/77b29f40bd0fb6c74c78695b07cdee901600670728.png" alt="">
                </div>
                <div style="padding-left: 28px;">
                    <div class="restaurant_bigText">3Lakh+</div>
                    <div class="restaurant_small_text">Restaurant listings</div>
                </div>
            </div>

            <div class="restaurnat_partner_content_item">
                <div class="restaurant_partner_icon_image">
                    <img src="https://b.zmtcdn.com/merchant-onboarding/e2b1283698fb6d3532c2df0c22a11fca1600670743.png" alt="">
                </div>
                <div style="padding-left: 28px;">
                    <div class="restaurant_bigText">10Cr+</div>
                    <div class="restaurant_small_text">Monthly orders</div>
                </div>
            </div>

            <div class="restaurnat_partner_content_item">
                <div class="restaurant_partner_icon_image">
                    <img src="https://b.zmtcdn.com/merchant-onboarding/e2b1283698fb6d3532c2df0c22a11fca1600670743.png" alt="">
                </div>
                <div style="padding-left: 28px;">
                    <div class="restaurant_bigText">2Lakh+</div>
                    <div class="restaurant_small_text">CAPTAINS</div>
                </div>
            </div>

            </div>
        </div>
    </div>

    <!-- How to Work Section -->

    <!-- Background Image -->
    <div class="Howtowork_background">
    </div>

    <div class="howtowork_content">
        <div class="restaurant_Container howtowork_content_content">
            <h1>How it Works?</h1>
            <div class="restaurant_howtowork_list">
                <div class="restaurant_howtowork_item">
                    <img src="https://b.zmtcdn.com/merchant-onboarding/ecb5e086ee64a4b8b063011537be18171600699886.png" alt="">
                    <p>Step 1</p>
                    <h4>Open Platera Website</h4>
                    <p>Go to browser and visit our website</p>
                </div>

                <div class="restaurant_howtowork_item">
                    <img src="https://b.zmtcdn.com/merchant-onboarding/71d998231fdaeb0bffe8ff5872edcde81600699935.png" alt="">
                    <p>Step 2</p>
                    <h4>Register Yourself</h4>
                    <p>In Delivery Executive Registration, Fill your details</p>
                </div>

                <div class="restaurant_howtowork_item">
                    <img src="https://b.zmtcdn.com/merchant-onboarding/efdd6ac0cd160a46c97ad58d9bbd73fd1600699950.png" alt="">
                    <p>Step 3</p>
                    <h4>Start deliverying orders</h4>
                    <p>Start delivering orders and manage your delivery schedule</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Start your journey -->
    <div class="Startyourjourney_Container">
        <div class="Startyourjourney_background">
        <h1>Start your journey with Platera</h1>
        <p>Create your profile and start delivering</p>
        <a id="register"><span>Start now</span><ion-icon name="caret-forward-outline" class="startnow_icon"></ion-icon></a>
        
        </div>
    </div>

    <!-- FAQ Section-->
    <div class="FAQ_Container">
        <div class="wrapper">
        <h1>FrequentIy Asked Questions</h1>

        <div class="faq active">
            <button class="accordion">
                Is there any joining fees to become a delivery executive on Platera<i class="fa-solid fa-chevron-down"></i>
            </button>
            <div class="pannel">
                <p>The onboarding fee is around Rs. 1500, It varies based on your location. It is non-refundable.</p>
            </div>
        </div>

        <div class="faq active">
            <button class="accordion">
                What all documents are required for registering on Platera<i class="fa-solid fa-chevron-down"></i>
            </button>
            <div class="pannel">
                <p>Registration for online ordering requires: <br>
                    a: Driving License<br>
                    b: Aadhar Card<br>
                    c: PAN Card</p>
                    d: Vehicle Number</p>
                    e: Bank Account Details</p>
            </div>
        </div>

        <div class="faq active">
            <button class="accordion">
                What are working hours for a delivery executive on Platera<i class="fa-solid fa-chevron-down"></i>
            </button>
            <div class="pannel">
                <p>Platera gives full flexibility to delivery executives. They can work as per their convenience as part time or full time.</p>
            </div>
        </div>

        <div class="faq active">
            <button class="accordion">
                I don't have any vehicle. Can I still become a delivery executive on Platera<i class="fa-solid fa-chevron-down"></i>
            </button>
            <div class="pannel">
                <p>Yes, you can rent a bike/e-bike/cycle for deliveries. Platera may also be able to connect with vendors to make the vehicle available for delivery.</p>
            </div>
        </div>
        </div>
    </div>


    <!-- Footer Section -->


    <footer>
        <div class="container_footer">
            <div class="row">
                <div class="col">
                    <img src="./assets/PlateraLogo-red.png" alt="logo">
                    <p>Platera delivers delicious meals from your favorite local restaurants straight to your door, combining speed and convenience with every order. From quick bites to gourmet dishes, enjoy a world of flavors anytime, anywhere!</p>
                </div>
                <div class="col">
                    <h3>Office <div class="underline"><span></span></div></h3>
                    <p>ITFL Road</p>
                    <p>Whitefield, Bangalore</p>
                    <p>Karnatak, PIN 568629, INDIA</p>
                    <p class="email_id">support@platera.in</p>
                    <h4>+91 - 1234567891</h4>
                </div>
                <div class="col">
                    <h3>Links <div class="underline"><span></span></div></h3>
                    <ul>
                        <li><a href="../FooterLinkPages/Terms&Conditions/Terms&Conditions.html" target="_blank">Terms & Conditions</a></li>
                        <li><a href="../FooterLinkPages/PrivacyPolicy/PrivacyPolicy.html" target="_blank">Privacy Policy</a></li>
                        <li><a href="../FooterLinkPages/Help/Help.html" target="_blank">Help</a></li>
                    </ul>
                </div>
                <div class="col">
                    <h3>Newsletter <div class="underline"><span></span></div></h3>
                    <form>
                        <img id="mail" src="./Public/images/mail.png" alt="">
                        <input type="email" name="" id="" placeholder="Enter Your Email Address">
                        <button type="submit"><img id="send" src="./Public/images/send.png" alt=""></button>
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
        <hr>
        <p class="copyright">Platera @2024 - All Rights Reserved</p>
    </footer>


<!-- Script Starts Here -->

    
<!-- All Icon links -->
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>


<!-- Main Script -->
<script>

    let select = document.getElementById("select");
    let list = document.getElementById("list");

    list.addEventListener("click", function(e){
        if(e.target.tagName === "LI"){
                select.querySelector("p").innerHTML = e.target.innerHTML;
        }
    })

    select.addEventListener("click", function(){
            list.classList.toggle("open");
    })

</script>
<!-- Signup/SIgin input animation -->
<script>
    const inputs = document.querySelectorAll(".input");

    function focusFunc() {
        let parent =this.parentNode;
        parent.classList.add("focus");
    }

    function blurFunc() {
        let parent = this.parentNode;
        if(this.value == "") {
            parent.classList.remove("focus");
    }
    }
    inputs.forEach((input) => {
        input.addEventListener("focus", focusFunc);
        input.addEventListener("blur", blurFunc);
    });
        </script>

        <!-- For signin popup and close -->
        <script>
           document.querySelector("#register").addEventListener("click", function() {
    document.querySelector(".Signup-popup").classList.add("activate");
});

document.querySelector(".Signup-popup .container .close-btn").addEventListener("click", function() {
    document.querySelector(".Signup-popup").classList.remove("activate");
});
document.querySelectorAll(".signin, #login").forEach(element => {
    element.addEventListener("click", function() {
        document.querySelector("#Signin-popup").classList.add("activate");
    });
});

document.querySelector("#Signin-popup .container1 .close-btn").addEventListener("click", function() {
    document.querySelector("#Signin-popup").classList.remove("activate");
});


    // Link to open Signup-popup and close Signin-popup
    document.querySelector("#link-Signup").addEventListener("click", function() {
        document.querySelector("#Signin-popup").classList.remove("activate"); // Hide Signin popup
        document.querySelector(".Signup-popup").classList.add("activate"); // Show Signup popup
    });


    document.addEventListener('DOMContentLoaded', function() {
        if (window.location.hash === '#Signin-popup') {
            const popup = document.querySelector('#Signin-popup');
            if (popup) {
                popup.classList.add('activate'); // Activate the popup
            }
            const container = document.querySelector('.container');
            if (container) {
                container.classList.add('activate'); // Activate the container as well
            }
        }
    });
</script>

 <!-- For FAQ -->
<script>
        var acc = document.getElementsByClassName("accordion");
        var i;

        for (i = 0; i < acc.length ; i++) {
            acc[i].addEventListener("click", function(){
                this.classList.toggle("active");
                this.parentElement.classList.toggle("active")

                var pannel = this.nextElementSibling;

                if(pannel.style.display === "block"){
                    pannel.style.display = "none";
                }else{
                    pannel.style.display = "block";
                }
            });
        }
</script>

</body>
</html>