//
//  LocalPlayerViewController.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LocalPlayerViewController.h"
#import "LocalPlayerModel.h"
#import "LocalPlayerTableViewCell.h"
#import "LocalPlayerCollectionViewCell.h"
@interface LocalPlayerViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

#pragma mark ---下方的tableV
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSMutableArray *tableArr;

#pragma mark ---上方的collectionView
@property(nonatomic,strong)UICollectionView *collectionV;
@property(nonatomic,strong)NSMutableArray *collectionArr;



@end

@implementation LocalPlayerViewController

-(NSMutableArray *)collectionArr
{
    if (!_collectionArr) {
        _collectionArr = [NSMutableArray array];
    }
    return _collectionArr;
}

-(NSMutableArray *)tableArr
{
    if (!_tableArr) {
        _tableArr = [NSMutableArray array];
    }
    return _tableArr;
}

-(void)requestData
{
    [RequestManager requestWithURLString:@"http://open.qyer.com/qyer/discount/zk/search_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&keyword=%E9%A6%99%E6%B8%AF&lat=31.12996739267396&lon=121.2839331342126&order=1&page=1&track_app_channel=App%2520Store&track_app_version=6.9.4&track_device_info=iPhone7%2C2&track_deviceid=FDA917EF-BF2C-4F87-A49E-81DE31077108&track_os=ios%25209.2&type1=2410&v=1" pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.tableArr = [LocalPlayerModel TableModelConfigure:jsonDic];
        self.collectionArr = [LocalPlayerModel CollectionModelConfigure:jsonDic];
        [self.collectionV reloadData];
        [self.tableV reloadData];
    } error:^(NSError *error) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"网络错误" message:@"检查网络是否连接" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleCancel) handler:nil];
        
        [ac addAction:act];
        
        [self presentViewController:ac animated:YES completion:nil];
    }];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createButtonView];
    [self createTableV];
    [self createCollectV];
    [self requestData];

}

#pragma mark ---创建btn
-(void)createButtonView
{
    NSArray *arr = [NSArray arrayWithObjects:@"当地游",@"智能排序",@"更多筛选", nil];
    UIView *view = [[UIView alloc]initWithFrame:[self createFrimeWithX:0 andY:0 andWidth:375 andHeight:50]];
   
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn.frame = [self createFrimeWithX:125*i andY:0 andWidth:125 andHeight:40];
        
        [btn setTitle:arr[i] forState:(UIControlStateNormal)];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        [view addSubview:btn];
    
    }
    
    
    
    [self.view addSubview:view];
    
}


#pragma makr --- 创建CollectionV
-(void)createCollectV
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.itemSize = CGSizeMake(60, 20);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
   self.collectionV = [[UICollectionView alloc]initWithFrame:[self createFrimeWithX:0 andY:0 andWidth:375 andHeight:50] collectionViewLayout:layout];
   
    self.collectionV.delegate = self;
    
    self.collectionV.dataSource =self;
    
    self.collectionV.backgroundColor = PKCOLOR(239, 239, 244);
    
    self.collectionV.showsHorizontalScrollIndicator = NO;
    
    
    [self.collectionV registerClass:[LocalPlayerCollectionViewCell class] forCellWithReuseIdentifier:@"aa"];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LocalPlayerModel *model = self.collectionArr[indexPath.row];
    
    LocalPlayerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aa" forIndexPath:indexPath];
    
    cell.titleL.text = model.catename;
    
    return cell;
}



#pragma mark ---创建tableview

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.collectionV;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}


- (void)createTableV {
    self.tableV = [[UITableView alloc]initWithFrame:[self createFrimeWithX:0 andY:50 andWidth:375 andHeight:667] style:(UITableViewStyleGrouped)];
    self.tableV.delegate = self;
    
    self.tableV.dataSource = self;
    
    [self.tableV registerClass:[LocalPlayerTableViewCell class] forCellReuseIdentifier:@"aa"];
    
    [self.view addSubview:self.tableV];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocalPlayerModel *model = self.tableArr[indexPath.row];
    
    LocalPlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa" forIndexPath:indexPath];
    
    
    [cell passValue:model];
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100*(kScreenHeight/667);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height
{
    
    return CGRectMake(x*(kScreenWidth/375), y*(kScreenHeight/667), width*(kScreenWidth/375), height*(kScreenHeight/667));
}
@end
