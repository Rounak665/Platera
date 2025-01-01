package Utilities;

public class MenuItems {

    private int itemId;
    private String itemName;
    private double price;
    private String image;
    private String categoryName; // New field for category name
    private int restaurantId;
    private String restaurantName;
    private boolean availability;

    // Getters and Setters
    public boolean isAvailability() {
        return availability;
    }

    public void setAvailability(boolean availability) {
        this.availability = availability;
    }

    // Constructor
    public MenuItems() {
        // Initialize with default values if needed
    }

    // Getters and Setters
    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }
        public String getRestaurantName() {
        return restaurantName;
    }

    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }

    // toString method for debugging
    @Override
    public String toString() {
        return "MenuItems{"
                + "itemId=" + itemId
                + ", itemName='" + itemName + '\''
                + ", price=" + price
                + ", image='" + image + '\''
                + ", categoryName='" + categoryName + '\''
                + ", restaurantId=" + restaurantId
                + '}';
    }
}
