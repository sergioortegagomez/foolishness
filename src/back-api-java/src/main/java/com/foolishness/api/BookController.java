package com.foolishness.api;

import java.util.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.SimpleMongoDbFactory;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import com.mongodb.Mongo;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.BasicDBObjectBuilder;
import org.bson.Document;
import org.bson.types.ObjectId;

@RestController
@RequestMapping("/book")
public class BookController {

    private final String DATABASE_NAME = "mydb";

    @GetMapping(value = "/list")
    @ResponseBody
    public String bookList() {
        System.out.println("/book/list");
        MongoOperations mongoOps = new MongoTemplate(new SimpleMongoDbFactory(new Mongo("mongodb"), DATABASE_NAME));
        DBCollection bookCollection = mongoOps.getCollection("books");

        DBCursor cursor = bookCollection.find();
        String value = "[";
        while (cursor.hasNext()) {
            final DBObject obj = cursor.next();
            if (value.length() > 1) {
                value = value + ", ";
            }
            value = value + "{ \"title\": \"" + obj.get("title") + "\", \"isbn\": \"" + obj.get("isbn") + "\", \"pages\": \"" + obj.get("pages") + "\", \"author\": \"" + obj.get("author") + "\", \"title\": \"" + value.get("title") + "\" }";
        }
        return value + "]";
    }

    @GetMapping(value = "/count")
    @ResponseBody
    public Map<String, Object> bookCount() {
        System.out.println("/book/count");
        MongoOperations mongoOps = new MongoTemplate(new SimpleMongoDbFactory(new Mongo("mongodb"), DATABASE_NAME));
        DBCollection bookCollection = mongoOps.getCollection("books");
        return Collections.singletonMap("total", bookCollection.find().count());
    }

    @PostMapping(value = "/create")
    @ResponseBody
    public Map<String, Object> bookCreate(@RequestBody BookForm bookForm) {
        System.out.println("/book/create");
        boolean done = true;
        try {
            MongoOperations mongoOps = new MongoTemplate(new SimpleMongoDbFactory(new Mongo("mongodb"), DATABASE_NAME));
            DBCollection bookCollection = mongoOps.getCollection("books");
            
            bookCollection.insert(BasicDBObjectBuilder.start()
                .add("_id", new ObjectId())
                .add("title", bookForm.getTitle())
                .add("isbn", bookForm.getIsbn())
                .add("pages", bookForm.getPages())
                .add("author", bookForm.getAuthor())
            .get());
        } catch (Exception e) {
            done = false;
        }
        return Collections.singletonMap("insertedCount", done ? 1 : 0 );
    }

    @DeleteMapping(value = "/drop")
    @ResponseBody
    public Map<String, Object> bookDrop() {
        System.out.println("/book/drop");
        boolean done = true;
        try {
            MongoOperations mongoOps = new MongoTemplate(new SimpleMongoDbFactory(new Mongo("mongodb"), DATABASE_NAME));
            mongoOps.dropCollection("books");
        } catch (Exception e) {
            done = false;
        }
        return Collections.singletonMap("status", done);
    }
}