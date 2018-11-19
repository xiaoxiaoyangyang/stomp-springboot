package com.example.stompspringboot.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.annotation.sql.DataSourceDefinition;


/**
 *
 * @ClassName: ClientMessage
 * @Description: 客户端发送消息实体
 * @author cheng
 * @date 2017年9月27日 下午4:24:11
 */


@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClientMessage {
    private String name;
}
