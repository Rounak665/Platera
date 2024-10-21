import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/restaurant_sign_in")  // Servlet URL mapping
public class restaurant_sign_in extends HttpServlet {

    // JDBC variables (update with your own database connection details)
    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    private static final String JDBC_USER = "ROUNAK";
    private static final String JDBC_PASSWORD = "CHAKRABORTY";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            handleRegistration(request, response);
        } else if ("login".equals(action)) {
            handleLogin(request, response);
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Fetch form data for registration
        String restaurantName = request.getParameter("restaurant_name");
        String ownerName = request.getParameter("owner_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String bankAccountName = request.getParameter("bank_account_name");
        String bankAccountNumber = request.getParameter("bank_account_number");
        String gstin = request.getParameter("gstin");
        String password = request.getParameter("password");

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO restaurants (restaurant_name, owner_name, email, phone, bank_account_name, bank_account_number, gstin, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)")) {

            // Set query parameters
            stmt.setString(1, restaurantName);
            stmt.setString(2, ownerName);
            stmt.setString(3, email);
            stmt.setString(4, phone);
            stmt.setString(5, bankAccountName);
            stmt.setString(6, bankAccountNumber);
            stmt.setString(7, gstin);
            stmt.setString(8, password);

            // Execute the insert
            int result = stmt.executeUpdate();

            if (result > 0) {
                response.getWriter().println("Restaurant Registered Successfully!");
            } else {
                response.getWriter().println("Registration Failed.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database Error: " + e.getMessage());
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Fetch login form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM restaurants WHERE email = ? AND password = ?")) {

            // Set query parameters
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Login successful
                response.getWriter().println("Login Successful!");
                // You can redirect to the restaurant's dashboard here if needed
            } else {
                // Invalid credentials
                response.getWriter().println("Invalid Email or Password.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database Error: " + e.getMessage());
        }
    }
}
