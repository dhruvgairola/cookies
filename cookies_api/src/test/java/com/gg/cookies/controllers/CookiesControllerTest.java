package com.gg.cookies.controllers;

import static org.mockito.MockitoAnnotations.initMocks;

import com.gg.cookies.Constants;
import com.gg.cookies.hibernate.Order;
import com.gg.cookies.hibernate.OrderDetail;
import com.gg.cookies.services.OrdersService;
import com.gg.cookies.services.UsersService;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.FileReader;
import java.io.Reader;
import javax.imageio.ImageIO;
import javax.xml.bind.DatatypeConverter;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.ClassPathResource;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class CookiesControllerTest {

  @Autowired
  private UsersService usersService;
  @Autowired
  private OrdersService ordersService;

  @Test
  public void testGetUsers() throws Exception {
    System.out.println(usersService.getUsers(1));
  }

  @Test
  public void testAddOrderDetail() throws Exception {

    Order or = new Order();
    or.setUserGroupId(1);
    ordersService.saveOrder(or);

    BufferedImage img = ImageIO.read(ClassLoader.getSystemResource(Constants.OREOS_IMG));
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    ImageIO.write(img, "jpg", baos);

    OrderDetail od = new OrderDetail();
    od.setImage(DatatypeConverter.printBase64Binary(baos.toByteArray()));
    od.setOrder(or);
    od.setUserId(1);
    ordersService.saveOrderDetail(od);
  }

  @Test
  public void testGetOrders() throws Exception {
    System.out.println(ordersService.selectOrders(1));
  }

  @Test
  public void testToggleIsRemoved() throws Exception {
    ordersService.updateOrderDetail(true, 95);
  }

  @Test
  public void testGetImageMetadata() throws Exception {
    BufferedImage img = ImageIO.read(ClassLoader.getSystemResource(Constants.OREOS_IMG));
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    ImageIO.write(img, "jpg", baos);
    String str = DatatypeConverter.printBase64Binary(baos.toByteArray());
    System.out.println(str);
//      ordersService.printImageMetadata(str);
  }
}
