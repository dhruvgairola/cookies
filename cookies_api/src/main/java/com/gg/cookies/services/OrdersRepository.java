package com.gg.cookies.services;

import com.gg.cookies.hibernate.Order;
import com.gg.cookies.hibernate.User;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface OrdersRepository extends JpaRepository<Order, Long> {

  List<Order> findByUserGroupId(long userGroupId);

}
