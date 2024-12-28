const cardMethod = document.getElementById('cardMethod');
const codMethod = document.getElementById('codMethod');
const netBankingMethod = document.getElementById('netBankingMethod');

const cardDetails = document.getElementById('cardDetails');
const codDetails = document.getElementById('codDetails');
const netBankingDetails = document.getElementById('netBankingDetails');

function resetActive() {
  document.querySelectorAll('.method').forEach(button => button.classList.remove('active'));
  cardDetails.style.display = 'none';
  codDetails.style.display = 'none';
  netBankingDetails.style.display = 'none';
}

cardMethod.addEventListener('click', () => {
  resetActive();
  cardMethod.classList.add('active');
  cardDetails.style.display = 'block';
});

codMethod.addEventListener('click', () => {
  resetActive();
  codMethod.classList.add('active');
  codDetails.style.display = 'block';
});

netBankingMethod.addEventListener('click', () => {
  resetActive();
  netBankingMethod.classList.add('active');
  netBankingDetails.style.display = 'block';
});

function goBack(){
  window.location.href = "../DeliveryDetailsPage/deliverydetailspage.jsp";
}