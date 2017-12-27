package com.jufeng.openresty.webserver;

import com.google.common.net.HostAndPort;
import com.orbitz.consul.AgentClient;
import com.orbitz.consul.Consul;
import com.orbitz.consul.model.agent.ImmutableRegistration;
import com.orbitz.consul.model.agent.Registration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

/**
 * Created by jufeng on 17-12-7.
 */
@Configuration
@ComponentScan
@EnableAutoConfiguration
public class ConsulWeb {

    public static void main(String [] args){
        SpringApplication.run(ConsulWeb.class, args);
       // registerAndDe();
    }

    public static void registerAndDe(){
        Consul consul = Consul.builder().withHostAndPort(HostAndPort.fromString("127.0.0.1:8500")).build();
        final AgentClient agentClient = consul.agentClient();
        ImmutableRegistration.Builder builder = ImmutableRegistration.builder();
        String service = "demo_tomcat";
        String address = "127.0.0.1";
        String tag = "dev";
        int port = 8888;
        final String serviceId = address+":"+port;
        builder.id(serviceId).name(service).address(address).port(port).addTags(tag).
                //添加健康检查
                addChecks(Registration.RegCheck.http("http://127.0.0.1:8888",10));
        agentClient.register(builder.build());

        //挂掉的时候 ，从注册中心摘抄
        Runtime.getRuntime().addShutdownHook(new Thread(){

            public void run() {
                agentClient.deregister(serviceId);
            }
        });
    }

}
