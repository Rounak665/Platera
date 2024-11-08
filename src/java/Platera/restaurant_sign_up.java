package Platera;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
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
import oracle.jdbc.OraclePreparedStatement;

@WebServlet(urlPatterns = {"/restaurant_sign_up"})
public class restaurant_sign_up extends HttpServlet {

    // This method processes requests for both HTTP GET and POST methods
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the form data
        String restaurant_name = request.getParameter("restaurant_name");
        String owner_name = request.getParameter("owner_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
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
                session.setAttribute("phone", phone);
                session.setAttribute("address", address);
                session.setAttribute("bank_account_name", bank_account_name);
                session.setAttribute("bank_account_number", bank_account_number);
                session.setAttribute("fssai_license", fssai_license);
                session.setAttribute("pan_card", pan_card);
                session.setAttribute("gstin", gstin);
                session.setAttribute("password", password);
                session.setAttribute("user_role",3);

                String subject = "Your OTP for Platera Restaurant registration";
                String body = "Hello " + owner_name + ",\n\nYour OTP is: " + otp + "\n\nPlease enter this OTP to verify your email address for your restaurant registration.";

                // Sending email
                final String username = "plateraminorproject@gmail.com";  // Use your actual Gmail account
                final String passwordEmail = "ybnwqkgdnlmlywbf"; // Use your actual Gmail App Password
                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");

                Session mailSession = Session.getInstance(props, new Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, passwordEmail);
                    }
                });

                try {
                    
                    Message message = new MimeMessage(mailSession);
                    message.setFrom(new InternetAddress(username));
                    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                    message.setSubject(subject);
                    message.setText(body);

                    // Send the email
                    Transport.send(message);

                    // Set email attribute and forward to verifyOTP page
                    request.setAttribute("email", email);
                    
// Continue for other attributes

                    request.getRequestDispatcher("src/pages/SignUp_SignIn/RestaurantVerifyOTP.jsp").forward(request, response);
                } catch (MessagingException e) {
                    // Log error message and print stack trace
                    out.println("<h1>Error sending OTP email!</h1>");
                    out.println("<p>Message: " + e.getMessage() + "</p>");
                    e.printStackTrace(out);  // Optionally log this in a log file
                }

            }

            out.println("</body>");
            out.println("</html>");
        }
    }

}
