package Utilities;

public class Restaurant {

    private int restaurantId;
    private String name;
    private String address;
    private String phone;
    private String image;
    private String location; // Updated to store location_name
    private double minPrice;
    private double maxPrice;
    private double rating;
    private String category1;
    private String category2;
    private String category3;
    private String ownerPhone;
    private String ownerAddress;
    private String ownerEmail;
    private boolean twoStepVerification;
    private int locationId;  // New property for location_id
    private String ownerName;  // New property for owner's name
    private int ownerId;
    
    public int getOwnerId(){
        return ownerId;
    }
    public void setOwnerId(int ownerId){
        this.ownerId=ownerId;
    }

    // Getter and Setter for ownerName
    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    // Getter and Setter for locationId
    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    // Constructor
    public Restaurant() {
        // Initialize with default values or leave it empty
//        this.restaurantId = 0;
//        this.name = "";
//        this.address = "";
//        this.phone = "";
//        this.image = "";
//        this.location = "";
//        this.minPrice = 0.0;
//        this.maxPrice = 0.0;
//        this.rating = 0.0;
//        this.category1 = "";
//        this.category2 = "";
//        this.category3 = "";
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

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
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

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = Math.round(rating * 10) / 10.0;
    }

    // Getters and Setters for categories
    public String getCategory1() {
        return category1;
    }

    public void setCategory1(String category1) {
        this.category1 = category1;
    }

    public String getCategory2() {
        return category2;
    }

    public void setCategory2(String category2) {
        this.category2 = category2;
    }

    public String getCategory3() {
        return category3;
    }

    public void setCategory3(String category3) {
        this.category3 = category3;
    }

    // Calculate Price Range
    public String getPriceRange() {
        if (minPrice == maxPrice) {
            return "₹" + (int) minPrice; // Show only one value if min and max are the same
        }
        return "₹" + (int) minPrice + " - ₹" + (int) maxPrice;
    }

    public double getPriceForTwo() {
        return 4 * minPrice; // Calculate capped price for two
    }

    public String getOwnerPhone() {
        return ownerPhone;
    }

    public void setOwnerPhone(String ownerPhone) {
        this.ownerPhone = ownerPhone;
    }

    public String getOwnerAddress() {
        return ownerAddress;
    }

    public void setOwnerAddress(String ownerAddress) {
        this.ownerAddress = ownerAddress;
    }

    public String getOwnerEmail() {
        return ownerEmail;
    }

    public void setOwnerEmail(String ownerEmail) {
        this.ownerEmail = ownerEmail;
    }

    public boolean isTwoStepVerification() {
        return twoStepVerification;
    }

    public void setTwoStepVerification(boolean twoStepVerification) {
        this.twoStepVerification = twoStepVerification;
    }

    // toString method for debugging
    @Override
    public String toString() {
        return "Restaurant{"
                + "restaurantId=" + restaurantId
                + ", name='" + name + '\''
                + ", address='" + address + '\''
                + ", phone='" + phone + '\''
                + ", image='" + image + '\''
                + ", location='" + location + '\''
                + ", minPrice=" + minPrice
                + ", maxPrice=" + maxPrice
                + ", rating=" + rating
                + ", category1='" + category1 + '\''
                + ", category2='" + category2 + '\''
                + ", category3='" + category3 + '\''
                + '}';
    }
}
