package Customer;

import Utilities.Customer;
import Utilities.CustomerDAO;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RemoveCustomerPhoto", urlPatterns = {"/RemoveCustomerPhoto"})
public class RemoveCustomerPhoto extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve user_id from session
        Object userIdObj = request.getSession().getAttribute("user_id");

        if (userIdObj == null) {
            // If user_id is not in session, redirect to error page or login page
            response.sendRedirect("login.jsp?error=noSession");
            return;
        }

        int userId;

        // If user_id is stored as Integer in session, use it directly
        if (userIdObj instanceof Integer) {
            userId = (Integer) userIdObj;
        } else if (userIdObj instanceof String) {
            // If user_id is stored as String, parse it to int
            try {
                userId = Integer.parseInt((String) userIdObj);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("src/pages/Customer/CustomerDashboard/CustomerProfile.jsp?invalidUserId");
                return;
            }
        } else {
            // Handle the case where user_id is neither Integer nor String
            response.sendRedirect("login.jsp?error=invalidSession");
            return;
        }

        // Now proceed with the rest of the logic for retrieving and processing the customer
        try (Connection conn = Utilities.Database.getConnection()) {
            // Use userId (int) to retrieve the customer object
            Customer customer = CustomerDAO.getCustomerByUserId(userId);
            if (customer != null) {
                System.out.println("Customer found: " + customer.getCustomerId());

                // Get the current image path and delete the file from the server
                String imagePath = customer.getImage();
                if (imagePath != null && !imagePath.equals("DatabaseImages/Customers/default.png")) {
                    System.out.println("Deleting photo: " + imagePath);

                    // Get the real path to the image directory
                    String realPath = getServletContext().getRealPath("/");
                    String projectRoot = new File(realPath).getParentFile().getParent();
                    String imageDirectoryPath = projectRoot + File.separator + "web" + File.separator + "DatabaseImages" + File.separator + "Customers";

                    // Delete the image file from the server
                    File imageFile = new File(imageDirectoryPath + File.separator + imagePath.substring(imagePath.lastIndexOf(File.separator) + 1));
                    if (imageFile.exists()) {
                        imageFile.delete(); // Delete the image from the server
                        System.out.println("Image deleted: " + imageFile.getAbsolutePath());
                    } else {
                        System.out.println("Image file not found: " + imageFile.getAbsolutePath());
                    }
                } else {
                    System.out.println("No image to delete or default image.");
                }

                // Update the image path in the database to the default image
                String updateQuery = "UPDATE customers SET image = ? WHERE customer_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateQuery)) {
                    stmt.setString(1, "DatabaseImages/Customers/default.png");
                    stmt.setInt(2, customer.getCustomerId());  // Use customer.getCustomerId() from the retrieved Customer object

                    // Execute the update query
                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        response.sendRedirect("src/pages/Customer/CustomerDashboard/CustomerProfile.jsp?photoDeleted");
                    } else {
                        response.sendRedirect("src/pages/Customer/CustomerDashboard/CustomerProfile.jsp?photoDeletionFailed");
                    }
                }
            } else {
                System.out.println("Customer not found for user ID: " + userId);
                response.sendRedirect("src/pages/Customer/CustomerDashboard/CustomerProfile.jsp?error=true");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("src/pages/Customer/CustomerDashboard/CustomerProfile.jsp?sqlError");
        }
    }
}
