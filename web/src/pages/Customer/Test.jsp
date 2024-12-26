<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Place Order Test</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            max-width: 600px;
            margin: auto;
        }
        .order-form {
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        .order-form button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .order-form button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Place Order Test</h1>
        
        <!-- Order Placement Form -->
        <form class="order-form" action="http://localhost:8080/Platera-Main/PlaceOrder" method="POST">
            <!-- Hidden input for customer ID -->
            <input type="hidden" name="customer_id" value="30">
            
            <!-- Place Order Button -->
            <button type="submit">Place Order</button>
        </form>
    </div>
</body>
</html>
