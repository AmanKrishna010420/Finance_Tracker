package com.fin_app.Finance_Tracker.Controller;

import com.fin_app.Finance_Tracker.DTOs.CreateUserRequest;
import com.fin_app.Finance_Tracker.DTOs.LoginDTO;
import com.fin_app.Finance_Tracker.DTOs.UserResponse;
import com.fin_app.Finance_Tracker.Mapper.UserMapper;
import com.fin_app.Finance_Tracker.Service.UserService;
import org.apache.catalina.User;
import org.hibernate.validator.constraints.CodePointLength;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static org.springframework.http.ResponseEntity.ok;

@CrossOrigin("*")
@RestController
@RequestMapping("/user")
public class UserController {


    private final UserService service;


    public UserController(UserService service) {
        this.service = service;
    }

    @PostMapping("/register")
    public ResponseEntity<UserResponse> createUser(@RequestBody CreateUserRequest createUserRequest) {
        return ok(service.registerUser(createUserRequest));
    }

    @PostMapping("/login")
    public ResponseEntity<UserResponse> loginUser(@RequestBody LoginDTO loginDTO) {

        return ok(service.loginUser(loginDTO));
    }

    @GetMapping
    public ResponseEntity<UserResponse> getUserByEmail(@RequestParam String email) {

        return ResponseEntity.ok(service.fetchUserByEmail(email));
    }



}
