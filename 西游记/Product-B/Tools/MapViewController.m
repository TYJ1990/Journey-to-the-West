//
//  MapViewController.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,UISearchBarDelegate>
@property (nonatomic,strong) BMKMapView* mapView;
@property (nonatomic,strong) BMKLocationService *locService;
//一上来就显示当前地理位置
@property (nonatomic,strong) CLLocationManager *locationManager;
// 记录地理位置坐标更新，点击btn时，让地图移动到最新位置上
@property (nonatomic,strong) BMKUserLocation *userLocation;
@property (nonatomic,strong) BMKPointAnnotation *annotation;

// 搜索目的地
@property (nonatomic,strong) UISearchBar *searchBar;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.view = self.mapView;
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
    _locService.distanceFilter = 100.0f; // 如果设为kCLDistanceFilterNone，则每秒更新一次;
    //启动LocationService
    [_locService startUserLocationService];
    
    // 一上来就显示当前地理信息
    // 实例化一个位置管理器
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.mapView setCenterCoordinate:self.locationManager.location.coordinate animated:YES];
    [self initsearchController];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:1] style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
}
- (void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //  NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.userLocation = userLocation;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    self.tabBarController.tabBar.hidden = NO;
    [self.searchBar removeFromSuperview];
}
- (void) viewDidAppear:(BOOL)animated {
    // 添加一个PointAnnotation
    self.annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = self.locationManager.location.coordinate.latitude;
    coor.longitude = self.locationManager.location.coordinate.longitude;
    self.annotation.coordinate = coor;
    //  annotation.title = @"这里是北京";
    [_mapView addAnnotation:self.annotation];
}
// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        //        newAnnotationView.image
        return newAnnotationView;
    }
    return nil;
}
- (void)initsearchController {
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(kScreenWidth/2-100, 6, 200, 30)];
    self.searchBar.placeholder = @"输入目的地";
    self.searchBar.delegate = self;
    [self.navigationController.navigationBar addSubview:self.searchBar];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"GO" style:0 target:self action:@selector(qiognyou)];
}
- (void)qiognyou {

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
