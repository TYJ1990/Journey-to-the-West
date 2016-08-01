//
//  UIWEBController.m
//  Product-B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "UIWEBController.h"
#import "NSString+Html.h"
@interface UIWEBController ()

@end

@implementation UIWEBController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webV = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    NSString *path = self.htmlUrl;
    
    path = [NSString importStyleWithHtmlString:path];
    
    [webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.htmlUrl]]];
    
    
    [self.view addSubview:webV];
    
    

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
