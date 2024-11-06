document.addEventListener('DOMContentLoaded', () => {
    const popup = document.getElementById('popup');
    const loginForm = document.getElementById('loginForm');
    const signupForm = document.getElementById('signupForm');
    const toggleLogin = document.getElementById('toggleLogin');
    const toggleSignup = document.getElementById('toggleSignup');

    // Function to check for a specific cookie
    function getCookie(name) {
        const value = `; ${document.cookie}`;
        const parts = value.split(`; ${name}=`);
        if (parts.length === 2) return parts.pop().split(';').shift();
    }

    // Show the popup only if the signedUp cookie does not exist
    if (!getCookie('signedUp')) {
        setTimeout(() => {
            popup.classList.add('show');
            loginForm.style.display = 'block'; // Show login form by default
            signupForm.style.display = 'none'; // Hide signup form
        }, 100);
    }

    // Toggle to login form
    toggleLogin.addEventListener('click', () => {
        loginForm.style.display = 'block'; // Show login form
        signupForm.style.display = 'none'; // Hide signup form
    });

    // Toggle to signup form
    toggleSignup.addEventListener('click', () => {
        signupForm.style.display = 'block'; // Show signup form
        loginForm.style.display = 'none'; // Hide login form
    });

    // Handle login form submission
    loginForm.addEventListener('submit', (event) => {
        event.preventDefault();
        if (loginForm.checkValidity()) {
            console.log('Login successful!');
            popup.classList.remove('show'); // Hide popup
            setTimeout(() => { popup.style.display = 'none'; }, 500); // Ensure the transition completes before hiding
        } else {
            alert("Please fill in all fields.");
        }
    });

    // Handle signup form submission
    // Handle signup form submission
signupForm.addEventListener('submit', (event) => {
    if (signupForm.checkValidity()) {
        // Let the form submit to the server
        console.log('Signup form is valid, proceeding to servlet.');
        popup.classList.remove('show'); // Hide popup
        setTimeout(() => { popup.style.display = 'none'; }, 500);
    } else {
        // If the form is not valid, prevent submission and alert the user
        event.preventDefault();
        alert("Please fill in all fields.");
    }
});

});
