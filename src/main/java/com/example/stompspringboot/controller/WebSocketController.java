package com.example.stompspringboot.controller;

import com.example.stompspringboot.entity.ClientMessage;
import com.example.stompspringboot.entity.ServerMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SubscribeMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WebSocketController {

    private Logger logger=LoggerFactory.getLogger(WebSocketController.class);

    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;

    @MessageMapping("/sendTest")
    @SendTo("/topic/subscribeTest")
    public ServerMessage sendDemo(@RequestBody ClientMessage message) {
        logger.info("接收到了信息" + message.getName());
        return new ServerMessage("你发送的消息为:" + message.getName());
    }

    @SubscribeMapping("/subscribeTest")
    public ServerMessage sub() {
        logger.info("XXX用户订阅了我。。。");
        return new ServerMessage("感谢你订阅了我。。。");
    }



//    @MessageMapping("/sendTest")
//    public void ss(@RequestBody ClientMessage message){
//        logger.info(message.getName());
//        simpMessagingTemplate.convertAndSend("/app/subscribeTest",message.getName());
//    }


//    @MessageMapping("/send")
//    public void sendPublicMessage(String msg) {
//        logger.info(msg+"###########################");
//        simpMessagingTemplate.convertAndSend("/topic/public", msg);
//    }
}
