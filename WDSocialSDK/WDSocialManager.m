//
//  WDSocialManager.m
//  WDSocialSDK
//
//  Created by 何伟东 on 2017/7/18.
//  Copyright © 2017年 何伟东. All rights reserved.
//

#import "WDSocialManager.h"


typedef void(^WDTencentDidLoginBlock)(TencentOAuth *tencentOAuth);
typedef void(^WDCommonNOParamBlock)();
typedef void(^WDTencentDidNotLoginBlock)(BOOL cancle);
typedef void(^WDWechatLoginFinishBlock)(SendAuthResp *resp);

static WDSocialManager *socialManager = nil;
@interface WDSocialManager()<TencentSessionDelegate>{
    
}
@property(nonatomic,copy) WDWechatCompleteBlock wechatCompleteBlock;
@property(nonatomic,copy) WDTencentCompleteBlock tencentCompleteBlock;
@property(nonatomic,copy) WDWeiboCompleteBlock weiboCompleteBlock;
@property(nonatomic,strong) WDTencentDelegateImplement *tencentDelegateImplement;


/**
 QQ授权登录相关block
 */
@property(nonatomic,copy) WDTencentDidLoginBlock tencentDidLoginBlock;
@property(nonatomic,copy) WDTencentDidNotLoginBlock tencentdidNotLoginBlock;
@property(nonatomic,copy) WDCommonNOParamBlock tencentdidNotNetWorkBlock;

/**
 微信登录完成block
 */
@property(nonatomic,copy) WDWechatLoginFinishBlock wechatLoginFinishBlock;


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
 */
+(void)setTencentAppKey:(NSString*)appKey{
    [WDSocialManager manager].tencentOAuth = [[TencentOAuth alloc] initWithAppId:appKey andDelegate:[WDSocialManager manager]];
}

/**
 初始化微博
 
 @param appKey <#appKey description#>
 */
+(void)setWeiboAppKey:(NSString*)appKey{
    [WeiboSDK registerApp:appKey];
}

/**
 初始化微信
 
 @param appKey <#appKey description#>
 */
+(void)setWeChatAppKey:(NSString*)appKey{
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
        self.weiboCompleteBlock = nil;
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
        self.wechatCompleteBlock = nil;
    }else if (self.wechatLoginFinishBlock){
        self.wechatLoginFinishBlock((SendAuthResp*)resp);
        self.wechatLoginFinishBlock = nil;
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
 分享信息到QQ
 
 @param messageReq <#messageReq description#>
 @param block <#block description#>
 */
-(void)shareMessageToQQ:(QQBaseReq*)messageReq completeBlock:(WDTencentCompleteBlock)block{
    [self setTencentCompleteBlock:block];
    [QQApiInterface sendReq:messageReq];
}

/**
 分享信息到QQ空间

 @param messageReq <#messageReq description#>
 @param block <#block description#>
 */
-(void)shareMessageToQZone:(QQBaseReq*)messageReq completeBlock:(WDTencentCompleteBlock)block{
    [self setTencentCompleteBlock:block];
    [QQApiInterface SendReqToQZone:messageReq];
}

/**
 腾讯登录授权

 @param permissions <#permissions description#>
 @param didLogin 登录成功后的回调
 @param didNotLogin 登录失败后的回调
 @param didNotNetWork 登录时网络有问题的回调
 */
-(void)tencentAuthPermissions:(NSArray*)permissions
             didLogin:(void(^)(TencentOAuth *auth))didLogin
          didNotLogin:(void(^)(BOOL cancle))didNotLogin
        didNotNetWork:(void(^)())didNotNetWork{
    [self setTencentDidLoginBlock:didLogin];
    [self setTencentdidNotLoginBlock:didNotLogin];
    [self setTencentdidNotNetWorkBlock:didNotNetWork];
    [self.tencentOAuth authorize:permissions inSafari:![QQApiInterface isQQInstalled]];
    
}

/**
 微信登录授权

 @param req <#req description#>
 @param viewController <#viewController description#>
 @param finishBlock <#finishBlock description#>
 */
-(void)wechatAuthReq:(SendAuthReq*)req
      viewController:(UIViewController*)viewController
         finishBlock:(void(^)(SendAuthResp *resp))finishBlock{
    [self setWechatLoginFinishBlock:finishBlock];
    [WXApi sendAuthReq:req viewController:viewController delegate:self];
}


/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{
    if (self.tencentDidLoginBlock) {
        self.tencentDidLoginBlock(self.tencentOAuth);
        self.tencentDidLoginBlock = nil;
    }
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (self.tencentdidNotLoginBlock) {
        self.tencentdidNotLoginBlock(cancelled);
        self.tencentdidNotLoginBlock = nil;
    }
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    if (self.tencentdidNotNetWorkBlock) {
        self.tencentdidNotNetWorkBlock();
        self.tencentdidNotNetWorkBlock = nil;
    }
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
        self.socialManager.tencentCompleteBlock = nil;
    }
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response{
    
}

@end
