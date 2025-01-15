package Customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Utilities.CartDAO;
import Utilities.Cart;
import Utilities.Restaurant;
import Utilities.RestaurantDAO;

@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int itemId = Integer.parseInt(request.getParameter("itemId"));

        System.out.println("Customer ID: " + customerId);
        System.out.println("Item ID: " + itemId);

        CartDAO cartDAO = new CartDAO();
        RestaurantDAO restaurantDAO = new RestaurantDAO();

        // Check if the "overwrite" parameter is true
        boolean overwrite = request.getParameter("overwrite") != null
                && request.getParameter("overwrite").equalsIgnoreCase("true");

        if (overwrite) {
            // Clear the cart for the customer
            cartDAO.clearCart(customerId);
            System.out.println("Cart cleared for Customer ID: " + customerId);
            // No return statement, continue to add the new item
        }

        // Fetch the restaurantId using the itemId
        Restaurant restaurant = restaurantDAO.getRestaurantByItemId(itemId);
        int restaurantId = (restaurant != null) ? restaurant.getRestaurantId() : -1;

        if (restaurantId == -1) {
            response.sendRedirect("src/pages/Error/DatabaseError.html");
            return;
        }

        boolean hasDifferentRestaurantItems = cartDAO.hasItemsFromDifferentRestaurant(customerId, restaurantId);

        if (hasDifferentRestaurantItems) {
            response.sendRedirect("src/pages/Error/CartConflict.jsp?customerId=" + customerId
                    + "&itemId=" + itemId
                    + "&restaurantId=" + restaurantId);
        } else {
            boolean isInCart = cartDAO.isItemInCart(customerId, itemId);
            if (isInCart) {
                response.sendRedirect("src/pages/Customer/Home.jsp#cartSection");
            } else {
                // Add the current item to the cart
                Cart cart = new Cart();
                cart.setCustomerId(customerId);
                cart.setItemId(itemId);
                cart.setRestaurantId(restaurantId);
                cart.setQuantity(1);

                boolean success = cartDAO.addItemToCart(cart);

                if (success) {
                    response.sendRedirect("src/pages/Customer/RestaurantDetails/RestaurantDetails.jsp?restaurantId=" + restaurantId + "#item" + itemId);
                } else {
                    response.sendRedirect("src/pages/Error/DatabaseError.html");
                }
            }
        }
    }
}
