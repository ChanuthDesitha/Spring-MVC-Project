package com.example.crudMvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.io.InputStream;

@RestController
@RequestMapping("/photo")
public class PhotoController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/{id}")
    public ResponseEntity<byte[]> getUserPhoto(@PathVariable("id") int userId) {
        byte[] photo = getUserPhotoFromDatabase(userId);

        if (photo != null && photo.length > 0) {
            HttpHeaders headers = new HttpHeaders();
            headers.set("Content-Type", "image/jpeg");
            return new ResponseEntity<>(photo, headers, HttpStatus.OK);
        } else {
            return getDefaultImage();
        }
    }

    private byte[] getUserPhotoFromDatabase(int userId) {
        try {
            String sql = "SELECT photo FROM users WHERE id=?";
            byte[] photo = jdbcTemplate.queryForObject(sql, new Object[]{userId}, byte[].class);

            return photo.length > 0 ? photo : null;
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    private ResponseEntity<byte[]> getDefaultImage() {
        try {
            InputStream defaultImgStream = new ClassPathResource("static/img/default.jpg").getInputStream();
            byte[] defaultImageBytes = defaultImgStream.readAllBytes();

            HttpHeaders headers = new HttpHeaders();
            headers.set("Content-Type", "image/jpeg");
            return new ResponseEntity<>(defaultImageBytes, headers, HttpStatus.OK);
        } catch (IOException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
