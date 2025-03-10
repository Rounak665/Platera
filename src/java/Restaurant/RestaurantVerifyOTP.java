
package Restaurant;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/RestaurantVerifyOTP"})
public class RestaurantVerifyOTP extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the OTP entered by the user
        String enteredOTP = request.getParameter("otp");

        // Retrieve the session and the stored OTP
        HttpSession session = request.getSession(false);
        Integer sessionOTP = (Integer) session.getAttribute("otp");

        // Set response content type
        response.setContentType("text/html;charset=UTF-8");

        // Verify OTP
        try {
            if (sessionOTP != null && sessionOTP.equals(Integer.valueOf(enteredOTP))) {
                // OTP verified successfully
                 response.sendRedirect("src/pages/AddRestaurant/Restaurant_public_info/Restaurant_public_info.jsp");
            } else {
                response.sendRedirect("src/pages/Error/WrongOTP.html");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("src/pages/Error/DatabaseError.html");
        }
    }
}


