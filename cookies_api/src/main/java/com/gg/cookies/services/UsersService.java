package com.gg.cookies.services;

import com.gg.cookies.hibernate.User;
import java.util.List;

public interface UsersService {
  List<User> getUsers(long groupId);

  User getUser(long userId);
}
