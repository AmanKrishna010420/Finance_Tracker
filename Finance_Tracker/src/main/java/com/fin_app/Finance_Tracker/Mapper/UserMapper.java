package com.fin_app.Finance_Tracker.Mapper;

import com.fin_app.Finance_Tracker.DTOs.*;
import com.fin_app.Finance_Tracker.DTOs.CreateUserRequest;
import com.fin_app.Finance_Tracker.Entities.User;
import com.fin_app.Finance_Tracker.DTOs.UserResponse;

public class UserMapper {

    public static User toEntity(CreateUserRequest request){
        User user = new User();
        user.setFirstName(request.getFirstName());
        user.setLastName(request.getLastName());
        user.setUserName(request.getUsername());
        user.setUserEmail(request.getUserEmail());
        user.setUserPassword(request.getUserPassword());
        user.setBanks(request.getBanks());
        user.setUserBalance(request.getBalance());
        return user;
    }


    public static UserResponse toResponse(User user){
        UserResponse response = new UserResponse();
        response.setFirstName(user.getFirstName());
        response.setLastName(user.getLastName());
        response.setBalance(user.getUserBalance());
        response.setBanks(user.getBanks());
        response.setEmail(user.getUserEmail());
        return response;
    }


}
