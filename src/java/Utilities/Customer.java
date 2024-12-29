package Utilities;

public class Customer {

    private int customerId;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private int locationId;
    private String location;
    private String image;  // Add the image field

    // Getters and setters for the other fields...
    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    // Existing getters and setters for customerId, fullName, email, etc.
    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
