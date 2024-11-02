
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/ApproveDeliveryExecutive"})
public class ApproveDeliveryExecutive extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int request_id = Integer.parseInt(request.getParameter("request_id"));
        try (Connection conn = Database.getConnection()) {
            String selectSql = "SELECT * FROM DELIVERY_EXECUTIVE_REQUESTS WHERE REQUEST_ID = ?";
            try (PreparedStatement selectPstmt = conn.prepareStatement(selectSql)) {
                selectPstmt.setInt(1,request_id);
                ResultSet rs=selectPstmt.executeQuery();
                if(rs.next()){
                    String insertUsersSql="INSERT INTO users(name,email,password,phone,user_role) VALUES (?,?,?,?,4)";
                    try(PreparedStatement insertUsersPstmt=conn.prepareStatement(insertUsersSql)){
                        insertUsersPstmt.setString(1,rs.getString("name"));
                        insertUsersPstmt.setString(2,rs.getString("email"));
                        insertUsersPstmt.setString(3,rs.getString("password"));
                        insertUsersPstmt.setInt(4,rs.getInt("phone"));
                        insertUsersPstmt.executeUpdate();
                    }
                    String insertDelExecSql="INSERT INTO delivery_executives (aadhar_number,pan_number,driving_license_number,gender,age,vehicle_type,vehicle_number,bank_account_number,bank_account_number) VALUES (?,?,?,?,?,?,?,?,?)";
                    try(PreparedStatement insertDelExecPstmt=conn.prepareStatement(insertDelExecSql)){
                        insertDelExecPstmt.setInt(1,rs.getInt("aadhar_number"));
                        insertDelExecPstmt.setInt(2,rs.getInt("pan_number"));
                        insertDelExecPstmt.setString(3,rs.getString("driving_license_number"));
                        insertDelExecPstmt.setString(4,rs.getString("gender"));
                        insertDelExecPstmt.setString(5,rs.getString("age"));
                        insertDelExecPstmt.setString(6,rs.getString("vehicle_type"));
                        insertDelExecPstmt.setString(7,rs.getString("vehicle_number"));
                        insertDelExecPstmt.setString(8,rs.getString("bank_account_name"));
                        insertDelExecPstmt.setString(9,rs.getString("bank_account_number"));
                        insertDelExecPstmt.executeUpdate();
                    }
                    String deleteSql="DELETE FROM delivery_executive_requests where request_id=?";
                    try(PreparedStatement deletePstmt=conn.prepareStatement(deleteSql)){
                        deletePstmt.setInt(1, request_id);
                        deletePstmt.executeQuery();
                    }
                    response.setContentType("text/html");
                    response.getWriter().println("<h2>Restaurant has been approved successfully</h2>");
                }
            } catch (SQLException ex) {
                Logger.getLogger(ApproveDeliveryExecutive.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ApproveDeliveryExecutive.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
