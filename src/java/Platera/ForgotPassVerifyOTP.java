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

        String enteredOTP = request.getParameter("code");
        HttpSession session = request.getSession();
        Integer sessionOTP = (Integer) session.getAttribute("otp");
        
        
        // Set response content type

        
        try (PrintWriter out = response.getWriter()) {
            if (sessionOTP != null && sessionOTP.equals(Integer.valueOf(enteredOTP))) {
                // OTP is correct, redirect to resetPassword.jsp
                response.sendRedirect("src/pages/ForgotPassword/resetPassword.jsp");
            } else {
                // OTP is incorrect
                response.setContentType("text/html;charset=UTF-8");
                out.println("<h1>Invalid OTP. Please try again.</h1>");
//                request.setAttribute("errorMessage", "Invalid OTP. Please try again.");
//                request.getRequestDispatcher("ForgotPassVerifyOTP.jsp").forward(request, response);
            }
        }
    }
}
