package Platera;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/ForgotPassVerifyOTP")
public class ForgotPassVerifyOTP extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String enteredOtp = request.getParameter("code");
        HttpSession session = request.getSession();
        String sessionOtp = (String) session.getAttribute("otp");
        
        // Set response content type
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            if (sessionOtp != null && sessionOtp.equals(enteredOtp)) {
                // OTP is correct, redirect to resetPassword.jsp
                response.sendRedirect("src/pages/ForgotPassword/resetPassword.jsp");
            } else {
                // OTP is incorrect
                out.println("<h1>Invalid OTP. Please try again.</h1>");
//                request.setAttribute("errorMessage", "Invalid OTP. Please try again.");
//                request.getRequestDispatcher("ForgotPassVerifyOTP.jsp").forward(request, response);
            }
        }
    }
}
