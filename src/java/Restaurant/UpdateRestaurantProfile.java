package Restaurant;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import Utilities.RestaurantDAO;
import Utilities.Restaurant;
import javax.servlet.annotation.WebServlet;

@WebServlet("/UpdateRestaurantProfile")
@MultipartConfig(maxFileSize = 10485760) // 10MB max file size
public class UpdateRestaurantProfile extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data from the request
        int userId = Integer.parseInt(request.getParameter("user_id"));
        int restaurantId = Integer.parseInt(request.getParameter("restaurant_id"));
        String restaurantName = request.getParameter("restaurant-name");
        String ownerName = request.getParameter("owner-name");
        String restaurantPhone = request.getParameter("restaurant-phone");
        String ownerPhone = request.getParameter("owner-phone");
        String restaurantAddress = request.getParameter("restaurant-address");
        String ownerAddress = request.getParameter("owner-address");
        Part profilePhoto = request.getPart("profileImage");
        String imagePath = null;

        // Create an instance of RestaurantDAO to interact with the database
        RestaurantDAO restaurantDAO = new RestaurantDAO();

        // If a new image is uploaded, process the image
        if (profilePhoto != null && profilePhoto.getSize() > 0) {
            // Generate a unique file name for the image
            String fileName = "restaurant_" + restaurantId + "_" + System.currentTimeMillis() + ".jpg";
            System.out.println("Photo found");

            // Define the directory path where the image will be stored
            String realPath = getServletContext().getRealPath("/");
            String projectRoot = new File(realPath).getParentFile().getParent();
            String imageDirectoryPath = projectRoot + File.separator + "web" + File.separator + "DatabaseImages" + File.separator + "Restaurants";

            // Create the directory if it doesn't exist
            File imageDirectory = new File(imageDirectoryPath);
            if (!imageDirectory.exists()) {
                imageDirectory.mkdirs();
            }

            // Write the image to the specified directory
            try (InputStream inputStream = profilePhoto.getInputStream();
                 OutputStream outputStream = new FileOutputStream(imageDirectoryPath + File.separator + fileName)) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            } catch (IOException e) {
                response.sendRedirect("src/pages/Error/DatabaseError.html");
                return;
            }

            // Set the image path for saving in the database
            imagePath = "DatabaseImages/Restaurants" + File.separator + fileName;
        }

        try {
            // Get the existing restaurant details from the database using the restaurantDAO instance
            Restaurant restaurant = restaurantDAO.getRestaurantById(restaurantId);
            if (restaurant != null) {
                // Set ownerId as userId
                restaurant.setOwnerId(userId);
                // Update restaurant's fields using the form data
                restaurant.setName(restaurantName);
                restaurant.setOwnerName(ownerName);
                restaurant.setPhone(restaurantPhone);
                restaurant.setOwnerPhone(ownerPhone);
                restaurant.setAddress(restaurantAddress);
                restaurant.setOwnerAddress(ownerAddress);
                restaurant.setImage(imagePath);

                // Update the profile in the database
                boolean isUpdated = restaurantDAO.updateRestaurantProfile(restaurant);
                if (isUpdated) {
                    response.sendRedirect("src/pages/Restaurant/RestaurantDashboard.jsp?profileUpdated");
                } else {
                    response.sendRedirect("src/pages/Restaurant/RestaurantProfile.jsp#ErrorPopup");
                }
            } else {
                response.sendRedirect("src/pages/Restaurant/RestaurantProfile.jsp#ErrorPopup");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("src/pages/Error/DatabaseError.html");
        }
    }
}
