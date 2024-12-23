// ----------------Sidebar----------------------------
// Toggle the sidebar menu visibility
const menuToggle = document.querySelector('#menu');
const closeButton = document.querySelector('.close-btn');
const sidebar = document.querySelector('.sidebar');

menuToggle.addEventListener('click', () => {
    sidebar.classList.add('activate');
});

closeButton.addEventListener('click', () => {
    sidebar.classList.remove('activate');
});




// -------------------Cart Section Script-------------------
function toggleDetails(row) {
  // Toggle the background color
  row.classList.toggle('active');
  // Find the next row (details row)
  const nextRow = row.nextElementSibling;
  nextRow.classList.toggle('show');
  // Toggle the dropdown icon
  const icon = row.querySelector('.dropdown');
  icon.classList.toggle('rotate');
}

// checkout to paynow transfer
const checkoutButton = document.querySelector('.checkout-button');
if (checkoutButton) {
    checkoutButton.addEventListener('click', function () {
        // Hide the cart checkout container
        document.querySelector('.checkout').style.display = 'none';

        // Show the payment checkout container
        document.querySelector('.paynow').style.display = 'block';
    });
}
// Optional: Add functionality to close the containers
document.querySelectorAll('.close').forEach(closeButton => {
  closeButton.addEventListener('click', function () {
      // Hide both containers
      document.querySelector('.checkout').style.display = 'none';
      document.querySelector('.paynow').style.display = 'none';
  });
});



document.addEventListener('DOMContentLoaded', () => {
  // ----------------Settings Section Script------------------------

  // Toggle for Account Tab
  document.getElementById('account-tab').addEventListener('click', () => {
      document.getElementById('account-section').style.display = 'block';
      document.getElementById('notifications-section').style.display = 'none';
      document.getElementById('privacy-policy').style.display = 'none';
      document.getElementById('help-section').style.display = 'none';
      document.getElementById('security-section').style.display = 'none';
  });

  // Toggle for Notification Tab
  document.getElementById('notification-tab').addEventListener('click', () => {
      document.getElementById('notifications-section').style.display = 'block';
      document.getElementById('account-section').style.display = 'none';
      document.getElementById('privacy-policy').style.display = 'none';
      document.getElementById('help-section').style.display = 'none';
      document.getElementById('security-section').style.display = 'none';
  });

  // Toggle for Privacy Policy Tab
  document.getElementById('privacy-policy-tab').addEventListener('click', () => {
      document.getElementById('privacy-policy').style.display = 'block';
      document.getElementById('account-section').style.display = 'none';
      document.getElementById('notifications-section').style.display = 'none';
      document.getElementById('help-section').style.display = 'none';
      document.getElementById('security-section').style.display = 'none';
  });

  // Toggle for Help Tab
  document.getElementById('help-tab').addEventListener('click', () => {
      document.getElementById('help-section').style.display = 'block';
      document.getElementById('account-section').style.display = 'none';
      document.getElementById('notifications-section').style.display = 'none';
      document.getElementById('privacy-policy').style.display = 'none';
      document.getElementById('security-section').style.display = 'none';
  });

  // Toggle for Security Tab
  document.getElementById('security-tab').addEventListener('click', () => {
      document.getElementById('security-section').style.display = 'flex';
      document.getElementById('account-section').style.display = 'none';
      document.getElementById('notifications-section').style.display = 'none';
      document.getElementById('privacy-policy').style.display = 'none';
      document.getElementById('help-section').style.display = 'none';
  });
});




// Two-Factor Authentication Toggles
document.getElementById('authenticator-toggle').addEventListener('change', (e) => {
  if (e.target.checked) {
    alert('Authenticator App Enabled!');
  } else {
    alert('Authenticator App Disabled!');
  }
});

document.getElementById('sms-toggle').addEventListener('change', (e) => {
  if (e.target.checked) {
    alert('Text Message Authentication Enabled!');
  } else {
    alert('Text Message Authentication Disabled!');
  }
});

// Cancel Button Action
document.getElementById('cancel-btn').addEventListener('click', () => {
  alert('Changes were canceled.');
});

// Save Changes Action
document.getElementById('save-btn').addEventListener('click', () => {
  alert('Changes saved successfully!');
});

