<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
    <link rel="stylesheet" type="text/css" href="./ForgotPassword.css">
</head>
<body>
    <div class="container">
        <div class="logo">
            <img src="Assets/favicon.png" alt="Logo" width="50" height="50">
        </div>
        <h2>Reset Password</h2>
        <p>Please enter your new password below to reset it.</p>
        <%
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            String email = (String) session.getAttribute("userEmail");
    
            if (newPassword != null && confirmPassword != null) {
                if (newPassword.equals(confirmPassword)) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdb", "username", "password");
    
                        String sql = "UPDATE users SET password = ? WHERE email = ?";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        stmt.setString(1, newPassword);
                        stmt.setString(2, email);
    
                        int rows = stmt.executeUpdate();
                        if (rows > 0) {
                            out.println("<p class='success-message'>Password updated successfully!</p>");
                        } else {
                            out.println("<p class='error-message'>Failed to update password. Try again.</p>");
                        }
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                    out.println("<p class='error-message'>Passwords do not match.</p>");
                }
            }
        %>
        <form method="post">
            <input type="password" id="newPassword" name="newPassword" placeholder="Enter New Password" required />
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm New Password" required />
    
            <button type="submit">Change Password</button>
        </form>
        <a href="login.jsp" class="back-link">Back to login</a>
    </div>
</body>
</html>
