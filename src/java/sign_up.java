import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;
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

    // This method processes requests for both HTTP GET and POST methods
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get the form data
        String name = request.getParameter("name_signup");
        String email = request.getParameter("email_signup");
        String password = request.getParameter("password_signup");
        String re_password = request.getParameter("repassword_signup");

        // Set the response content type
        response.setContentType("text/html;charset=UTF-8");

        OracleConnection oconn = null;
        OraclePreparedStatement ops = null;

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
                try {
                    // STEP 2: REGISTERING THE ORACLE DRIVER WITH THIS SERVLET (if needed)
                    DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
                    
                    // STEP 3: INSTANTIATING THE ORACLE CONNECTION OBJECT
                    OracleDataSource ods = new OracleDataSource();
                    ods.setURL("jdbc:oracle:thin:@Rounak:1521:orcl"); // Use your DB details
                    ods.setUser("ROUNAK");
                    ods.setPassword("CHAKRABORTY");
                    oconn = (OracleConnection) ods.getConnection();
                    
                    // STEP 4: INSTANTIATING THE ORACLE PREPARED STATEMENT OBJECT
                    String sql = "INSERT INTO users (name, email, password, user_role) values (?, ?, ?, ?)";
                    ops = (OraclePreparedStatement) oconn.prepareStatement(sql);
                    
                    // STEP 5: SETTING THE PLACEHOLDERS
                    ops.setString(1, name);
                    ops.setString(2, email);
                    ops.setString(3, password);
                    ops.setString(4, "customer");  // Default role set to "customer"

                    
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

                } catch (SQLException e) {
                    out.println("<h1>Database error occurred!</h1>");
                    e.printStackTrace(out);
                } finally {
                    // STEP 7: CLEAN UP RESOURCES
                    if (ops != null) {
                        try {
                            ops.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (oconn != null) {
                        try {
                            oconn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
            
            out.println("</body>");
            out.println("</html>");
        }
    }

    // Handles the HTTP GET method
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    // Handles the HTTP POST method
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    // Returns a short description of the servlet
    @Override
    public String getServletInfo() {
        return "Sign-up servlet that saves user data to Oracle DB with default role 'customer'";
    }
}
