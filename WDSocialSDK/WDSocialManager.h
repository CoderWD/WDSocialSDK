//
//  WDSocialManager.h
//  WDSocialSDK
//
//  Created by 何伟东 on 2017/7/18.
//  Copyright © 2017年 何伟东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeiboSDK/WeiboSDK.h>
#import <WechatOpenSDK/WXApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>


@interface WDSocialManager : NSObject<WXApiDelegate,WeiboSDKDelegate>

@end

@interface WDTencentDelegateImplement : NSObject<QQApiInterfaceDelegate>
@property(nonatomic,weak) WDSocialManager *socialManager;
@end


