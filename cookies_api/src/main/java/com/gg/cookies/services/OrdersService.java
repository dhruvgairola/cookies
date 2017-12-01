package com.gg.cookies.services;

import com.gg.cookies.hibernate.Order;
import com.gg.cookies.hibernate.OrderDetail;
import com.gg.cookies.hibernate.User;
import java.io.IOException;
import java.util.List;

public interface OrdersService {
    void saveOrder(Order order);

    void saveOrderDetail(OrderDetail orderDetail);

    List<Order> selectOrders(long userGroupId);

    Order selectOrder(long orderId);

    OrderDetail getOrderDetail(long orderDetailId);

    void updateOrderDetail(boolean isRemoved, long orderDetailId);

    void printImageMetadata(String base64img) throws Exception;
}
