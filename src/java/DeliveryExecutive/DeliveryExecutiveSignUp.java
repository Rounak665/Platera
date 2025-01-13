package DeliveryExecutive;

import Utilities.EmailUtility;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet(urlPatterns = {"/DeliveryExecutiveSignUp"})
@MultipartConfig
public class DeliveryExecutiveSignUp extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String age = request.getParameter("age");
        String gender = request.getParameter("gender");
        String location = request.getParameter("location");
        String aadharNumber = request.getParameter("aadhar_number");
        String bankAccountName = request.getParameter("bank_account_name");
        String bankAccountNumber = request.getParameter("bank_account_number");
        String panNumber = request.getParameter("pan_number");
        String drivingLicenseNumber = request.getParameter("driving_license_number");
        String vehicleNumber = request.getParameter("vehicle_number");
        String vehicleType = request.getParameter("vehicle_type");
        String password = request.getParameter("password");
        String rePassword = request.getParameter("re_password");

        // Set the response content type
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Validate passwords match (commented out, can be enabled later)
        // if (!password.equals(rePassword)) {
        //     out.println("<h1>Passwords do not match!</h1>");
        //     return;
        // }

        // Generate OTP
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);

        // Create session and store form data
        HttpSession session = request.getSession(true);
        session.setAttribute("otp", otp);
        session.setAttribute("name", name);
        session.setAttribute("email", email);
        session.setAttribute("phone", phone);
        session.setAttribute("address", address);
        session.setAttribute("age", age);
        session.setAttribute("gender", gender);
        session.setAttribute("location", location);
        session.setAttribute("aadharNumber", aadharNumber);
        session.setAttribute("bankAccountName", bankAccountName);
        session.setAttribute("bankAccountNumber", bankAccountNumber);
        session.setAttribute("panNumber", panNumber);
        session.setAttribute("drivingLicenseNumber", drivingLicenseNumber);
        session.setAttribute("vehicleNumber", vehicleNumber);
        session.setAttribute("vehicleType", vehicleType);
        session.setAttribute("password", password);

        // Handle Profile Image (as file)
        Part filePart = request.getPart("profile_image"); // Retrieve the image file
        if (filePart == null || filePart.getSize() == 0) {
            out.println("<h1>Profile image is missing. Please provide a valid image.</h1>");
            return;
        } else {
            System.out.println("Profile image received: " + filePart.getSubmittedFileName()); // Debugging output

            try (InputStream inputStream = filePart.getInputStream();
                 ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream()) {

                // Read bytes from the input stream and write them to ByteArrayOutputStream
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    byteArrayOutputStream.write(buffer, 0, bytesRead);
                }

                // Convert image to Base64 string
                byte[] imageBytes = byteArrayOutputStream.toByteArray();
                String base64EncodedImage = Base64.getEncoder().encodeToString(imageBytes);

                // Store the Base64 image in the session
                session.setAttribute("profileImage", base64EncodedImage);
            } catch (IOException e) {
                e.printStackTrace();
                response.sendRedirect("src/pages/Admin/Admin_Restaurant_Approval.jsp#errorPopup");
                return;
            }
        }

        // Sending OTP email
        String subject = "Your OTP for Platera Delivery Executive Sign Up";
        String body = "Hello " + name + ",\n\nYour OTP is: " + otp + "\n\nPlease enter this OTP to verify your email address for delivery executive registration.";
        if (EmailUtility.sendEmail(email, subject, body)) {
            response.sendRedirect("src/pages/OTPVerifications/DeliveryExecutiveVerifyOTP.jsp");
        } else {
            response.sendRedirect("src/pages/AddDeliveryExecutive/AddDeliveryExecutive.jsp#errorPopup");
        }
    }
}
