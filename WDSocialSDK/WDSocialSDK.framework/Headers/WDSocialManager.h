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
 分享信息到腾讯
 
 @param messageReq <#messageReq description#>
 @param block <#block description#>
 */
-(void)shareMessageToTencent:(QQBaseReq*)messageReq completeBlock:(WDTencentCompleteBlock)block;

/**
 实例
 
 @return <#return value description#>
 */
+(WDSocialManager*)manager;

@end

@interface WDTencentDelegateImplement : NSObject<QQApiInterfaceDelegate>
@property(nonatomic,weak) WDSocialManager *socialManager;

@end


