/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package FetchingClasses;

import java.sql.*;
import java.util.*;

public class LocationDAO {
    // Method to fetch all locations from the locations table
    public List<Location> getLocations() {
        List<Location> locations = new ArrayList<>();
        try (Connection conn = Database.getConnection()) {
            String query = "SELECT * FROM locations";  // SQL query to fetch all locations
            PreparedStatement stmt = conn.prepareStatement(query);  // Prepare the statement
            ResultSet rs = stmt.executeQuery();  // Execute the query
            
            // Loop through the result set
            while (rs.next()) {
                
                int locationId = rs.getInt("location_id");  
                String locationName = rs.getString("location_name");  
                
                Location location = new Location(locationId, locationName);
                
                locations.add(location);
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Handle any SQL exceptions
        }
        return locations;  // Return the list of Location objects
    }
}
