package com.gg.cookies.services;

import com.gg.cookies.hibernate.Order;
import com.gg.cookies.hibernate.OrderDetail;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface OrderDetailsRepository extends JpaRepository<OrderDetail, Long> {

  @Modifying
  @Query("update OrderDetail od set od.isRemoved = ?1 where od.orderDetailId = ?2")
  int updateOrderDetailIsRemoved(boolean isRemoved, long id);
}
