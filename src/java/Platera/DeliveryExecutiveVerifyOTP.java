package Platera;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

//@WebServlet(urlPatterns = {"/DeliveryExecutiveVerifyOTP"})
public class DeliveryExecutiveVerifyOTP extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the OTP entered by the user
        String enteredOTP = request.getParameter("otp");
        
        // Get the session and the OTP stored in the session
        HttpSession session = request.getSession(false);  // Use existing session
        if (session == null) {
            response.sendRedirect("index.html");  // If no session exists, redirect to homepage
            return;
        }

        Integer sessionOTP = (Integer) session.getAttribute("otp");
        String name = (String) session.getAttribute("name");
        String email = (String) session.getAttribute("email");
        Integer phone = (Integer) session.getAttribute("phone");
        String address = (String) session.getAttribute("address");
        Integer age = (Integer) session.getAttribute("age");
        String gender = (String) session.getAttribute("gender");
        Integer aadharNumber = (Integer) session.getAttribute("aadharNumber");
        String bankAccountName = (String) session.getAttribute("bankAccountName");
        String bankAccountNumber = (String) session.getAttribute("bankAccountNumber");
        String panNumber = (String) session.getAttribute("panNumber");
        String drivingLicenseNumber = (String) session.getAttribute("drivingLicenseNumber");
        String vehicleNumber = (String) session.getAttribute("vehicleNumber");
        String vehicleType = (String) session.getAttribute("vehicleType");
        String password = (String) session.getAttribute("password");
        
        out.println("<p>Age: </p>" + age);  // Add this line to debug the input


        // Set the response content type
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Check if the OTP entered by the user matches the session OTP
            if (enteredOTP != null && sessionOTP != null && sessionOTP.equals(Integer.valueOf(enteredOTP))) {
                try (Connection conn = Database.getConnection()) {
                    String sql = "INSERT INTO delivery_executive_requests (name, email, phone, address, age, gender, aadhar_number, bank_account_name, bank_account_number, pan_number, driving_license_number, vehicle_number, vehicle_type, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement statement = conn.prepareStatement(sql);

                    // Set values for the placeholders
                    statement.setString(1, name);
                    statement.setString(2, email);
                    statement.setInt(3, phone);
                    statement.setString(4, address);
                    statement.setInt(5, age);
                    statement.setString(6, gender);
                    statement.setInt(7, aadharNumber);
                    statement.setString(8, bankAccountName);
                    statement.setString(9, bankAccountNumber);
                    statement.setString(10, panNumber);
                    statement.setString(11, drivingLicenseNumber);
                    statement.setString(12, vehicleNumber);
                    statement.setString(13, vehicleType);
                    statement.setString(14, password);

                    // Execute the insert
                    int result = statement.executeUpdate();
                    if (result > 0) {
                        // If data inserted successfully, redirect to a success page or dashboard
                        out.println("<h3>Your application has been received.<br>Further updates will be sent to your email.</h3>");
                        out.println("<h1>Registration Successful!</h1>");
                        out.println("<p>Your account has been created successfully.</p>");
                        out.println("<P><a href='index.html'>Click here to go back to the landing page</a></p>");
                        session.invalidate();  // Invalidate the session after the successful registration
                    } else {
                        out.println("<h1>Error saving data. Please try again later.</h1>");
                        session.invalidate();  // Invalidate the session on error
                    }
                } catch (SQLException ex) {
                    // Custom debugging lines for error reporting
                    Logger.getLogger(DeliveryExecutiveVerifyOTP.class.getName()).log(Level.SEVERE, "SQL Error: " + ex.getMessage(), ex);
                    out.println("<h1>Database error. Please try again later.</h1>");
                    out.println("<p>Detailed Error: " + ex.getMessage() + "</p>");
                    out.println("<h4>age: "+ age);
                    ex.printStackTrace();  // Print stack trace for further debugging
                }
            } else {
                out.println("<h1>Invalid OTP. Please try again.</h1>");
                session.invalidate();  
            }
        } catch (Exception e) {
            e.printStackTrace();  // Custom debugging for other errors
        }
    }
}
