package Utilities;

import java.util.ArrayList;
import java.util.List;

public class OrderDetails {
    // Existing fields
    public int orderId;
    public int restaurantId;
    public String restaurantName;
    public String restaurantImage;
    public String restaurantAddress;
    public int customerId;
    public String customerName;
    public String customerImage;
    public  String customerAddress;
    public String orderDate;
    public double totalAmount;
    public String paymentStatus;
    public String paymentMethod;

    // New list to store menu items with quantities
    private List<OrderItem> items = new ArrayList<OrderItem>();

    // Constructor (keep the existing fields, and add the items list)
//    public OrderDetails(int orderId, int restaurantId, String restaurantName, String restaurantImage,
//                        String restaurantAddress, int customerId, String customerName, String customerImage,
//                        String customerAddress, String orderDate, double totalAmount) {
//        this.orderId = orderId;
//        this.restaurantId = restaurantId;
//        this.restaurantName = restaurantName;
//        this.restaurantImage = restaurantImage;
//        this.restaurantAddress = restaurantAddress;
//        this.customerId = customerId;
//        this.customerName = customerName;
//        this.customerImage = customerImage;
//        this.customerAddress = customerAddress;
//        this.orderDate = orderDate;
//        this.totalAmount = totalAmount;
//    }

    // Add item to the list
    public void addItem(int itemId, String itemName, int quantity) {
        items.add(new OrderItem(itemId, itemName, quantity));
    }

    // Getter methods for the fields and items
    public List<OrderItem> getItems() {
        return items;
    }
}