//
//  CommunityDeltaAnswerViewController.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityDeltaAnswerViewController.h"
#import "CommunityAnswerModel.h"
#import "CommunityAnswerTableViewCell.h"
#import "CommunityAnswerDetailViewController.h"
@interface CommunityDeltaAnswerViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign)NSInteger currentPage;
@property (nonatomic, strong)NSMutableArray *answerArray;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation CommunityDeltaAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.answerArray = [[NSMutableArray alloc] init];
    self.currentPage = 1;
    [self initTableView];
    [self requestData];
    // Do any additional setup after loading the view.
}
#pragma mark 数据请求
- (void)requestData
{
    NSString *path = [NSString stringWithFormat:DeltaAnswerURL@"%@",self.groupId,(int)self.currentPage,DeltaAnswerURL2];
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - 200) style:(UITableViewStylePlain)];
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
    return 100;
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
