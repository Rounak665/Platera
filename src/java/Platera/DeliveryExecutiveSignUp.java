package Platera;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.PreparedStatement;
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

@WebServlet(urlPatterns = {"/DeliveryExecutiveSignUp"})
public class DeliveryExecutiveSignUp extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneStr = request.getParameter("phone");
        Integer phone=Integer.parseInt(phoneStr);
        String address = request.getParameter("address");
        String ageStr = request.getParameter("age");
        Integer age=Integer.parseInt(ageStr);
        String gender = request.getParameter("gender");
        String aadharNumberStr = request.getParameter("aadhar_number");
        Integer aadhar_number = Integer.parseInt(aadharNumberStr);
        String bank_account_name = request.getParameter("bank_account_name");
        String bank_account_number = request.getParameter("bank_account_number");
        String pan_number = request.getParameter("pan_number");
        String driving_license_number = request.getParameter("driving_license_number");
        String vehicle_number = request.getParameter("vehicle_number");
        String vehicle_type = request.getParameter("vehicle_type");
        String password = request.getParameter("password");
        String re_Password = request.getParameter("re_password");

        // Set the response content type
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<p>Age: </p>" + age);

        
            // Check if passwords match
            if (!password.equals(re_Password)) {
                out.println("<h1>Passwords do not match!</h1>");
                return;
            }
        

            // Generate OTP
            Random random = new Random();
            int otp = 100000 + random.nextInt(900000);

            // Create session and set session attributes
            HttpSession session = request.getSession(true);
            session.setAttribute("otp", otp);
            session.setAttribute("name", name);
            session.setAttribute("email", email);
            session.setAttribute("phone", phone);
            session.setAttribute("address", address);
            session.setAttribute("age", age);
            session.setAttribute("gender", gender);
            session.setAttribute("aadharNumber", aadhar_number);
            session.setAttribute("bankAccountName", bank_account_name);
            session.setAttribute("bankAccountNumber", bank_account_number);
            session.setAttribute("panNumber", pan_number);
            session.setAttribute("drivingLicenseNumber", driving_license_number);
            session.setAttribute("vehicleNumber", vehicle_number);
            session.setAttribute("vehicleType", vehicle_type);
            session.setAttribute("password", password);

            String subject = "Your OTP for Platera Delivery Executive Sign Up";
            String body = "Hello " + name + ",\n\nYour OTP is: " + otp + "\n\nPlease enter this OTP to verify your email address for delivery execuitve registration.";

            // Sending email
            final String username = "plateraminorproject@gmail.com";
            final String passwordEmail = "ybnwqkgdnlmlywbf";
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
                request.getRequestDispatcher("src/pages/SignUp_SignIn/DeliveryExecutiveVerifyOTP.jsp").forward(request, response);
            } catch (MessagingException e) {
                // Log error message and print stack trace
                out.println("<h1>Error sending OTP email!</h1>");
                out.println("<p>Message: " + e.getMessage() + "</p>");
                e.printStackTrace(out);  // Optionally log this in a log file
            }
//        }
    }
}

