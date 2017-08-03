//
//  WDSocialManager.h
//  WDSocialSDK
//
//  Created by 何伟东 on 2017/7/18.
//  Copyright © 2017年 何伟东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WDWeiboSDK/WeiboSDK.h>
#import <WechatOpenSDK/WXApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

typedef enum : NSUInteger {
    WDPlatformWeiBo,
    WDPlatformWechat,
    WDPlatformTencent,
} WDPlatformType;

typedef void(^WDWechatCompleteBlock)(BaseResp *resp);
typedef void(^WDTencentCompleteBlock)(QQBaseResp *resp);
typedef void(^WDWeiboCompleteBlock)(WBBaseResponse *resp);




@interface WDSocialManager : NSObject<WXApiDelegate,WeiboSDKDelegate>

@property(nonatomic,strong) TencentOAuth *tencentOAuth;

/**
 实例
 
 @return <#return value description#>
 */
+(WDSocialManager*)manager;


/**
 初始化QQ
 
 @param appKey <#appKey description#>
 */
-(void)setTencentAppKey:(NSString*)appKey;

/**
 初始化微博
 
 @param appKey <#appKey description#>
 */
-(void)setWeiboAppKey:(NSString*)appKey;
/**
 初始化微信
 
 @param appKey <#appKey description#>
 */
-(void)setWeChatAppKey:(NSString*)appKey;
    

/**
 处理通过URL启动App时传递的数据
 
 @param url <#url description#>
 @return <#return value description#>
 */
+(BOOL)handleOpenURL:(NSURL *)url;

/**
 分享信息到微信

 @param messageReq <#messageReq description#>
 @param block <#block description#>
 */
-(void)shareMessageToWechat:(BaseReq*)messageReq completeBlock:(WDWechatCompleteBlock)block;

/**
 分享信息到微博
 
 @param messageReq <#messageReq description#>
 @param block <#block description#>
 */
-(void)shareMessageToWeibo:(WBBaseRequest*)messageReq completeBlock:(WDWeiboCompleteBlock)block;

/**
 分享信息到QQ
 
 @param messageReq <#messageReq description#>
 @param block <#block description#>
 */
-(void)shareMessageToQQ:(QQBaseReq*)messageReq completeBlock:(WDTencentCompleteBlock)block;

/**
 分享信息到QQ空间
 
 @param messageReq <#messageReq description#>
 @param block <#block description#>
 */
-(void)shareMessageToQZone:(QQBaseReq*)messageReq completeBlock:(WDTencentCompleteBlock)block;


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
                didNotNetWork:(void(^)())didNotNetWork;


/**
 微信登录授权
 
 @param req <#req description#>
 @param viewController <#viewController description#>
 @param finishBlock <#finishBlock description#>
 */
-(void)wechatAuthReq:(SendAuthReq*)req
      viewController:(UIViewController*)viewController
         finishBlock:(void(^)(SendAuthResp *resp))finishBlock;


@end

@interface WDTencentDelegateImplement : NSObject<QQApiInterfaceDelegate,TencentSessionDelegate>
@property(nonatomic,weak) WDSocialManager *socialManager;

@end


