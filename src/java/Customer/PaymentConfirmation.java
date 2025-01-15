package Customer;

import Utilities.PlaceOrder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "PaymentConfirmation", urlPatterns = {"/PaymentConfirmation"})
public class PaymentConfirmation extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the session
        HttpSession session = request.getSession();

        // Retrieve session attributes
        String paymentMethod = (String) session.getAttribute("paymentMethod");
        String fullName = (String) session.getAttribute("fullName");
        String phone = (String) session.getAttribute("phone");
        String address = (String) session.getAttribute("address");
        String email = (String) session.getAttribute("email");
        int customerId = (int) session.getAttribute("customerId");
        int locationId = (int) session.getAttribute("locationId");
        boolean emailConfirmation = (boolean) session.getAttribute("emailConfirmation");

        // Clear session attributes after use
        session.removeAttribute("paymentMethod");
        session.removeAttribute("fullName");
        session.removeAttribute("phone");
        session.removeAttribute("address");
        session.removeAttribute("email");
        session.removeAttribute("customerId");
        session.removeAttribute("locationId");
        session.removeAttribute("emailConfirmation");

        // Call PlaceOrder with retrieved session values
        PlaceOrder placeOrder = new PlaceOrder(customerId, locationId, paymentMethod, address, phone, fullName, email, emailConfirmation);
        String result = placeOrder.placeOrder();

        if ("Order placed successfully!".equals(result)) {
            response.sendRedirect("src/pages/Customer/CustomerDashboard/CustomerOrder.jsp?OrderConfirmed");
        } else {
            response.sendRedirect("src/pages/Customer/Home.jsp#errorPopup");
        }
    }
}
