package com.example.springbootproject.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

//https://stackoverflow.com/questions/52999004/subscribemapping-vs-messagemapping
@Configuration
@EnableWebSocketMessageBroker
//@Profile("stomp-web-socket-memory")
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    // for regular connection ws://localhost:8443/mywebsockets
    /*
    curl --include \
            --no-buffer \
            --header "Connection: Upgrade" \
            --header "Upgrade: websocket" \
            --header "Host: localhost" \
            --header "Origin: http://localhost:8080" \
            --header "Sec-WebSocket-Key: SGVsbG8sIHdvcmxkIQ==" \
            --header "Sec-WebSocket-Version: 13" \
    http://localhost:8080/mywebsockets
    */

    // for secure connection wss://localhost:8443/mywebsockets
    /*
    curl -k --include \
        --no-buffer \
        --header "Connection: Upgrade" \
        --header "Upgrade: websocket" \
        --header "Host: localhost" \
        --header "Origin: https://localhost:8443" \
        --header "Sec-WebSocket-Key: SGVsbG8sIHdvcmxkIQ==" \
        --header "Sec-WebSocket-Version: 13" \
    https://localhost:8443/mywebsockets
    */
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // to be used without SockJS; to test with curl like the command above
        registry.addEndpoint("/mywebsockets")
                .setAllowedOrigins("http://localhost:8080");

        // to be used with SockJS
        registry.addEndpoint("/mywebsockets")
                .setAllowedOrigins("http://localhost:8080").withSockJS();

//        registry.addEndpoint("/mywebsockets")
//                .setAllowedOrigins("https://localhost:8443");
//
//        // to be used with SockJS
//        registry.addEndpoint("/mywebsockets")
//                .setAllowedOrigins("https://localhost:8443").withSockJS();
//
//
    }


    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {

        // Creates the in-memory message broker with one or more destinations
        config.enableSimpleBroker("/topic/", "/queue/");

        // Defines the prefix app that is used to filter destinations handled by methods annotated with @MessageMapping
        config.setApplicationDestinationPrefixes("/app");
    }

}