package com.foolishness.api;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller {

    @RequestMapping("/")
    String hello() {
        System.out.println("/");
        return "{\"message\":\"hello world from java\"}";
    }

}