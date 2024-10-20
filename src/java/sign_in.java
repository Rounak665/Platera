import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import oracle.jdbc.pool.OracleDataSource;

@WebServlet("/sign_in") // Ensure the servlet is correctly mapped
public class sign_in extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response content type
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get parameters from the request
        String email = request.getParameter("email_signin");
        String password = request.getParameter("password_signin");

        // Oracle Database connection details
        OracleDataSource ods = null;
        try {
            ods = new OracleDataSource();
        } catch (SQLException ex) {
            Logger.getLogger(sign_in.class.getName()).log(Level.SEVERE, null, ex);
        }
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Establish connection
            ods.setURL("jdbc:oracle:thin:@Rounak:1521:orcl"); // Update as needed
            ods.setUser("ROUNAK");
            ods.setPassword("CHAKRABORTY");
            conn = ods.getConnection();
            System.out.println("Connection established.");

            // Prepare SQL statement
            stmt = conn.prepareStatement("SELECT * FROM USERS WHERE email = ? AND password = ?");
            stmt.setString(1, email);
            stmt.setString(2, password);

            // Execute query
            rs = stmt.executeQuery();
            System.out.println("Query executed.");

            // Check if user exists
            if (rs.next()) {
                // User exists, display success message
                out.println("<h2>Login Successful!</h2>");
                out.println("<p>Welcome, " + email + "!</p>");
            } else {
                // User does not exist, display error message
                out.println("<h2>Login Failed!</h2>");
                out.println("<p>Invalid username or password. Please try again.</p>");
            }
        } catch (SQLException e) {
            // Handle SQL exception and display error message
            out.println("<h2>Error:</h2>");
            out.println("<p>" + e.getMessage() + "</p>");
            // Print stack trace for debugging
        } finally {
            // Clean up resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<h2>Error closing resources:</h2>");
                out.println("<p>" + e.getMessage() + "</p>");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // Redirect POST requests to doGet
    }
}
