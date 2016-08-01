//
//  CommunityDeltaStrategyViewController.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityDeltaStrategyViewController.h"
#import "CommunityDeltaStrategyAllModel.h"
#import "CommunityDeltaStrategyTableViewCell.h"
#import "CommunityDeltaStrategyDetailViewController.h"
@interface CommunityDeltaStrategyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign)NSInteger currentPage;
@property (nonatomic, strong)NSMutableArray *strategyAllArray; // 全部
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)NSInteger flag;
@property (nonatomic,strong) NSMutableArray *btnArr;
@end

@implementation CommunityDeltaStrategyViewController
- (NSMutableArray *)strategyAllArray
{
    if (!_strategyAllArray) {
        _strategyAllArray = [[NSMutableArray alloc] init];
    }
    return _strategyAllArray;
}
- (NSMutableArray *)btnArr {
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    self.flag = 1;
    [self initTableView];
    [self requestAllData];
    [self initButton];
    
    // Do any additional setup after loading the view.
}
#pragma mark 全部数据请求
- (void)requestAllData
{
    NSString *path = [NSString stringWithFormat:DeltaStrategyURL@"%@" DeltaStrategyURL3@"%@",self.groupId,DeltaStrategyURL2,(int)self.currentPage,DeltaStrategyURL4];
    [RequestManager requestWithURLString:path pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:nil];
        if (self.currentPage == 1) {
            [self.strategyAllArray removeAllObjects];
        }
        NSArray *array = [CommunityDeltaStrategyAllModel modelConfigerJsonDic:dic];
         for (CommunityDeltaStrategyAllModel *model in array) {
            [self.strategyAllArray addObject:model];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } error:^(NSError *error) {
        
    }];

}
#pragma mark 精华数据请求
- (void)requestCreamData
{
    NSString *path = [NSString stringWithFormat:DeltaStrategyCreamURL@"%@",self.groupId,(int)self.currentPage,DeltaStrategyCreamURL2];
    [RequestManager requestWithURLString:path pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (self.currentPage == 1) {
            [self.strategyAllArray removeAllObjects];
        }
        NSArray *array = [CommunityDeltaStrategyAllModel modelConfigerJsonDic:dic];
        for (CommunityDeltaStrategyAllModel *model in array) {
            [self.strategyAllArray addObject:model];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
     } error:^(NSError *error) {
        
    }];
    
}
#pragma mark 游记数据请求
- (void)requestTravelData
{
    NSString *path = [NSString stringWithFormat:DeltaStrategyTravelURL@"%@",self.groupId,(int)self.currentPage,DeltaStrategyTravelURL2];
    [RequestManager requestWithURLString:path pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (self.currentPage == 1) {
            [self.strategyAllArray removeAllObjects];
        }
        NSArray *array = [CommunityDeltaStrategyAllModel modelConfigerJsonDic:dic];
        for (CommunityDeltaStrategyAllModel *model in array) {
            [self.strategyAllArray addObject:model];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark 攻略数据请求
- (void)requestStrategyInData
{
    NSString *path = [NSString stringWithFormat:DeltaStrategyInURL@"%@",self.groupId,(int)self.currentPage,DeltaStrategyInURL2];
    [RequestManager requestWithURLString:path pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (self.currentPage == 1) {
            [self.strategyAllArray removeAllObjects];
        }
        NSArray *array = [CommunityDeltaStrategyAllModel modelConfigerJsonDic:dic];
        for (CommunityDeltaStrategyAllModel *model in array) {
            [self.strategyAllArray addObject:model];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } error:^(NSError *error) {
        
    }];
 
}
#pragma mark 上面的button
- (void)initButton
{
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    buttonView.backgroundColor = [UIColor grayColor];
    buttonView.alpha = 0.2;
    [self.view addSubview:buttonView];
    NSArray *array = @[@"全部",@"精华",@"游记",@"攻略"];
    for (int i = 0; i < 4; i ++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        button.frame = CGRectMake(kScreenWidth * 0.2 + i *kScreenWidth * 0.2 ,0, 30, 30);
        [button setTitle:array[i] forState:(UIControlStateNormal)];
        [button setTintColor:[UIColor blackColor]];
        if (i == 0) {
        [button setTintColor:[UIColor blueColor]];
        }
        button.tag = 1 + i;
        [button addTarget:self action:@selector(Action:) forControlEvents:(UIControlEventTouchUpInside)];
        [buttonView addSubview:button];
        [self.btnArr addObject:button];
    }
    
}
#pragma mark button方法
- (void)Action:(UIButton *)button
{
    for (UIButton *btn in self.btnArr) {
        [btn setTintColor:[UIColor blackColor]];
    }
    if (button.tag == 1) {
        self.flag = 1;
        [self.strategyAllArray removeAllObjects];
        [button setTintColor:[UIColor blueColor]];
        [self requestAllData];
    }else if (button.tag == 2){
        self.flag = 2;
        [self.strategyAllArray removeAllObjects];
        [button setTintColor:[UIColor blueColor]];
        [self requestCreamData];
    }else if (button.tag == 3){
        self.flag = 3;
        [self.strategyAllArray removeAllObjects];
        [button setTintColor:[UIColor blueColor]];
        [self requestTravelData];
    }else if (button.tag == 4){
        self.flag = 4;
        [self.strategyAllArray removeAllObjects];
        [button setTintColor:[UIColor blueColor]];
        [self requestStrategyInData];
    }
}

#pragma mark tableView
- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight - 200)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CommunityDeltaStrategyTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        if (self.flag == 1) {
            [self requestAllData];
        }else if(self.flag == 2){
            [self requestCreamData];
        }else if (self.flag == 3){
            [self requestTravelData];
        }else if (self.flag == 4){
            [self requestStrategyInData];
        }
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage ++;
        if (self.flag == 1) {
            [self requestAllData];
        }else if(self.flag == 2){
            [self requestCreamData];
        }else if (self.flag == 3){
            [self requestTravelData];
        }else if (self.flag == 4){
            [self requestStrategyInData];
        }
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.strategyAllArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityDeltaStrategyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CommunityDeltaStrategyAllModel *model = self.strategyAllArray[indexPath.row];
    [cell cellConfigerModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark 点击进入下个界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityDeltaStrategyDetailViewController *cddVC = [[CommunityDeltaStrategyDetailViewController alloc] init];
     CommunityDeltaStrategyAllModel *model = self.strategyAllArray[indexPath.row];
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
