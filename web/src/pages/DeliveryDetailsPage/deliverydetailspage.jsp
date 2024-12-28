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
        <form>
            <div class="input-group">
                <label for="full-name">Full Name</label>
                <input type="text" id="full-name" name="full-name" placeholder="Enter full name" required>
            </div>
            <div class="input-group">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone" placeholder="Enter phone number" required>
            </div>
            <h3>Select Address</h3>
            <!-- Saved Address -->
            <div class="address-group">
                <input type="radio" id="saved-address-radio" name="addressRadio" value="saved" checked>
                <label for="saved-address-radio" class="address-label">Saved Address</label>
                <input type="text" id="saved-address" class="address-input" value="1234 Elm Street, Springfield, IL 62704" disabled>
            </div>
            <!-- New Address -->
            <div class="address-group">
                <input type="radio" id="new-address-radio" name="addressRadio" value="new">
                <label for="new-address-radio" class="address-label">New Address</label>
                <input type="text" id="new-address" class="address-input" placeholder="Enter new address" disabled>
            </div>
            <!-- Accept Emails Checkbox -->
            <div class="checkbox-group">
                <input type="checkbox" id="accept-emails" name="accept-emails">
                <label for="accept-emails">I accept to receive emails</label>
            </div>
        <button type="submit" onclick="redirect()">Submit</button>
            
        </form>
    </div>


    <script>
        // JavaScript to handle enabling/disabling the address inputs based on radio button selection
        const savedAddressRadio = document.getElementById('saved-address-radio');
        const newAddressRadio = document.getElementById('new-address-radio');
        const savedAddressInput = document.getElementById('saved-address');
        const newAddressInput = document.getElementById('new-address');

        newAddressRadio.addEventListener('change', function() {
            if (this.checked) {
                savedAddressInput.disabled = true;
                newAddressInput.disabled = false;
            }
        });

        // Initialize the state
        savedAddressInput.disabled = true;
        newAddressInput.disabled = true;

        function redirect() {
            window.location.href = "../PaymentGateway/paymentGateway.jsp";
        }

        // Function to go back to the previous page
        function goBack() {
            window.location.href = "../Customer/Home.jsp";
        }
    </script>
</body>
</html>