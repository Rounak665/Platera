package FetchingClasses;



public class Restaurant {

    private int restaurantId;
    private String name;
    private String address;
    private String phone;
    private String image;
    private String location; // Updated to store location_name
    private double minPrice;
    private double maxPrice;

    // Constructor
    public Restaurant() {
    // Initialize with default values or leave it empty
    this.restaurantId = 0;
    this.name = "";
    this.address = "";
    this.phone = "";
    this.image = "";
    this.location = "";
    this.minPrice = 0.0;
    this.maxPrice = 0.0;
}

    
    // Getters and Setters
    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getLocation() { // Added getter for locationName
        return location;
    }

    public void setLocation(String location) { // Added setter for locationName
        this.location = location;
    }

    public double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(double minPrice) {
        this.minPrice = minPrice;
    }

    public double getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(double maxPrice) {
        this.maxPrice = maxPrice;
    }

    // Calculate Price Range
    public String getPriceRange() {
        if (minPrice == maxPrice) {
            return "₹" + (int) minPrice; // Show only one value if min and max are the same
        }
        return "₹" + (int) minPrice + " - ₹" + (int) maxPrice;
    }

    // toString method for debugging
    @Override
    public String toString() {
        return "Restaurant{" +
                "restaurantId=" + restaurantId +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                ", phone='" + phone + '\'' +
                ", image='" + image + '\'' +
                ", locationName='" + location + '\'' +
                ", minPrice=" + minPrice +
                ", maxPrice=" + maxPrice +
                '}';
    }
}
