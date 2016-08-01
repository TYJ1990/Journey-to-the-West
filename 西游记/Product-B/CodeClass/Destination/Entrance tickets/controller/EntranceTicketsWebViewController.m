//
//  EntranceTicketsWebViewController.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "EntranceTicketsWebViewController.h"
#import "NSString+Html.h"
@interface EntranceTicketsWebViewController ()

@end

@implementation EntranceTicketsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIWebView *webV = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSString *path = [NSString stringWithFormat:@"http://m.qyer.com/z/deal/%@/?source=app&client_id=qyer_ios&track_app_version=6.9.4&track_deviceid=FDA917EF-BF2C-4F87-A49E-81DE31077108",self.WebID];
    
    path = [NSString importStyleWithHtmlString:path];
    [webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
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
