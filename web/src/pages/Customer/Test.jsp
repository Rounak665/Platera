<%@ page import="Utilities.CustomerDAO, Utilities.Customer" %>
<%
    // Retrieve user_id from the session (replace this with actual session retrieval)
    int user_id = 201;

    // Initialize necessary variables
    String name = "";
    String email = "";
    int customer_id = 0;
    String image = "";
    String imagepath = "";
    int location_id = 0;
    String location_name = "";
    String address = "";
    String phone = "";
    boolean twoFA = false;

    // Fetch customer details
    Customer customer = CustomerDAO.getCustomerByUserId(user_id);
    if (customer != null) {
        customer_id = customer.getCustomerId();
        name = customer.getFullName();
        email = customer.getEmail();
        image = customer.getImage();
        location_id = customer.getLocationId();
        location_name = customer.getLocation();
        address = customer.getAddress();
        phone = customer.getPhone();
        twoFA = customer.isTwoStepVerification();
    }

    // Construct image path
    imagepath = request.getContextPath() + '/' + image;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Details</title>
    <style>
        table {
            border-collapse: collapse;
            width: 50%;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
    <h1 style="text-align: center;">Customer Details</h1>
    <table>
        <tr>
            <th>Field</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>Customer ID</td>
            <td><%= customer_id %></td>
        </tr>
        <tr>
            <td>Name</td>
            <td><%= name %></td>
        </tr>
        <tr>
            <td>Email</td>
            <td><%= email %></td>
        </tr>
        <tr>
            <td>Image</td>
            <td>
                <img src="<%= imagepath %>" alt="Customer Image" style="max-width: 150px; height: auto;" />
            </td>
        </tr>
        <tr>
            <td>Location ID</td>
            <td><%= location_id %></td>
        </tr>
        <tr>
            <td>Location Name</td>
            <td><%= location_name %></td>
        </tr>
        <tr>
            <td>Address</td>
            <td><%= address %></td>
        </tr>
        <tr>
            <td>Phone</td>
            <td><%= phone %></td>
        </tr>
        <tr>
            <td>Two-Step Verification</td>
            <td><%= twoFA ? "Enabled" : "Disabled" %></td>
        </tr>
    </table>
</body>
</html>
