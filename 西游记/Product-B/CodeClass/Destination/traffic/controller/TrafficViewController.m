//
//  TrafficViewController.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#define traffic @"http://m.qyer.com/place/city/"

#define traffic2 @"/entry/transportationcity?from_device=app"

#import "TrafficViewController.h"
#import "NSString+Html.h"
@interface TrafficViewController ()

@end

@implementation TrafficViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIWebView *webV = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    NSLog(@"%@",self.pathA);
    
    NSString *path = [NSString stringWithFormat:@"%@%@%@",traffic,self.pathA,traffic2];
    
    path = [NSString importStyleWithHtmlString:path];
    
    [webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    
    [self.view addSubview:webV];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height{
    
    return CGRectMake(x*(kScreenWidth/375), y*(kScreenHeight/667), width*(kScreenWidth/375), height*(kScreenHeight/667));
    
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
