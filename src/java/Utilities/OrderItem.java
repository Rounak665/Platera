
package Utilities;

public class OrderItem {
    public int itemId;
    public String itemName;
    public int quantity;

    public OrderItem(int itemId, String itemName, int quantity) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.quantity = quantity;
    }

    // Getter methods for the item details
    public int getItemId() {
        return itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public int getQuantity() {
        return quantity;
    }
}
