//
//  WriterViewController.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//
#define goneCountryURL @"http://open.qyer.com/qyer/footprint/gone_city_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&country_id=%@&lat=31.1301092668289&lon=121.2839416585626&page=1&track_app_channel=App2520Store&track_app_version=6.9.4&track_device_info=iPhone25205s&track_deviceid=94F70022-4846-4FC9-A365-FE5CB11C6A2A&track_os=ios25209.3.2&user_id=2878443&v=1"
#define wantCountryURL @"http://open.qyer.com/qyer/footprint/want_city_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&country_id=%@&lat=31.1301092668289&lon=121.2839416585626&page=1&track_app_channel=App2520Store&track_app_version=6.9.4&track_device_info=iPhone25205s&track_deviceid=94F70022-4846-4FC9-A365-FE5CB11C6A2A&track_os=ios25209.3.2&user_id=2878443&v=1"
#define goneURL @"http://open.qyer.com/qyer/footprint/gone_country_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=31.1301092668289&lon=121.2839416585626&page=1&track_app_channel=App%2520Store&track_app_version=6.9.4&track_device_info=iPhone%25205s&track_deviceid=94F70022-4846-4FC9-A365-FE5CB11C6A2A&track_os=ios%25209.3.2&user_id=2878443&v=1"
#define wantURL @"http://open.qyer.com/qyer/footprint/want_country_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=31.1301092668289&lon=121.2839416585626&page=1&track_app_channel=App%2520Store&track_app_version=6.9.4&track_device_info=iPhone%25205s&track_deviceid=94F70022-4846-4FC9-A365-FE5CB11C6A2A&track_os=ios%25209.3.2&user_id=2878443&v=1"
#define mapURL @"http://static.qyer.com/upload/app/usermapphoto/85/422552_1080x587.jpg?rnd=1468914612"
#define WriterURL @"http://open.qyer.com/qyer/user/profile?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=45.4343376159668&lon=12.33878421783447&page=1&track_app_channel=App%2520Store&track_app_version=6.9.4&track_device_info=iPhone5%2C3&track_deviceid=1D958DFF-4880-4594-BA79-F4F887D99C93&track_os=ios%25209.3.1&user_id=1650504&v=1"
#import "WriterModel.h"
#import "WriterViewController.h"
#import "WriterHeadView.h"
#import "WriterMapCollectionViewCell.h"
#import "WriterSecCollectionViewCell.h"
#import "WriterThCollectionViewCell.h"
#import "CountryCollViewController.h"
@interface WriterViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    WriterHeadView *headView;
    UICollectionView *_collectionView;
    WriterModel *writerModel;
}
@property (strong, nonatomic) FeHourGlass *hourGlass;
@end

@implementation WriterViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;// 状态栏字体颜色
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
   // self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectionView];
    [self requestNet];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:1] style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
    self.title = @"锦囊作者";
}
- (void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --- 网络请求 --- 
- (void)requestNet {
    _hourGlass = [[FeHourGlass alloc] initWithView:self.view];
    [self.view addSubview:_hourGlass];
    [_hourGlass showWhileExecutingBlock:^{
        [self myTask];
    } completion:^{
    }];
    [RequestManager requestWithURLString:WriterURL pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil][@"data"];
        writerModel = [[WriterModel alloc] init];
        [writerModel setValuesForKeysWithDictionary:dic];
        [headView.backImag sd_setImageWithURL:[NSURL URLWithString:writerModel.cover] placeholderImage:kPlacehodeImage completed:nil];
        [headView.imageV sd_setImageWithURL:[NSURL URLWithString:writerModel.avatar] placeholderImage:kPlacehodeImage completed:nil];
        headView.nameL.text = writerModel.username;
        if (writerModel.follow == nil) {
            [headView.addObserve setTitle:[NSString stringWithFormat:@"0关注"] forState:(UIControlStateNormal)];
            [headView.fans setTitle:[NSString stringWithFormat:@"0粉丝"] forState:(UIControlStateNormal)];
        }else{
        [headView.addObserve setTitle:[NSString stringWithFormat:@"%@关注",writerModel.follow] forState:(UIControlStateNormal)];
            [headView.fans setTitle:[NSString stringWithFormat:@"%@粉丝",writerModel.fans] forState:(UIControlStateNormal)];
            [_collectionView reloadData];
            [_hourGlass removeFromSuperview];
        }
    } error:^(NSError *error) {
        
    }];
}
- (void)myTask
{
    // Do something usefull in here instead of sleeping ...
    sleep(12);
}
#pragma mark --- clooectionView ---
- (void)initCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = PKCOLOR(230, 230, 230);
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
    [_collectionView registerNib:[UINib nibWithNibName:@"WriterMapCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WriterMapCollectionViewCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"WriterSecCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WriterSecCollectionViewCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"WriterThCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WriterThCollectionViewCell"];
    headView  = [[WriterHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*1.7/5)];
    [_collectionView addSubview:headView];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }
    return 4;
}
//创建或刷新cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WriterMapCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WriterMapCollectionViewCell" forIndexPath:indexPath];
        [cell.mapImage sd_setImageWithURL:[NSURL URLWithString:mapURL] placeholderImage:kPlacehodeImage completed:nil];
        return cell;
    }else if (indexPath.section == 1){
        WriterSecCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WriterSecCollectionViewCell" forIndexPath:indexPath];
        cell.backgroundColor = PKCOLOR(250, 250, 250);
        NSArray *tilArr = @[@"足迹",@"想去"];
        cell.typeL.text = tilArr[indexPath.row];
        if (writerModel.cities == nil) {
            cell.wantL.text = [NSString stringWithFormat:@"0国家"];
            cell.customerL.text = [NSString stringWithFormat:@"0城市"];
        }else{
        if (indexPath.row == 0) {
            cell.wantL.text = [NSString stringWithFormat:@"%@国家",writerModel.countries];
            cell.customerL.text = [NSString stringWithFormat:@"%@城市",writerModel.cities];
        }else{
        cell.wantL.text = [NSString stringWithFormat:@"%@国家",writerModel.want_counties];
            cell.customerL.text = [NSString stringWithFormat:@"%@城市",writerModel.want_cities];
           }
        }
        return cell;
    }
    WriterThCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WriterThCollectionViewCell" forIndexPath:indexPath];
    NSArray *picArr = @[@"zu",@"tie",@"wen.png",@"jie"];
    NSArray *tilArr = @[@"Ta的行程",@"Ta的帖子",@"Ta的问答",@"Ta的结伴"];
    cell.typlImag.image = [UIImage imageNamed:picArr[indexPath.row]];
    cell.typeL.text = tilArr[indexPath.row];
    cell.backgroundColor = PKCOLOR(250, 250, 250);
       return cell;

}
//设置某一个网格的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
            return CGSizeMake(kScreenWidth, 180*(kScreenHeight/667.0));
        }else if (indexPath.section==1){
            return CGSizeMake(184*(kScreenWidth/375.0), 70*(kScreenHeight/667.0));
    }else{
        return CGSizeMake(kScreenWidth, 40*(kScreenHeight/667.0));
    }
}
//设置collectionView当前页距离四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2.5*(kScreenWidth/375.0), 0,0, 0);
}
//设置最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置最小列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else if(section==1){
        return 1.5*(kScreenWidth/375.0);
    }else{
        return 0;
    }
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //头视图
        if([kind isEqualToString:UICollectionElementKindSectionHeader]){
            static NSString* header=@"head";
            UICollectionReusableView *view=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
            view.alpha = 0.0;
            return  view;
        }else{
            UICollectionReusableView *footview=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot" forIndexPath:indexPath];
            return  footview;
        }
    }else{
        if([kind isEqualToString:UICollectionElementKindSectionHeader]){
            static NSString* header=@"head";
            UICollectionReusableView *view=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
            return  view;
        }else{
            UICollectionReusableView *footview=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot" forIndexPath:indexPath];
            return  footview;
        }
    }
}
//返回组头视图的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(kScreenWidth, kScreenHeight*1.7/5);
    }else{
        return CGSizeMake(0, 0);
    }    
}

//返回组脚视图的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     CGFloat offsetY = 0;
    offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        headView.frame = CGRectMake(offsetY / 2, offsetY, kScreenWidth - offsetY, kScreenHeight*1.7/5 - offsetY);  // 修改头部的frame值就行了
    }
}

#pragma mark --- cell点击方法 ---
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        CountryCollViewController *countryVC = [[CountryCollViewController alloc] init];
         if (indexPath.row == 0) {
             countryVC.urlStr = goneURL;
             countryVC.countryURL = goneCountryURL;
         }else{
             countryVC.urlStr = wantURL;
             countryVC.countryURL = wantCountryURL;
         }
        [self.navigationController pushViewController:countryVC animated:YES];
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
