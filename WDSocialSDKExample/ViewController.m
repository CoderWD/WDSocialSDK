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

- (void)viewDidLoad model{
    [super viewDidLoad];
    
    [[WDSocialManager manager] shareMessageToWechat:req completeBlock:^(BaseResp *resp) {
        
    }];

    
    
    [[WDSocialManager manager] tencentAuthReq:req viewController:self didLogin:^(TencentOAuth *auth) {
        
    } didNotLogin:^{
        
    } didNotNetWork:^{
        
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
