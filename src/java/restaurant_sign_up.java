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

@WebServlet(urlPatterns = {"/restaurant_sign_up"})
public class restaurant_sign_up extends HttpServlet {

    // This method processes requests for both HTTP GET and POST methods
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get the form data
        String restaurant_name = request.getParameter("restaurant_name");
        String owner_name = request.getParameter("owner_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String bank_account_name = request.getParameter("bank_account_name");
        String bank_account_number = request.getParameter("bank_account_number");
        String fssai_license = request.getParameter("fssai_license");
        String pan_card = request.getParameter("pan_card");
        String gstin = request.getParameter("gstin");
        String password = request.getParameter("password");
        String re_password = request.getParameter("re_password");
        

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
            out.println("<p>Its working</p>");
            
            
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
                    String sql = "INSERT INTO restaurant_requests (restaurant_name, owner_name, email, password, phone, address, bank_acc_name, bank_acc_number, fssai_lic_no, pan_number, gst_in) values (?, ?, ?, ?,?,?,?,?,?,?,?)";
                    ops = (OraclePreparedStatement) oconn.prepareStatement(sql);
                    
                    // STEP 5: SETTING THE PLACEHOLDERS
                    ops.setString(1, restaurant_name);
                    ops.setString(2, owner_name);
                    ops.setString(3, email);
                    ops.setString(4, password);
                    ops.setString(5, phone);
                    ops.setString(6, address);
                    ops.setString(7, bank_account_name);
                    ops.setString(8, bank_account_number);
                    ops.setString(9, fssai_license);
                    ops.setString(10, pan_card);
                    ops.setString(11, gstin);

                    
                    // STEP 6: EXECUTE THE STATEMENT
                    int result = ops.executeUpdate();
                    
                    if (result > 0) {
                        out.println("<h1>Sign Up Successful!</h1>");
                        out.println("<p>Restaurant name: " + restaurant_name + "</p>");
                        out.println("<p>Owner name: " + owner_name + "</p>");
                        out.println("<p>Email: " + email + "</p>");
                        out.println("<p>Phone: " + phone + "</p>");
                        out.println("<p>Address: " + address + "</p>");
                        out.println("<p>Bank account name: " + bank_account_name + "</p>");
                        out.println("<p>Bank account number: " + bank_account_number + "</p>");
                        out.println("<p>fssai license number: " + fssai_license + "</p>");
                        out.println("<p>Pan number: " + pan_card + "</p>");
                        out.println("<p>GSTIN: " + gstin + "</p>");
                        
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
                        }
                    }
                    if (oconn != null) {
                        try {
                            oconn.close();
                        } catch (SQLException e) {
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
