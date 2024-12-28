<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Details</title>
        <link rel="stylesheet" href="./deliverydetailspage.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar">
            <div class="logo"><a href=""><img src="./Assets/PlateraLogo-red.png" alt="" width="150px"></a></div>
            <button class="back-button" onclick="goBack()">Back</button>
        </nav>
        <div class="container">
            <h2>User Details</h2>
            <form id="userDetailsForm">
                <div class="input-group">
                    <label for="full-name">Full Name</label>
                    <input type="text" id="full-name" name="full-name" required>
                </div>
                <div class="input-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" required>
                </div>
                <h3>Select Address</h3>
                <!-- Saved Address -->
                <div class="address-group">
                    <input type="radio" id="saved-address-radio" name="addressRadio" value="saved" checked>
                    <label for="saved-address-radio" class="address-label">Saved Address</label>
                </div>
                <input type="text" id="saved-address" class="address-input" value="1234 Elm Street, Springfield, IL 62704" readonly>

                <!-- New Address -->
                <div class="address-group">
                    <input type="radio" id="new-address-radio" name="addressRadio" value="new">
                    <label for="new-address-radio" class="address-label">New Address</label>
                </div>
                <input type="text" id="new-address" class="address-input" placeholder="Enter new address" style="display: none;">

                <!-- Confirmation Email -->
                <div class="input-group checkbox-group">
                    <input type="checkbox" id="email-confirmation" name="email-confirmation">
                    <label for="email-confirmation">Receive order confirmation in your registered email</label>
                </div>

                <button type="submit">Submit</button>
            </form>
        </div>




        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const savedAddressRadio = document.getElementById("saved-address-radio");
                const newAddressRadio = document.getElementById("new-address-radio");
                const savedAddressInput = document.getElementById("saved-address");
                const newAddressInput = document.getElementById("new-address");

                // Toggle visibility of the text area input fields based on the selected address radio button
                function toggleAddressInputVisibility() {
                    if (savedAddressRadio.checked) {
                        savedAddressInput.style.display = "block";
                        newAddressInput.style.display = "none";
                    } else if (newAddressRadio.checked) {
                        savedAddressInput.style.display = "none";
                        newAddressInput.style.display = "block";
                    }
                }

                // Add event listeners to the radio buttons
                savedAddressRadio.addEventListener("change", toggleAddressInputVisibility);
                newAddressRadio.addEventListener("change", toggleAddressInputVisibility);

                // Initialize the form
                toggleAddressInputVisibility();
            });


        </script>
    </body>
</html>