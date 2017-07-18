//
//  WDSocialManager.m
//  WDSocialSDK
//
//  Created by 何伟东 on 2017/7/18.
//  Copyright © 2017年 何伟东. All rights reserved.
//

#import "WDSocialManager.h"


static NSString *tencentAppKey = nil;
static NSString *weiboAppKey = nil;
static NSString *wechatAppKey = nil;

static WDSocialManager *socialManager = nil;

@interface WDSocialManager(){
    
}
@property(nonatomic,strong) WDTencentDelegateImplement *tencentDelegateImplement;

@end
@implementation WDSocialManager

+(WDSocialManager*)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socialManager = [[WDSocialManager alloc] init];
    });
    return socialManager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _tencentDelegateImplement = [[WDTencentDelegateImplement alloc] init];
        [_tencentDelegateImplement setSocialManager:self];
    }
    return self;
}
/**
 初始化QQ
 
 @param appKey <#appKey description#>
 @param redirectURL <#redirectURL description#>
 */
+(void)setTencentAppKey:(NSString*)appKey redirectURL:(NSString*)redirectURL{
    
}

/**
 初始化微博
 
 @param appKey <#appKey description#>
 @param redirectURL <#redirectURL description#>
 */
+(void)setWeiboAppKey:(NSString*)appKey redirectURL:(NSString*)redirectURL{
    [WeiboSDK registerApp:appKey];
}

/**
 初始化微信
 
 @param appKey <#appKey description#>
 @param redirectURL <#redirectURL description#>
 */
+(void)setWeChatAppKey:(NSString*)appKey redirectURL:(NSString*)redirectURL{
    
}

-(BOOL)handleOpenURL:(NSURL *)url delegate:(id<WeiboSDKDelegate>)delegate{
    if ([WXApi handleOpenURL:url delegate:self]) {
        return YES;
    }else if ([WeiboSDK handleOpenURL:url delegate:self]){
        return YES;
    }else if([TencentOAuth HandleOpenURL:url]){
        return YES;
    }else if([QQApiInterface handleOpenURL:url delegate:_tencentDelegateImplement]){
        return YES;
    }
    return NO;
}


/**
 收到一个来自微博客户端程序的请求
 
 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]){//发送结果
        
    }else if ([response isKindOfClass:WBAuthorizeResponse.class]){//授权结果
        
    }
}


/*! @brief 收到一个来自微信的请求，第三方应用程序处理完后调用sendResp向微信发送结果
 *
 * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
-(void) onReq:(BaseReq*)req{
    
}


/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp 具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp{
    
}


@end



@implementation WDTencentDelegateImplement

/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req{
    
}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp{
    
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response{
    
}

@end
