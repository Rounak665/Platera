package DeliveryExecutive;

import Utilities.Database;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/DeliveryExecutiveVerifyOTP"})
public class DeliveryExecutiveVerifyOTP extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the OTP entered by the user
        String enteredOTP = request.getParameter("otp");

        // Get the session and the OTP stored in the session
        HttpSession session = request.getSession(false); // Use existing session
        if (session == null) {
            response.sendRedirect("index.html"); // Redirect if no session exists
            return;
        }

        // Retrieve session attributes
        Integer sessionOTP = (Integer) session.getAttribute("otp");
        String name = (String) session.getAttribute("name");
        String email = (String) session.getAttribute("email");
        String phone = (String) session.getAttribute("phone");
        String address = (String) session.getAttribute("address");
        String age = (String) session.getAttribute("age");
        String gender = (String) session.getAttribute("gender");
        String profileImage = (String) session.getAttribute("profileImage"); // Base64-encoded image
        String location = (String) session.getAttribute("location");
        String aadharNumber = (String) session.getAttribute("aadharNumber");
        String bankAccountName = (String) session.getAttribute("bankAccountName");
        String bankAccountNumber = (String) session.getAttribute("bankAccountNumber");
        String panNumber = (String) session.getAttribute("panNumber");
        String drivingLicenseNumber = (String) session.getAttribute("drivingLicenseNumber");
        String vehicleNumber = (String) session.getAttribute("vehicleNumber");
        String vehicleType = (String) session.getAttribute("vehicleType");
        String password = (String) session.getAttribute("password");

        // Set response content type

            // Validate OTP
            if (enteredOTP != null && sessionOTP != null && sessionOTP.equals(Integer.valueOf(enteredOTP))) {
                try (Connection conn = Database.getConnection()) {
                    String sql = "INSERT INTO delivery_executive_requests (name, email, phone, address, age, gender, image, location, aadhar_number, bank_account_name, bank_account_number, pan_number, driving_license_number, vehicle_number, vehicle_type, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement statement = conn.prepareStatement(sql);

                    // Set placeholders with values
                    statement.setString(1, name);
                    statement.setString(2, email);
                    statement.setString(3, phone);
                    statement.setString(4, address);
                    statement.setString(5, age);
                    statement.setString(6, gender);
                    statement.setString(7, profileImage); // Store Base64 image string
                    statement.setString(8, location);
                    statement.setString(9, aadharNumber);
                    statement.setString(10, bankAccountName);
                    statement.setString(11, bankAccountNumber);
                    statement.setString(12, panNumber);
                    statement.setString(13, drivingLicenseNumber);
                    statement.setString(14, vehicleNumber);
                    statement.setString(15, vehicleType);
                    statement.setString(16, password);

                    // Execute the query
                    int result = statement.executeUpdate();
                    if (result > 0) {
                        // Redirect to confirmation page
                        response.sendRedirect("src/pages/Confirmations/DeliveryExecutiveConfirmation.jsp");
                    } else {
                        response.sendRedirect("src/pages/Error/DatabaseError.html");
                    }
                } catch (SQLException ex) {
                    response.sendRedirect("src/pages/Error/DatabaseError.html");
                }
            } else {
                response.sendRedirect("src/pages/Error/WrongOTP.html");
            }
    }
}

