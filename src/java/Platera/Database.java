package Platera;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {

    public static Connection getConnection() throws SQLException {
        // Replace with your actual database connection details
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver"); // Load the driver
        } catch (ClassNotFoundException e) {
            throw new SQLException("Oracle JDBC Driver not found.", e);
        }

        String url = "jdbc:oracle:thin:@Rounak:1521:orcl";
        String user = "ROUNAK";
        String password = "CHAKRABORTY";
        return DriverManager.getConnection(url, user, password);
    }
}
