package Customer;

import Utilities.CartDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteFromCart")
public class DeleteFromCart extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the cartId from the request
        String cartIdParam = request.getParameter("cart_id");

        try {
            int cartId = Integer.parseInt(cartIdParam);

            // Use the CartDAO to remove the item
            CartDAO cartDAO = new CartDAO();
            boolean isRemoved = cartDAO.removeItemFromCart(cartId);

            if (isRemoved) {
                // Item successfully removed, redirect or notify user
                response.sendRedirect("src/pages/Customer/Home.jsp?status=removed#cartSection");
            } else {
                // Failed to remove item, handle error
                response.sendRedirect("src/pages/Customer/Home.jsp#errorPopup");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("src/pages/Error/DatabaseError.html");
        }
    }
}
