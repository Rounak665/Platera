import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/DeliveryExecutiveRegistration"})
public class DeliveryExecutiveRegistration extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response content type and get PrintWriter for output
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Retrieve session to access request_id and creation_time
        HttpSession session = request.getSession(false);
        if (session == null) {
            out.println("<h1>Error: Session not found. Please sign up again.</h1>");
            return;
        }

        Integer request_id = (Integer) session.getAttribute("request_id");
        Timestamp creationTime = (Timestamp) session.getAttribute("request_creation_time");

        if (request_id == null || creationTime == null) {
            out.println("<h1>Error: Sign-up information not found. Please sign up first.</h1>");
            return;
        }

        // Check if 30-minute window has expired
        long timeElapsed = Instant.now().toEpochMilli() - creationTime.getTime();
        if (timeElapsed > 30 * 60 * 1000) {  // 30 minutes in milliseconds
            out.println("<h1>Error: Session expired. Please sign up again.</h1>");

            // Optionally delete expired request from the database
            try (Connection conn = Database.getConnection()) {
                String deleteSql = "DELETE FROM delivery_executive_requests WHERE request_id = ?";
                try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                    deleteStmt.setInt(1, request_id);
                    deleteStmt.executeUpdate();
                }
            } catch (SQLException e) {
                e.printStackTrace(out);
                out.println("<h1>Database error occurred during cleanup!</h1>");
            }
            session.invalidate();
            return;
        }

        // Collect form data
        String aadharNumber = request.getParameter("aadhar");
        String panNumber = request.getParameter("pan");
        String drivingLicenseNumber = request.getParameter("driving_license");
        String gender = request.getParameter("gender");
        int age = Integer.parseInt(request.getParameter("age"));
        String vehicleType = request.getParameter("vehicle-type");
        String vehicleNumber = request.getParameter("vehicle-number");
        String bankAccountNumber = request.getParameter("bank-account-number");

        // Insert form data into delivery_executive_requests table
        try (Connection conn = Database.getConnection()) {
            String sql = "UPDATE delivery_executive_requests SET aadhar_number = ?, pan_number = ?, "
                    + "driving_license_number = ?, gender = ?, age = ?, vehicle_type = ?, "
                    + "vehicle_number = ?, bank_account_number = ? WHERE request_id = ?";

            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, aadharNumber);
                pstmt.setString(2, panNumber);
                pstmt.setString(3, drivingLicenseNumber);
                pstmt.setString(4, gender);
                pstmt.setInt(5, age);
                pstmt.setString(6, vehicleType);
                pstmt.setString(7, vehicleNumber);
                pstmt.setString(8, bankAccountNumber);
                pstmt.setInt(9, request_id);

                int result = pstmt.executeUpdate();

                if (result > 0) {
                    out.println("<h1>We have received your application. Further updates will be sent to your email.</h1>");
                } else {
                    out.println("<h1>Error updating details. Please try again.</h1>");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(out);
            out.println("<h1>Database error occurred!</h1>");
        }
    }
}
