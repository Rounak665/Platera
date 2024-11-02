
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import oracle.jdbc.pool.OracleDataSource;

@WebServlet(urlPatterns = {"/sign_up"})
public class sign_up extends HttpServlet {

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{

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
                try (Connection conn = Database.getConnection()) {

                    if (conn != null) {
                        System.out.println("Database connected successfully.");
                    } else {
                        System.out.println("Failed to connect to the database.");
                    }

                    String sql = "INSERT INTO users (name, email, password, user_role) values (?, ?, ?, ?)";
                    try (OraclePreparedStatement ops = (OraclePreparedStatement) conn.prepareStatement(sql)) {

                        // STEP 5: SETTING THE PLACEHOLDERS
                        ops.setString(1, name);
                        ops.setString(2, email);
                        ops.setString(3, password);
                        ops.setString(4, "2");  // Default role set to "customer".2 for customer

                        // STEP 6: EXECUTE THE STATEMENT
                        int result = ops.executeUpdate();

                        if (result > 0) {
                            out.println("<h1>Sign Up Successful!</h1>");
                            out.println("<p>Name: " + name + "</p>");
                            out.println("<p>Email: " + email + "</p>");
                            out.println("<p>Role: customer</p>");
                        } else {
                            out.println("<h1>Error in sign-up. Please try again.</h1>");
                        }
                    }

                } catch (SQLException e) {
                    out.println("<h1>Database error occurred!</h1>");
                    e.printStackTrace(out);
                }
            }

            out.println("</body>");
            out.println("</html>");
        }

    }
    

    
}

    
   

