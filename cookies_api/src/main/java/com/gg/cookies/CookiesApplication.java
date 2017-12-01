package com.gg.cookies;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import java.util.concurrent.Executor;

@EnableAsync
@SpringBootApplication
public class CookiesApplication {

  public static void main(String[] args) {
    SpringApplication.run(CookiesApplication.class, args);
  }

  @Bean
  public Executor asyncExecutor() {
    ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
    executor.setCorePoolSize(Constants.CORE_POOL_SIZE);
    executor.setMaxPoolSize(Constants.MAX_POOL_SIZE);
    executor.setThreadNamePrefix(Constants.THREAD_NAME_PREFIX);
    executor.initialize();
    return executor;
  }
}
