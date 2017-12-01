package com.gg.cookies.controllers;

import com.gg.cookies.Constants;
import com.gg.cookies.hibernate.Order;
import com.gg.cookies.hibernate.OrderDetail;
import com.gg.cookies.hibernate.User;
import com.gg.cookies.hibernate.UserGroup;
import com.gg.cookies.services.OrdersService;
import com.gg.cookies.services.UsersService;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Set;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping(Constants.COOKIES_ENDPOINT)
public class CookiesController {

  @Autowired
  OrdersService ordersService;
  @Autowired
  UsersService usersService;

  @RequestMapping(value = "/addOrder", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
  @ResponseStatus(value = HttpStatus.OK)
  public Order addOrder(@RequestBody Order order) {
    ordersService.saveOrder(order);
    pingSocketServer("newOrder", order.getOrderId() + "");
    return order;
  }


  @RequestMapping(value = "/addOrderDetail", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
  @ResponseStatus(value = HttpStatus.OK)
  public OrderDetail addOrderDetail(@RequestBody OrderDetail orderDetail) {

    String itemName = "Cookies and cream";
    if(orderDetail.getItemName() != null && !orderDetail.getItemName().isEmpty()) {
      itemName = orderDetail.getItemName();
    }

    orderDetail.setItemName(itemName);
    ordersService.saveOrderDetail(orderDetail);
    System.out.println(orderDetail);

    pingSocketServer("newItem", orderDetail.getItemName() + "&userId=" + orderDetail.getUserName());
    return orderDetail;
  }

  private void pingSocketServer(String event, String data) {
    RestTemplate restTemplate = new RestTemplate();
    String fooResourceUrl = "";

    if(data == null) {
      fooResourceUrl =
          "http://54.159.150.45:3000/" + event;
    } else {
      fooResourceUrl =
          "http://54.159.150.45:3000/" + event + "?" + event + "=" + data;
    }

    ResponseEntity<String> response
        = restTemplate.getForEntity(fooResourceUrl, String.class);

  }

  @RequestMapping(value = "/getOrders", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
  @ResponseStatus(value = HttpStatus.OK)
  public List<Order> getOrders(@RequestBody Order order) {
    List<Order> orders = ordersService.selectOrders(order.getUserGroupId());

    for (Order single : orders) {
      Set<OrderDetail> ods = single.getOrderDetails();

      for (OrderDetail od : ods) {
        od.setOrder(null);
      }
    }

    return orders;
  }


  @RequestMapping(value = "/getOrder", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
  @ResponseStatus(value = HttpStatus.OK)
  public Order getOrder(@RequestBody Order order) {
    Order single = ordersService.selectOrder(order.getOrderId());

    Set<OrderDetail> ods = single.getOrderDetails();

    for (OrderDetail od : ods) {
      od.setOrder(null);
    }

    return single;
  }

  @RequestMapping(value = "/getUser", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
  @ResponseStatus(value = HttpStatus.OK)
  public User getUser(@RequestBody User user) {
    return usersService.getUser(user.getUserId());
  }


  @RequestMapping(value = "/getUsers", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
  @ResponseStatus(value = HttpStatus.OK)
  public List<User> getUsers(@RequestBody User user) {
    return usersService.getUsers(user.getUserGroupId());
  }

  @RequestMapping(value = "/toggleOrderDetailRemoved", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
  @ResponseStatus(value = HttpStatus.OK)
  public void toggleOrderDetailRemoved(@RequestBody OrderDetail orderDetail) {
    OrderDetail od = ordersService.getOrderDetail(orderDetail.getOrderDetailId());
    od.setIsRemoved(orderDetail.getIsRemoved());
    pingSocketServer("updateList", null);
    ordersService.updateOrderDetail(orderDetail.getIsRemoved(), orderDetail.getOrderDetailId());
  }
}