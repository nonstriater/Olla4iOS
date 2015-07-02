//
//  OllaSocket.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-9.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaSocket.h"
#import "Olla4iOS.h"

#import "sys/socket.h"
#import "netinet/in.h"
#import "arpa/inet.h"
#import "netdb.h"

#define READ_BUFFER_SIZE 1024*32  // 32k
#define READ_TMP_BUF_LEN   (READ_BUFFER_SIZE+4096)// 36k


@interface OllaSocket (){
    
    CFSocketRef _socket;
    NSThread *readThread;
    
    //未处理完的缓冲区,消息太大
    //NSMutableString *lineBuffer;// 或者使用下面这种C语言的写法,中文乱码
    unsigned char rbuf[READ_TMP_BUF_LEN];
    ssize_t rlen;
    
}

@property(nonatomic,weak) id delegate;
@property(nonatomic,strong) NSString *host;
@property(nonatomic,assign) UInt16 port;

@end


@implementation OllaSocket


- (id)initWithDelegate:(id)delegate{
    if (self = [super init]) {
        
        //lineBuffer = [[NSMutableString alloc] init];
        _delegate  = delegate;
        rlen = 0;
        [self commonInitial];
    }
    return self;
    
}

- (void)commonInitial{
}


- (void)connectOnHost:(NSString *)host port:(UInt16)port{
    [self connectOnHost:host port:port timeout:60.f];
}

- (void)connectOnHost:(NSString *)host port:(UInt16)port timeout:(NSTimeInterval)timeout
{
    
    if (!_socket || !CFSocketIsValid(_socket)) {
        CFSocketContext context = {0,(__bridge void *)(self),NULL,NULL,NULL};
        _socket = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM, IPPROTO_TCP, kCFSocketConnectCallBack, socketConnectionCallBack, &context);
        if (_socket==NULL || !CFSocketIsValid(_socket)) {
            DDLogError(@"cfsocket create fail");
            [self connectionFailHandler:[[NSError alloc] initWithDomain:@"com.olla.im.invalideSocket" code:-1 userInfo:@{@"message":@"socket error when create socket"}]];
            CFRelease(_socket);
            _socket = NULL;
            return;
        }
    }
    
    // prevent sigpipe crash
    int nosigpipe = 1;
    setsockopt(CFSocketGetNative(_socket), SOL_SOCKET, SO_NOSIGPIPE, &nosigpipe, sizeof(nosigpipe));
    
    if (_socket!=NULL) {
        
        if ([self checkISDomain:host]) {//如果是域名
            DDLogInfo(@"域名host=%@",host);
            host = [self IPFromHost:host];
            if (host==nil) {
                DDLogError(@"域名转ip解析错误");
                // 这里会报ollasocket dealloc的崩溃
                [self connectionFailHandler:[[NSError alloc] initWithDomain:@"com.olla.im.invalideSocket" code:-1 userInfo:@{@"message":@"域名转ip解析错误"}]];
                return;
            }
            DDLogInfo(@"域名转ip:ip=%@",host);
        }
        
        
        struct sockaddr_in addr4;
        memset(&addr4, 0, sizeof(addr4));
        addr4.sin_len = sizeof(addr4);
        addr4.sin_family = AF_INET;
        addr4.sin_addr.s_addr = inet_addr([host UTF8String]);
        addr4.sin_port = htons(port);// 转成网络字节序，不然会造成send崩溃
        
        _host = host;
        _port = port;
        
        // addr4-->NSData
        CFDataRef address = CFDataCreate(kCFAllocatorDefault, (UInt8 *)&addr4, sizeof(addr4));
        if (address == NULL) {
            DDLogError(@"address to data create fail");
            [self connectionFailHandler:[[NSError alloc] initWithDomain:@"com.olla.im.invalideSocket" code:-1 userInfo:@{@"message":@"socket error when create address"}]];
            return;
        }
        //NSZombie_OllaSocket!!
        //_socket 为nil崩溃，这是怎么搞的！
        if (_socket==NULL) {
            DDLogError(@"CFSocketConnectToAddress 发现socket为nil，重新开启连接");
            [self connectionFailHandler:[[NSError alloc] initWithDomain:@"com.olla.im.invalideSocket" code:-1 userInfo:@{@"message":@"CFSocketConnectToAddress 发现socket为nil，重新开始连接"}]];
            return;
            
        }
        CFSocketError status = CFSocketConnectToAddress(_socket, address, timeout);
        if (status != kCFSocketSuccess) {
            DDLogError(@"socket connect to address fail");
            [self connectionFailHandler:[[NSError alloc] initWithDomain:@"com.olla.im.invalideSocket" code:-1 userInfo:@{@"message":@"socket error when connect to address"}]];
            
            CFRelease(address);
            return;
        }
        CFRelease(address);
        
        
        CFRunLoopRef runloop = CFRunLoopGetMain();//CFRunLoopGetCurrent();
        CFRunLoopSourceRef source = CFSocketCreateRunLoopSource(kCFAllocatorDefault, _socket, 0);
        if (source == NULL) {
            NSLog(@"create runloop socket source fail");
            [self connectionFailHandler:[[NSError alloc] initWithDomain:@"com.olla.im.invalideSocket" code:-1 userInfo:@{@"message":@"创建runloop source 失败"}]];
            return;
        }
        CFRunLoopAddSource(runloop, source, kCFRunLoopCommonModes);
        CFRelease(source);
        
    }
    
}


- (BOOL)checkISDomain:(NSString *)string{//检查是否是域名
    
    return 1;
    
}

- (NSString *)IPFromHost:(NSString *)host{
    
    //这个操作要数秒才返回，如果有问题会不会导致页面打不开！！！，如果断网了这里就完蛋了！！
    struct hostent *hostent = gethostbyname([host UTF8String]);
    if (hostent==NULL) {
        DDLogError(@"通过域名获取主机信息失败");
        return nil;
    }
    
    struct in_addr ip_addr;
    memcpy(&ip_addr, hostent->h_addr_list[0], 4);
    char ip[20] = {0};
    inet_ntop(AF_INET, &ip_addr, ip, sizeof(ip));
    
    NSString *ipAddr = [NSString stringWithUTF8String:ip];
    
    return ipAddr;
}



- (void)disconnect{
    
    if (_socket!=NULL && CFSocketIsValid(_socket)) {
        CFSocketInvalidate(_socket);
        CFRelease(_socket);
        _socket = NULL;
    }
    
    if (![readThread isCancelled]) {
        [readThread cancel];
    }
    
}

- (void)dealloc{
    
    [self disconnect];
}

- (BOOL)isValid{
    
    return  (_socket!=NULL)&&CFSocketIsValid(_socket);
}

- (int)portFromSocket{
    
    struct sockaddr_in addr;
    unsigned long length = sizeof(addr);
    //这里socket为nil，就会崩溃
    if (_socket==NULL) {
        DDLogError(@"getsockname() found socket be nil...");
        return -1;
    }
    getsockname(CFSocketGetNative(_socket), (struct sockaddr *)&addr, (socklen_t *)&length);
    int port = ntohs(addr.sin_port);
    return port;
}

// send data
- (void)sendData:(NSData *)data tag:(long)tag{
    
    if (!_socket || !CFSocketIsValid(_socket)) {
        NSLog(@"send data cancel:socket invalide");
        [self connectionFailHandler:[[NSError alloc] initWithDomain:@"com.olla.im.invalideSocket" code:-1 userInfo:@{@"message":@"socket error when send data"}]];
        return ;
    }
    //如果send在等待协议发送数据时断网，send会崩溃
    //解决办法： signal(SIGPIPE,SIG_IGN);  or set MSG_NOSIGNAL on send()
    //CFSocketError sendStatus = CFSocketSendData(_socket, NULL,CFDataCreate(NULL, [data bytes], [data length]), 10);//mem leak!
    CFSocketError sendStatus = CFSocketSendData(_socket, NULL,(__bridge CFDataRef)data, 10);
    if (sendStatus==kCFSocketError) {//
        NSLog(@"socket error : send data error");
        [self connectionFailHandler:[[NSError alloc] initWithDomain:@"com.olla.im.invalideSocket" code:-1 userInfo:@{}]];
        return ;
    }
    
    if ([_delegate respondsToSelector:@selector(socket:didWriteData:tag:)]) {
        [_delegate socket:self didWriteData:data tag:tag];
    }
    
}

- (void)readData:(NSData *)data tag:(long)tag{
    
}


//  private //////////////////////////////////////////////////////

/**
 *  address :  a struct sockaddr
 *  data 为null表示连接成功，连接错误data指向一个 uint32的error code，即错误代码指针
 */
static void socketConnectionCallBack(CFSocketRef socket,CFSocketCallBackType type,CFDataRef address ,const void *data, void *info){
    if (type==kCFSocketConnectCallBack) {
        OllaSocket *mself = (__bridge OllaSocket *)info;
        if (!data) {
            [mself performSelectorOnMainThread:@selector(connectionSuccessHandler) withObject:nil waitUntilDone:NO];
        }else{
            NSError *error = [NSError errorWithDomain:@"com.olla.socket" code:(NSInteger)data userInfo:nil];
            [mself connectionFailHandler:error];
        }
    }
    
}

- (void)connectionFailHandler:(NSError *)error{
    
    [self performSelectorOnMainThread:@selector(connectionFailHandlerOnMainThread:) withObject:error waitUntilDone:NO];
}

- (void)connectionFailHandlerOnMainThread:(NSError *)error{
    
    [self disconnect];
    
    if ([_delegate respondsToSelector:@selector(socketDidDisConnect:withError:)]) {
        [_delegate socketDidDisConnect:self withError:error];
    }
    
}


- (void)connectionSuccessHandler{
    [self startReadThread];
    DDLogInfo(@"local addr:ip=(:%d)",[self port]);//网络慢时,获取port操作也比较耗时，其次是login操作
    if ([_delegate respondsToSelector:@selector(socket:didConnectToHost:port:)]) {
        [_delegate socket:self didConnectToHost:_host port:_port];
    }
}


- (void)startReadThread{
    
    @autoreleasepool {
        
        if (!readThread && ![readThread isCancelled]) {
            [readThread cancel];
        }
        
        @try {
            readThread = [[NSThread alloc] initWithTarget:self selector:@selector(readRunLoop) object:nil];
            readThread.name = @"com.olla.im.read";
            [readThread start];
        }
        @catch (NSException *exception) {// 定义异常类
            NSLog(@"catch recv() exception");
        }
        @finally {
            
        }
        
    }
}

- (BOOL)readThreadIsActive{
    
    if ([readThread isCancelled]) {
        return NO;
    }
    
    if (_socket==NULL) {
        return NO;
    }
    
    if (!CFSocketIsValid(_socket)) {
        return NO;
    }
    
    if (CFSocketGetNative(_socket)<0) {//-1 error
        return NO;
    }
    
    return YES;
    
}

- (void)readRunLoop{
    
    while([self readThreadIsActive]){
 
        unsigned char buffer[READ_BUFFER_SIZE];
        bzero(buffer, READ_BUFFER_SIZE);
        
        // 加一个select好处：
        // 1. 没消息时阻塞  2.服务器断开连接时判断准确
        
        
        //        FD_ZERO(&readfds);
        //        FD_SET(CFSocketGetNative(_socket), &readfds);
        //        timeout.tv_sec = 3l;
        //        timeout.tv_usec = 0l;
        //        int sel = select(CFSocketGetNative(_socket)+1, &readfds, NULL, NULL, &timeout);
        //        if (sel<0) {
        //            break;
        //        }
        
        // recv 没消息时本身就是阻塞的，这里不会一直循环
        // 1. 有数据时返回，2. socket出问题时，返回-1
        // 如果接收缓冲>read_buffer_size, recv()要多掉几次才能把数据copy万
        ssize_t size = recv(CFSocketGetNative(_socket), buffer, READ_BUFFER_SIZE, 0);
        if (size>0) {
            buffer[size]='\0';
            // buffer里面可能有多条message，我们要用"\r\n"把它们分隔开，一条条传上去
            [self readLine:buffer size:size];
            
        }else if(size==0){
            
            
        }else{
            NSLog(@"recv() return<0 ");// throw,在调用Catch
            break;
        }
        
    }
    
    // 读socket线程退出：可能线程cancel, socket断开
    NSLog(@"socket read thread exit, recv() maybe return<0");
    if (_delegate) {
        [_delegate socketDidDisConnect:self withError:nil];
    }
    
    if ([[NSThread currentThread] isCancelled]) {
        [NSThread exit];
    }
    
}

// buffer里面可能有多条message，我们要用"\r\n"把它们分隔开，一条条传上去,用递归实现
// 使用消息边界的做法，对于消息体大的时候效率会有所影响，毕竟需要每个字符检查是否是边界符号
/**
 1. buffer里面是完整的带分隔符的几条消息 如 mes    age1\r\nmessage2\r\n
 2. 消息比较大，整个buffer只是消息的一部分，也就是读不到\n
 3.
 */

- (void)readLine:(unsigned char *)buffer size:(size_t)size{
    
    NSString *line=nil;
    
    unsigned char *h;
    unsigned char *p;
    
    ssize_t prelen;
    
    if ( rlen > 0 ) {
        line = [NSString stringWithFormat:@"%s",rbuf];
    }
    
    h=buffer;
    p=buffer;
    
    for ( int i = 0; i < size; i++ ) {
        
        if ( '\n' == *p ) {
            
            *p='\0';
            
            if ( nil!=line ) {
                
                line = [line stringByAppendingString:[NSString stringWithFormat:@"%s",h] ];
                
            } else {
                
                //line = [NSString stringWithFormat:@"%s",h];// 乱码！！
                line = [NSString stringWithCString:(const char *)h encoding:NSUTF8StringEncoding];
                
            }
            //传出去
            
            [self performSelectorOnMainThread:@selector(getLineHandle:) withObject:line waitUntilDone:YES];
            [NSThread sleepForTimeInterval:0.5];//休息0.5s
            
            line = nil;
            
            
            h = p+1;
            
        }// if ( '\n' == *p )
        
        p++;
        
    }// for ( int i = 0; i < _rlen; i++ )
    
    if ('\0'==*h ) {
        
        rlen = 0;
        
    } else {
        //缓冲区还有数据
        
        prelen = p-h;
        
        if ( prelen>0 && prelen < READ_TMP_BUF_LEN - rlen ) {
            memcpy(rbuf+rlen, h, prelen );
            rlen += prelen;
            rbuf[size]='\0';
        } else {
            NSLog(@"缓冲区太小，设置大点");
            
        }
        
    }
    
    
}

- (void)getLineHandle:(NSString *)line{
    
    if (_delegate) {
        [_delegate socket:self didReadData:[line dataUsingEncoding:NSUTF8StringEncoding] tag:0];
    }
    
}



@end
