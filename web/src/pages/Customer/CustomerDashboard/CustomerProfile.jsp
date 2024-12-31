<%@page import="Utilities.Location"%>
<%@page import="java.util.List"%>
<%@page import="Utilities.LocationDAO"%>
<%@page import="Utilities.CustomerDAO"%>
<%@page import="Utilities.Customer"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Platera - Customer Dashboard</title>
        <link rel="stylesheet" href="Customer_Dashboard.css">
    </style>
</head>
<body>
    <%
        // Retrieve user_id from the session
//            Integer user_id = (Integer)session.getAttribute("user_id");

        int user_id = 201;

        // Initialize necessary variables
        String name = "";
        String email = "";
        int customer_id = 0;
        String image = "";
        String imagepath = "";
        int location_id = 0;
        String location_name = "";
        String address = "";
        String phone = "";
        boolean twoFA = false;

        Customer customer = CustomerDAO.getCustomerByUserId(user_id);
        if (customer != null) {
            customer_id = customer.getCustomerId();
            name = customer.getFullName();
            email = customer.getEmail();
            image = customer.getImage();
            location_id = customer.getLocationId();
            location_name = customer.getLocation();
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
                    <img src="<%=request.getContextPath()%>/Public/images/logo.png" alt="Logo">
                </div>
            </div>
            <div class="sidebar-menu">
                <ul>
                    <li>
                        <a href="./CustomerProfile.jsp">
                            <span class="icon"><ion-icon name="person"></ion-icon></span>
                            <span>Account</span>
                        </a>
                    </li>
                    <li>
                        <a href="./CustomerOrder.jsp">
                            <span class="icon"><ion-icon name="receipt-outline"></ion-icon></span>
                            <span>Orders</span>
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
                <h1>Welcome, <%=name%>!</h1>
            </div>
            <main class="main-content">
                <section class="settings-section">
                    <div class="settings-container">
                        <div class="settings-sidebar">
                            <h2>Settings</h2>
                            <ul>
                                <li id="account-tab">
                                    <i class="fas fa-user"></i>
                                    <span>Edit Profile</span>
                                </li>
                                <li id="notification-tab">
                                    <i class="fas fa-bell"></i>
                                    <span>Notification</span>
                                </li>
                                <li id="security-tab">
                                    <i class="fas fa-shield-alt"></i>
                                    <span>Two Step Authentication</span>
                                </li>
                                <li id="forgot-pass" onclick="confirmRedirect()">
                                    <i class="fas fa-shield-alt"></i>
                                    <span>Forgot Password</span>
                                </li>
                                <li id="help-tab">
                                    <i class="fas fa-question-circle"></i>
                                    <span>Help</span>
                                </li>
                                <li id="privacy-policy-tab">
                                    <i class="fas fa-file-alt"></i>
                                    <span>Privacy Policy</span>
                                </li>
                                <li id="delete-acc">
                                    <form action="http://localhost:8080/Platera-Main/DeleteUser" method="POST" onsubmit="return confirmDelete()">
                                        <input type="hidden" name="userId" value="<%=user_id%>">
                                        <button type="submit" class="delete-btn">
                                            <i class="fas fa-file-alt"></i>
                                            <span>Delete Account</span>
                                        </button>
                                    </form>
                                </li>
                            </ul>
                        </div>


                        <div class="settings-content" id="account-section">
                            <h2>Account</h2>
                            <div class="profile-section">
                                <form class="account-form" method="post" action="http://localhost:8080/Platera-Main/UpdateCustomerProfile" enctype="multipart/form-data">
                                    <input type="hidden" name="customer_id" value="<%=customer_id%>">
                                    <!-- Profile Photo Section -->
                                    <div class="profile-photo">
                                        <img id="profile-photo-preview" src="<%=imagepath%>" alt="Profile Photo" />
                                        <div class="photo-actions">
                                            <!-- File input for selecting a new photo -->
                                            <input type="file" id="photo-input" name="profilePhoto" accept="image/*" style="display: none;" />
                                            <button type="button" class="btn change-photo" onclick="document.getElementById('photo-input').click();">Change photo</button>
                                            <button type="button" class="btn remove-photo" onclick="removePhoto()">Remove Photo</button>
                                        </div>
                                    </div>

                                    <!-- User Details Section -->
                                    <div class="form-row">
                                        <div class="form-col">
                                            <label>Name</label>
                                            <input type="text" name="name" value="<%=name%>" />
                                        </div>
                                        <div class="form-col">
                                            <label>Phone</label>
                                            <input type="tel" name="phone" value="<%=phone%>" />
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-col">
                                            <label for="location">Location:</label>
                                            <select id="location" name="location" class="styled-dropdown" required>
                                                <option value="" disabled selected>
                                                    <%= location_name != null ? location_name : "Select a location"%>
                                                </option>
                                                <%
                                                    LocationDAO locationDAO = new LocationDAO();
                                                    List<Location> locations = locationDAO.getLocations();
                                                    for (Location location : locations) {
                                                %>
                                                <option value="<%= location.getId()%>"><%= location.getName()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-col">
                                            <label>Address Details</label>
                                            <textarea name="address"><%=address%></textarea>
                                        </div>
                                    </div>

                                    <!-- Save Settings Button -->
                                    <button type="submit" class="btn save-settings">Save Setting</button>
                                </form>
                            </div>



                        </div>
                        <!-- Notification Section -->
                        <section class="notifications" id="notifications-section" style="display: none;">
                            <!-- Tabs -->
                            <div class="notification-tabs">
                                <button class="tab-active">Activity</button>
                                <button>Notifications</button>
                            </div>

                            <!-- Notifications -->
                            <div class="notification-content">
                                <!-- Today -->
                                <h3>Today</h3>
                                <div class="notification-item">
                                    <div class="icon yellow-icon"></div>
                                    <div class="notification-details">
                                        <h4>Order #1</h4>
                                        <p><strong>Order Accepted</strong> by restaurant.</p>
                                    </div>
                                    <span class="notification-date">Monday, June 31 2020</span>
                                </div>
                                <div class="notification-item">
                                    <div class="icon green-icon"></div>
                                    <div class="notification-details">
                                        <h4>Offer</h4>
                                        <p><strong>Get voucher up to 20%</strong> by restaurant. Get Now!</p>
                                    </div>
                                    <span class="notification-date">Monday, June 31 2020</span>
                                </div>
                                <div class="notification-item">
                                    <div class="icon blue-icon"></div>
                                    <div class="notification-details">
                                        <h4>Update</h4>
                                        <p><strong>Weekly maintenance schedule</strong></p>
                                    </div>
                                    <span class="notification-date">Monday, June 31 2020</span>
                                </div>

                                <!-- Yesterday -->
                                <h3>Yesterday</h3>
                                <div class="notification-item">
                                    <div class="icon yellow-icon"></div>
                                    <div class="notification-details">
                                        <h4>Order #1</h4>
                                        <p><strong>Order Accepted</strong> by restaurant.</p>
                                    </div>
                                    <span class="notification-date">Monday, June 31 2020</span>
                                </div>
                                <div class="notification-item">
                                    <div class="icon green-icon"></div>
                                    <div class="notification-details">
                                        <h4>Offer</h4>
                                        <p><strong>Get voucher up to 20%</strong> by restaurant. Get Now!</p>
                                    </div>
                                    <span class="notification-date">Monday, June 31 2020</span>
                                </div>
                            </div>
                        </section>

                        <section class="privacy-policy" id="privacy-policy" style="display: none;">
                            <div class="container">
                                <div class="privacy-header">
                                    <h1>Privacy Policy</h1>
                                    <p>Your privacy is critically important to us at <span class="brand-name">Platera</span>.</p>
                                </div>

                                <div class="privacy-content">
                                    <!-- Section 1 -->
                                    <div class="policy-section">
                                        <h2>1. Information We Collect</h2>
                                        <p>
                                            We collect personal data to provide and improve our services. This includes:
                                        </p>
                                        <ul>
                                            <li>Basic account information: Name, Email, Phone Number</li>
                                            <li>Payment information (secured and encrypted)</li>
                                            <li>Order and delivery details</li>
                                            <li>Location data for order delivery and tracking</li>
                                            <li>Technical data: IP address, browser type, and usage patterns</li>
                                        </ul>
                                    </div>

                                    <!-- Section 2 -->
                                    <div class="policy-section">
                                        <h2>2. How We Use Your Information</h2>
                                        <p>We use your data to:</p>
                                        <ul>
                                            <li>Process and deliver your orders</li>
                                            <li>Improve user experience and personalize recommendations</li>
                                            <li>Communicate promotions, offers, and updates</li>
                                            <li>Enhance website functionality through analytics</li>
                                            <li>Ensure security and fraud prevention</li>
                                        </ul>
                                    </div>

                                    <!-- Section 3 -->
                                    <div class="policy-section">
                                        <h2>3. Data Sharing & Security</h2>
                                        <p>
                                            Your privacy is a priority. We do not sell your data to third parties. However, we may share information with:
                                        </p>
                                        <ul>
                                            <li>Delivery executives for order fulfillment</li>
                                            <li>Trusted payment gateways</li>
                                            <li>Service providers to improve our platform</li>
                                            <li>Legal authorities if required by law</li>
                                        </ul>
                                        <p>
                                            All data transmissions are encrypted using SSL technology. We regularly update our systems to ensure maximum protection.
                                        </p>
                                    </div>

                                    <!-- Section 4 -->
                                    <div class="policy-section">
                                        <h2>4. Your Rights</h2>
                                        <p>You have the right to:</p>
                                        <ul>
                                            <li>Access, update, or delete your personal data</li>
                                            <li>Opt out of marketing communications</li>
                                            <li>Request data portability</li>
                                        </ul>
                                        <p>
                                            For any privacy concerns, contact us at <a href="mailto:privacy@platera.com">privacy@platera.com</a>.
                                        </p>
                                    </div>

                                    <!-- Section 5 -->
                                    <div class="policy-section">
                                        <h2>5. Updates to This Policy</h2>
                                        <p>
                                            We may update this Privacy Policy periodically. We will notify you of any significant changes through the website or email.
                                        </p>
                                        <p>
                                            Last updated: <span id="last-updated">December 15, 2024</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <div id="help-section" style="display: none;">
                            <div class="help-container">
                                <h1 class="help-heading">How Can We Help You?</h1>
                                <p class="help-description">
                                    At Platera, we are committed to providing you with the best experience. Whether you have questions about orders, payments, or account settings, our support team is here for you.
                                </p>
                                <div class="help-topics">
                                    <div class="topic">
                                        <h2>Order-Related Issues</h2>
                                        <p>
                                            Need help tracking your order or reporting a problem? Visit the 
                                            <a href="#order-support">Order Support</a> section.
                                        </p>
                                    </div>
                                    <div class="topic">
                                        <h2>Payment Queries</h2>
                                        <p>
                                            Questions about your transactions? Check our 
                                            <a href="#payment-support">Payment Help</a> section for guidance.
                                        </p>
                                    </div>
                                    <div class="topic">
                                        <h2>Account Assistance</h2>
                                        <p>
                                            Trouble accessing your account or updating information? Visit 
                                            <a href="#account-support">Account Support</a>.
                                        </p>
                                    </div>
                                </div>
                                <div class="help-contact">
                                    <h2>Still Need Help?</h2>
                                    <p>
                                        Contact our support team at 
                                        <a href="mailto:support@platera.com">support@platera.com</a> or call us at 
                                        <span>+1-800-PLATERA</span>.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div id="security-section" class="security-container" style="display: none;">
                            <div class="security-card">
                                <div class="security-header">
                                    <img src="asset/lock-on.png" alt="Lock Icon" class="lock-icon" />
                                    <h2>Two-factor Authentication</h2>
                                </div>
                                <p class="security-description">
                                    Enhance your security by setting up two-factor authentication (2FA) on your registered email.
                                </p>
                                <form id="twoFAForm" method="post" action="<%= request.getContextPath()%>/updateTwoFA">
                                    <div class="security-option">
                                        <div class="security-description">
                                            <label class="option-title">
                                                <span>Text Message</span> <span class="option-subtitle">EMAIL</span>
                                            </label>
                                            <p class="option-description">
                                                Get a one-time passcode through email.
                                            </p>
                                        </div>
                                        <label class="switch">
                                            <!-- Dynamically set the 'checked' attribute based on the 'twoFA' variable -->
                                            <input type="checkbox" id="email-toggle" name="twoFA" <%= twoFA ? "checked" : ""%> />
                                            <span class="slider round"></span>
                                        </label>
                                    </div>
                                    <div class="security-footer">
                                        <button type="button" id="cancel-btn" class="btn cancel-btn">Cancel</button>
                                        <button type="submit" id="save-btn" class="btn save-btn">Save changes</button>
                                    </div>
                                </form>
                            </div>
                        </div>



                    </div>
                </section>

            </main>
        </div>
    </div>
    <script>
        function confirmRedirect() {
            const proceed = confirm("Are you sure you want to proceed to the forgot password page?");
            if (proceed) {
                window.location.href = "<%=request.getContextPath()%>/src/pages/ForgotPassword/ForgotPassword.jsp"; // Replace with your actual URL
            }
        }
    </script>
    <script>
        // JavaScript to handle the photo preview
        document.getElementById('photo-input').addEventListener('change', function (event) {
            const file = event.target.files[0]; // Get the selected file
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    // Update the img src with the chosen photo
                    document.getElementById('profile-photo-preview').src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
    </script>
    <script>
        function removePhoto() {
            let confirmDelete = confirm("Are you sure you want to delete your profile photo?");

            if (!confirmDelete) {
                return;
            }

            let customerId = <%= customer_id%>;
            let formData = new FormData();
            formData.append("customer_id", customerId);

            let contextPath = window.location.pathname.split('/')[1];
            let xhr = new XMLHttpRequest();
            xhr.open("POST", "/" + contextPath + "/RemoveCustomerPhoto", true);

            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4) {
                    if (xhr.status == 200) {
                        let responseText = xhr.responseText.trim();
                        if (responseText === "success") {
                            document.getElementById("profile-photo-preview").src = "DatabaseImages/Customers/Default.png";
                            alert("Photo removed successfully!");
                        } else if (responseText === "photoDeletionFailed") {
                            alert("Failed to remove photo. Please try again.");
                        } else if (responseText === "error") {
                            alert("Customer not found. Please try again.");
                        } else if (responseText === "sqlError") {
                            alert("Database error occurred. Please try again later.");
                        } else if (responseText === "invalidUserId") {
                            alert("Invalid user ID. Please try again.");
                        }
                    } else {
                        alert("Error: " + xhr.status + " - " + xhr.statusText);
                    }
                }
            };
            xhr.send(formData);
        }

    </script>
    <script>
        // Confirmation for deleting account
        function confirmDelete() {
            return confirm("Are you sure you want to delete your account? This action cannot be undone.");
        }
    </script>

    <script src="./script.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

</body>
</html>
