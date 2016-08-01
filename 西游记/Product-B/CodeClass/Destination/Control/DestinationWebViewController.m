//
//  DestinationWebViewController.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#define DISCOUNTDETAILWEB @"http://m.qyer.com/z/deal/"
#define a @"/?source=app&client_id=qyer_ios&track_app_version=6.8&track_deviceid=7B6FA080-F9FB-44C1-B932-401CD69CD5D2&track_user_id=6971539"

#import "DestinationWebViewController.h"
#import "NSString+Html.h"
@interface DestinationWebViewController ()

@end

@implementation DestinationWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self createWebV];
    
}

-(void)createWebV
{
    NSString *path = [NSString stringWithFormat:@"%@%@%@",DISCOUNTDETAILWEB,self.webID,a];
    
    path = [NSString importStyleWithHtmlString:path];
    
    UIWebView *webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    [webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    
    [self.view addSubview:webV];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
