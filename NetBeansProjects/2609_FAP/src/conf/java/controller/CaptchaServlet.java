/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;


/**
 *
 * @author mirai
 */
public class CaptchaServlet extends HttpServlet {

    private static final String SECRET_KEY = "6LcF3fsqAAAAANtdGM3SAlrmJqUzhD-OtMGoq8ci";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String gRecaptchaResponse = request.getParameter("g-recaptcha- response");
if (gRecaptchaResponse == null || gRecaptchaResponse.isEmpty()) {
            response.getWriter().write("Captcha verification failed!");
            return;
        }
        boolean isValid = verifyCaptcha(gRecaptchaResponse);
        if (isValid) {
            response.getWriter().write("Captcha verification successful! Welcome.");
} else {
response.getWriter().write("Captcha verification failed! Try again.");
}
}
private boolean verifyCaptcha(String gRecaptchaResponse) throws
            IOException {
        String url = "https://www.google.com/recaptcha/api/siteverify";
        String params = "secret=" + SECRET_KEY + "&response="
                + gRecaptchaResponse;
        HttpURLConnection con = (HttpURLConnection) new URL(url).openConnection();
        con.setRequestMethod("POST");
        con.setDoOutput(true);
        try (OutputStream os = con.getOutputStream()) {
            os.write(params.getBytes());
        }
        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        StringBuilder response = new StringBuilder();
        String inputLine;
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();
        JSONObject jsonResponse = new JSONObject(response.toString());
        return jsonResponse.getBoolean("success");
    }
}
