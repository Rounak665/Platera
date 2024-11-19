document.getElementById('profile-form').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevent form from submitting
    
    const profilePhoto = document.getElementById('profile-photo').files[0];
    const name = document.getElementById('name').value;
    const phone = document.getElementById('phone').value;
    const address = document.getElementById('address').value;
    const cuisine1 = document.getElementById('cuisine1').value;
    const cuisine2 = document.getElementById('cuisine2').value;
    const cuisine3 = document.getElementById('cuisine3').value;
    const minPrice = document.getElementById('min-price').value;
    const maxPrice = document.getElementById('max-price').value;
  
    console.log('Profile Photo:', profilePhoto ? profilePhoto.name : 'No file selected');
    console.log('Name:', name);
    console.log('Phone:', phone);
    console.log('Address:', address);
    console.log('Cuisine 1:', cuisine1);
    console.log('Cuisine 2:', cuisine2);
    console.log('Cuisine 3:', cuisine3);
    console.log('Min Price:', minPrice);
    console.log('Max Price:', maxPrice);
  
    alert('Form submitted successfully!');
  });
  