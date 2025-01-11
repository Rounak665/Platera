
package Utilities;

public class OrderItem {

    private int itemId;
    private String itemName;
    private int quantity;
    private String image;
    private double price;

    OrderItem() {
    }
    
    
    public OrderItem(int itemId, String itemName, int quantity) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.quantity = quantity;
    }

        public OrderItem(int itemId, String itemName, int quantity, String image) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.quantity = quantity;
        this.image = image;
    }

    // Getter and Setter methods
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

    public int getQuantity() {
        return quantity;
    }
    public double getPrice(){
    return price;
}

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
        public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    public void setPrice(double price){
        this.price=price;
    }
}
