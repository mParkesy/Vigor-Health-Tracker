/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import classes.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author xze15agu
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Database db = new Database();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        Date date = new Date();
        try {
            date = new SimpleDateFormat("yyyy-MM-dd").parse(dob);
        } catch (ParseException ex) {
            System.out.println("Failed to change date format in register controller");
        }
        String postcode = request.getParameter("postcode");
        String nationality = request.getParameter("nationality");
        String email = request.getParameter("email");
        double height = Double.parseDouble(request.getParameter("height"));
        double weight = Double.parseDouble(request.getParameter("weight"));
        double exercise = Double.parseDouble(request.getParameter("exerciseLevel"));

        String error;
        String success;

        if (!password.equals(repassword)) {
            error = "Entered passwords were not the same.";
            request.setAttribute("error", error);
            request.getRequestDispatcher("register.jsp").include(request, response);
        }

        try {
            if (!db.exists(username)) {
                User registered = db.insertUser(username, password, firstname, lastname, gender, date, postcode, nationality, email, height, weight, exercise);
                success = "Registration successful, please log in";
                request.setAttribute("message", success);
                request.getRequestDispatcher("login.jsp").include(request, response);
            } else {
                error = "Username already exists. Please register again";
                request.setAttribute("error", error);
                request.getRequestDispatcher("register.jsp").include(request, response);
            }
        } catch (Exception ex) {
            System.out.println("Failed to check if username exists during registration");
        }
    }
}