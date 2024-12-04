
package Utilities;

public class Location {
    private int id;
    private String locationName;

    // Constructor
    public Location(int id, String locationName) {
        this.id = id;
        this.locationName = locationName;
    }

    // Getter methods
    public int getId() {
        return id;
    }

    public String getName() {
        return locationName;
    }

    // Setter methods (if needed)
    public void setId(int id) {
        this.id = id;
    }

    public void setName(String locationName) {
        this.locationName = locationName;
    }
}

