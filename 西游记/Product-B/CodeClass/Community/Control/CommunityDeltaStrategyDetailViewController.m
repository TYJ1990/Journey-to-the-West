//
//  CommunityDeltaStrategyDetailViewController.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityDeltaStrategyDetailViewController.h"

@interface CommunityDeltaStrategyDetailViewController ()
@property (nonatomic, strong)UIWebView *webView;

@end

@implementation CommunityDeltaStrategyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       [self initWebView];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImg"] forBarMetrics:0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:1] style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
    // Do any additional setup after loading the view.
}

- (void)popBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark webView
- (void)initWebView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - 64)];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.view_url]]];
    [self.view addSubview:self.webView];
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
