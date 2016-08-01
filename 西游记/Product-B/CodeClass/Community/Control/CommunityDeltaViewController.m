//
//  CommunityDeltaViewController.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityDeltaViewController.h"
#import "zgSCNavTabBarController.h"

#import "CommunityDeltaLatestViewController.h" //最新
#import "CommunityDeltaStrategyViewController.h" // 攻略
#import "CommunityDeltaCompanyViewController.h" // 结伴
#import "CommunityDeltaAnswerViewController.h" // 回答
#import "CommunityDeltaTransferViewController.h" // 转让

@interface CommunityDeltaViewController ()

@end

@implementation CommunityDeltaViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createController];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回" ]imageWithRenderingMode:1]  style:0 target:self action:@selector(showBack)];
    self.title = self.groupName;
    // Do any additional setup after loading the view.
}

#pragma mark 导航栏上的button
- (void)showBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 创建controller
- (void)createController
{
    CommunityDeltaLatestViewController *latest = [[CommunityDeltaLatestViewController alloc] init];
    latest.title = @"最新";
    latest.groupId = self.groupId;
    CommunityDeltaStrategyViewController *strategy = [[CommunityDeltaStrategyViewController alloc] init];
    strategy.title = @"攻略";
    strategy.groupId = self.groupId;
    CommunityDeltaCompanyViewController *company = [[CommunityDeltaCompanyViewController alloc] init];
    company.title = @"结伴";
    company.groupId = self.groupId;
    CommunityDeltaAnswerViewController *answer = [[CommunityDeltaAnswerViewController alloc] init];
    answer.title = @"回答";
    answer.groupId = self.groupId;
    CommunityDeltaTransferViewController *transfer = [[CommunityDeltaTransferViewController alloc] init];
    transfer.title = @"转让";
    transfer.groupId = self.groupId;
    
    zgSCNavTabBarController *tabBar=[[zgSCNavTabBarController alloc]init];
    NSArray *array=@[latest,strategy,company,answer,transfer];
    tabBar.subViewControllers=array;
    [tabBar addParentController:self];
    UIView *pikView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    [tabBar.view addSubview:pikView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 70, 70)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.photo]];
    [pikView addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, 200, 30)];
    label.text = [NSString stringWithFormat:@"%@个帖子",self.total_threads];
    label.font = [UIFont systemFontOfSize:15];
    [pikView addSubview:label];

}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
   
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
