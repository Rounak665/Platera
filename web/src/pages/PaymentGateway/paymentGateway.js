document.addEventListener("DOMContentLoaded", function() {
  const cardMethod = document.getElementById('cardMethod');
  const codMethod = document.getElementById('codMethod');
  const netBankingMethod = document.getElementById('netBankingMethod');

  const cardDetails = document.getElementById('cardDetails');
  const codDetails = document.getElementById('codDetails');
  const netBankingDetails = document.getElementById('netBankingDetails');

  // Log initial state
  console.log('Initial state of elements:');
  console.log('cardMethod:', cardMethod);
  console.log('codMethod:', codMethod);
  console.log('netBankingMethod:', netBankingMethod);
  console.log('cardDetails:', cardDetails);
  console.log('codDetails:', codDetails);
  console.log('netBankingDetails:', netBankingDetails);

  // Function to reset the active state and hide all payment details
  function resetActive() {
      console.log('Resetting active states and hiding all details');
      document.querySelectorAll('.method').forEach(button => {
          console.log(`Removing active class from ${button.id}`);
          button.classList.remove('active');
      });
      if (cardDetails) {
          cardDetails.style.display = 'none';
          console.log('cardDetails display set to none');
      } else {
          console.error('cardDetails element not found');
      }
      if (codDetails) {
          codDetails.style.display = 'none';
          console.log('codDetails display set to none');
      } else {
          console.error('codDetails element not found');
      }
      if (netBankingDetails) {
          netBankingDetails.style.display = 'none';
          console.log('netBankingDetails display set to none');
      } else {
          console.error('netBankingDetails element not found');
      }
  }

  // Event listener for card method button
  cardMethod.addEventListener('click', () => {
      console.log('Card method button clicked');
      resetActive();
      cardMethod.classList.add('active');
      console.log('Added active class to cardMethod');
      if (cardDetails) {
          cardDetails.style.display = 'block';
          console.log('cardDetails display after click:', cardDetails.style.display);
      }
  });

  // Event listener for COD method button
  codMethod.addEventListener('click', () => {
      console.log('COD method button clicked');
      resetActive();
      codMethod.classList.add('active');
      console.log('Added active class to codMethod');
      if (codDetails) {
          codDetails.style.display = 'block';
          console.log('codDetails display after click:', codDetails.style.display);
      }
  });

  // Event listener for net banking method button
  netBankingMethod.addEventListener('click', () => {
      console.log('Net banking method button clicked');
      resetActive();
      netBankingMethod.classList.add('active');
      console.log('Added active class to netBankingMethod');
      if (netBankingDetails) {
          netBankingDetails.style.display = 'block';
          console.log('netBankingDetails display after click:', netBankingDetails.style.display);
      }
  });

  // Function to navigate back to the order details page
  function goBack() {
      console.log('Navigating back to the order details page');
      window.location.href = "../OrderDetails/OrderDetails.jsp";
  }
});