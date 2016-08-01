//
//  MyTabBarViewController.m
//  Product-B
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "CommunityViewController.h"
#import "DestinationViewController.h"
#import "MineViewController.h"
#import "RecommendViewController.h"


@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RecommendViewController *recommend = [[RecommendViewController alloc]init];
    DestinationViewController *destination = [[DestinationViewController alloc]init];
    CommunityViewController *community = [[CommunityViewController alloc]init];
    MineViewController *mine = [[MineViewController alloc]init];
    
    [self createNavc:recommend title:@"推荐" image:[UIImage imageNamed:@"recommend"]];
    
    [self createNavc:destination title:@"目的地" image:[UIImage imageNamed:@"destination"]];
    
    [self createNavc:community title:@"社区" image:[UIImage imageNamed:@"community"]];
    
    [self createNavc:mine title:@"我的" image:[UIImage imageNamed:@"mine.png"]];
    
    
    NSDictionary *dic=@{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    
    [[UITabBarItem appearance] setTitleTextAttributes:dic forState:(UIControlStateNormal)];
    

    
}





-(void)createNavc:(UIViewController *)vc title:(NSString *)title image:(UIImage *)image
{
    vc.title = title;
    
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
    
    navc.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:image tag:100];
    
    [self addChildViewController:navc];
    
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
