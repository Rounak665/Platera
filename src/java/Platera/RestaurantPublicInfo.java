package Platera;

import Utilities.Database;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/RestaurantPublicInfo")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50  // 50 MB
)
public class RestaurantPublicInfo extends HttpServlet {

    // Directory to save uploaded images for restaurants (relative to the root of the project)
    private static final String IMAGE_DIRECTORY = "DatabaseImages/Restaurants";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set the response content type
        response.setContentType("text/html;charset=UTF-8");

        // Fetch session attributes from the previous servlet
        HttpSession session = request.getSession();
        String restaurantName = (String) session.getAttribute("restaurant_name");
        String ownerName = (String) session.getAttribute("owner_name");
        String email = (String) session.getAttribute("email");
        String ownerPhone = (String) session.getAttribute("owner_phone");
        String ownerAddress = (String) session.getAttribute("owner_address");
        String bankAccountName = (String) session.getAttribute("bank_account_name");
        String bankAccountNumber = (String) session.getAttribute("bank_account_number");
        String fssaiLicense = (String) session.getAttribute("fssai_license");
        String panCard = (String) session.getAttribute("pan_card");
        String gstin = (String) session.getAttribute("gstin");
        String password = (String) session.getAttribute("password");

        // Get the form parameters
        String restaurantPhone = request.getParameter("restaurant-phone");
        String restaurantAddress = request.getParameter("restaurant-address");
        String restaurantLocation = request.getParameter("restaurant-location");
        String category1 = request.getParameter("category1");
        String category2 = request.getParameter("category2");
        String category3 = request.getParameter("category3");
        String minPrice = request.getParameter("min-price");
        String maxPrice = request.getParameter("max-price");

        // Handle the image upload if present
        Part imagePart = request.getPart("image");
        String imageFileName = null;

        // Check if the file is uploaded
        if (imagePart != null && imagePart.getSize() > 0) {
            // Generate a unique file name for the image
            imageFileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();

            // Sanitize the file name to prevent any special characters
            imageFileName = imageFileName.replaceAll("[^a-zA-Z0-9.-]", "_");

            // Calculate the path relative to the web folder (Platera-Main/web)
            String realPath = getServletContext().getRealPath("/");
            String projectRoot = new File(realPath).getParentFile().getParent();  
            String imageDirectoryPath = projectRoot + File.separator + "web" + File.separator + IMAGE_DIRECTORY;

            // Create the directory if it doesn't exist
            File imageDirectory = new File(imageDirectoryPath);
            if (!imageDirectory.exists()) {
                imageDirectory.mkdirs();
            }

            // Write the image to the specified directory
            try (InputStream inputStream = imagePart.getInputStream();
                    OutputStream outputStream = new FileOutputStream(imageDirectoryPath + File.separator + imageFileName)) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            } catch (IOException e) {
                response.sendRedirect("src/pages/Restaurant/Menu.jsp?error=FileUploadError");
                return;
            }
        }

        // Database insertion logic
        try (Connection connection = Database.getConnection()) {
            // SQL query to insert restaurant details into the 'restaurant_requests' table
            String sql = "INSERT INTO restaurant_requests "
                    + "(restaurant_name, owner_name, email, owner_phone, owner_address, bank_acc_name, "
                    + "bank_acc_number, fssai_lic_no, pan_number, gst_in, password, restaurant_phone, "
                    + "restaurant_address, location, category_1, category_2, category_3, min_price, max_price, image) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                // Set the parameters for the SQL query
                ps.setString(1, restaurantName);
                ps.setString(2, ownerName);
                ps.setString(3, email);
                ps.setString(4, ownerPhone);
                ps.setString(5, ownerAddress);
                ps.setString(6, bankAccountName);
                ps.setString(7, bankAccountNumber);
                ps.setString(8, fssaiLicense);
                ps.setString(9, panCard);
                ps.setString(10, gstin);
                ps.setString(11, password);
                ps.setString(12, restaurantPhone);
                ps.setString(13, restaurantAddress);
                ps.setString(14, restaurantLocation);
                ps.setString(15, category1);
                ps.setString(16, category2);
                ps.setString(17, category3);
                ps.setString(18, minPrice);
                ps.setString(19, maxPrice);

                // Save the relative image path to the database
                if (imageFileName != null) {
                    ps.setString(20, IMAGE_DIRECTORY + "/" + imageFileName);  // Store the relative path in the database
                } else {
                    ps.setNull(20, java.sql.Types.VARCHAR);  // If no image, set it as null
                }

                // Execute the insert query
                int rowsInserted = ps.executeUpdate();
                if (rowsInserted > 0) {
                    // Print a confirmation message in the servlet
                    response.getWriter().println("<h2>Restaurant details added successfully!</h2>");
                } else {
                    response.getWriter().println("<h2>Error saving data!</h2>");
                }
            }
        } catch (Exception e) {
            // Handle database connection and query errors
            e.printStackTrace();
            response.getWriter().println("<h2>Error: " + e.getMessage() + "</h2>");
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().println("<h1>GET request received. Please use POST to submit the form.</h1>");
    }
}
