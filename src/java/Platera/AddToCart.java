package Platera;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Utilities.CartDAO;
import Utilities.Cart;

@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
        int itemId = Integer.parseInt(request.getParameter("itemId"));

        System.out.println("Customer ID: " + customerId);
        System.out.println("Restaurant ID: " + restaurantId);
        System.out.println("Item ID: " + itemId);

        CartDAO cartDAO = new CartDAO();
        boolean isInCart = cartDAO.isItemInCart(customerId, restaurantId, itemId);

        if (isInCart) {
            response.sendRedirect("src/pages/Customer/Home.jsp?cartSection");
        } else {
            Cart cart = new Cart();
            cart.setCustomerId(customerId);
            cart.setItemId(itemId);
            cart.setRestaurantId(restaurantId);
            cart.setQuantity(1);

            boolean success = cartDAO.addItemToCart(cart);

            if (success) {
                response.sendRedirect("src/pages/Customer/RestaurantDetails/RestaurantDetails.jsp#item" +itemId);
            } else {
                request.setAttribute("errorMessage", "Failed to add item to cart.");
                request.getRequestDispatcher("restaurantDetails.jsp").forward(request, response);
            }
        }
    }
}
