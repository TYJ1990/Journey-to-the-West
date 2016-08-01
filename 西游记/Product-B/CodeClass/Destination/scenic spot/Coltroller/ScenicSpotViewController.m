//
//  ScenicSpotViewController.m
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//
#define scenic @"http://open.qyer.com/qyer/place/city_poi_list?category_id=151&city_id="

#define scenic2 @"http://open.qyer.com/qyer/place/city_poi_list?category_id=78&city_id="

#define scenic3 @"http://open.qyer.com/qyer/place/city_poi_list?category_id=147&city_id="

#define scenic4 @"http://open.qyer.com/qyer/place/city_poi_list?category_id=152&city_id="

#define scenicTWO @"&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=10&lat=31.12818908691405&lon=121.2835540771484&orderby=1&page=1&track_app_channel=App%2520Store&track_app_version=6.9.4&track_device_info=iPhone7%2C2&track_deviceid=FDA917EF-BF2C-4F87-A49E-81DE31077108&track_os=ios%25209.2&v=1"

#import "ScenicSpotViewController.h"
#import "ScenicModel.h"
#import "ScenicCollectionViewCell.h"
#import "ScenicTableViewCell.h"
#import "UIWEBController.h"
@interface ScenicSpotViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate>
// 头部的标签按钮
@property(nonatomic,strong)UIScrollView *headSrc;
@property(nonatomic,strong)NSMutableArray *BtnArr;

// 中间collectionView的图片
@property(nonatomic,strong)UICollectionView *collectionV;

@property(nonatomic,strong)NSMutableArray *collectionArr;

// 下面的tableV
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSMutableArray *tabArr;

@property(nonatomic,strong)NSString *path;

// 跳动的View
@property(nonatomic,strong)UIView *jumpview;

@end

@implementation ScenicSpotViewController
#pragma mark ---懒加载

-(NSMutableArray *)BtnArr
{
    if (!_BtnArr) {
        _BtnArr = [NSMutableArray array];
    }
    return _BtnArr;
}

-(NSMutableArray *)tabArr
{
    if (!_tabArr) {
        _tabArr = [NSMutableArray array];
    }
    return _tabArr;
}

-(NSMutableArray *)collectionArr
{
    if (!_collectionArr) {
        _collectionArr = [NSMutableArray array];
    }
    return _collectionArr;
}


-(void)changNavi
{
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.title = @"全部目的地";
}

-(void)requestData
{
    
    
    NSLog(@"%@",self.path);
    [RequestManager requestWithURLString:self.path pardic:nil requesttype:requestGET finish:^(NSData *data) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.collectionArr = [ScenicModel  collectionConfigureModel:jsonDic];
        
        [self.collectionV reloadData];
        
        self.tabArr = [ScenicModel tableVConfigureModel:jsonDic];
        [self.tableV reloadData];

    } error:^(NSError *error) {
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"网络错误" message:@"检查网络是否连接" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleCancel) handler:nil];
        
        [ac addAction:act];
        
        [self presentViewController:ac animated:YES completion:nil];

    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if ([self.type isEqualToString:@"scenic"]) {
        self.path = [NSString stringWithFormat:@"%@%@%@",scenic,self.ID,scenicTWO];
    }else
    {
        self.path = [NSString stringWithFormat:@"%@%@%@",scenic2,self.ID,scenicTWO];
       
        
    }
    
        self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self changNavi];
    
    [self requestData];
    
    [self createHeadSrc];
    
    [self createTableV];
    
}

-(void)createHeadSrc
{
    self.headSrc = [[UIScrollView alloc]initWithFrame:[self createFrimeWithX:0 andY:0 andWidth:375 andHeight:50]];
    self.headSrc.contentSize = CGSizeMake(kScreenWidth, self.headSrc.frame.size.height);
    
    NSArray *arr = @[@"景点观光",@"美食",@"购物",@"休闲娱乐",@"更多分类"];
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        
        btn.frame = [self createFrimeWithX:5+75*i andY:0 andWidth:65 andHeight:50];
        
        [btn setTitle:arr[i] forState:(UIControlStateNormal)];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        btn.titleLabel.textAlignment = 1;
        
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        btn.tag = 100+i;
        
       
        
        [btn addTarget:self action:@selector(nextView:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.headSrc addSubview:btn];
     
        [self.BtnArr addObject:btn];
        
    }
    
     self.jumpview = [[UIView alloc]init];
    
    if ([self.type isEqualToString:@"food"]) {
        self.jumpview.frame = [self createFrimeWithX:75 andY:45 andWidth:65 andHeight:5];
        UIButton *btn = self.BtnArr[1];
        
            
            [btn setTitleColor:PKCOLOR(59, 191, 118) forState:(UIControlStateNormal)];
            
        
        
    }else
    {
        self.jumpview.frame = [self createFrimeWithX:0 andY:45 andWidth:65 andHeight:5];
        UIButton *btn = self.BtnArr[0];
        
        
        [btn setTitleColor:PKCOLOR(59, 191, 118) forState:(UIControlStateNormal)];
        
    }
    
    
    self.jumpview.backgroundColor = PKCOLOR(59, 191, 118);
    
    [self.view addSubview:self.jumpview];
    [self.view addSubview:self.headSrc];

}

#pragma mark ---头部标签按钮对应的下面视图
// 根据tag值不同来决定怎么跳转
-(void)nextView:(UIButton *)btn
{
    for (UIButton *btn in self.BtnArr) {
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    [btn setTitleColor:PKCOLOR(59, 191, 118) forState:(UIControlStateNormal)];
    
    if (btn.tag==100) {
        self.path = [NSString stringWithFormat:@"%@%@%@",scenic,self.ID,scenicTWO];
        [self requestData];
      
    }else if (btn.tag==101)
    {
        self.path = [NSString stringWithFormat:@"%@%@%@",scenic2,self.ID,scenicTWO];
        [self requestData];
      
    }else if (btn.tag==102)
    {
        self.path = [NSString stringWithFormat:@"%@%@%@",scenic3,self.ID,scenicTWO];
        [self requestData];
        
    }else if (btn.tag==103)
    {
        self.path = [NSString stringWithFormat:@"%@%@%@",scenic4,self.ID,scenicTWO];
        [self requestData];
    
    }
//    self.jumpview = [[UIView alloc]initWithFrame:[self createFrimeWithX:5 andY:42 andWidth:75 andHeight:5]];
    [UIView animateWithDuration:0.5 animations:^{
        self.jumpview.frame = [self createFrimeWithX:75*(btn.tag-100) andY:45 andWidth:75 andHeight:5];
    } completion:nil];
    
    
    
}

#pragma mark ---头部视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.minimumInteritemSpacing = 10 ;
    
    layout.minimumLineSpacing  = 10;
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    layout.itemSize = CGSizeMake(120, 80);
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionV = [[UICollectionView alloc]initWithFrame:[self createFrimeWithX:0 andY:0 andWidth:375 andHeight:100] collectionViewLayout:layout];
    
    self.collectionV.delegate = self;
    
    self.collectionV.dataSource = self;
    
    self.collectionV.backgroundColor = PKCOLOR(239, 239, 244);
    
    self.collectionV.showsHorizontalScrollIndicator = NO;
    
    [self.collectionV registerNib:[UINib nibWithNibName:@"ScenicCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ScenicCollectionCell"];
    
    return self.collectionV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.collectionArr.count==0) {
        return 0.1;
    }else
    {
        return 100;
        
    }
}


#pragma mark ---collectionview的代理实现方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ScenicModel *model = self.collectionArr[indexPath.row];
    
    ScenicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ScenicCollectionCell" forIndexPath:indexPath];
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:nil completed:nil];
    
    cell.titleL.text = model.title;
    
    cell.titleL.textAlignment = 1;
    
    cell.titleL.textColor = [UIColor whiteColor];
    
    cell.titleL.font = [UIFont systemFontOfSize:12];
    
    return cell;
    
}


#pragma mark ---创建tableView

-(void)createTableV
{
    self.tableV = [[UITableView alloc]initWithFrame:[self createFrimeWithX:0 andY:50 andWidth:375 andHeight:667-87] style:(UITableViewStyleGrouped)];
    
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.tableV.separatorColor = [UIColor redColor];
    
    self.tableV.delegate =self;
    
    self.tableV.dataSource =self;

    [self.tableV registerClass:[ScenicTableViewCell class] forCellReuseIdentifier:@"ss"];
    
    [self.view addSubview:self.tableV];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tabArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScenicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss" forIndexPath:indexPath];

    cell.DiscountitleL.text = nil;
    cell.DiscountitleL2.text = nil;
    cell.DiscountpriceL.text = nil;
    cell.DiscountpriceL2.text  = nil;
    ScenicModel *model = self.tabArr[indexPath.row];
    
    if (model.discounts.count==0) {
        model.NumberOfDiscount = noDiscount;
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil completed:nil];
        cell.titleLabel.text = model.chinesename;
        cell.titleLabel.font = [UIFont systemFontOfSize:15];
        
        cell.gradeL.text =model.grade;
        cell.gradeL.font = [UIFont systemFontOfSize:12];
        cell.gradeL.textColor = [UIColor grayColor];
        cell.rankL.text = model.rank;
        cell.rankL.font = [UIFont systemFontOfSize:12];
        cell.rankL.textColor = [UIColor grayColor];
        
        cell.beennumberL.text = [NSString stringWithFormat:@"%@",model.beennumber];
        cell.beennumberL.font = [UIFont systemFontOfSize:12];
        cell.beennumberL.textColor = [UIColor grayColor];
        
        cell.catenameL.text = model.catename;
        cell.catenameL.font = [UIFont systemFontOfSize:12];
        cell.catenameL.textColor = [UIColor grayColor];
        
        cell.distanceL.text = model.distance;
        cell.distanceL.font = [UIFont systemFontOfSize:12];
        cell.distanceL.textColor = [UIColor grayColor];

    }else if(model.discounts.count==1)
    {
        model.NumberOfDiscount = oneDiscount;
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil completed:nil];
        cell.titleLabel.text = model.chinesename;
        cell.titleLabel.font = [UIFont systemFontOfSize:15];
        
        cell.gradeL.text =model.grade;
        cell.gradeL.font = [UIFont systemFontOfSize:12];
        cell.gradeL.textColor = [UIColor grayColor];
        cell.rankL.text = model.rank;
        cell.rankL.font = [UIFont systemFontOfSize:12];
        cell.rankL.textColor = [UIColor grayColor];
        
        cell.beennumberL.text = [NSString stringWithFormat:@"%@",model.beennumber];
        cell.beennumberL.font = [UIFont systemFontOfSize:12];
        cell.beennumberL.textColor = [UIColor grayColor];
        
        cell.catenameL.text = model.catename;
        cell.catenameL.font = [UIFont systemFontOfSize:12];
        cell.catenameL.textColor = [UIColor grayColor];
        
        cell.distanceL.text = model.distance;
        cell.distanceL.font = [UIFont systemFontOfSize:12];
        cell.distanceL.textColor = [UIColor grayColor];
        
        ScenicModel *model1 = model.discounts[0];
        cell.DiscountitleL.text = model1.title;
        cell.DiscountpriceL.text = model1.price;
    }else
    {
        model.NumberOfDiscount = twoDiscount;
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil completed:nil];
        cell.titleLabel.text = model.chinesename;
        cell.titleLabel.font = [UIFont systemFontOfSize:15];
        
        cell.gradeL.text =model.grade;
        cell.gradeL.font = [UIFont systemFontOfSize:12];
        cell.gradeL.textColor = [UIColor grayColor];
        cell.rankL.text = model.rank;
        cell.rankL.font = [UIFont systemFontOfSize:12];
        cell.rankL.textColor = [UIColor grayColor];
        
        cell.beennumberL.text = [NSString stringWithFormat:@"%@",model.beennumber];
        cell.beennumberL.font = [UIFont systemFontOfSize:12];
        cell.beennumberL.textColor = [UIColor grayColor];
        
        cell.catenameL.text = model.catename;
        cell.catenameL.font = [UIFont systemFontOfSize:12];
        cell.catenameL.textColor = [UIColor grayColor];
        
        cell.distanceL.text = model.distance;
        cell.distanceL.font = [UIFont systemFontOfSize:12];
        cell.distanceL.textColor = [UIColor grayColor];
        
        ScenicModel *model1 = model.discounts[0];
        cell.DiscountitleL.text = model1.title;
        cell.DiscountitleL.font = [UIFont systemFontOfSize:12];
        cell.DiscountpriceL.text = model1.price;
        cell.DiscountpriceL.font = [UIFont systemFontOfSize:12];
        
        ScenicModel *model2 = model.discounts[1];
        cell.DiscountitleL2.text = model2.title;
        cell.DiscountitleL2.font = [UIFont systemFontOfSize:12];
        cell.DiscountpriceL2.text = model2.price;
        cell.DiscountpriceL2.font = [UIFont systemFontOfSize:12];
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScenicModel *model = self.tabArr[indexPath.row];

    if (model.NumberOfDiscount==noDiscount) {
        
        return 120;
        
    }else if (model.NumberOfDiscount==oneDiscount)
    {
        return 160;
    
    }else
    {
        return 200;
    }
    

}


#pragma mark ---CollcetionV的点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ScenicModel *model = self.collectionArr[indexPath.row];
    
    UIWEBController *webV = [[UIWEBController alloc]init];
    
    webV.htmlUrl = model.link;
    
    [self.navigationController pushViewController:webV animated:YES];
    
}

#pragma mark ---tableView的点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}







// 适配屏幕方法
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
