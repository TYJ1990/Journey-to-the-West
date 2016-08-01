//
//  CommunityDeltaCompanyViewController.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityDeltaCompanyViewController.h"
#import "CommunityCompanyModel.h"
#import "CommunityCompanyTableViewCell.h"
#import "CommunityCompanyDetailViewController.h"
@interface CommunityDeltaCompanyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign)NSInteger currentPage;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *companyArray;
@end

@implementation CommunityDeltaCompanyViewController
- (NSMutableArray *)companyArray
{
    if (!_companyArray) {
        _companyArray = [[NSMutableArray alloc] init];
    }
    return _companyArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    [self initTableView];
    [self requestCompanyData];
    // Do any additional setup after loading the view.
}



#pragma mark 攻略数据请求
- (void)requestCompanyData
{
    NSString *path = [NSString stringWithFormat:DeltaCompanyURL @"%@",self.groupId,(int)self.currentPage,DeltaCompanyURL2];
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CommunityCompanyTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        [self requestCompanyData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage ++;
        [self requestCompanyData];
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.companyArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityCompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CommunityCompanyModel *model = self.companyArray[indexPath.row];
    [cell cellConfigerModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
