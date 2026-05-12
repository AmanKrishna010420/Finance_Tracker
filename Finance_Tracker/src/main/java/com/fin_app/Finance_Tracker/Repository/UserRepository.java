package com.fin_app.Finance_Tracker.Repository;

import com.fin_app.Finance_Tracker.Entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Integer> {
    User findByuserEmail(String reqEmail) ;
//    User getByUser(User user);
}
