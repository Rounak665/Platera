
package Platera;

import Utilities.Cart;
import Utilities.CartDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "UpdateCartQuantity", urlPatterns = {"/UpdateCartQuantity"})

public class UpdateCartQuantity extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int cartId = Integer.parseInt(request.getParameter("cart_id"));
        String action = request.getParameter("action");
        CartDAO cartDAO = new CartDAO();

        // Get the current cart item
        Cart cart = cartDAO.getCartItemById(cartId);

        // Update the quantity based on the action
        if ("add".equals(action)) {
            cart.setQuantity(cart.getQuantity() + 1); // Increase quantity
        } else if ("subtract".equals(action)) {
            if (cart.getQuantity() > 1) {
                cart.setQuantity(cart.getQuantity() - 1); // Decrease quantity
            }
        }

        // Update the cart in the database
        cartDAO.updateItemQuantity(cart.getCartId(),cart.getQuantity());

        // Redirect to the cart page to reflect the changes
        response.sendRedirect("src/pages/Customer/Home.jsp#cartSection");

    }
}
