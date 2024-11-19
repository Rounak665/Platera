package FetchingClasses;  // Make sure the package is correct, matching your project structure

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/FetchCategories")
public class FetchCategories extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();  // Get the current session

        // If categories are already stored in session, use them
        ArrayList<Category> categories = (ArrayList<Category>) session.getAttribute("categories");

        // If categories are not in session, fetch them from the database
        if (categories == null) {
            categories = new ArrayList<>();
            try (Connection conn = Database.getConnection();
                 PreparedStatement stmt = conn.prepareStatement("SELECT category_id, category_name FROM category")) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("category_id");
                    String name = rs.getString("category_name");
                    categories.add(new Category(id, name));
                }

                // Store the fetched categories in the session for future use
                session.setAttribute("categories", categories);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Set the categories list as a request attribute before redirect
        request.setAttribute("categories", categories);

        // Send a redirect to the JSP page
        response.sendRedirect("src/pages/Restaurant/AddDish.jsp");  
    }
}

