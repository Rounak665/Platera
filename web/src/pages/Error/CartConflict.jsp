<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cart Conflict</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Arial', sans-serif;
            }

            /* Overlay background */
            .popup-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.7);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 1000;
            }

            /* Popup container */
            .popup {
                background: #fff;
                border-radius: 10px;
                padding: 20px 30px;
                width: 90%;
                max-width: 400px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.25);
                text-align: center;
                animation: fadeIn 0.3s ease-out;
            }

            /* Popup heading */
            .popup h2 {
                font-size: 24px;
                margin-bottom: 10px;
                color: #333;
            }

            /* Popup text */
            .popup p {
                font-size: 16px;
                color: #555;
                margin-bottom: 20px;
                line-height: 1.5;
            }

            /* Buttons container */
            .popup-buttons {
                display: flex;
                justify-content: space-evenly;
                gap: 10px;
            }

            /* Buttons styling */
            .btn {
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            /* Yes button styling */
            .btn.yes {
                background: #007bff;
                color: #fff;
            }

            .btn.yes:hover {
                background: #0056b3;
            }

            /* No button styling */
            .btn.no {
                background: #f44336;
                color: #fff;
            }

            .btn.no:hover {
                background: #d32f2f;
            }

            /* Animation for popup */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: scale(0.9);
                }
                to {
                    opacity: 1;
                    transform: scale(1);
                }
            }
        </style>
    </head>
    <%
        // Retrieve current item details from query parameters
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
    %>
    <body>
        <div class="popup-overlay">
            <div class="popup">
                <h2>Cart Conflict</h2>
                <p>Your cart already contains items from another restaurant. Would you like to clear the cart and add the new items, or keep your existing items?</p>
                <div class="popup-buttons">
                    <button class="btn no">No</button>
                    <form action="<%= request.getContextPath()%>/AddToCart" method="post">
                        <input type="hidden" name="customerId" value="<%= customerId%>">
                        <input type="hidden" name="itemId" value="<%= itemId%>">
                        <input type="hidden" name="restaurantId" value="<%= restaurantId%>">
                        <input type="hidden" name="overwrite" value="true">
                        <button type="submit" class="btn yes">Yes</button>
                    </form>

                </div>
            </div>
        </div>
    </body>
</html>
