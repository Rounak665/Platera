package General;

import Utilities.Database;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "DeleteUser", urlPatterns = {"/DeleteUser"})
public class DeleteUser extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdParam = request.getParameter("userId");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (userIdParam != null && !userIdParam.isEmpty()) {
            try (Connection con = Database.getConnection(); 
                 PreparedStatement ps = con.prepareStatement("DELETE FROM users WHERE user_id = ?")) {

                int userId = Integer.parseInt(userIdParam);
                ps.setInt(1, userId);
                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("index.html?AccountDeleted");
                } else {
                    response.sendRedirect("index.html?ErrorDeletingAccount");
                }
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
                response.sendRedirect("error.jsp");
            }
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}
