package Utilities;

public class Category {

    private int id;
    private String categoryName;
    private String image;

    public Category(int id, String categoryName) {
        this.id = id;
        this.categoryName = categoryName;
    }
    public Category() {
        this.id = id;
        this.categoryName = categoryName;
        this.image=image;
    }

    // Getter methods
    public int getId() {
        return id;
    }

    public String getName() {
        return categoryName;
    }

    public String getImage() {
        return image;
    }

    // Setter methods
    public void setId(int id) {
        this.id = id;
    }

    public void setName(String categoryName) {
        this.categoryName = categoryName;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
