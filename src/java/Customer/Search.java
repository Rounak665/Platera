package Customer;

import Utilities.Restaurant;
import Utilities.MenuItems; // Updated to use MenuItems class
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Search")
public class Search extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keywordType = request.getParameter("keywordType");
        String keyword = request.getParameter("keyword");
        String locationId = request.getParameter("location");

        if (keyword == null || keyword.isEmpty() || locationId == null || locationId.isEmpty()) {
            response.sendRedirect("src/pages/Customer/Home.jsp#errorSection");
            return;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("locationId", locationId);
        session.setAttribute("keyword", keyword);

        // Redirect to the appropriate page based on the keywordType
        if ("restaurants".equalsIgnoreCase(keywordType)) {
            response.sendRedirect("src/pages/search/RestaurantsSearchResult.jsp");
        } else if ("dishes".equalsIgnoreCase(keywordType)) {
            response.sendRedirect("src/pages/search/MenuSearchResult.jsp");
        } else {
            response.sendRedirect("src/pages/Customer/Home.jsp");
        }
    }
}
