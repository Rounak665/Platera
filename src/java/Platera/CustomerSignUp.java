package Platera;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/CustomerSignUp"})
public class CustomerSignUp extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the form data
        String name = request.getParameter("name_signup");
        String email = request.getParameter("email_signup");
        String password = request.getParameter("password_signup");
        String re_password = request.getParameter("repassword_signup");

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
                // Generate OTP
                Random random = new Random();
                int otp = 100000 + random.nextInt(900000); // Generates a 6-digit OTP

                // Store OTP in session for verification later
                HttpSession session = request.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("name", name);
                session.setAttribute("email",email);
                session.setAttribute("password",password);
                session.setAttribute("name",name);
                session.setAttribute("welcomePopup",false);
//                session.setAttribute("user_role",2);

                // Send OTP to email
                String subject = "Your OTP for Platera Signup";
                String body = "Hello " + name + ",\n\nYour OTP is: " + otp + "\n\nPlease enter this OTP to complete your sign-up.";

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

                    // Debug: Email sent successfully
                    out.println("<h1>Email sent to: " + email + "</h1>");
                    out.println("<p>An OTP has been sent to your email address. Please check your inbox.</p>");

                    // Set email attribute and forward to verifyOTP page                   
                    response.sendRedirect("src/pages/OTPVerifications/CustomerVerifyOTP.jsp");

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
