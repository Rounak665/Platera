package Customer;

import Utilities.PlaceOrder;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "OrderDetails", urlPatterns = {"/OrderDetails"})
public class OrderDetails extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String paymentMethod = request.getParameter("payment-method");
        String fullName = request.getParameter("full-name");
        String phone = request.getParameter("phone");
        String addressRadio = request.getParameter("addressRadio");
        String email = request.getParameter("email");
        String address = null;

        if ("saved-address".equals(addressRadio)) {
            address = request.getParameter("saved-address");
        } else if ("new-address".equals(addressRadio)) {
            address = request.getParameter("new-address");
        }

        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int locationId = Integer.parseInt(request.getParameter("locationId"));
        boolean emailConfirmation = request.getParameter("email-confirmation") != null;

        if ("Cash On Delivery".equals(paymentMethod)) {
            // Directly place the order for COD
            PlaceOrder placeOrder = new PlaceOrder(customerId, locationId, paymentMethod, address, phone, fullName, email, emailConfirmation);
            String result = placeOrder.placeOrder();

            if ("Order placed successfully!".equals(result)) {
                response.sendRedirect("src/pages/CustomerDashboard/CustomerOrder.jsp?OrderConfirmed");
            } else {
                // Redirect to error page if order placement failed
                response.sendRedirect("src/pages/Customer/Home.jsp#errorPopup");
            }
        } else {
            // Set session attributes for other payment methods (e.g., Credit Card, Net Banking)
            HttpSession session = request.getSession();
            session.setAttribute("paymentMethod", paymentMethod);
            session.setAttribute("fullName", fullName);
            session.setAttribute("phone", phone);
            session.setAttribute("addressRadio", addressRadio);
            session.setAttribute("email", email);
            session.setAttribute("address", address);
            session.setAttribute("customerId", customerId);
            session.setAttribute("locationId", locationId);
            session.setAttribute("emailConfirmation", emailConfirmation);

            // Redirect to the payment page
            response.sendRedirect("src/pages/PaymentGateway/PaymentGateway.jsp");
        }
    }
}

