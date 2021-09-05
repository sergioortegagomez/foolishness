package com.foolishness.api;

import java.util.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.http.MediaType;

@RestController
public class Controller {


    @RequestMapping(value = "/", produces = MediaType.APPLICATION_JSON_VALUE, method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> hello() {
        System.out.println("/");
        return Collections.singletonMap("message", "hello world from java");
    }


}