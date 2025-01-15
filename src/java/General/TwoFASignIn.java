package General;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/TwoFASignIn")
public class TwoFASignIn extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get the OTP entered by the user
        String enteredOtp = request.getParameter("otp");

        // Get the OTP stored in the session
        HttpSession session = request.getSession();
        String generatedOtp = (String) session.getAttribute("otp");
        session.setAttribute("welcomePopup", false);  // Set welcome popup flag

        // Check if the entered OTP matches the generated OTP
        if (enteredOtp != null && enteredOtp.equals(generatedOtp)) {
            // OTP matches, proceed to the user's dashboard

            // Get user_role_id from the session
            Integer userRoleId = (Integer) session.getAttribute("user_role_id");

            // Redirect based on user role
            String dashboardUrl = "";
            switch (userRoleId) {
                case 1:  // Admin
                    dashboardUrl = "src/pages/Admin/Admin_Order_Management.jsp";
                    break;
                case 2:  // Customer
                    dashboardUrl = "src/pages/Customer/Home.jsp";
                    break;
                case 3:  // Restaurant
                    dashboardUrl = "src/pages/Restaurant/RestaurantDashboard.jsp";
                    break;
                case 4:  // Delivery Executive
                    dashboardUrl = "src/pages/DeliveryExecutive/DeliveryDashboard.jsp";
                    break;
                default:
                    out.println("src/pages/Error/DatabaseError.html");
                    return;  // Exit if the user role is invalid
            }

            // Redirect to the relevant dashboard
            response.sendRedirect(dashboardUrl);
        } else {
            // OTP doesn't match, show an error message
            response.sendRedirect("src/pages/Error/WrongOTP.html");
        }
    }
}
