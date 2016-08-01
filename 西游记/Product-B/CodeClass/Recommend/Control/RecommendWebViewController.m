//
//  RecommendWebViewController.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RecommendWebViewController.h"

@interface RecommendWebViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
}


@end

@implementation RecommendWebViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
   // self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //NSLog(@"%@",self.discountID);
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    
    if (self.discountID==nil) {
        NSURL *url = [NSURL URLWithString:self.pathStr];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
        [_webView loadRequest:request];
        [self.view addSubview:_webView];
    }else{
        NSString* pathUrl=[NSString stringWithFormat:DISCOUNTDETAIL1,self.discountID,DISCOUNTDETAIL2];
        [RequestManager requestWithURLString:pathUrl pardic:nil requesttype:requestGET finish:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString* pathStr = dic[@"data"][@"app_url"];
            NSURL *url = [NSURL URLWithString:pathStr];
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
            [_webView loadRequest:request];
            [self.view addSubview:_webView];
        } error:^(NSError *error) {
            
        }];
    }
    self.title = self.naVCtitle;
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.tintColor = [UIColor whiteColor];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
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
