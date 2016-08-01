//
//  DestinationDetailViewController.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#define ASIADESTINATIONDETAIL @"http://open.qyer.com/qyer/footprint/country_detail?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&country_id=%@%@"

#define pa @"&lat=40.03622574273529&lon=116.363834514835&oauth_token=2c8a27f98da55363b7f5ca09940dc14c&page=1&track_app_channel=App%2520Store&track_app_version=6.8&track_device_info=iPhone7%2C1&track_deviceid=7B6FA080-F9FB-44C1-B932-401CD69CD5D2&track_os=ios%25209.1&track_user_id=6971539&v=1"


#import "DestinationDetailViewController.h"
#import "DestinationDetailModel.h"
#import "DestinationDetailCollectionViewCell.h"
#import "DestinationDetailTableViewCell.h"
#import "DestionatonCityDetailViewController.h"
#import "DestinationWebViewController.h"

@interface DestinationDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>

// tableView的头视图
@property(nonatomic,strong)UIView *headView;
#pragma mark ---轮播图的数据的数组
@property(nonatomic,strong)NSMutableArray *lunbotuArr;
@property(nonatomic,strong)DestinationDetailModel *lunboModel;
@property(nonatomic,strong)CycleScrollView *cycles;
#pragma mark ---中间的collectionView
@property(nonatomic,strong)UICollectionView *collectionV;
@property(nonatomic,strong)NSMutableArray *collectionArr;
#pragma mark ---最下方的tableView
@property(nonatomic,strong)UITableView *MyTableview;
@property(nonatomic,strong)NSMutableArray *tableArr;


@end

@implementation DestinationDetailViewController
// 懒加载

-(NSMutableArray *)tableArr
{
    if (!_tableArr) {
        _tableArr = [NSMutableArray array];
    }
    return _tableArr;
}

-(NSMutableArray *)collectionArr
{
    if (!_collectionArr) {
        _collectionArr = [NSMutableArray array];
    }
    return _collectionArr;
    
}

-(DestinationDetailModel *)lunboModel
{
    if (!_lunboModel) {
        _lunboModel = [[DestinationDetailModel alloc]init];
    }
    return _lunboModel;
}

-(NSMutableArray *)lunbotuArr
{
    if (!_lunbotuArr) {
        _lunbotuArr = [NSMutableArray array];
    }
    return _lunbotuArr;
}




#pragma mark ---视图将要出现
-(void)viewWillAppear:(BOOL)animated
{
    
    [self changeNavi];
    
    self.tabBarController.tabBar.hidden = YES;
   self.navigationController.navigationBar.translucent = NO;
    
}





#pragma mark ---数据解析
-(void)requestData
{
    NSString *urlString = [NSString stringWithFormat:ASIADESTINATIONDETAIL,self.myID,pa];   
    
    [RequestManager requestWithURLString:urlString pardic:nil requesttype:requestGET finish:^(NSData *data) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
#pragma mark ---最下面的tableView的数据解析
        self.tableArr = [DestinationDetailModel tableModelConfigure:jsonDic];
        [self.MyTableview reloadData];
#pragma mark --- 轮播图
        self.lunboModel = [DestinationDetailModel lunboshujuConfigure:jsonDic];
        
       self.lunbotuArr = [DestinationDetailModel LunbotumodelConfigure:jsonDic];
        
        __weak DestinationDetailViewController *Myself = self;
        
        
        self.cycles = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/3) DurationTime:4.0];
        [self.cycles.pageControl removeFromSuperview];
        self.cycles.fetchContentView = ^NSString *(NSInteger index){
            return Myself.lunbotuArr[index];
        };
        
        self.cycles.pages = self.lunbotuArr.count;
        
        
      
        
      
#pragma mark ---中间的collection的数据解析
        
        self.collectionArr = [DestinationDetailModel collectionModelConfigure:jsonDic];
        
        [self.collectionV reloadData];



    } error:^(NSError *error) {
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"网络错误" message:@"检查网络是否连接" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleCancel) handler:nil];
        
        [ac addAction:act];
        
        [self presentViewController:ac animated:YES completion:nil];
        
    }];
    
    
}

-(void)changeNavi
{
    self.navigationController.navigationBar.translucent = YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self requestData];
    
    [self changenavigationController];
    
    [self createTableView];
    
}

-(void)changenavigationController
{
    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark ---创建tableView
-(void)createTableView
{
    self.MyTableview = [[UITableView alloc]initWithFrame:[self createFrimeWithX:0 andY:0 andWidth:375 andHeight:667] style:(UITableViewStyleGrouped)];
    
    self.MyTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.MyTableview.delegate =self;
    
    self.MyTableview.dataSource =self;
    
    [self.MyTableview registerNib:[UINib nibWithNibName:@"DestinationDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DestinationDetailCell"];
    
    self.MyTableview.rowHeight = 70;
    
    [self.view addSubview:self.MyTableview];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DestinationDetailModel *model = self.tableArr[indexPath.row];
    DestinationDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DestinationDetailCell" forIndexPath:indexPath];
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil completed:nil
     ];
    
    cell.titleL.text = model.title;
    
    cell.titleL.numberOfLines = 0;
    
    cell.titleL.textColor = [UIColor grayColor];
    
    cell.titleL.font = [UIFont systemFontOfSize:15];
    
    cell.priceoffL.text = model.priceoff;
    
    cell.priceoffL.font = [UIFont systemFontOfSize:12];
    
    cell.priceoffL.textColor = [UIColor grayColor];
    
    cell.priceL.text = [NSString stringWithFormat:@"%@元起",model.price];
    
    cell.priceL.textColor = PKCOLOR(156, 58, 156);
    
    cell.priceL.textAlignment = 2;
    
    return cell;
}

#pragma mark ---tableView的头部试图用
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*4/5)];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.minimumInteritemSpacing = 10;
    
    layout.minimumLineSpacing = 10;
    
    layout.itemSize = CGSizeMake((kScreenWidth-30)/2, (kScreenWidth-30)/2/1.5);
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kScreenHeight/3, kScreenWidth, kScreenHeight/2.5) collectionViewLayout:layout];
    
    self.collectionV.scrollEnabled = NO;
    
    self.collectionV.dataSource =self;
    
    self.collectionV.delegate =self;
    
    self.collectionV.backgroundColor = [UIColor whiteColor];

    [self.collectionV registerNib:[UINib nibWithNibName:@"DestinationDetailCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"DestinationDetailCell"];
      [self.headView addSubview:self.cycles];
    
    UILabel *country = [[UILabel alloc]initWithFrame:[self createFrimeWithX:15 andY:100 andWidth:100 andHeight:50]];
    country.text =self.lunboModel.cnname;
    
    country.textColor = [UIColor whiteColor];
    
    UILabel *countryEnglish = [[UILabel alloc]initWithFrame:[self createFrimeWithX:15 andY:130 andWidth:100 andHeight:50]];
    
    countryEnglish.text = self.lunboModel.enname;
    
    countryEnglish.textColor = [UIColor whiteColor];
    
    UILabel *introduceL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:15 andY:170 andWidth:kScreenWidth*5/6 andHeight:50]];
    
    introduceL.text = self.lunboModel.entryCont;
    
    introduceL.textColor = [UIColor whiteColor];
    
    introduceL.numberOfLines = 0;
    
    introduceL.font = [UIFont systemFontOfSize:12];
    
    [self.headView addSubview:country];
    
    [self.headView addSubview:countryEnglish];
    
    [self.headView addSubview:introduceL];
    
    [self.headView addSubview:self.collectionV];
    
    return self.headView;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kScreenHeight*3/4;
}

#pragma mark ---collectionView代理实现的方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DestinationDetailModel *model = self.collectionArr[indexPath.row];
    
    DestinationDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DestinationDetailCell" forIndexPath:indexPath];
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil completed:nil];
    
    cell.cnName.text = model.cnname;
    
    cell.cnName.textAlignment = 1;
    
    cell.cnName.textColor = [UIColor whiteColor];
    
    cell.enName.text = model.enname;
    
    cell.enName.textAlignment = 1;
    
    cell.enName.textColor = [UIColor whiteColor];
    
    
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FLT_MIN;
}

#pragma mark ---页面的跳转方法(tableView)
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DestinationDetailModel *model = self.tableArr[indexPath.row];
    
    DestinationWebViewController *webVC = [[DestinationWebViewController alloc]init];
    
    webVC.webID = [NSString stringWithFormat:@"%@",model.tableID];
    
    [self.navigationController pushViewController:webVC animated:YES];
    
}
#pragma mark ---页面的跳转方法(collectionView)

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DestinationDetailModel *model = self.collectionArr[indexPath.row];
    
    DestionatonCityDetailViewController *cityVC = [[DestionatonCityDetailViewController alloc]init];
    
    cityVC.cityID = [NSString stringWithFormat:@"%@",model.collectionID];
    cityVC.cityName = [NSString stringWithFormat:@"%@",model.enname];
    cityVC.countryEN = self.countryEN;
    


    [self.navigationController pushViewController:cityVC animated:YES];
    
}

#pragma mark ---适配屏幕的方法
-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height{
    
    return CGRectMake(x*(kScreenWidth/375), y*(kScreenHeight/667), width*(kScreenWidth/375), height*(kScreenHeight/667));
    
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
