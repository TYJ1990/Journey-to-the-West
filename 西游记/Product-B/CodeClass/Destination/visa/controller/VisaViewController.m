//
//  VisaViewController.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#define VisaUrl @"http://m.qyer.com/place/country/"
#define VisaUrl2 @"/entry/visa?suffix=11186&from_device=app"

#import "VisaViewController.h"
#import "NSString+Html.h"
@interface VisaViewController ()

@end

@implementation VisaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    NSLog(@"%@",self.countryEN);
    
    NSString *path = [NSString stringWithFormat:@"%@%@%@",VisaUrl,self.countryEN,VisaUrl2];
    
    path = [NSString importStyleWithHtmlString:path];

    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    
    [self.view addSubview:webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
