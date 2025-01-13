
// ---------------------Profile Setting Scetion---------------------
const settingIcon = document.getElementById('setIcon');
const settingSection = document.getElementById('setSection');
const closeSetSection = document.getElementById("closeSetSection");
const closeEditSection = document.getElementById("closeEditSection");
settingIcon.addEventListener('click', () => {
    // Check if the screen width is less than 450px
    if (window.matchMedia("(max-width: 450px)").matches) {
        // Screen is less than 450px
        if (settingSection.style.right === '0%') {
            settingSection.style.right = '-100%'; // Slide out cart section for small screens
        } else {
            settingSection.style.right = '0%'; // Slide in cart section
            userSection.style.right = '-100%'; // Ensure user section is hidden
        }
    } else {
        // Screen is 450px or more
        if (settingSection.style.right === '0%') {
            settingSection.style.right = '-50%'; // Slide out cart section for larger screens
        } else {
            settingSection.style.right = '0%'; // Slide in cart section
            userSection.style.right = '-50%'; // Ensure user section is hidden
        }
    }
});


if (closeSetSection) {
    closeSetSection.addEventListener("click", () => {
        if (window.matchMedia("(max-width: 450px)").matches) {
            // Screen is less than 450px
            document.getElementById("setSection").style.right = "-100%";
        } else {
            // Screen is 450px or more
            document.getElementById("setSection").style.right = "-50%";
        }
    });
}

if (closeEditSection) {
    closeEditSection.addEventListener("click", () => {
        if (window.matchMedia("(max-width: 450px)").matches) {
            // Screen is less than 450px
            document.getElementById("setSection").style.right = "-100%";
        } else {
            // Screen is 450px or more
            document.getElementById("setSection").style.right = "-50%";
        }
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


