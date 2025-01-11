<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="Utilities.MenuItemsDAO" %>
<%@ page import="Utilities.MenuItems" %>

<%
    // Retrieve the item_id from the request parameter
    MenuItemsDAO menuItemsDAO = new MenuItemsDAO();
    MenuItems item = null;
    
        int itemId = 81;
        item = menuItemsDAO.getMenuItemById(itemId); // Fetch item using the method
    
%>

<html>
<head>
    <title>Menu Item Details</title>
</head>
<body>
    <h2>Menu Item Details</h2>

    <% if (item != null) { %>
        <p><strong>Item ID:</strong> <%= item.getItemId() %></p>
        <p><strong>Item Name:</strong> <%= item.getItemName() %></p>
        <p><strong>Price:</strong> <%= item.getPrice() %></p>
        <p><strong>Category:</strong> <%= item.getCategoryName() %></p>
        <p><strong>Availability:</strong> <%= item.isAvailability() ? "Available" : "Not Available" %></p>
        <p><strong>Image:</strong> <img src="<%= item.getImage() %>" alt="Dish Image" width="100"></p>
    <% } else { %>
        <p>No menu item found with the provided ID.</p>
    <% } %>

    <br>
    <a href="menu.jsp">Back to Menu</a>
</body>
</html>
