package Platera;


import Platera.Database;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/DeliveryExecutiveSignUp2"})
public class DeliveryExecutiveSignUp2 extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String re_password = request.getParameter("re-password");

        response.setContentType("text/html;charset=UTF-8");

        // Initialize PrintWriter
        try (PrintWriter out = response.getWriter()) {
            // Check if passwords match
            if (!password.equals(re_password)) {
                out.println("<h1>Passwords do not match!</h1>");
                return; // Exit if passwords do not match
            }

            // Establish database connection
            try (Connection conn = Database.getConnection()) {
                String sql = "INSERT INTO delivery_executive_requests(name,email,password) VALUES (?,?,?)";

                // Enable generated keys for the prepared statement
                try (PreparedStatement pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    pstmt.setString(1, name);
                    pstmt.setString(2, email);
                    pstmt.setString(3, password);
                    int result = pstmt.executeUpdate();

                    // Assuming you have already done the insert as shown before
                   

                    if (result > 0) {
                        // Fetch the request_id using the email or some unique identifier
                        String userIdSql = "SELECT request_id FROM delivery_executive_requests WHERE email = ?";
                        try (PreparedStatement userIdPstmt = conn.prepareStatement(userIdSql)) {
                            userIdPstmt.setString(1, email); // Use the email you just inserted
                            ResultSet userIdRs = userIdPstmt.executeQuery();
                            int request_id = 0; // Default value
                            if (userIdRs.next()) {
                                request_id = userIdRs.getInt("request_id"); // Fetch the request_id
                            }

                            // Store request_id in a session
                            HttpSession session = request.getSession();
                            session.setAttribute("request_id", request_id); // Store in session
                        }
                    

                    // Set the signedUp cookie
                    Cookie signedUpCookie = new Cookie("signedUp", "true");
                    signedUpCookie.setMaxAge(-1); // 1-day expiration
                    response.addCookie(signedUpCookie);

                    // Redirect to the desired page
                   response.sendRedirect("src/pages/DeliveryExecutive/DeliveryExecutiveRegisterForm.html");
                    return; // Ensure no further processing occurs after redirect
                }
                
            else {
                        out.println("<h1>Error in sign-up. Please try again.</h1>");
                    }
            }
        } catch (SQLException e) {
            out.println("<h1>Database error occurred!</h1>");
            e.printStackTrace(out);
        }
    }
}
}
