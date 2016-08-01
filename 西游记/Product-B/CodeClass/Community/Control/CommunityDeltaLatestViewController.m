//
//  CommunityDeltaLatestViewController.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityDeltaLatestViewController.h"
#import "CommunityDeltaLatestModel.h"
#import "CommunityDeltaLatestTableViewCell.h"
#import "CommunityDeltaLatestDetailViewController.h"
@interface CommunityDeltaLatestViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign)NSInteger currentPage;
@property (nonatomic, strong)NSMutableArray *latestArray;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation CommunityDeltaLatestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    [self initTableView];
    [self requestData];
    
    
    // Do any additional setup after loading the view.
}
#pragma mark 数据请求
- (void)requestData
{
    NSString *path=[NSString stringWithFormat:DeltaLatestURL@"%@",self.groupId,(int)self.currentPage,DeltaLatestURL2];
    [RequestManager requestWithURLString:path pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (self.currentPage == 1) {
            [self.latestArray removeAllObjects];
        }
        self.latestArray = [CommunityDeltaLatestModel modelConfigerJsonDic:dic];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
      } error:^(NSError *error) {
        
    }];

}
#pragma mark tableView
- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CommunityDeltaLatestTableViewCell class] forCellReuseIdentifier:@"cell"];
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
    return self.latestArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityDeltaLatestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CommunityDeltaLatestModel *model = self.latestArray[indexPath.row];
    [cell cellConfigerModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight/6;
}

#pragma mark 点击进入
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityDeltaLatestDetailViewController *cddVC = [[CommunityDeltaLatestDetailViewController alloc] init];
    CommunityDeltaLatestModel *model = self.latestArray[indexPath.row];
    cddVC.view_url = model.view_url;
    cddVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:cddVC];
    [self presentViewController:naVC animated:YES completion:nil];

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
