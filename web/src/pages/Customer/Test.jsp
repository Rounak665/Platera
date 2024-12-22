<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Category Images</title>
    <style>
        .image-gallery {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
        }
        .image-item {
            text-align: center;
            margin: 10px;
        }
        .image-item img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border: 2px solid #ccc;
            border-radius: 10px;
        }
        .image-item p {
            margin-top: 5px;
            font-weight: bold;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <h1>Category Images</h1>
    <div class="image-gallery">
        <!-- Explicitly written for each category -->
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Appetizer.jpeg" alt="Appetizer">
            <p>Appetizers</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/MainCourse.jpg" alt="Main Course">
            <p>Main Course</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Desserts.jpg" alt="Desserts">
            <p>Desserts</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Drinks.jpg" alt="Drinks">
            <p>Drinks</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Vegetarian.jpeg" alt="Vegetarian">
            <p>Vegetarian</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Vegan.jpeg" alt="Vegan">
            <p>Vegan</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/GlutenFree.jpg" alt="Gluten Free">
            <p>Gluten Free</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/SeaFood.jpeg" alt="Seafood">
            <p>Seafood</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Italian.jpeg" alt="Italian">
            <p>Italian</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Chinese.jpeg" alt="Chinese">
            <p>Chinese</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Mexican.jpeg" alt="Mexican">
            <p>Mexican</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Indian.jpg" alt="Indian">
            <p>Indian</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Japanese.jpeg" alt="Japanese">
            <p>Japanese</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Barbecue.jpg" alt="Barbecue">
            <p>Barbecue</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Healthy.jpeg" alt="Healthy">
            <p>Healthy</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Salad.jpeg" alt="Salads">
            <p>Salads</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Pasta.jpg" alt="Pasta">
            <p>Pasta</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Pizza.jpeg" alt="Pizza">
            <p>Pizza</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Sandwich.jpeg" alt="Sandwich">
            <p>Sandwiches</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Burgers.jpeg" alt="Burgers">
            <p>Burgers</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Soup.jpg" alt="Soup">
            <p>Soup</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Steaks.jpeg" alt="Steaks">
            <p>Steaks</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Sushi.jpg" alt="Sushi">
            <p>Sushi</p>
        </div>
        <div class="image-item">
            <img src="<%= request.getContextPath() %>/DatabaseImages/Categories/Tacos.jpeg" alt="Tacos">
            <p>Tacos</p>
        </div>
    </div>
</body>
</html>
