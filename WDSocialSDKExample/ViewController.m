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
//
//    NSArray *permissions =  [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
//    [[WDSocialManager manager] tencentAuthPermissions:permissions didLogin:^(TencentOAuth *auth) {
//        
//    } didNotLogin:^{
//        
//    } didNotNetWork:^{
//        
//    }];
//    
//    //构造SendAuthReq结构体
//    SendAuthReq* req =[[SendAuthReq alloc ] init ];
//    req.scope = @"snsapi_userinfo" ;
//    req.state = @"zylotte_weix_login";
//    [[WDSocialManager manager] wechatAuthReq:req viewController:self finishBlock:^{
//        
//    }];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
