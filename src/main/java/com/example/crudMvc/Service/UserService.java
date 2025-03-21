package com.example.crudMvc.Service;

import com.example.crudMvc.DAO.UserDAO;
import com.example.crudMvc.Model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserDAO userDAO;

    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public User getUserById(int id) {
        return userDAO.getUserById(id);
    }

    public void deleteUser(int id) {
        userDAO.deleteUser(id);
    }

    public User authenticateUser(String email, String password) {
        User user = userDAO.findUserByEmailAndPassword(email, password);
        return user;
    }

    public boolean registerUser(User user) {
        return userDAO.addUser(user);
    }

    public boolean isEmailExists(String email, int userId) {
        return userDAO.isEmailExists(email, userId);
    }

    public boolean updateUser(User user) {
        return userDAO.updateUser(user);
    }
}

