package Platera;

import Utilities.Database;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;  // Import for session handling

@WebServlet("/sign_in")
public class sign_in extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email_signin");
        String password = request.getParameter("password_signin");

        try (Connection conn = Database.getConnection()) {
            // Validate the user's credentials and get user_id
            String sql = "SELECT user_id FROM USERS WHERE email = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                stmt.setString(2, password);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        int user_id = rs.getInt("user_id");

                        // Create or get session, store user_id and welcomePopup flag
                        HttpSession session = request.getSession(true);
                        session.setAttribute("user_id", user_id);
                        session.setAttribute("welcomePopup", true);  // Set welcome popup flag

                        // Redirect to the appropriate page
                        response.sendRedirect("src/pages/Home.jsp");  // Adjust this as needed
                    } else {
                        // Invalid credentials
                        out.println("<h2>Login Failed!</h2>");
                        out.println("<p>Invalid email or password. Please try again.</p>");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h2>Something went wrong!</h2>");
        }
    }
}
