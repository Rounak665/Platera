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

    // Add item to the list
    public void addItem(int itemId, String itemName, int quantity) {
        items.add(new OrderItem(itemId, itemName, quantity));
    }

    // Getter methods for the fields and items
    public List<OrderItem> getItems() {
        return items;
    }
}