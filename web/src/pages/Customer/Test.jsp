<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="FetchingClasses.LocationDAO" %>
<%@ page import="FetchingClasses.CategoryDAO" %>
<%@ page import="FetchingClasses.Location" %>
<%@ page import="FetchingClasses.Category" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Test | Platera</title>
    </head>
    <body>
        <h1>Test Page for Location and Category Fetching</h1>

        <h2>Locations:</h2>
        <ul>
            <%
                // Debugging code for Locations
                LocationDAO locationDAO = new LocationDAO();
                List<Location> locations = locationDAO.getLocations();
                if (locations != null && !locations.isEmpty()) {
                    for (Location location : locations) {
                        out.println("<li>" + location.getId() + ": " + location.getName() + "</li>");
                    }
                } else {
                    out.println("<li>No locations found!</li>");
                }
            %>
        </ul>

        <h2>Categories:</h2>
        <ul>
            <%
                // Debugging code for Categories
                CategoryDAO categoryDAO = new CategoryDAO();
                List<Category> categories = categoryDAO.getCategories();
                if (categories != null && !categories.isEmpty()) {
                    for (Category category : categories) {
                        out.println("<li>" + category.getId() + ": " + category.getName() + "</li>");
                    }
                } else {
                    out.println("<li>No categories found!</li>");
                }
            %>
        </ul>

    </body>
</html>
