package Platera;

import Utilities.EmailUtility;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/restaurant_sign_up"})
public class RestaurantSignUp extends HttpServlet {

    // This method processes requests for both HTTP GET and POST methods
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the form data
        String restaurant_name = request.getParameter("restaurant_name");
        String owner_name = request.getParameter("owner_name");
        String email = request.getParameter("email");
        String owner_phone = request.getParameter("owner_phone");
        String owner_address = request.getParameter("owner_address");
        String bank_account_name = request.getParameter("bank_account_name");
        String bank_account_number = request.getParameter("bank_account_number");
        String fssai_license = request.getParameter("fssai_license");
        String pan_card = request.getParameter("pan_card");
        String gstin = request.getParameter("gstin");
        String password = request.getParameter("password");
        String re_password = request.getParameter("re_password");

        // Set the response content type
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet sign_up</title>");
            out.println("</head>");
            out.println("<body>");

            // Check if password and re-password match
            if (!password.equals(re_password)) {
                out.println("<h1>Passwords do not match!</h1>");
            } else {

                Random random = new Random();
                int otp = 100000 + random.nextInt(900000);

                HttpSession session = request.getSession(true);
                session.setAttribute("otp", otp);
                session.setAttribute("restaurant_name", restaurant_name);
                session.setAttribute("owner_name", owner_name);
                session.setAttribute("email", email);
                session.setAttribute("owner_phone", owner_phone);
                session.setAttribute("owner_address", owner_address);
                session.setAttribute("bank_account_name", bank_account_name);
                session.setAttribute("bank_account_number", bank_account_number);
                session.setAttribute("fssai_license", fssai_license);
                session.setAttribute("pan_card", pan_card);
                session.setAttribute("gstin", gstin);
                session.setAttribute("password", password);
                session.setAttribute("user_role", 3);

                // Sending email
                String subject = "Your OTP for Platera Restaurant registration";
                String body = "Hello " + owner_name + ",\n\nYour OTP is: " + otp + "\n\nPlease enter this OTP to verify your email address for your restaurant registration.";
                if (EmailUtility.sendEmail(email, subject, body)) {
                    response.sendRedirect("src/pages/OTPVerifications/RestaurantVerifyOTP.jsp");
                } else {
                    out.println("<h1>Error sending OTP email!</h1>");
                }
            }

            out.println("</body>");
            out.println("</html>");
        }
    }

}
