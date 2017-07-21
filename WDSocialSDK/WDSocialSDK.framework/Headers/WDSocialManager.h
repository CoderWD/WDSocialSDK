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

@interface WDSocialManager : NSObject<WXApiDelegate,WeiboSDKDelegate>



/**
 分享信息到分享

 @param messageReq <#messageReq description#>
 @param block <#block description#>
 */
-(void)shareMessageToWechat:(BaseReq*)messageReq completeBlock:(WDWechatCompleteBlock)block;

/**
 实例
 
 @return <#return value description#>
 */
+(WDSocialManager*)manager;

@end

@interface WDTencentDelegateImplement : NSObject<QQApiInterfaceDelegate>
@property(nonatomic,weak) WDSocialManager *socialManager;

@end


