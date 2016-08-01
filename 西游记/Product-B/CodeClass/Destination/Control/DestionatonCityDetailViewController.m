//
//  DestionatonCityDetailViewController.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#define CityPATH @"http://open.qyer.com/qyer/footprint/city_detail?city_id=%@%@"
#define CityPath @"&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=40.03355031999999&lon=116.36718922&oauth_token=2c8a27f98da55363b7f5ca09940dc14c&page=1&track_app_channel=App%2520Store&track_app_version=6.8&track_device_info=iPhone7%2C1&track_deviceid=7B6FA080-F9FB-44C1-B932-401CD69CD5D2&track_os=ios%25209.1&track_user_id=6971539&v=1"

#import "DestionatonCityDetailViewController.h"
#import "DestionationCityModel.h"
#import "DestinationCityDetailCollectionViewCell.h"
#import "DestinationDetailTableViewCell.h"
#import "DestinationWebViewController.h"
#import "ScenicSpotViewController.h"
#import "HotelViewController.h"
#import "EntranceTicketsViewController.h"
#import "DestinationSummaryViewController.h"
#import "PhoneCardViewController.h"
#import "TrafficViewController.h"
#import "VisaViewController.h"
#import "LocalPlayerViewController.h"
@interface DestionatonCityDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

#pragma mark ---与tableView有关的

@property(nonatomic,strong)UITableView *myTableView;

@property(nonatomic,strong)NSMutableArray *tableArr;

#pragma mark ---轮播图图片的数组
@property(nonatomic,strong)NSMutableArray *lunbotuPictureArr;

@property(nonatomic,strong)DestionationCityModel *lunboModel;

#pragma mark ---中间的collectionView有关的数据;
@property(nonatomic,strong)NSMutableArray *collectionArr;

@property(nonatomic,strong)UICollectionView *myCollectionView;

@property (nonatomic,strong) UIView *headView;

@end

@implementation DestionatonCityDetailViewController

#pragma mark ---懒加载
-(NSMutableArray *)collectionArr
{
    if (!_collectionArr) {
        
        _collectionArr = [NSMutableArray array];
        
    }
    
    return _collectionArr;
    
}

-(DestionationCityModel *)lunboModel
{
    if (!_lunboModel) {
        
        _lunboModel = [[DestionationCityModel alloc]init];
        
    }
    return _lunboModel;
}

-(NSMutableArray *)lunbotuPictureArr
{
    if (!_lunbotuPictureArr) {
        _lunbotuPictureArr = [NSMutableArray array];
    }
    return _lunbotuPictureArr;
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
    NSString *path = [NSString stringWithFormat:CityPATH,self.cityID,CityPath];
    
    
    [RequestManager requestWithURLString:path pardic:nil requesttype:requestGET finish:^(NSData *data) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
#pragma mark ---tableView的数据解析
        
        self.tableArr = [DestionationCityModel tableModelConfigure:jsonDic];
        
#pragma mark ---轮播图的数据解析
        
        self.lunbotuPictureArr = [DestionationCityModel lunbotuModelconfigure:jsonDic];
        
        self.lunboModel = [DestionationCityModel lunbotuDataModelConfigure:jsonDic];
        
     
        
#pragma mark ---中间的collection的数据解析
        
        self.collectionArr = [DestionationCityModel collectionModelConfigure:jsonDic];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumInteritemSpacing = 10;
        
        layout.minimumLineSpacing = 10 ;
        
        layout.itemSize = CGSizeMake((kScreenWidth-30)/2,(kScreenWidth-30)/2*1.2);
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        self.myCollectionView = [[UICollectionView alloc]initWithFrame:[self createFrimeWithX:0 andY:500 andWidth:375 andHeight:((375-30)/2*1.5)*1.8] collectionViewLayout:layout];
        
        if (self.collectionArr.count!=0) {
            self.myCollectionView.frame = [self createFrimeWithX:0 andY:400 andWidth:375 andHeight:((375-30)/2*1.5)*1.8];
        }else
        {
            self.myCollectionView.frame = [self createFrimeWithX:0 andY:400 andWidth:375 andHeight:0];
            
        }
        
        
        [self.myCollectionView reloadData];
        
       [self.myTableView reloadData];
    } error:^(NSError *error) {
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"网络错误" message:@"检查网络是否连接" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleCancel) handler:nil];
        
        [ac addAction:act];
        
        [self presentViewController:ac animated:YES completion:nil];
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self changeNavi];
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
}

-(void)changeNavi
{
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    
    
   
    
    [self requestData];
    
    
    
    

    
    [self createTableView];
    
    
    
}

-(void)createTableView
{
    
    self.myTableView = [[UITableView alloc]initWithFrame:[self createFrimeWithX:0 andY:0 andWidth:375 andHeight:667] style:(UITableViewStyleGrouped)];;
    
    self.myTableView.delegate = self;
    
    self.myTableView.dataSource = self;
    
    self.myTableView.separatorStyle = 0;
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"DestinationDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DestinationDetailCell"];
    
    [self.view addSubview:self.myTableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DestionationCityModel *model = self.tableArr[indexPath.row];
    
    DestinationDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DestinationDetailCell" forIndexPath:indexPath];
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil completed:nil];
    
    cell.titleL.text = model.title;

    cell.priceoffL.text = model.priceoff;
    
    cell.priceL.text = model.price;
    
    cell.titleL.numberOfLines = 0;
    
    cell.titleL.textColor = [UIColor grayColor];
    
    cell.titleL.font = [UIFont systemFontOfSize:15];
   
    cell.priceoffL.font = [UIFont systemFontOfSize:12];
    
    cell.priceoffL.textColor = [UIColor grayColor];
    
    cell.priceL.textColor = PKCOLOR(156, 58, 156);
    
    cell.priceL.textAlignment = 2;

    return cell;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark ---tableView的头部视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    self.headView = [[UIView alloc]init ];
    
    
    

    self.headView.frame =[self createFrimeWithX:0 andY:0 andWidth:375 andHeight:425];
        
  
    
    

    
    CycleScrollView *cycel = [[CycleScrollView alloc]initWithFrame:[self createFrimeWithX:0 andY:0 andWidth:375 andHeight:225] DurationTime:5];
    
    cycel.alpha = 0.5;
    [cycel.pageControl removeFromSuperview];
    __weak DestionatonCityDetailViewController *myself = self;
    
    cycel.fetchContentView = ^NSString *(NSInteger index){
        
        return myself.lunbotuPictureArr[index];
        
    };
    
    cycel.pages = self.lunbotuPictureArr.count;
    
    [self.headView addSubview:cycel];
    
    UILabel *country = [[UILabel alloc]initWithFrame:[self createFrimeWithX:15 andY:100 andWidth:100 andHeight:50]];
    country.text =self.lunboModel.cnname;
    
    country.textColor = [UIColor whiteColor];
    
    UILabel *countryEnglish = [[UILabel alloc]initWithFrame:[self createFrimeWithX:15 andY:130 andWidth:100 andHeight:50]];
    
    countryEnglish.text = self.lunboModel.enname;
    
    countryEnglish.textColor = [UIColor whiteColor];
    
    UILabel *introduceL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:15 andY:170 andWidth:375*5/6 andHeight:50]];
    
    introduceL.text = self.lunboModel.entryCont;
    
    introduceL.textColor = [UIColor whiteColor];
    
    introduceL.numberOfLines = 0;
    
    introduceL.font = [UIFont systemFontOfSize:12];
    
    [self.headView addSubview:country];
    
    [self.headView addSubview:countryEnglish];
    
    [self.headView addSubview:introduceL];
    
   
    

    
    UIScrollView *src = [[UIScrollView alloc]initWithFrame:[self createFrimeWithX:0 andY:225 andWidth:375 andHeight:200]];
    
    src.contentSize = CGSizeMake(kScreenWidth*2, src.frame.size.height);
    
    src.backgroundColor = [UIColor whiteColor];
    
    src.bounces = NO;
    
    src.pagingEnabled = YES;
    
#pragma mark ---锦囊
    for (int i = 0; i<4; i++) {
        
        
        UIButton *btn = [[UIButton alloc]initWithFrame:[self createFrimeWithX:15+88.75*i andY:10 andWidth:78.75 andHeight:78.75]];
        
        btn.tag = i+101;
        
        [btn addTarget:self action:@selector(nextView:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn setImage:[[UIImage imageNamed:@"122.jpg"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:39.375];
        
        
        [src addSubview:btn];
        
    }
    
    for (int i = 0; i<4; i++) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:[self createFrimeWithX:15+88.75*i andY:110 andWidth:78.75 andHeight:80]];
        
        
        btn.tag = i+105;
        
        [btn addTarget:self action:@selector(nextView:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn setImage:[[UIImage imageNamed:@"122.jpg"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:39.375];
        
        [src addSubview:btn];
        
    }
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:[self createFrimeWithX:375+15+88.75*i andY:10 andWidth:78.75 andHeight:80]];
        btn.tag = i+109;
        
        [btn addTarget:self action:@selector(nextView:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn setImage:[[UIImage imageNamed:@"122.jpg"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:39.375];
        
        [src addSubview:btn];
    }
    
    [self.headView addSubview:src];
    
    
    
        
    
    self.myCollectionView.scrollEnabled = NO;
    
    self.myCollectionView.dataSource = self;
    
    self.myCollectionView.delegate =self;
    
    self.myCollectionView.backgroundColor = [UIColor whiteColor];
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"DestinationCityDetailCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"DestinationCityDetailCell"];
    
    [self.headView addSubview:self.myCollectionView];
    
    return self.headView;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    
    return 425*(kScreenHeight/667)+self.myCollectionView.frame.size.height;
    

}

#pragma mark ---中间button的点击方法

-(void)nextView:(UIButton *)btn
{
    if (btn.tag == 101) {
        
        ScenicSpotViewController *scenicVC = [[ScenicSpotViewController alloc]init];
        scenicVC.ID = self.cityID;
        scenicVC.type = @"scenic";
        [self.navigationController pushViewController:scenicVC animated:YES];
        
    }else if(btn.tag == 102)
    {
        
        ScenicSpotViewController *scenicVC = [[ScenicSpotViewController alloc]init];
        scenicVC.ID = self.cityID;
        
        scenicVC.type = @"food";
        
        
        [self.navigationController pushViewController:scenicVC animated:YES];
        
    }else if (btn.tag == 103)
    {
        DestinationSummaryViewController *webV = [[DestinationSummaryViewController alloc]init];
        
        webV.CityID = self.cityID;
        
        [self.navigationController pushViewController:webV animated:YES];
        
    }else if (btn.tag == 104)
    {
        HotelViewController *hotelVC = [[HotelViewController alloc]init];
        
        hotelVC.ID = self.cityID;
        [self.navigationController pushViewController:hotelVC animated:YES];
    }else if (btn.tag ==108)
    {
        EntranceTicketsViewController *entranceVC = [[EntranceTicketsViewController alloc]init];
        
        
        [self.navigationController pushViewController:entranceVC animated:YES];
    }else if (btn.tag == 107)
    {
        PhoneCardViewController *phoneCardVC = [[PhoneCardViewController alloc]init];
        
        [self.navigationController pushViewController:phoneCardVC animated:YES];
        
        
    }else if (btn.tag == 106)
    {
        
        TrafficViewController *trafficV = [[TrafficViewController alloc]init];
        
        trafficV.pathA = self.cityName;
        
        [self.navigationController pushViewController:trafficV animated:YES];
        

    }else if (btn.tag == 105)
    {
        VisaViewController *visaWebV = [[VisaViewController alloc]init];
        
        visaWebV.countryEN = self.countryEN;
    
        [self.navigationController pushViewController:visaWebV animated:YES];
        
        
    }else if (btn.tag == 109)
    {
        LocalPlayerViewController *localPlay = [[LocalPlayerViewController alloc]init];
        
        [self.navigationController pushViewController:localPlay animated:YES];
        
        
    }
    
    
    
    
    
 
}



#pragma mark ---collection的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.collectionArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DestionationCityModel *model = self.collectionArr[indexPath.row];
    DestinationCityDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DestinationCityDetailCell" forIndexPath:indexPath];
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil completed:nil];
    cell.titleL.text = model.title;
    cell.titleL.numberOfLines = 0;
    cell.titleL.font = [UIFont systemFontOfSize:15];
   
    cell.priceoffL.text = model.priceoff;
    cell.priceoffL.textColor = [UIColor grayColor];
    cell.priceoffL.font = [UIFont systemFontOfSize:12];
    
    cell.priceL.text = [NSString stringWithFormat:@"%@元起",model.price];
    cell.priceL.textColor = [UIColor redColor];
    cell.priceL.font = [UIFont systemFontOfSize:12];
    cell.priceL.textAlignment = 2;
    return cell;

}



#pragma mark ---collectionView的跳转方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DestionationCityModel *model = self.collectionArr[indexPath.row];
    
    DestinationWebViewController *webV = [[DestinationWebViewController alloc]init];
    
    webV.webID = [NSString stringWithFormat:@"%@",model.collectionID];
    
    [self.navigationController pushViewController:webV animated:YES];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DestionationCityModel *model = self.tableArr[indexPath.row];
    DestinationWebViewController *webV = [[DestinationWebViewController alloc]init];
    webV.webID = [NSString stringWithFormat:@"%@",model.tableID];
    [self.navigationController pushViewController:webV animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FLT_MIN;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height{
    
    return CGRectMake(x*(kScreenWidth/375), y*(kScreenHeight/667), width*(kScreenWidth/375), height*(kScreenHeight/667));
    
}
@end
