//
//  CommunityCompanyViewController.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityCompanyViewController.h"
#import "CommunityCompanyModel.h"
#import "CommunityCompanyTableViewCell.h"
#import "CommunityCompanyDetailViewController.h"
@interface CommunityCompanyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign)NSInteger currentPage;
@property (nonatomic, strong)NSMutableArray *companyArray;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation CommunityCompanyViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.companyArray = [[NSMutableArray alloc] init];
    self.currentPage = 1;
    [self initTableView];
    [self requestData];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"最新结伴";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回" ]imageWithRenderingMode:1]  style:0 target:self action:@selector(showBack)];
}
#pragma mark 导航栏上的button
- (void)showBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 数据请求
- (void)requestData
{
   NSString *path=[NSString stringWithFormat:CompanyURL@"%@",(int)self.currentPage,CompanyURL2];
       [RequestManager requestWithURLString:path pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
           if (self.currentPage == 1) {
               [self.companyArray removeAllObjects];
           }
          NSArray *array = [CommunityCompanyModel modelConfigerJsonDic:dic];
           for (CommunityCompanyModel *model in array) {
               [self.companyArray addObject:model];
           }
           [self.tableView reloadData];
           [self.tableView.mj_header endRefreshing];
           [self.tableView.mj_footer endRefreshing];
       } error:^(NSError *error) {
        
    }];
}

#pragma mark tableView
- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CommunityCompanyTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        [self requestData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage ++;
        [self requestData];
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.companyArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityCompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    CommunityCompanyModel *model = self.companyArray[indexPath.row];
    [cell cellConfigerModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenWidth/3.5;
}
#pragma mark 点击进入
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityCompanyDetailViewController *ccdVC = [[CommunityCompanyDetailViewController alloc] init];
    CommunityCompanyModel *model = self.companyArray[indexPath.row];
    ccdVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    ccdVC.appview_url = model.appview_url;
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:ccdVC];
    [self presentViewController:naVC animated:YES completion:nil];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
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
