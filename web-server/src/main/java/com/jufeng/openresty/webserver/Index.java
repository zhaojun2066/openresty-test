package com.jufeng.openresty.webserver;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by jufeng on 17-12-7.
 */
@RestController
public class Index {

    @RequestMapping("/")
    public String index(){
        return "Hello index";
    }

    @RequestMapping("/hello")
    public String hello(String a ,String b){
        return "Hello from upstream a="+a;
    }


    @RequestMapping("/hello/v1")
    public String hellov1(String a ,String b){
        System.out.println("aaa");
        return "Hello v1";
    }

    @RequestMapping("/hello/v2")
    public String hellov2(String a ,String b){
        return "Hello v2";
    }

    @RequestMapping("/hello/v0")
    public String hellov0(String a ,String b){
        return "Hello v0";
    }
}
