package org.apache.jsp.src.pages.Admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Connection;
import Platera.Database;
import java.sql.SQLException;

public final class Admin_005fOrder_005fManagement2_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"UTF-8\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("        <title>Admin</title>\n");
      out.write("        <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH\" crossorigin=\"anonymous\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"Admin.css\">\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("\n");
      out.write("        <!-- loader -->\n");
      out.write("        <div class=\"loader\">\n");
      out.write("            <div id=\"pl\">\n");
      out.write("                <div>\n");
      out.write("                    <video class=\"vid\" src=\"../ContactUs/Assets/loader.mp4\" autoplay muted loop></video>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <div>\n");
      out.write("            <div class=\"sidebar\">\n");
      out.write("                <div class=\"sidebar-toggle menu\" id=\"menu\">\n");
      out.write("                    <ion-icon name=\"menu\"></ion-icon>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"sidebar-toggle close-btn\"><ion-icon name=\"close-outline\" class=\"ico\"></ion-icon></div>\n");
      out.write("                <div class=\"sidebar-header\">\n");
      out.write("                    <div class=\"logo\">\n");
      out.write("                        <img src=\"../../../Public/images/logo.png\" alt=\"\">\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"sidebar-menu\">\n");
      out.write("                    <ul>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"\">\n");
      out.write("                                <span class=\"icon\"><ion-icon name=\"bar-chart\"></ion-icon></span>\n");
      out.write("                                <span>Dashboard Overview</span>\n");
      out.write("                            </a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"\">\n");
      out.write("                                <span class=\"icon\"><ion-icon name=\"wine\"></ion-icon></span>\n");
      out.write("                                <span>Order Management</span>\n");
      out.write("                            </a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"./Admin_Restaurant_Approval.jsp\">\n");
      out.write("                                <span class=\"icon\"><ion-icon name=\"restaurant\"></ion-icon></span>\n");
      out.write("                                <span>Restaurant Approval</span>\n");
      out.write("                            </a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"./Admin_Delivery_Executive_Approval.jsp\">\n");
      out.write("                                <span class=\"icon\"><ion-icon name=\"bicycle\"></ion-icon></span>\n");
      out.write("                                <span>Delivery Executive Management</span>\n");
      out.write("                            </a>\n");
      out.write("                        </li>\n");
      out.write("                    </ul>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"main-content\">\n");
      out.write("                <header>\n");
      out.write("                    <div class=\"headerLogo\">\n");
      out.write("                        <div class=\"logo\">\n");
      out.write("                            <img src=\"../../../Public/images/logo.png\" alt=\"\">\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"search-wrapper\">\n");
      out.write("                        <span class=\"icon\"><ion-icon name=\"search\"></ion-icon></span>\n");
      out.write("                        <input type=\"search\" placeholder=\"Search\">\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <div class=\"social-icons\">\n");
      out.write("                        <div class=\"logout_btn\">\n");
      out.write("                            <form action=\"http://localhost:8080/Platera-Main/logout\" class=\"d-flex align-items-center\">\n");
      out.write("                                <button type=\"submit\" class=\"btn d-flex align-items-center\">\n");
      out.write("                                    <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"16\" height=\"16\" fill=\"currentColor\" class=\"bi bi-power\" viewBox=\"0 0 16 16\">\n");
      out.write("                                    <path d=\"M7.5 1v7h1V1z\"></path>\n");
      out.write("                                    <path d=\"M3 8.812a5 5 0 0 1 2.578-4.375l-.485-.874A6 6 0 1 0 11 3.616l-.501.865A5 5 0 1 1 3 8.812\"></path>\n");
      out.write("                                    </svg>\n");
      out.write("                                    <span class=\"ml-2\">Logout</span>\n");
      out.write("                                </button>\n");
      out.write("                            </form>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </header>\n");
      out.write("\n");
      out.write("                <main>\n");
      out.write("                    <h2 class=\"dash-title\">Order Management</h2>\n");
      out.write("\n");
      out.write("                    <!-- Pending Orders Section -->\n");
      out.write("\n");
      out.write("\n");
      out.write("                    <section id=\"pending-orders\">\n");
      out.write("                        <h2>Pending Orders</h2>\n");
      out.write("\n");
      out.write("                        ");

                            Connection conn = null;
                            PreparedStatement stmt = null;
                            ResultSet rs = null;
                            String orderSql = "SELECT o.order_id, r.name AS restaurant_name, u.name AS customer_name, mi.item_name, oi.quantity, oi.price, o.total_amount, o.order_status "
                                    + "FROM orders o "
                                    + "JOIN order_items oi ON o.order_id = oi.order_id "
                                    + "JOIN restaurants r ON oi.restaurant_id = r.restaurant_id "
                                    + "JOIN menu_items mi ON oi.item_id = mi.item_id "
                                    + "JOIN users u ON o.customer_user_id = u.user_id "
                                    + "WHERE o.order_status = 'Pending' "
                                    + "ORDER BY o.order_id";

                            List<String[]> orderDetailsList = new ArrayList<String[]>();  // List to store order details for each order
                            int currentOrderId = -1;
                            StringBuilder itemsOrdered = new StringBuilder();
                            String restaurantName = "";
                            String customerName = "";
                            double totalAmount = 0;
                            String orderStatus = "";

                            try {
                                conn = Database.getConnection();
                                stmt = conn.prepareStatement(orderSql);
                                rs = stmt.executeQuery();

                                // Process the result set
                                while (rs.next()) {
                                    int orderId = rs.getInt("order_id");

                                    // When a new order is encountered, save the previous order's details
                                    if (orderId != currentOrderId && currentOrderId != -1) {
                                        orderDetailsList.add(new String[]{
                                            String.valueOf(currentOrderId),
                                            restaurantName,
                                            customerName,
                                            itemsOrdered.toString(),
                                            String.valueOf(totalAmount),
                                            orderStatus
                                        });
                                        itemsOrdered.setLength(0); // Clear the StringBuilder for the next order
                                    }

                                    // Update order-level details
                                    currentOrderId = orderId;
                                    restaurantName = rs.getString("restaurant_name");
                                    customerName = rs.getString("customer_name");
                                    totalAmount = rs.getDouble("total_amount");
                                    orderStatus = rs.getString("order_status");

                                    // Append item details for the current order
                                    if (itemsOrdered.length() > 0) {
                                        itemsOrdered.append(", ");
                                    }
                                    itemsOrdered.append(rs.getInt("quantity")).append("x ").append(rs.getString("item_name"));
                                }

                                // Add the last order's details to the list
                                if (currentOrderId != -1) {
                                    orderDetailsList.add(new String[]{
                                        String.valueOf(currentOrderId),
                                        restaurantName,
                                        customerName,
                                        itemsOrdered.toString(),
                                        String.valueOf(totalAmount),
                                        orderStatus
                                    });
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                // Close resources
                                if (rs != null) {
                                    try {
                                        rs.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (stmt != null) {
                                    try {
                                        stmt.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (conn != null) {
                                    try {
                                        conn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                        
      out.write("\n");
      out.write("\n");
      out.write("                        <!-- HTML table to display the order details -->\n");
      out.write("                        <table border=\"1\">\n");
      out.write("                            <thead>\n");
      out.write("                                <tr>\n");
      out.write("                                    <th>Order ID</th>\n");
      out.write("                                    <th>Restaurant Name</th>\n");
      out.write("                                    <th>Customer Name</th>\n");
      out.write("                                    <th>Items Ordered</th>\n");
      out.write("                                    <th>Total Amount</th>\n");
      out.write("                                    <th>Order Status</th>\n");
      out.write("                                </tr>\n");
      out.write("                            </thead>\n");
      out.write("                            <tbody>\n");
      out.write("                                ");
 for (int i = 0; i < orderDetailsList.size(); i++) {
                                        String[] orderDetails = (String[]) orderDetailsList.get(i);
                                
      out.write("\n");
      out.write("                                <tr>\n");
      out.write("                                    <td>");
      out.print( orderDetails[0]);
      out.write("</td>\n");
      out.write("                                    <td>");
      out.print( orderDetails[1]);
      out.write("</td>\n");
      out.write("                                    <td>");
      out.print( orderDetails[2]);
      out.write("</td>\n");
      out.write("                                    <td>");
      out.print( orderDetails[3]);
      out.write("</td>\n");
      out.write("                                    <td>");
      out.print( orderDetails[4]);
      out.write("</td>\n");
      out.write("                                    <td>");
      out.print( orderDetails[5]);
      out.write("</td>\n");
      out.write("                                </tr>\n");
      out.write("                                ");
 } 
      out.write("\n");
      out.write("                            </tbody>\n");
      out.write("                        </table>\n");
      out.write("\n");
      out.write("                    </section>\n");
      out.write("\n");
      out.write("\n");
      out.write("                    <!-- Pending Delivery Section -->\n");
      out.write("                    <section id=\"pending-delivery\">\n");
      out.write("                        <h2>Pending Delivery Orders</h2>\n");
      out.write("\n");
      out.write("                        ");

                            Connection deliveryConn = null;
                            PreparedStatement deliveryStmt = null;
                            ResultSet deliveryRs = null;
                            String deliveryOrderSql = "SELECT o.order_id, r.name AS restaurant_name, u.name AS customer_name, mi.item_name, oi.quantity, oi.price, o.total_amount, o.order_status "
                                    + "FROM orders o "
                                    + "JOIN order_items oi ON o.order_id = oi.order_id "
                                    + "JOIN restaurants r ON oi.restaurant_id = r.restaurant_id "
                                    + "JOIN menu_items mi ON oi.item_id = mi.item_id "
                                    + "JOIN users u ON o.customer_user_id = u.user_id "
                                    + "WHERE o.order_status = 'Picked Up' "
                                    + "ORDER BY o.order_id";

                            List<String[]> deliveryOrderList = new ArrayList<String[]>();  // List to store delivery order details
                            int currentDeliveryOrderId = -1;
                            StringBuilder deliveryItemsOrdered = new StringBuilder();
                            String deliveryRestaurantName = "";
                            String deliveryCustomerName = "";
                            double deliveryTotalAmount = 0;
                            String deliveryOrderStatus = "";

                            try {
                                deliveryConn = Database.getConnection();
                                deliveryStmt = deliveryConn.prepareStatement(deliveryOrderSql);
                                deliveryRs = deliveryStmt.executeQuery();

                                // Process the result set
                                while (deliveryRs.next()) {
                                    int deliveryOrderId = deliveryRs.getInt("order_id");

                                    // When a new order is encountered, save the previous order's details
                                    if (deliveryOrderId != currentDeliveryOrderId && currentDeliveryOrderId != -1) {
                                        deliveryOrderList.add(new String[]{
                                            String.valueOf(currentDeliveryOrderId),
                                            deliveryRestaurantName,
                                            deliveryCustomerName,
                                            deliveryItemsOrdered.toString(),
                                            String.valueOf(deliveryTotalAmount),
                                            deliveryOrderStatus
                                        });
                                        deliveryItemsOrdered.setLength(0); // Clear the StringBuilder for the next order
                                    }

                                    // Update order-level details
                                    currentDeliveryOrderId = deliveryOrderId;
                                    deliveryRestaurantName = deliveryRs.getString("restaurant_name");
                                    deliveryCustomerName = deliveryRs.getString("customer_name");
                                    deliveryTotalAmount = deliveryRs.getDouble("total_amount");
                                    deliveryOrderStatus = deliveryRs.getString("order_status");

                                    // Append item details for the current order
                                    if (deliveryItemsOrdered.length() > 0) {
                                        deliveryItemsOrdered.append(", ");
                                    }
                                    deliveryItemsOrdered.append(deliveryRs.getInt("quantity")).append("x ").append(deliveryRs.getString("item_name"));
                                }

                                // Add the last order's details to the list
                                if (currentDeliveryOrderId != -1) {
                                    deliveryOrderList.add(new String[]{
                                        String.valueOf(currentDeliveryOrderId),
                                        deliveryRestaurantName,
                                        deliveryCustomerName,
                                        deliveryItemsOrdered.toString(),
                                        String.valueOf(deliveryTotalAmount),
                                        deliveryOrderStatus
                                    });
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                // Close resources
                                if (deliveryRs != null) {
                                    try {
                                        deliveryRs.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (deliveryStmt != null) {
                                    try {
                                        deliveryStmt.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (deliveryConn != null) {
                                    try {
                                        deliveryConn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                        
      out.write("\n");
      out.write("\n");
      out.write("                        <!-- HTML table to display the delivery order details -->\n");
      out.write("                        <table border=\"1\">\n");
      out.write("                            <thead>\n");
      out.write("                                <tr>\n");
      out.write("                                    <th>Order ID</th>\n");
      out.write("                                    <th>Restaurant Name</th>\n");
      out.write("                                    <th>Customer Name</th>\n");
      out.write("                                    <th>Items Ordered</th>\n");
      out.write("                                    <th>Total Amount</th>\n");
      out.write("                                    <th>Order Status</th>\n");
      out.write("                                </tr>\n");
      out.write("                            </thead>\n");
      out.write("                            <tbody>\n");
      out.write("                                ");
 for (int i = 0; i < deliveryOrderList.size(); i++) {
                                        String[] deliveryOrderDetails = deliveryOrderList.get(i);
                                
      out.write("\n");
      out.write("                                <tr>\n");
      out.write("                                    <td>");
      out.print( deliveryOrderDetails[0]);
      out.write("</td>\n");
      out.write("                                    <td>");
      out.print( deliveryOrderDetails[1]);
      out.write("</td>\n");
      out.write("                                    <td>");
      out.print( deliveryOrderDetails[2]);
      out.write("</td>\n");
      out.write("                                    <td>");
      out.print( deliveryOrderDetails[3]);
      out.write("</td>\n");
      out.write("                                    <td>");
      out.print( deliveryOrderDetails[4]);
      out.write("</td>\n");
      out.write("                                    <td>");
      out.print( deliveryOrderDetails[5]);
      out.write("</td>\n");
      out.write("                                </tr>\n");
      out.write("                                ");
 } 
      out.write("\n");
      out.write("                            </tbody>\n");
      out.write("                        </table>\n");
      out.write("                    </section>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                    <!-- Order History Section -->\n");
      out.write("                    <section id=\"order-history\">\n");
      out.write("                        <h2>Delivered Orders</h2>\n");
      out.write("\n");
      out.write("                        ");

                            Connection deliveredConn = null;
                            PreparedStatement deliveredStmt = null;
                            ResultSet deliveredRs = null;
                            String deliveredOrderSql = "SELECT o.order_id, r.name AS restaurant_name, u.name AS customer_name, mi.item_name, oi.quantity, oi.price, o.total_amount, o.order_status "
                                    + "FROM orders o "
                                    + "JOIN order_items oi ON o.order_id = oi.order_id "
                                    + "JOIN restaurants r ON oi.restaurant_id = r.restaurant_id "
                                    + "JOIN menu_items mi ON oi.item_id = mi.item_id "
                                    + "JOIN users u ON o.customer_user_id = u.user_id "
                                    + "WHERE o.order_status = 'Delivered' "
                                    + "ORDER BY o.order_id";

                            List<String[]> deliveredOrderList = new ArrayList<String[]>();  // List to store delivered order details
                            int currentDeliveredOrderId = -1;
                            StringBuilder deliveredItemsOrdered = new StringBuilder();
                            String deliveredRestaurantName = "";
                            String deliveredCustomerName = "";
                            double deliveredTotalAmount = 0;
                            String deliveredOrderStatus = "";

                            try {
                                deliveredConn = Database.getConnection();
                                deliveredStmt = deliveredConn.prepareStatement(deliveredOrderSql);
                                deliveredRs = deliveredStmt.executeQuery();

                                // Process the result set
                                while (deliveredRs.next()) {
                                    int deliveredOrderId = deliveredRs.getInt("order_id");

                                    // When a new order is encountered, save the previous order's details
                                    if (deliveredOrderId != currentDeliveredOrderId && currentDeliveredOrderId != -1) {
                                        deliveredOrderList.add(new String[]{
                                            String.valueOf(currentDeliveredOrderId),
                                            deliveredRestaurantName,
                                            deliveredCustomerName,
                                            deliveredItemsOrdered.toString(),
                                            String.valueOf(deliveredTotalAmount),
                                            deliveredOrderStatus
                                        });
                                        deliveredItemsOrdered.setLength(0); // Clear the StringBuilder for the next order
                                    }

                                    // Update order-level details
                                    currentDeliveredOrderId = deliveredOrderId;
                                    deliveredRestaurantName = deliveredRs.getString("restaurant_name");
                                    deliveredCustomerName = deliveredRs.getString("customer_name");
                                    deliveredTotalAmount = deliveredRs.getDouble("total_amount");
                                    deliveredOrderStatus = deliveredRs.getString("order_status");

                                    // Append item details for the current order
                                    if (deliveredItemsOrdered.length() > 0) {
                                        deliveredItemsOrdered.append(", ");
                                    }
                                    deliveredItemsOrdered.append(deliveredRs.getInt("quantity")).append("x ").append(deliveredRs.getString("item_name"));
                                }

                                // Add the last order's details to the list
                                if (currentDeliveredOrderId != -1) {
                                    deliveredOrderList.add(new String[]{
                                        String.valueOf(currentDeliveredOrderId),
                                        deliveredRestaurantName,
                                        deliveredCustomerName,
                                        deliveredItemsOrdered.toString(),
                                        String.valueOf(deliveredTotalAmount),
                                        deliveredOrderStatus
                                    });
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                // Close resources
                                if (deliveredRs != null) {
                                    try {
                                        deliveredRs.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (deliveredStmt != null) {
                                    try {
                                        deliveredStmt.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (deliveredConn != null) {
                                    try {
                                        deliveredConn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                        
      out.write("\n");
      out.write("\n");
      out.write("                        <!-- HTML table to display the delivered order details -->\n");
      out.write("                        <table border=\"1\">\n");
      out.write("                            <thead>\n");
      out.write("                                <tr>\n");
      out.write("                                    <th>Order ID</th>\n");
      out.write("                                    <th>Restaurant Name</th>\n");
      out.write("                                    <th>Customer Name</th>\n");
      out.write("                                    <th>Items Ordered</th>\n");
      out.write("                                    <th>Total Amount</th>\n");
      out.write("                                    <th>Order Status</th>\n");
      out.write("                                </tr>\n");
      out.write("                            </thead>\n");
      out.write("                            <tbody>\n");
      out.write("                                ");
 for (int i = 0; i < deliveredOrderList.size(); i++) {
                                        String[] deliveredOrderDetails = deliveredOrderList.get(i);
                                
      out.write("\n");
      out.write("                                <tr>\n");
      out.write("                                    <td>");
      out.print( deliveredOrderDetails[0]);
      out.write("</td>\n");
      out.write("                                    <td>");
      out.print( deliveredOrderDetails[1]);
      out.write("</td>\n");
      out.write("                                    <td>");
      out.print( deliveredOrderDetails[2]);
      out.write("</td>\n");
      out.write("                                    <td>");
      out.print( deliveredOrderDetails[3]);
      out.write("</td>\n");
      out.write("                                    <td>");
      out.print( deliveredOrderDetails[4]);
      out.write("</td>\n");
      out.write("                                    <td>");
      out.print( deliveredOrderDetails[5]);
      out.write("</td>\n");
      out.write("                                </tr>\n");
      out.write("                                ");
 }
      out.write("\n");
      out.write("                            </tbody>\n");
      out.write("                        </table>\n");
      out.write("                    </section>\n");
      out.write("\n");
      out.write("\n");
      out.write("                </main>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <!-- Scripts -->\n");
      out.write("\n");
      out.write("        <!-- Icon Scripts -->\n");
      out.write("        <script src=\"https://unpkg.com/boxicons@2.1.4/dist/boxicons.js\"></script>\n");
      out.write("        <script type=\"module\" src=\"https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js\"></script>\n");
      out.write("        <script nomodule src=\"https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js\"></script>\n");
      out.write("        <!--Bootstrap-->\n");
      out.write("        <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js\" integrity=\"sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz\" crossorigin=\"anonymous\"></script>\n");
      out.write("\n");
      out.write("        <!-- Main JavaScript -->\n");
      out.write("        <script>\n");
      out.write("            document.querySelector(\"#menu\").addEventListener(\"click\", function () {\n");
      out.write("                document.querySelector(\".sidebar\").classList.add(\"activate\");\n");
      out.write("            });\n");
      out.write("\n");
      out.write("            document.querySelector(\".sidebar .close-btn\").addEventListener(\"click\", function () {\n");
      out.write("                document.querySelector(\".sidebar\").classList.remove(\"activate\");\n");
      out.write("            });\n");
      out.write("\n");
      out.write("\n");
      out.write("        </script>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
