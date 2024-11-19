package Platera;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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

        // Get the session to retrieve stored OTP and user data
        HttpSession session = request.getSession(false);
        Integer sessionOTP = (Integer) session.getAttribute("otp");
        String owner_name = (String) session.getAttribute("owner_name");
        String restaurant_name = (String) session.getAttribute("restaurant_name");
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        String owner_phone = (String) session.getAttribute("owner_phone");
        String owner_address = (String) session.getAttribute("owner_address");
        String bank_account_name = (String) session.getAttribute("bank_account_name");
        String bank_account_number = (String) session.getAttribute("bank_account_number");
        String gstin = (String) session.getAttribute("gstin");
        String pan_card = (String) session.getAttribute("pan_card");
        String fssai_license = (String) session.getAttribute("fssai_license");

        // Set response content type
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Verify OTP
            if (sessionOTP != null && sessionOTP.equals(Integer.valueOf(enteredOTP))) {

                // Database connection
                try (Connection conn = Database.getConnection()) {

                    // Insert the data into the restaurant_requests table
                    String insertSql = "INSERT INTO restaurant_requests (restaurant_name, owner_name, email, password, owner_phone, owner_address, bank_acc_name, bank_acc_number, fssai_lic_no, pan_number, gst_in) "
                            + "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement ops = conn.prepareStatement(insertSql)) {

                        // Set the values for placeholders
                        ops.setString(1, restaurant_name);
                        ops.setString(2, owner_name);
                        ops.setString(3, email);
                        ops.setString(4, password);
                        ops.setString(5, owner_phone);
                        ops.setString(6, owner_address);
                        ops.setString(7, bank_account_name);
                        ops.setString(8, bank_account_number);
                        ops.setString(9, fssai_license);
                        ops.setString(10, pan_card);
                        ops.setString(11, gstin);

                        // Execute the insert
                        int result = ops.executeUpdate();

                        if (result > 0) {
                            // After insert, get the request_id using the email
                            String selectSql = "SELECT request_id FROM restaurant_requests WHERE email = ?";
                            try (PreparedStatement ps = conn.prepareStatement(selectSql)) {
                                ps.setString(1, email);
                                try (ResultSet rs = ps.executeQuery()) {
                                    if (rs.next()) {
                                        long requestId = rs.getLong("request_id");

                                        // Set the request_id in session
                                        session.setAttribute("request_id", requestId);

                                        // Provide confirmation to the user
                                        out.println("<h3>Your application has been received.<br>Further updates will be sent to your email.</h3>");
                                        out.println("<p>Restaurant name: " + restaurant_name + "</p>");
                                        out.println("<p>Owner name: " + owner_name + "</p>");
                                        out.println("<p>Email: " + email + "</p>");
                                        out.println("<p>Phone: " + owner_phone + "</p>");
                                        out.println("<p>Address: " + owner_address + "</p>");
                                        out.println("<p>Bank account name: " + bank_account_name + "</p>");
                                        out.println("<p>Bank account number: " + bank_account_number + "</p>");
                                        out.println("<p>FSSAI License Number: " + fssai_license + "</p>");
                                        out.println("<p>PAN Number: " + pan_card + "</p>");
                                        out.println("<p>GSTIN: " + gstin + "</p>");
                                        out.println("<P><a href='index.html'>Click here to go back to the landing page</a></p>");
                                    }
                                }
                            }
                        }
                    }

                    // Clear session attributes after successful signup
                    // session.invalidate(); (No session invalidation to retain request_id for next form)
                    
                } catch (SQLException ex) {
                    // Log the SQL exception message and print stack trace for detailed error info
                    out.println("<h1>Error in SQL Execution</h1>");
                    ex.printStackTrace(out);  // Print the stack trace for debugging
                }

            } else {
                // OTP verification failed
                request.setAttribute("errorMessage", "Invalid OTP. Please try again.");
                request.getRequestDispatcher("src/pages/SignUp/SignIn/Restaurant_DeliveryOTP.jsp").forward(request, response);
            }
        }
    }
}


