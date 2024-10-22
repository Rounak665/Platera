package org.apache.jsp.src.pages.Admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class AdminApproval_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <title>Admin Approval Page</title>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    <h1>Pending Restaurant Approvals</h1>\n");
      out.write("\n");
      out.write("    <table border=\"1\">\n");
      out.write("        <thead>\n");
      out.write("            <tr>\n");
      out.write("                <th>Request ID</th>\n");
      out.write("                <th>Restaurant Name</th>\n");
      out.write("                <th>Owner Name</th>\n");
      out.write("                <th>Email</th>\n");
      out.write("                <th>Phone</th>\n");
      out.write("                <th>Bank Account Name</th>\n");
      out.write("                <th>Bank Account Number</th>\n");
      out.write("                <th>GSTIN</th>\n");
      out.write("                <th>FSSAI License</th>\n");
      out.write("                <th>Actions</th> \n");
      out.write("            </tr>\n");
      out.write("        </thead>\n");
      out.write("        <tbody>\n");
      out.write("\n");
      out.write("        ");

            // Database connection details
            String jdbcUrl = "jdbc:oracle:thin:@Rounak:1521:orcl"; // Replace with your Oracle DB URL
            String dbUser = "ROUNAK"; // Replace with your DB username
            String dbPassword = "CHAKRABORTY"; // Replace with your DB password

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // Load Oracle JDBC Driver
                Class.forName("oracle.jdbc.driver.OracleDriver");

                // Establish the connection
                conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                // Create a statement
                stmt = conn.createStatement();

                // Query to select pending restaurant approvals
                String sql = "SELECT * FROM restaurant_requests"; // Adjust the table name as needed
                rs = stmt.executeQuery(sql);

                // Iterate through the result set and display each entry
                while (rs.next()) {
                    int request_id = rs.getInt("request_id");
                    String restaurant_name = rs.getString("restaurant_name");
                    String owner_name = rs.getString("owner_name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String bank_acc_name = rs.getString("bank_acc_name");
                    String bank_acc_number = rs.getString("bank_acc_number");
                    String gst_in = rs.getString("gst_in");
                    String fssai_lic_no=rs.getString("fssai_lic_no");

                    
      out.write("\n");
      out.write("                   ");
out.println("<tr>");
                    out.println("<td>" + request_id + "</td>");
                    out.println("<td>" + restaurant_name + "</td>");
                    out.println("<td>" + owner_name + "</td>");
                    out.println("<td>" + email + "</td>");
                    out.println("<td>" + phone + "</td>");
                    out.println("<td>" + bank_acc_name + "</td>");
                    out.println("<td>" + bank_acc_number + "</td>");
                    out.println("<td>" + gst_in + "</td>");
                    out.println("<td>" + fssai_lic_no + "</td>");
                    out.println("<td>");
                    out.println("<form action='http://localhost:8080/Platera-Main/approveRestaurant' method='post' style='display:inline;'>");
                    out.println("<input type='hidden' name='request_id' value='" + request_id + "'/>");
                    out.println("<input type='submit' value='Approve'/>");
                    out.println("</form>");
                    out.println("<form action='http://localhost:8080/Platera-Main/rejectRestaurant' method='post' style='display:inline;'>");
                    out.println("<input type='hidden' name='request_id' value='" + request_id + "'/>");
                    out.println("<input type='submit' value='Reject'/>");
                    out.println("</form>");
                    out.println("</td>");
                    out.println("</tr>");
                   
      out.write("\n");
      out.write("                    ");

                }
            } catch (ClassNotFoundException e) {
                out.println("Oracle JDBC Driver not found.");
                e.printStackTrace();
            } catch (SQLException e) {
                out.println("Error connecting to the database."+ e.getMessage());
                e.printStackTrace();
            } finally {
                // Close resources
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        
      out.write("\n");
      out.write("    </table>\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
