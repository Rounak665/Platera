package DeliveryExecutive;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import Utilities.DeliveryExecutiveDAO;
import Utilities.DeliveryExecutive;
import javax.servlet.annotation.WebServlet;

@WebServlet("/UpdateExecutiveProfile")
@MultipartConfig(maxFileSize = 10485760) // 10MB max file size
public class UpdateExecutiveProfile extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data from the request
        int executiveId = Integer.parseInt(request.getParameter("executive_id"));
        int userId = Integer.parseInt(request.getParameter("user_id"));
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String vehicleType = request.getParameter("vehicleType");
        String vehicleNumber = request.getParameter("vehicleNumber");
        int locationId = Integer.parseInt(request.getParameter("location"));
        Part profilePhoto = request.getPart("profileImage");
        String imagePath = null;

        // If a new image is uploaded, process the image
        if (profilePhoto != null && profilePhoto.getSize() > 0) {
            // Generate a unique file name for the image
            String fileName = "executive_" + executiveId + "_" + System.currentTimeMillis() + ".jpg";
            System.out.println("Photo found");

            // Define the directory path where the image will be stored
            String realPath = getServletContext().getRealPath("/");
            String projectRoot = new File(realPath).getParentFile().getParent();
            String imageDirectoryPath = projectRoot + File.separator + "web" + File.separator + "DatabaseImages" + File.separator + "Delivery_Executives";

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
                response.sendRedirect("src/pages/Executive/ExecutiveDashboard/ExecutiveProfile.jsp?error=FileUploadError");
                return;
            }

            // Set the image path for saving in the database
            imagePath = "DatabaseImages/Delivery_Executives" + File.separator + fileName;
        }

        try {
            // Get the existing executive details from the database
            DeliveryExecutive executive = DeliveryExecutiveDAO.getDeliveryExecutiveById(executiveId);
            if (executive != null) {
                // Update executive's fields
                executive.setFullName(name);
                executive.setPhone(phone);
                executive.setAddress(address);
                executive.setVehicleType(vehicleType);
                executive.setVehicleNumber(vehicleNumber);
                executive.setLocationId(locationId);
                executive.setImage(imagePath);

                // Update the profile in the database
                boolean isUpdated = DeliveryExecutiveDAO.updateDeliveryExecutiveProfile(executive);
                if (isUpdated) {
                    response.sendRedirect("src/pages/DeliveryExecutive/DeliveryDashboard.jsp?profileUpdated");
                } else {
                    response.sendRedirect("src/pages/Executive/ExecutiveDashboard/ExecutiveProfile.jsp#ErrorPopup");
                }
            } else {
                response.sendRedirect("src/pages/Executive/ExecutiveDashboard/ExecutiveProfile.jsp#ErrorPopup");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("src/pages/Error/DatabaseError.html");
        }
    }
}
