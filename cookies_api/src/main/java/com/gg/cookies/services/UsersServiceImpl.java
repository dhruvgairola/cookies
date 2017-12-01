package com.gg.cookies.services;

import com.gg.cookies.hibernate.User;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;


@Service
public class UsersServiceImpl implements UsersService {

  @Autowired
  UsersRepository usersRepository;

  @Override
  public List<User> getUsers(long userGroupId) {
    return usersRepository.findByUserGroupId(userGroupId);
  }

  @Override
  public User getUser(long userId) {
    return usersRepository.findOne(userId);
  }
}
