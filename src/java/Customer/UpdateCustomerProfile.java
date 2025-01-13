package Customer;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import Utilities.CustomerDAO;
import Utilities.Customer;
import javax.servlet.annotation.WebServlet;

@WebServlet("/UpdateCustomerProfile")
@MultipartConfig(maxFileSize = 10485760) // 10MB max file size
public class UpdateCustomerProfile extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId =Integer.parseInt( request.getParameter("customer_id"));
        // Retrieve form data
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        int locationId = Integer.parseInt(request.getParameter("location"));
        String address = request.getParameter("address");
        Part profilePhoto = request.getPart("profilePhoto");
        String imagePath = null;

        // If a new image is uploaded, process the image
        if (profilePhoto != null && profilePhoto.getSize() > 0) {
            // Generate a unique file name for the image
            String fileName = "customer_" + customerId + "_" + System.currentTimeMillis() + ".jpg";

            // Define the directory path where the image will be stored
            String realPath = getServletContext().getRealPath("/");
            String projectRoot = new File(realPath).getParentFile().getParent();  
            String imageDirectoryPath = projectRoot + File.separator + "web" + File.separator + "DatabaseImages" + File.separator + "Customers"; 

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
                response.sendRedirect("src/pages/Restaurant/Menu.jsp?error=FileUploadError");
                return;
            }

            // Set the image path for saving in the database
            imagePath = "DatabaseImages/Customers" + File.separator + fileName;
        }

        try {
            // Get the existing customer details
            Customer customer = CustomerDAO.getCustomerById(customerId);
            if (customer != null) {
                customer.setFullName(name);
                customer.setPhone(phone);
                customer.setLocationId(locationId);
                customer.setAddress(address);
                customer.setImage(imagePath);
                boolean isUpdated = CustomerDAO.updateCustomerProfile(customer);
                if (isUpdated) {
                    response.sendRedirect("src/pages/Customer/CustomerDashboard/CustomerProfile.jsp?profileUpdated");
                } else {
                    response.sendRedirect("src/pages/Customer/CustomerDashboard/CustomerProfile.jsp#errorPopup");
                }
            } else {
                response.sendRedirect("src/pages/Customer/CustomerDashboard/CustomerProfile.jsp#errorPopup");
            }
        } catch (Exception e) {
            e.printStackTrace();
           response.sendRedirect("src/pages/Error/DatabaseError.html");
        }
    }
}
