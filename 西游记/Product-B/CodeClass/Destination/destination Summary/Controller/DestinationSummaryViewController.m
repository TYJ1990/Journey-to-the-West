//
//  DestinationSummaryViewController.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DestinationSummaryViewController.h"
#import "NSString+Html.h"
@interface DestinationSummaryViewController ()

@end

@implementation DestinationSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [NSString stringWithFormat:@"http://appview.qyer.com/place/ientries/city/%@/2037",self.CityID];
    NSLog(@"%@",self.CityID);
    
    path = [NSString importStyleWithHtmlString:path];
    
    UIWebView *webV = [[UIWebView alloc]initWithFrame:self.view.frame];
    
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
