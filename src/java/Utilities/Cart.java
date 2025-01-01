package Utilities;

public class Cart {
    private int cartId;
    private int customerId;
    private int itemId;
    private String itemName;
    private String itemImage;
    private double itemPrice;
    private int quantity;
    private String restaurantName; // New field
    private int restaurantId; // Optional: If needed for adding items to the cart
    private double totalPrice;
    private double promotions;
    private int couponId;

    // Getters and Setters
    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

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

    public String getItemImage() {
        return itemImage;
    }

    public void setItemImage(String itemImage) {
        this.itemImage = itemImage;
    }

    public double getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(double itemPrice) {
        this.itemPrice = itemPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getRestaurantName() {
        return restaurantName;
    }

    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }
    
    public void setTotalPrice(double totalPrice){
        this.totalPrice=totalPrice;
    }
    
    public double getTotalPrice(){
        return totalPrice;
    }
    public void setCouponId(int couponId){
        this.couponId=couponId;
    }
    public int getCouponId(){
        return couponId;
    }
    public void setCouponDiscount(double promotions){
        this.promotions=promotions;
    }
    public double getCouponDiscount(){
        return promotions;
    }
   

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }
}
