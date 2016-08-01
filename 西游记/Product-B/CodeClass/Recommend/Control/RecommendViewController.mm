//
//  RecommendViewController.m
//  Product-B
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//
#define WIDTH (float)(self.view.window.frame.size.width)
#define HEIGHT (float)(self.view.window.frame.size.height)
#import "RecommendViewController.h"
#import "RecommendScrollViewModel.h"
#import "NextStationModel.h"
#import "DiscountSubjectModel.h"
#import "DiscountModel.h"
#import "RecommendFirstCollectionReusableView.h"
#import "RcmdImageCell.h"
#import "RcmLabelCell.h"
#import "RcmLikeTabCell.h"
#import "RcmSmallCell.h"
#import "WRRecFooterView.h"
#import "WRRecHeaderView.h"
#import "CellModel.h"
#import "RecommendWebViewController.h"
#import "WRAllSpecialViewController.h"
#import "WRDiscountViewController.h"
@interface RecommendViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WRRecFooterViewDelegate,CLLocationManagerDelegate>{
    NSMutableArray* nextStationArray;
    NSMutableArray* discountArray;
    NSMutableArray* discountSubjectArray;
    NSMutableArray* slideArray;
    NSMutableArray* slideUrlArr;
    NSMutableArray* cellModelArray;
    int currentPage;
    CLLocationManager *_locationManager;
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) RecommendFirstCollectionReusableView* headerView;
@property (strong, nonatomic) FeHourGlass *hourGlass;
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title=@"说走就走";
    [self creatCollectionView];
    [self requestNet];
    currentPage = 1;
    cellModelArray = [NSMutableArray array];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //定位管理器
    _locationManager=[[CLLocationManager alloc]init];
    
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
         [_locationManager requestWhenInUseAuthorization];
    }
    
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
        UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"开启定位" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [_locationManager requestWhenInUseAuthorization];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        [alterVC addAction:ac];
        [alterVC addAction:ac1];
        [self presentViewController:alterVC animated:YES completion:nil];
        
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        _locationManager.distanceFilter=distance;
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    }

}
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
}
#pragma mark --- collectionView ---
- (void)creatCollectionView {
    //创建一个网格布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) collectionViewLayout:layout];
    //指定代理
    _collectionView.delegate = self;
    //指定数据源代理
    _collectionView.dataSource = self;
    //添加到当前视图上显示
    _collectionView.backgroundColor = PKCOLOR(230, 230, 230);
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[RcmdImageCell class] forCellWithReuseIdentifier:@"RcmdImageCell"];
    [_collectionView registerClass:[RcmSmallCell class] forCellWithReuseIdentifier:@"RcmSmallCell"];
    [_collectionView registerClass:[RcmLabelCell class] forCellWithReuseIdentifier:@"RcmLabelCell"];
    [_collectionView registerClass:[RcmLikeTabCell class] forCellWithReuseIdentifier:@"RcmLikeTabCell"];
    
    [_collectionView registerClass:[RecommendFirstCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ADheadView"];
    [_collectionView registerClass:[WRRecHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WRRecHeaderView"];
    [_collectionView registerClass:[WRRecFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WRRecFooterView"];
    self.collectionView .mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        currentPage = 1;
        [self requestNet];
    }];
    
    self.collectionView .mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        currentPage++;
        [self requestNet];
    }];

}
#pragma mark --- 网络请求 --- 
- (void)requestNet {
    _hourGlass = [[FeHourGlass alloc] initWithView:self.view];
    [self.view addSubview:_hourGlass];
    [_hourGlass showWhileExecutingBlock:^{
        [self myTask];
    } completion:^{
    }];
    [RequestManager requestWithURLString:RecoumendUrl pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        slideArray = [RecommendScrollViewModel modelCongifureWithJsonDic:dic];
        nextStationArray = [NextStationModel modelCongifureWithJsonDic:dic];
        discountArray = [DiscountModel modelCongifureWithJsonDic:dic];
        discountSubjectArray = [DiscountSubjectModel modelCongifureWithJsonDic:dic];
        [self.headerView creatSubViewsWithImagArrar:slideArray];
        [self.collectionView reloadData];
    } error:^(NSError *error) {
        
    }];
    NSString* travelnote=[NSString stringWithFormat:RecoumendUrl1,currentPage,RecoumendUrl2];
    [RequestManager requestWithURLString:travelnote pardic:nil requesttype:requestGET finish:^(NSData *data) {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *arr = [CellModel modelCongifureWithJsonDic:dic];
        if (currentPage == 1) {
            [cellModelArray removeAllObjects];
        }
        [cellModelArray addObjectsFromArray:arr];
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
        [_hourGlass removeFromSuperview];
    } error:^(NSError *error) {
        
    }];
}
- (void)myTask
{
    // Do something usefull in here instead of sleeping ...
    sleep(12);
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return nextStationArray.count;
    }else if (section == 1){
        return discountArray.count + discountSubjectArray.count - 1;
    }
    return cellModelArray.count;
}
//创建或刷新cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        NextStationModel *model = nextStationArray[indexPath.row];
        if (indexPath.row==0) {
            
            static NSString* cellIDImage=@"RcmdImageCell";
            RcmdImageCell* rcmdImageCell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIDImage forIndexPath:indexPath];
                [rcmdImageCell.recImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:kPlacehodeImage completed:nil];
            return rcmdImageCell;
        }else{
            static NSString* cellIDSmall=@"RcmSmallCell";
            RcmSmallCell* rcmSmallCell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIDSmall forIndexPath:indexPath];
                [rcmSmallCell.recImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:kPlacehodeImage completed:nil];
        
            return rcmSmallCell;
        }
    }else if (indexPath.section==1){
        if (discountArray.count != 0) {
        if (indexPath.row==0) {
            static NSString* cellIDImage=@"RcmdImageCell";
            RcmdImageCell* rcmdImageCell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIDImage forIndexPath:indexPath];
            //discount_subject
            
                DiscountModel *model = discountArray[indexPath.row];
                [rcmdImageCell.recImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:kPlacehodeImage completed:nil];
            return rcmdImageCell;
            }else{
                NSLog(@"++++++++%ld",discountSubjectArray.count);
            DiscountSubjectModel *model = discountSubjectArray[indexPath.row - 1];
            static NSString* cellIDLabel=@"RcmLabelCell";
            RcmLabelCell* rcmLabelCell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIDLabel forIndexPath:indexPath];
            [rcmLabelCell cellCongigureWithModel:model];
            return rcmLabelCell;
        }
        }else{
            DiscountSubjectModel *model = discountSubjectArray[indexPath.row];
            static NSString* cellIDLabel=@"RcmLabelCell";
            RcmLabelCell* rcmLabelCell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIDLabel forIndexPath:indexPath];
            [rcmLabelCell cellCongigureWithModel:model];
            return rcmLabelCell;
        }
    }else{
        //array3
        static NSString* cellIDTab=@"RcmLikeTabCell";
        RcmLikeTabCell* rcmdTabCell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIDTab forIndexPath:indexPath];
        CellModel *model = cellModelArray[indexPath.row];
        [rcmdTabCell cellCongigureWithModel:model];
        return rcmdTabCell;
    }
    
}
//设置某一个网格的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return CGSizeMake(357*(WIDTH/375.0), 120*(HEIGHT/667.0));
        }else{
            return CGSizeMake(182*(WIDTH/375.0), 100*(HEIGHT/667.0));
        }
    }else if (indexPath.section==1){
        if (discountArray.count != 0) {
        if (indexPath.row==0) {
            return CGSizeMake(357*(WIDTH/375.0), 120*(HEIGHT/667.0));
        }else{
            return CGSizeMake(182*(WIDTH/375.0), 160*(HEIGHT/667.0));
        }
        }else{
            return CGSizeMake(182*(WIDTH/375.0), 160*(HEIGHT/667.0));
        }
    }else{
        return CGSizeMake(357*(WIDTH/375.0), 80*(HEIGHT/667.0));
    }
}
//设置collectionView当前页距离四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 2.5*(WIDTH/375.0),0, 2.5*(WIDTH/375.0));
}
//设置最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return 7*(HEIGHT/667.0);
    }else if(section==1){
        return 7*(HEIGHT/667.0);
    }else{
        return 3*(HEIGHT/667.0);
    }
}
//设置最小列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else if(section==1){
        return 5*(WIDTH/375.0);
    }else{
        return 0;
    }
}
//设置组头视图或组脚视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        //头视图
        if([kind isEqualToString:UICollectionElementKindSectionHeader]){
            static NSString* header=@"ADheadView";
            self.headerView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
            self.headerView.reVC = self;
            return  self.headerView;
        }else{
            static NSString* footer=@"WRRecFooterView";
            WRRecFooterView* footerView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footer forIndexPath:indexPath];
            [footerView.footBtn setTitle:@"查看更多精彩专题" forState:UIControlStateNormal];
            footerView.delegate=self;
            return footerView;
        }
        
    }else if (indexPath.section==1){
        //头视图
        if([kind isEqualToString:UICollectionElementKindSectionHeader]){
            static NSString* header=@"WRRecHeaderView";
            WRRecHeaderView* headerView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
            headerView.titleLabel.text=@"抢特价折扣";
            return headerView;
        }else{
            static NSString* footer=@"WRRecFooterView";
            WRRecFooterView* footerView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footer forIndexPath:indexPath];
            [footerView.footBtn setTitle:@"查看全部特价折扣" forState:UIControlStateNormal];
            footerView.delegate=self;
            return footerView;
        }
        
    }else{
        //头视图d
        if([kind isEqualToString:UICollectionElementKindSectionHeader]){
            static NSString* header=@"WRRecHeaderView";
            WRRecHeaderView* headerView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
            headerView.titleLabel.text=@"看热门游记";
            return headerView;
        }else{
            static NSString* footer=@"WRRecFooterView";
            WRRecFooterView* footerView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footer forIndexPath:indexPath];
            
            return footerView;
        }
    }
}
-(void)sendBtnTitle:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"查看更多精彩专题"]) {
        WRAllSpecialViewController* allSpecial=[[WRAllSpecialViewController alloc]init];
        [self.navigationController pushViewController:allSpecial animated:YES];
    }else{
        WRDiscountViewController* discount=[[WRDiscountViewController alloc]init];
        [self.navigationController pushViewController:discount animated:YES];
    }
}
//返回组头视图的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CGSizeMake(self.view.frame.size.width, kScreenWidth/64 * 30 + 80);
    }else if(section==1){
        return CGSizeMake(0, 40*(HEIGHT/667.0));
    }else{
        return CGSizeMake(0, 40*(HEIGHT/667.0));
    }
}

//返回组脚视图的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return CGSizeMake(self.view.frame.size.width, 40*(HEIGHT/667.0));
    }else if(section==1){
        return CGSizeMake(0, 40*(HEIGHT/667.0));
    }else{
        return CGSizeMake(0, 0);
    }
}
//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (discountArray.count != 0) {
            if (indexPath.row>=1&&indexPath.row<=4) {
            DiscountSubjectModel *model = discountSubjectArray[indexPath.row - 1];
      //  NSNumber* discountID=dataSource[indexPath.section][indexPath.row][@"id"];
        RecommendWebViewController* webView=[[RecommendWebViewController alloc]init];
        webView.discountID = model.myID;
        [self.navigationController pushViewController:webView animated:YES];
            }else{
                DiscountModel *model = discountArray[indexPath.row];
                RecommendWebViewController* webView=[[RecommendWebViewController alloc]init];
                webView.pathStr = model.url;
                [self.navigationController pushViewController:webView animated:YES];
            }
        }else{
            DiscountSubjectModel *model = discountSubjectArray[indexPath.row];
            //  NSNumber* discountID=dataSource[indexPath.section][indexPath.row][@"id"];
            RecommendWebViewController* webView=[[RecommendWebViewController alloc]init];
            webView.discountID = model.myID;
            [self.navigationController pushViewController:webView animated:YES];
        }
    }else if (indexPath.section==2){
        CellModel *model = cellModelArray[indexPath.row];
        RecommendWebViewController* webView=[[RecommendWebViewController alloc]init];
        webView.pathStr = model.view_url;
        [self.navigationController pushViewController:webView animated:YES];
    }else{
        RecommendWebViewController* webView=[[RecommendWebViewController alloc]init];
        NextStationModel *model = nextStationArray[indexPath.row];
        webView.pathStr = model.url;
        [self.navigationController pushViewController:webView animated:YES];
    }
    
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
