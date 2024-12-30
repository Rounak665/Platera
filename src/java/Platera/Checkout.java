
package Platera;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Checkout")
public class Checkout extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Retrieve the payment parameter from the request
        String paymentMethod = request.getParameter("payment");

        // Determine the user-friendly payment method description
        String paymentDescription;
        switch (paymentMethod) {
            case "cards":
                paymentDescription = "Credit/Debit Cards";
                break;
            case "netBanking":
                paymentDescription = "Net Banking";
                break;
            case "cod":
                paymentDescription = "Cash On Delivery";
                break;
            default:
                paymentDescription = "Unknown Payment Method";
                break;
        }

        // Redirect to the confirmation page with the payment description
        response.sendRedirect("src/pages/OrderDetails/OrderDetails.jsp?payment=" + paymentDescription);
    }
}
