// Check if the URL hash is #errorPopup
if (window.location.hash === '#errorPopup') {
    // Show the error popup
    document.addEventListener('DOMContentLoaded', function () {
        const errorPopup = document.getElementById('errorPopup');
        if (errorPopup) {
            errorPopup.style.display = 'flex';
        }
    });
}

// Function to display the error popup dynamically
function showErrorPopup(message) {
    const errorMessage = document.getElementById('errorMessage');
    const errorPopup = document.getElementById('errorPopup');
    if (errorMessage && errorPopup) {
        errorMessage.innerText = message;
        errorPopup.style.display = 'flex';
    }
}

// Close the error popup
document.addEventListener('DOMContentLoaded', function () {
    const closeErrorPopupButton = document.getElementById('closeErrorPopup');
    const errorPopup = document.getElementById('errorPopup');
    if (closeErrorPopupButton && errorPopup) {
        closeErrorPopupButton.addEventListener('click', function () {
            errorPopup.style.display = 'none';
        });
    }
});