package com.gg.cookies.hibernate;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "T_USER")
public class UserGroup {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private long userGroupId;

  private String userGroupName;

  public long getUserGroupId() {
    return userGroupId;
  }

  public void setUserGroupId(long userGroupId) {
    this.userGroupId = userGroupId;
  }

  public String getUserGroupName() {
    return userGroupName;
  }

  public void setUserGroupName(String userGroupName) {
    this.userGroupName = userGroupName;
  }
}
