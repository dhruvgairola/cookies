package com.gg.cookies.services;

import com.gg.cookies.hibernate.User;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UsersRepository extends JpaRepository<User, Long> {
  List<User> findByUserGroupId(long userGroupId);
}
