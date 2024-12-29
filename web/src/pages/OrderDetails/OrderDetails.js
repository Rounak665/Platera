
function goBack() {
    window.location.href = "/src/pages/Customer/Home.jsp#cartSection"; 
}

document.addEventListener("DOMContentLoaded", function () {
    const savedAddressRadio = document.getElementById("saved-address-radio");
    const newAddressRadio = document.getElementById("new-address-radio");
    const savedAddressInput = document.getElementById("saved-address");
    const newAddressInput = document.getElementById("new-address");
    const savedAddressCaution=document.getElementById("saved-address-caution");
    const newAddressCaution=document.getElementById("new-address-caution");

    // Toggle visibility of the text area input fields based on the selected address radio button
    function toggleAddressInputVisibility() {
        if (savedAddressRadio.checked) {
            savedAddressInput.style.display = "block";
            savedAddressCaution.style.display = "block";
            newAddressInput.style.display = "none";
            newAddressCaution.style.display = "none";
        } else if (newAddressRadio.checked) {
            savedAddressInput.style.display = "none";
            savedAddressCaution.style.display = "none";
            newAddressInput.style.display = "block";
            newAddressCaution.style.display = "block";
        }
    }

    // Add event listeners to the radio buttons
    savedAddressRadio.addEventListener("change", toggleAddressInputVisibility);
    newAddressRadio.addEventListener("change", toggleAddressInputVisibility);

    // Initialize the form
    toggleAddressInputVisibility();
});