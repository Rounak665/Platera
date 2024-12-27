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

    // Getters and Setters

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

        public void setRestaurantId(int restaurantId) {
        this.restaurantId=restaurantId;
    }
        
    public int getRestaurantId(){
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

    public Double getAmountPayable() {
        return amountPayable;
    }

    public void setAmountPayable(Double amountPayable) {
        this.amountPayable = amountPayable;
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
        return "Orders{" +
                "orderId=" + orderId +
                ", totalAmount=" + totalAmount +
                ", address='" + address + '\'' +
                ", restaurantName='" + restaurantName + '\'' +
                ", restaurantAddress='" + restaurantAddress + '\'' +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", paymentDate='" + paymentDate + '\'' +
                ", amountPayable=" + amountPayable +
                '}';
    }

}
