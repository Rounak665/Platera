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

@WebServlet(name = "RestaurantAddDish", urlPatterns = {"/RestaurantAddDish"})
@MultipartConfig
public class RestaurantAddDish extends HttpServlet {

    // Directory to save uploaded images relative to the root of the project (inside the web folder)
    private static final String IMAGE_DIRECTORY = "DatabaseImages/Dishes";  

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        // Ensure the user is logged in
        Integer restaurantId = (Integer) session.getAttribute("restaurant_id");
        if (restaurantId == null) {
            response.sendRedirect("index.html");
            return;
        }

        try {
            // Retrieve and validate form parameters
            String itemName = request.getParameter("dish-name");
            String priceParam = request.getParameter("dish-price");
            String categoryParam = request.getParameter("dish-category");
            double price = Double.parseDouble(priceParam);
            Integer categoryId = Integer.parseInt(categoryParam);
            String availabilityParam = request.getParameter("dish-availability");
            String availability = ("on".equals(availabilityParam)) ? "Y" : "N";

            // Handle the image upload if present
            Part imagePart = request.getPart("dish-image");
            String imageFileName = null;

            // Check if the file is uploaded
            if (imagePart != null && imagePart.getSize() > 0) {
                // Generate a unique file name
                imageFileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();

                // Sanitize the file name
                imageFileName = imageFileName.replaceAll("[^a-zA-Z0-9.-]", "_");

                // Calculate the path relative to the web folder (Platera-Main/web)
                String realPath = getServletContext().getRealPath("/");  
                String projectRoot = new File(realPath).getParentFile().getParent();  // Step back two levels to reach the Platera-Main root
                String imageDirectoryPath = projectRoot + File.separator + "web" + File.separator + IMAGE_DIRECTORY;

                // Create the directory if it doesn't exist
                File imageDirectory = new File(imageDirectoryPath);
                if (!imageDirectory.exists()) {
                    imageDirectory.mkdirs();
                }

                // Write the file to the specified directory
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

            // Insert data into menu_items table
            try (Connection conn = Database.getConnection()) {
                String query = "INSERT INTO menu_items (restaurant_id, item_name, price, availability, category_id, image) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setInt(1, restaurantId);
                    stmt.setString(2, itemName);
                    stmt.setDouble(3, price);
                    stmt.setString(4, availability);
                    stmt.setInt(5, categoryId);

                    // If there is an image, store the relative path (without the "web/" part)
                    if (imageFileName != null) {
                        stmt.setString(6, IMAGE_DIRECTORY + "/" + imageFileName);  // Store the relative path in the database
                    } else {
                        stmt.setNull(6, java.sql.Types.VARCHAR);  // If no image, set it as null
                    }

                    stmt.executeUpdate();
                }
                response.sendRedirect("src/pages/Restaurant/Menu.jsp?success=DishAdded");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("src/pages/Restaurant/Menu.jsp?error=InvalidNumberFormat");
        } catch (Exception e) {
            response.sendRedirect("src/pages/Restaurant/Menu.jsp?error=UnexpectedError");
        }
    }
}

