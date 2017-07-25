//
//  ViewController.m
//  WDSocialSDKExample
//
//  Created by 何伟东 on 2017/7/18.
//  Copyright © 2017年 何伟东. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [[WDSocialManager manager] shareMessageToWechat:nil completeBlock:^(BaseResp *resp) {
        
    }];

    //QQ登录
    NSArray *permissions =  [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
    [[WDSocialManager manager] tencentAuthPermissions:permissions didLogin:^(TencentOAuth *auth) {
        
    } didNotLogin:^{
        
    } didNotNetWork:^{
        
    }];
    
    
    //微信登录
    SendAuthReq* req =[[SendAuthReq alloc ] init ];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"weix_login";
    [[WDSocialManager manager] wechatAuthReq:req viewController:self finishBlock:^(BaseResp *resp) {
        
    }];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
