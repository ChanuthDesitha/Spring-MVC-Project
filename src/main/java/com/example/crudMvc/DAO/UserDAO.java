package com.example.crudMvc.DAO;

import com.example.crudMvc.Model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    public UserDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<User> getAllUsers() {
        String sql = "SELECT id, name, email, password, mobile, photo FROM users";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setName(rs.getString("name"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setMobile(rs.getString("mobile"));
            user.setPhoto(rs.getBytes("photo"));

            return user;
        });
    }

    public User getUserById(int id) {
        String sql = "SELECT id, name, email, password, mobile, photo FROM users WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{id}, (rs, rowNum) -> {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setName(rs.getString("name"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setMobile(rs.getString("mobile"));
            user.setPhoto(rs.getBytes("photo"));
            return user;
        });
    }

    public void deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    public User findUserByEmailAndPassword(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ?";

        try {
            User user = jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(User.class), email);

            BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
            if (user != null && encoder.matches(password, user.getPassword())) {
                return user;
            }
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
        return null;
    }

//    public boolean addUser(User user) {
//        String sql = "INSERT INTO users (name, email, password, mobile, photo) VALUES (?, ?, ?, ?, ?)";
//        String hashedPassword = passwordEncoder.encode(user.getPassword());
//        try {
//            return jdbcTemplate.update(sql,
//                    user.getName(),
//                    user.getEmail(),
//                    hashedPassword,
//                    user.getMobile(),
//                    user.getPhoto()) > 0;
//        } catch (Exception e) {
//            e.printStackTrace();
//            return false;
//        }
//    }

    public boolean addUser(User user) {
        String sql = "INSERT INTO users (name, email, password, mobile, photo) VALUES (?, ?, ?, ?, ?)";
        String hashedPassword = passwordEncoder.encode(user.getPassword());

        try {
            return jdbcTemplate.update(sql,
                    user.getName(),
                    user.getEmail(),
                    hashedPassword,
                    user.getMobile(),
                    (user.getPhoto() != null && user.getPhoto().length > 0) ? user.getPhoto() : null) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isEmailExists(String email, int userId) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ? AND id != ?";
        int count = jdbcTemplate.queryForObject(sql, Integer.class, email, userId);
        return count > 0;
    }

    public boolean updateUser(User user) {
        if (isEmailExists(user.getEmail(), user.getId())) {
            return false;
        }

        String sql = "UPDATE users SET name = ?, email = ?, password = ?, mobile = ?, photo = ? WHERE id = ?";

        int result = jdbcTemplate.update(sql,
                user.getName(),
                user.getEmail(),
                user.getPassword(),
                user.getMobile(),
                user.getPhoto(),
                user.getId());

        return result > 0;
    }
}
