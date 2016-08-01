//
//  CommunityAnswerViewController.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityAnswerViewController.h"
#import "CommunityAnswerModel.h"
#import "CommunityAnswerTableViewCell.h"
#import "AdjustHeight.h"
#import "CommunityAnswerDetailViewController.h"
@interface CommunityAnswerViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign)NSInteger currentPage;// 记录
@property (nonatomic, strong)NSMutableArray *answerArray;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation CommunityAnswerViewController
- (NSMutableArray *)answerArray
{
    if (!_answerArray) {
        _answerArray = [[NSMutableArray alloc] init];
    }
    return _answerArray;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    [self initTableView];
    [self requestData];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title =  @"最新问答";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回" ]imageWithRenderingMode:1]  style:0 target:self action:@selector(showBack)];
}
#pragma mark 返回
- (void)showBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 数据请求
- (void)requestData
{
    NSString *path =[NSString stringWithFormat:AnswerURL@"%@",(int)self.currentPage ,AnswerURL2];
    [RequestManager requestWithURLString:path pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:nil];
        if (self.currentPage == 0) {
            [self.answerArray removeAllObjects];
        }
        NSArray *array = [CommunityAnswerModel modelConfigerJsonDic:dic];
        for (CommunityAnswerModel *model in array) {
            [self.answerArray addObject:model];
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CommunityAnswerTableViewCell class] forCellReuseIdentifier:@"cell"];
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
    return self.answerArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityAnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CommunityAnswerModel *model = self.answerArray[indexPath.row];
    [cell cellConfigerModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenWidth/3.5;
}
#pragma mark 点击进入CommunityAnswerDetailViewController界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityAnswerDetailViewController *asdVC = [[CommunityAnswerDetailViewController alloc] init];
    asdVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    CommunityAnswerModel *model = self.answerArray[indexPath.row];
    asdVC.appview_url = model.appview_url;
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:asdVC];
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
