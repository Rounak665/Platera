package Platera;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/UpdateDish")
@MultipartConfig
public class UpdateDish extends HttpServlet {

    private static final String IMAGE_DIRECTORY = "DatabaseImages/Dishes"; // Directory inside 'web'

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try {
            // Retrieve and validate form parameters
            int itemId = Integer.parseInt(request.getParameter("dish-id"));
            String itemName = request.getParameter("dish-name");
            double price = Double.parseDouble(request.getParameter("dish-price"));
            String categoryParam = request.getParameter("dish-category");
            int categoryId = Integer.parseInt(categoryParam);
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

                // Ensure the directory exists
                File imageDirectory = new File(imageDirectoryPath);
                if (!imageDirectory.exists()) {
                    imageDirectory.mkdirs();
                }

                // Write the file to the specified directory
                try (InputStream inputStream = imagePart.getInputStream();
                     FileOutputStream outputStream = new FileOutputStream(imageDirectoryPath + File.separator + imageFileName)) {
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

            // Update data in menu_items table
            try (Connection conn = Database.getConnection()) {
                String query = "UPDATE menu_items SET item_name = ?, price = ?, availability = ?, category_id = ?, image = ? WHERE item_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, itemName);
                    stmt.setDouble(2, price);
                    stmt.setString(3, availability);
                    stmt.setInt(4, categoryId);

                    // If there is an image, store the relative path (without the "web/" part)
                    if (imageFileName != null) {
                        stmt.setString(5, IMAGE_DIRECTORY + "/" + imageFileName);  // Store the relative path in the database
                    } else {
                        stmt.setNull(5, java.sql.Types.VARCHAR);  // If no image, set it as null
                    }
                    stmt.setInt(6, itemId);

                    stmt.executeUpdate();
                }
                response.sendRedirect("src/pages/Restaurant/Menu.jsp?success=DishUpdated");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("src/pages/Restaurant/Menu.jsp?error=InvalidNumberFormat");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("src/pages/Restaurant/Menu.jsp?error=UnexpectedError");
        }
    }
}
