document.addEventListener('DOMContentLoaded', () => {
    const popup = document.getElementById('popup');
    const loginForm = document.getElementById('loginForm');
    const signupForm = document.getElementById('signupForm');
    const toggleLogin = document.getElementById('toggleLogin');
    const toggleSignup = document.getElementById('toggleSignup');

    // Show the popup on page load
    setTimeout(() => {
        popup.classList.add('show');
        loginForm.style.display = 'block'; // Show login form by default
        signupForm.style.display = 'none'; // Hide signup form
    }, 100);

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
    signupForm.addEventListener('submit', (event) => {
        event.preventDefault();
        if (signupForm.checkValidity()) {
            console.log('Signup successful!');
            popup.classList.remove('show'); // Hide popup
            setTimeout(() => { popup.style.display = 'none'; }, 500); // Ensure the transition completes before hiding
        } else {
            alert("Please fill in all fields.");
        }
    });
});
