//
//  WDSocialManager.m
//  WDSocialSDK
//
//  Created by 何伟东 on 2017/7/18.
//  Copyright © 2017年 何伟东. All rights reserved.
//

#import "WDSocialManager.h"
#import <TencentOpenAPI/TencentOAuth.h>

static NSString *tencentAppKey = nil;
static NSString *weiboAppKey = nil;
static NSString *wechatAppKey = nil;

static WDSocialManager *socialManager = nil;

@interface WDSocialManager()<TencentSessionDelegate>{
    
}
@property(nonatomic,copy) WDWechatCompleteBlock wechatCompleteBlock;
@property(nonatomic,copy) WDTencentCompleteBlock tencentCompleteBlock;
@property(nonatomic,copy) WDWeiboCompleteBlock weiboCompleteBlock;
@property(nonatomic,strong) WDTencentDelegateImplement *tencentDelegateImplement;

@property(nonatomic,strong) TencentOAuth *tencentOAuth;

@end
@implementation WDSocialManager


/**
 实例

 @return <#return value description#>
 */
+(WDSocialManager*)manager{
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
    [WDSocialManager manager].tencentOAuth = [[TencentOAuth alloc] initWithAppId:appKey andDelegate:self];
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
    [WXApi registerApp:appKey];
}


/**
 处理通过URL启动App时传递的数据

 @param url <#url description#>
 @return <#return value description#>
 */
+(BOOL)handleOpenURL:(NSURL *)url{
    if ([WXApi handleOpenURL:url delegate:[WDSocialManager manager]]) {
        return YES;
    }else if ([WeiboSDK handleOpenURL:url delegate:[WDSocialManager manager]]){
        return YES;
    }else if([TencentOAuth HandleOpenURL:url]){
        return YES;
    }else if([QQApiInterface handleOpenURL:url delegate:[WDSocialManager manager].tencentDelegateImplement]){
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
    if (self.weiboCompleteBlock) {
        self.weiboCompleteBlock(response);
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
    if (self.wechatCompleteBlock) {
        self.wechatCompleteBlock(resp);
    }
}






/**
 分享信息到微信
 
 @param messageReq <#messageReq description#>
 @param block <#block description#>
 */
-(void)shareMessageToWechat:(BaseReq*)req completeBlock:(WDWechatCompleteBlock)block{
    [self setWechatCompleteBlock:block];
    [WXApi sendReq:req];
}


/**
 分享信息到微博
 
 @param messageReq <#messageReq description#>
 @param block <#block description#>
 */
-(void)shareMessageToWeibo:(WBBaseRequest*)messageReq completeBlock:(WDWeiboCompleteBlock)block{
    [self setWeiboCompleteBlock:block];
    [WeiboSDK sendRequest:messageReq];
}

/**
 分享信息到腾讯
 
 @param messageReq <#messageReq description#>
 @param block <#block description#>
 */
-(void)shareMessageToTencent:(QQBaseReq*)messageReq completeBlock:(WDTencentCompleteBlock)block{
    [self setTencentCompleteBlock:block];
    [QQApiInterface sendReq:messageReq];
}



/**
 腾讯登录授权

 @param req <#req description#>
 @param viewController <#viewController description#>
 @param didLogin 登录成功后的回调
 @param didNotLogin 登录失败后的回调
 @param didNotNetWork 登录时网络有问题的回调
 */
-(void)tencentAuthReq:(SendAuthReq*)req
       viewController:(UIViewController*)viewController
             didLogin:(void(^)(TencentOAuth *auth))didLogin
          didNotLogin:(void(^)())didNotLogin
        didNotNetWork:(void(^)())didNotNetWork{
    
}

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{
    
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    
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
    if (self.socialManager.tencentCompleteBlock) {
        self.socialManager.tencentCompleteBlock(resp);
    }
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response{
    
}

@end
