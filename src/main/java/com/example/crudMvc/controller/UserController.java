package com.example.crudMvc.controller;

import com.example.crudMvc.DAO.UserDAO;
import com.example.crudMvc.Model.User;
import com.example.crudMvc.Service.UserService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/")
public class UserController {

    private final UserDAO userDAO;

    public UserController(UserDAO userDAO) {

        this.userDAO = userDAO;
    }

    @Autowired
    private UserService userService;

    @GetMapping("/userlist")
    public String showUserList(Model model) {
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "userlist";
    }

    // Registration
    @GetMapping("/register")
    public String showRegistrationPage() {
        return "register";
    }

    @PostMapping("/registerUser")
    public String registerUser(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("mobile") String mobile,
            @RequestParam(value = "photo", required = false) MultipartFile photo,
            Model model) {
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setMobile(mobile);

        try {
            if (photo != null && !photo.isEmpty()) {
                user.setPhoto(photo.getBytes());
            } else {
                user.setPhoto(null);
            }
        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("message", "Error uploading photo.");
            return "register";
        }

        boolean isUserAdded = userService.registerUser(user);
        if (isUserAdded) {
            model.addAttribute("message", "User registered successfully!");
            return "login";
        } else {
            model.addAttribute("message", "Please try again.");
            return "register";
        }
    }

    // Update User
    @GetMapping("/updateUser")
    public String showUpdateUserForm(@RequestParam("id") int id, Model model) {
        User user = userService.getUserById(id);
        model.addAttribute("user", user);
        return "updateUser";
    }

    @PostMapping("/updateUser")
    public String updateUser(@ModelAttribute User user,
                             @RequestParam(value = "photo", required = false) MultipartFile photo,
                             Model model) {

        if (user.getId() == 0) {
            model.addAttribute("message", "Invalid user ID.");
            return "error";
        }

        User existingUser = userService.getUserById(user.getId());
        if (existingUser == null) {
            model.addAttribute("message", "User not found.");
            return "error";
        }

        if (userService.isEmailExists(user.getEmail(), user.getId())) {
            model.addAttribute("message", "Email is already in use.");
            return "updateUser";
        }

        existingUser.setName(user.getName());
        existingUser.setEmail(user.getEmail());
        existingUser.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
        existingUser.setMobile(user.getMobile());

        if (photo != null && !photo.isEmpty()) {
            try {
                existingUser .setPhoto(photo.getBytes());
            } catch (IOException e) {
                e.printStackTrace();
                model.addAttribute("message", "Error uploading photo.");
                return "updateUser";
            }
        } else {
            existingUser .setPhoto(existingUser .getPhoto());
        }

        boolean isUpdated = userService.updateUser(existingUser);
        if (isUpdated) {
            model.addAttribute("message", "User updated successfully!");
            return "redirect:/userlist";
        } else {
            model.addAttribute("message", "Update failed.");
            return "updateUser";
        }
    }

    @GetMapping("/deleteuser/{id}")
    public String deleteUser(@PathVariable("id") int id) {
        userService.deleteUser(id);
        return "redirect:/userlist";
    }

    //login
    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam("email") String email,
                            @RequestParam("password") String password,
                            HttpSession session, Model model) {
        User user = userService.authenticateUser(email, password);

        if (user != null) {
            session.setAttribute("user", user);
            return "redirect:/userlist";
        } else {
            model.addAttribute("error", "Invalid email or password.");
            return "login";
        }
    }

    // Logout
//    @GetMapping("/logout")
//    public String logout(HttpSession session) {
//        session.invalidate();
//        return "redirect:/login";
//    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        Cookie cookie = new Cookie("JSESSIONID", null);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        cookie.setMaxAge(0);
        response.addCookie(cookie);

        return "redirect:/login?logout=true";
    }
}