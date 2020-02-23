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

    @RequestMapping("/voteremove")
    String voteRemove() {
        System.out.println("/voteremove");
        MongoOperations mongoOps = new MongoTemplate(new SimpleMongoDbFactory(new Mongo("mongodb"), "foolishness"));
        mongoOps.dropCollection("votes");
        return "{\"message\":\"ok\"}";
    }
}