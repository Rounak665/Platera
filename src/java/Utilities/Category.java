package Utilities;

public class Category {
    private int id;
    private String categoryName;

    // Constructor
    public Category(int id, String categoryName) {
        this.id = id;
        this.categoryName = categoryName;
    }

    // Getter methods
    public int getId() {
        return id;
    }

    public String getName() {
        return categoryName;
    }

    // Setter methods (if needed)
    public void setId(int id) {
        this.id = id;
    }

    public void setName(String categoryName) {
        this.categoryName = categoryName;
    }
}
