import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
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


@WebServlet("/sign_in") // Ensure the servlet is correctly mapped
public class sign_in extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response content type
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get parameters from the request
        String email = request.getParameter("email_signin");
        String password = request.getParameter("password_signin");
        

        try(Connection conn = Database.getConnection()) {
                       
            // Prepare SQL statement
            String sql = ("SELECT * FROM USERS WHERE email = ? AND password = ?");
            try (PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setString(1, email);
            stmt.setString(2, password);

            // Execute query
            try (ResultSet rs = stmt.executeQuery()){
    
            System.out.println("Query executed.");
            
            
           

            // Check if user exists
            if (rs.next()) {
                int userRole = 0;
                // User exists, display success message
                String userRoleSql = "SELECT user_role FROM users WHERE email = ?";
                    try (PreparedStatement userRolePstmt = conn.prepareStatement(userRoleSql)) {
                        userRolePstmt.setString(1, rs.getString("email"));
                        ResultSet userRoleRs = userRolePstmt.executeQuery();
                        if (userRoleRs.next()) {
                            userRole = userRoleRs.getInt("user_id");
                        }
                    }
                if(userRole==1){
                response.sendRedirect("src/pages/Admin/Admin_Order_Management.html");//1 for admin
                }
                if(userRole==2){
                response.sendRedirect("src/pages/Home/Home.html");//2 for customer
                }
                if(userRole==3){
                response.sendRedirect("src/pages/RestaurentDashboard/RestaurantDashboard.html");//3 for restaurant owners
                }
                if(userRole==4){
                response.sendRedirect("src/pages/Home/Home.html");//4 for delivery executives
                }
                

            } else {
                // User does not exist, display error message
                out.println("<h2>Login Failed!</h2>");
                out.println("<p>Invalid username or password. Please try again.</p>");
            }
            }
            }
        } catch (SQLException e) {
            // Handle SQL exception and display error message
            out.println("<h2>Error:</h2>");
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred."+ e.getMessage());
            // Print stack trace for debugging
        } 
    }

    
}
