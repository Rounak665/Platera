package Utilities;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailUtility {

    private static final String EMAIL = "plateraminorproject@gmail.com";  // Your email
    private static final String PASSWORD = "ybnwqkgdnlmlywbf";  // Your app password
    private static final String HOST = "smtp.gmail.com";  // SMTP host
    private static final String PORT = "587";  // SMTP port

    public static boolean sendEmail(String to, String subject, String body) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);
            return true; // Email sent successfully
        } catch (MessagingException e) {
            e.printStackTrace(); // Optionally log this using a logger
            return false; // Email sending failed
        }
    }
}
