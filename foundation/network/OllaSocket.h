//
//  OllaSocket.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-9.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,OllaSocketErrorCode){
    
    SocketErrorServerRespondDisconnect = -2,
    SocketErrorHeartbeatTimeout = -1,
    SocketErrorHandShake = 0,
    SocketErrorUnauthorized = 1
    
};

@interface OllaSocket : NSObject

/**
 * 1. 超时时间，多久没收到数据就表示socket断开了
 * 2. 每个ns发一个心跳包，没有respond表示socke断开了
 */
@property(nonatomic,assign) NSTimeInterval heartbeatTimeout;

- (id)initWithDelegate:(id)delegate;

- (void)connectOnHost:(NSString *)host port:(UInt16)port;
- (void)connectOnHost:(NSString *)host port:(UInt16)port timeout:(NSTimeInterval)timeout;
- (void)disconnect;

- (void)sendData:(NSData *)data tag:(long)tag;
- (void)readData:(NSData *)data tag:(long)tag;

- (BOOL)isValid;

- (int)portFromSocket;// 获得当前连接的本地port

@end


@protocol OllaSocketDelegate <NSObject>
@optional
- (void)socket:(OllaSocket *)socket didConnectToHost:(NSString *)host port:(UInt16)port;
- (void)socketDidDisConnect:(OllaSocket *)socket withError:(NSError *)error;

- (void)socket:(OllaSocket *)socket didReadData:(NSData *)data tag:(long)tag;
- (void)socket:(OllaSocket *)socket didWriteData:(NSData *)data tag:(long)tag;

@end

