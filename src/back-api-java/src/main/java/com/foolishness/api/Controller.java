package com.foolishness.api;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.SimpleMongoDbFactory;
import com.mongodb.Mongo;

@RestController
public class Controller {

    @RequestMapping("/")
    String hello() {
        System.out.println("/");
        return "{\"message\":\"hello world from java\"}";
    }

    @RequestMapping("/randomnumberremove")
    String ramdomNumberRemove() {
        System.out.println("/randomnumberremove");
        MongoOperations mongoOps = new MongoTemplate(new SimpleMongoDbFactory(new Mongo("mongodb"), "foolishness"));
        mongoOps.dropCollection("randomNumbers");
        return "{\"message\":\"ok\"}";
    }
}