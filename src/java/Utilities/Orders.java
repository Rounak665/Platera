/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utilities;

import java.util.ArrayList;
import java.util.List;

public class Orders {

    private int orderId;
    private double totalAmount;
    private String address;
    private String restaurantName;
    private String restaurantAddress;
    private String paymentMethod;
    private String paymentStatus;
    private String paymentDate;
    private Double amountPayable;
    private List<OrderItem> orderItems = new ArrayList<>();
    private int restaurantId;
    private String restaurantPhone;
    private String customerPhone;
    private String orderStatus;
    private String orderDate;

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }


    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getCustomerAddress() {
        return address;
    }

    public void setCustomerAddress(String address) {
        this.address = address;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public String getRestaurantName() {
        return restaurantName;
    }

    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }

    public String getRestaurantAddress() {
        return restaurantAddress;
    }

    public void setRestaurantAddress(String restaurantAddress) {
        this.restaurantAddress = restaurantAddress;
    }

    // Getter and Setter for Restaurant Phone
    public String getRestaurantPhone() {
        return restaurantPhone;
    }

    public void setRestaurantPhone(String restaurantPhone) {
        this.restaurantPhone = restaurantPhone;
    }

// Getter and Setter for Customer Phone
    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(String paymentDate) {
        this.paymentDate = paymentDate;
    }

    public void addOrderItem(OrderItem item) {
        this.orderItems.add(item);
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    // Optional: Add a toString method for easier debugging
    @Override
    public String toString() {
        return "Orders{"
                + "orderId=" + orderId
                + ", totalAmount=" + totalAmount
                + ", address='" + address + '\''
                + ", restaurantName='" + restaurantName + '\''
                + ", restaurantAddress='" + restaurantAddress + '\''
                + ", paymentMethod='" + paymentMethod + '\''
                + ", paymentStatus='" + paymentStatus + '\''
                + ", paymentDate='" + paymentDate + '\''
                + ", amountPayable=" + amountPayable
                + '}';
    }

}
