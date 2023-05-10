package com.example.springbootproject;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.boot.context.ApplicationPidFileWriter;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

//@SpringBootApplication(exclude = {
//		org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class,
//		org.springframework.boot.actuate.autoconfigure.security.servlet.ManagementWebSecurityAutoConfiguration.class}
//)
@SpringBootApplication(exclude = {SecurityAutoConfiguration.class})
@Slf4j
public class SpringbootProjectApplication implements CommandLineRunner {

//	–spring.config.location=file://{path to file}.

    public static void main(String[] args) {
        System.setProperty("spring.devtools.restart.enabled", "false");

        SpringApplication application = new SpringApplication(SpringbootProjectApplication.class);
        application.addListeners(new ApplicationPidFileWriter());


//        https://stackoverflow.com/questions/31619383/applicationpidfilewriter-doesnt-produce-pid-file-on-spring-boot
        ConfigurableApplicationContext applicationContext = application.run(args);
//		ConfigurableApplicationContext applicationContext = SpringApplication.run(SpringbootProjectApplication.class, args);
//		applicationContext.start();
//		applicationContext.stop();
//		applicationContext.refresh();
//		applicationContext.close();
    }

    @Override
    public void run(String... args) {
        log.info("EXECUTING : command line runner");

        for (int i = 0; i < args.length; ++i) {
            log.info("args[{}]: {}", i, args[i]);
        }
    }
}
