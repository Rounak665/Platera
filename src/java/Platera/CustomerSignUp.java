package Platera;

import Utilities.EmailUtility;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(urlPatterns = {"/CustomerSignUp"})
public class CustomerSignUp extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name_signup");
        String email = request.getParameter("email_signup");
        String password = request.getParameter("password_signup");
        String re_password = request.getParameter("repassword_signup");

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            if (!password.equals(re_password)) {
                out.println("<h1>Passwords do not match!</h1>");
                return;
            }

            // Generate OTP
            Random random = new Random();
            int otp = 100000 + random.nextInt(900000); // 6-digit OTP

            // Store user data and OTP in session
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("name", name);
            session.setAttribute("email", email);
            session.setAttribute("password", password);
            session.setAttribute("welcomePopup", false);

            // Email content
            String subject = "Your OTP for Platera Signup";
            String body = "Hello " + name + ",\n\nYour OTP is: " + otp + "\n\nPlease enter this OTP to complete your sign-up.";

            // Send email
            if (EmailUtility.sendEmail(email, subject, body)) {
                response.sendRedirect("src/pages/OTPVerifications/CustomerVerifyOTP.jsp");
            } else {
                out.println("<h1>Error sending OTP email!</h1>");
            }
        }
    }
}
