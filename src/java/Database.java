import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    public static Connection getConnection() throws SQLException {
        // Replace with your actual database connection details
        String url = "jdbc:oracle:thin:@LAPTOP-FD5S7I0J:1521:orclSree";
        String user = "ROUNAK";
        String password = "CHAKRABORTY";
        return DriverManager.getConnection(url, user, password);
    }
}
