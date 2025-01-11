
// ---------------------Profile Setting Scetion---------------------
const settingIcon = document.getElementById('setIcon');
const settingSection = document.getElementById('setSection');
const closeSetSection = document.getElementById("closeSetSection");
const closeEditSection = document.getElementById("closeEditSection");
settingIcon.addEventListener('click', () => {
    if (settingSection.style.right === '0%') {
        settingSection.style.right = '-50%'; // Slide out cart section
    } else {
        settingSection.style.right = '0%'; // Slide in cart section
        userSection.style.right = '-50%'; // Ensure user section is hidden
    }
});

if (closeSetSection) {
    closeSetSection.addEventListener("click", () => {
        document.getElementById("setSection").style.right = "-50%";
    });
}
if (closeEditSection) {
    closeEditSection.addEventListener("click", () => {
        document.getElementById("setSection").style.right = "-50%";
    });
}


// ---------------------Profile Setting Edit Scetion---------------------
document.getElementById('editProfile').addEventListener('click', function() {
    document.getElementById('settingContainer').style.display = 'none';
    document.getElementById('modalContent').style.display = 'block';
});
document.getElementById('cancelModal').addEventListener('click', function() {
    document.getElementById('modalContent').style.display = 'none';
    document.getElementById('settingContainer').style.display = 'block';
});
// ---------------------Security Scetion---------------------
document.getElementById('setSecure').addEventListener('click', function() {
    document.getElementById('security-section').style.display = 'flex';
});
document.getElementById('closeSecuritySection').addEventListener('click', function() {
    document.getElementById('security-section').style.display = 'none';
});

// ---------------------Edit Profile Section---------------------
const backToCheckoutButton = document.getElementById("backToCheckout");
if (backToCheckoutButton) {
    backToCheckoutButton.addEventListener("click", function () {
        // Hide the edit container
        document.querySelector('.modal-content').style.display = 'none';

        // Show the settings container
        document.querySelector('.setting-container').style.display = 'block';
    });
}