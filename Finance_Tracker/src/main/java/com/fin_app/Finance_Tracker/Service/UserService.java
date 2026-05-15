package com.fin_app.Finance_Tracker.Service;

import com.fin_app.Finance_Tracker.DTOs.*;
//import com.fin_app.Finance_Tracker.DTOs.;
import com.fin_app.Finance_Tracker.Entities.User;
import com.fin_app.Finance_Tracker.Mapper.UserMapper;
import com.fin_app.Finance_Tracker.Repository.UserRepository;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public UserResponse registerUser(CreateUserRequest userRequest) {
        User user = UserMapper.toEntity(userRequest);
        userRepository.save(user);
        return UserMapper.toResponse(user);
    }

    public UserResponse loginUser(LoginDTO userRequest) {


        String userEmail = userRequest.getEmail();
        if(userRepository.findByUserEmail(userEmail) == null){
            throw new RuntimeException("User with email doesn't exists");
        }else{
            User dbUser = userRepository.findByUserEmail(userEmail);
            if(dbUser.getUserPassword().equals(userRequest.getPassword())){
                return UserMapper.toResponse(dbUser);
            }
            else{
                throw new RuntimeException("Invalid User or Password");
            }
        }
    }

    public UserResponse fetchUserByEmail(String email) {
        User user = userRepository.findByUserEmail(email);
        return UserMapper.toResponse(user);
    }

}
