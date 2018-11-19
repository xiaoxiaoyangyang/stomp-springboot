package com.example.stompspringboot.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @ClassName: ServerMessage
 * @Description: 服务端发送消息实体
 * @author cheng
 * @date 2017年9月27日 下午4:25:26
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ServerMessage {
    private String responseMessage;
}
