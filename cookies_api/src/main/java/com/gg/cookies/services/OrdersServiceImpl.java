package com.gg.cookies.services;

import com.gg.cookies.hibernate.Order;
import com.gg.cookies.hibernate.OrderDetail;
import java.util.List;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrdersServiceImpl implements OrdersService {
  @Autowired
  OrdersRepository ordersRepository;

  @Autowired
  OrderDetailsRepository orderDetailsRepository;

  @Override
  public void saveOrder(Order order) {
    ordersRepository.save(order);
  }

  @Override
  public void saveOrderDetail(OrderDetail orderDetail) {
    orderDetailsRepository.save(orderDetail);
  }

  @Override
  public List<Order> selectOrders(long userGroupId) {
    return ordersRepository.findByUserGroupId(userGroupId);
  }

  @Override
  public Order selectOrder(long orderId) {
    return ordersRepository.findOne(orderId);
  }

  @Override
  public OrderDetail getOrderDetail(long orderDetailId) {
    return orderDetailsRepository.findOne(orderDetailId);
  }

  @Override
  @Transactional
  public void updateOrderDetail(boolean isRemoved, long orderDetailId) {
    orderDetailsRepository.updateOrderDetailIsRemoved(isRemoved, orderDetailId);
  }

  @Override
  public void printImageMetadata(String base64img) throws Exception {

  }
}
