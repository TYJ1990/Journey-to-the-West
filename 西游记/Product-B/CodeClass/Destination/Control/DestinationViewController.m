//
//  DestinationViewController.m
//  Product-B
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#define DestinationUrl @"http://open.qyer.com/qyer/footprint/continent_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=40.03623447101837&lon=116.363814398621&page=1&track_app_channel=App%2520Store&track_app_version=6.8&track_device_info=iPhone7%2C1&track_deviceid=7B6FA080-F9FB-44C1-B932-401CD69CD5D2&track_os=ios%25209.1&v=1"


#define buttonImage @"buttonbar_back"
#define buttonZhadian @"扎点_Small_Pressed@2x"

#pragma mark ---工具类

#import "DestinationViewController.h"
#import "DestinationModel.h"
#import "DestinationCollectionViewCell.h"
// 2级界面
#import "DestinationDetailViewController.h"
#import "DestinationWebViewController.h"


@interface DestinationViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

// 七大洲的数组
@property(nonatomic,strong)NSMutableArray *AllArr;
@property(nonatomic,strong)UIImageView *imageV;


// 下方的tableView

@property(nonatomic,strong)UITableView *MytableView;

@property(nonatomic,strong)NSMutableArray *tabArr;

// 中间的CollectionV

@property(nonatomic,strong)UICollectionView *MyCollectionV;

@property(nonatomic,strong)NSMutableArray *collectArr;

// 头视图高度
@property(nonatomic,assign)CGFloat headofHigh;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UILabel *labelfoot;

@property (nonatomic,strong) NSArray *buttonArr;
@end

@implementation DestinationViewController


#pragma mark ---数据的懒加载
-(NSMutableArray *)tabArr
{
    if (!_tabArr) {
        
        _tabArr = [NSMutableArray array];
        
    }
    
    return _tabArr;
}

-(NSMutableArray *)collectArr
{
    if (!_collectArr) {
        
        _collectArr = [NSMutableArray array];
        
    }
    
    return _collectArr;
    
}

-(UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:[self createFrimeWithX:10 andY:180 andWidth:375 andHeight:50]];
        _label.text = @"亚洲热门目的地";
    }
    return _label;
}

-(UILabel *)labelfoot
{
    if (!_labelfoot) {
        _labelfoot = [[UILabel alloc]init];
    }
    return _labelfoot;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}


-(void)requestData
{
    [RequestManager requestWithURLString:DestinationUrl pardic:nil requesttype:requestGET finish:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.AllArr = [DestinationModel modelConfigure:dic];
        
        NSDictionary *firstDic = self.AllArr[0];
        
        self.tabArr = [DestinationModel AllmodelConfigure:firstDic];
        
        self.collectArr = [DestinationModel hotmodelConfigure:firstDic];
        
        [self.MyCollectionV reloadData];
        
        [self.MytableView  reloadData];
    } error:^(NSError *error) {
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"网络错误" message:@"检查网络是否连接" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleCancel) handler:nil];
        
        [ac addAction:act];
        
        [self presentViewController:ac animated:YES completion:nil];
        
    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self titlename];
    
    [self createHead];
    
    [self requestData];
    
    [self CreateTable];
    
}


-(void)createHead
{
    self.imageV = [[UIImageView alloc]initWithFrame:[self createFrimeWithX:0 andY:0 andWidth:375 andHeight:180]];
    
    self.imageV.image = [UIImage imageNamed:@"map@2x"];
    self.imageV.userInteractionEnabled = YES;
    //亚洲的点 tag为100
    UIButton *yazhou = [UIButton buttonWithType:(UIButtonTypeSystem)];
    yazhou.frame = [self createFrimeWithX:305 andY:50 andWidth:40 andHeight:20];
    [yazhou setBackgroundImage:[[UIImage imageNamed:@"buttonbar_back"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]forState:(UIControlStateNormal)];
    yazhou.tag = 100;
    [yazhou setTitle:@"亚洲" forState:(UIControlStateNormal)];
    [yazhou setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
    [yazhou addTarget:self action:@selector(yazhou:) forControlEvents:(UIControlEventTouchUpInside)];
    yazhou.titleLabel.font = [UIFont systemFontOfSize:10];
    
    UIImageView *yazhouD = [[UIImageView alloc]initWithFrame:[self createFrimeWithX:295 andY:55 andWidth:10 andHeight:10]];
    yazhouD.image = [UIImage imageNamed:@"扎点_Small_Pressed@2x"];
    [self.imageV addSubview:yazhou];
    [self.imageV addSubview:yazhouD];
    
    //欧洲的点 tag为101
    UIButton *ouzhou = [UIButton buttonWithType:(UIButtonTypeSystem)];
    ouzhou.frame = [self createFrimeWithX:230 andY:45 andWidth:40 andHeight:20];
    [ouzhou setBackgroundImage:[[UIImage imageNamed:@"buttonbar_back"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [ouzhou setTitle:@"欧洲" forState:(UIControlStateNormal)];
    [ouzhou addTarget:self action:@selector(ouzhou:) forControlEvents:(UIControlEventTouchUpInside)];
    ouzhou.titleLabel.font = [UIFont systemFontOfSize:10];
    ouzhou.tag = 101;
    UIImageView *ouzhouD = [[UIImageView alloc]initWithFrame:[self createFrimeWithX:220 andY:50 andWidth:10 andHeight:10]];
    ouzhouD.image = [UIImage imageNamed:@"扎点_Small_Pressed@2x"];
    [self.imageV addSubview:ouzhouD];
    [self.imageV addSubview:ouzhou];
    
    
    //北美洲的点 tag为102
    UIButton *beimeizhou = [UIButton buttonWithType:(UIButtonTypeSystem)];
    beimeizhou.frame = [self createFrimeWithX:60 andY:45 andWidth:40 andHeight:20];
    [beimeizhou setBackgroundImage:[[UIImage imageNamed:buttonImage]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [beimeizhou addTarget:self action:@selector(beimiezhou:) forControlEvents:(UIControlEventTouchUpInside)];
    [beimeizhou setTitle:@"北美洲" forState:(UIControlStateNormal)];
    beimeizhou.tag = 102;
    beimeizhou.titleLabel.font = [UIFont systemFontOfSize:10];
    UIImageView *beimeizhouD = [[UIImageView alloc]initWithFrame:[self createFrimeWithX:50 andY:50 andWidth:10 andHeight:10]];
    beimeizhouD.image = [UIImage imageNamed:buttonZhadian];
    [self.imageV addSubview:beimeizhouD];
    [self.imageV addSubview:beimeizhou];
    
    //南美洲的点 tag为103
    UIButton *nanmeizhou = [UIButton buttonWithType:(UIButtonTypeSystem)];
    nanmeizhou.frame = [self createFrimeWithX:115 andY:125 andWidth:40 andHeight:20];
    [nanmeizhou setBackgroundImage:[[UIImage imageNamed:buttonImage]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [nanmeizhou addTarget:self action:@selector(nanmeizhou:) forControlEvents:(UIControlEventTouchUpInside)];
    [nanmeizhou setTitle:@"南美洲" forState:(UIControlStateNormal)];
    nanmeizhou.tag = 103;
    nanmeizhou.titleLabel.font = [UIFont systemFontOfSize:10];
    UIImageView *nanmeizhouD = [[UIImageView alloc]initWithFrame:[self createFrimeWithX:105 andY:130 andWidth:10 andHeight:10]];
    nanmeizhouD.image = [UIImage imageNamed:buttonZhadian];
    [self.imageV addSubview:nanmeizhouD];
    [self.imageV addSubview:nanmeizhou];
    
    //大洋洲的点 tag为104
    UIButton *dayangzhou = [UIButton buttonWithType:(UIButtonTypeSystem)];
    dayangzhou.frame = [self createFrimeWithX:330 andY:115 andWidth:40 andHeight:20];
    [dayangzhou setBackgroundImage:[[UIImage imageNamed:buttonImage]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [dayangzhou addTarget:self action:@selector(dayangzhou:) forControlEvents:(UIControlEventTouchUpInside)];
    [dayangzhou setTitle:@"大洋洲" forState:(UIControlStateNormal)];
    dayangzhou.tag = 104;
    dayangzhou.titleLabel.font = [UIFont systemFontOfSize:10];
    UIImageView *dayangzhouD = [[UIImageView alloc]initWithFrame:[self createFrimeWithX:320 andY:120 andWidth:10 andHeight:10]];
    dayangzhouD.image = [UIImage imageNamed:buttonZhadian];
    [self.imageV addSubview:dayangzhou];
    [self.imageV addSubview:dayangzhouD];
    
    //非洲的点 tag为105
    UIButton *feizhou = [UIButton buttonWithType:(UIButtonTypeSystem)];
    feizhou.frame = [self createFrimeWithX:210 andY:115 andWidth:40 andHeight:20];
    [feizhou setBackgroundImage:[[UIImage imageNamed:buttonImage]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [feizhou addTarget:self action:@selector(feizhou:) forControlEvents:(UIControlEventTouchUpInside)];
    [feizhou setTitle:@"非洲" forState:(UIControlStateNormal)];
    feizhou.tag = 105;
    feizhou.titleLabel.font = [UIFont systemFontOfSize:10];
    UIImageView *feizhouD = [[UIImageView alloc]initWithFrame:[self createFrimeWithX:200 andY:120 andWidth:10 andHeight:10]];
    feizhouD.image = [UIImage imageNamed:buttonZhadian];
    [self.imageV addSubview:feizhouD];
    [self.imageV addSubview:feizhou];
    
    
    //南极洲的点 tag为106
    UIButton *nanjizhou = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    nanjizhou.frame = [self createFrimeWithX:255 andY:160 andWidth:40 andHeight:20];
    
    [nanjizhou setBackgroundImage:[[UIImage imageNamed:buttonImage]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [nanjizhou addTarget:self action:@selector(nanjizhou:) forControlEvents:(UIControlEventTouchUpInside)];
    [nanjizhou setTitle:@"南极洲" forState:(UIControlStateNormal)];
    nanjizhou.tag = 106;
    nanjizhou.titleLabel.font = [UIFont systemFontOfSize:10];
    UIImageView *nanjizhouD = [[UIImageView alloc]initWithFrame:[self createFrimeWithX:245 andY:165 andWidth:10 andHeight:10]];
    nanjizhouD.image = [UIImage imageNamed:buttonZhadian];
    [self.imageV addSubview:nanjizhouD];
    [self.imageV addSubview:nanjizhou];
    self.buttonArr = @[yazhou,nanmeizhou,ouzhou,feizhou,beimeizhou,nanjizhou,dayangzhou];
}

#pragma mark ---修改标题、修改导航控制器透明度
-(void)titlename
{
    self.title = @"说走就走";
    
    self.navigationController.title = @"目的地";
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationImage"] forBarMetrics:0];
    
}


#pragma mark ---创建tableView
-(void)CreateTable
{
    self.MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:(UITableViewStyleGrouped)];
    
    self.MytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.MytableView.delegate = self;
    
    self.MytableView.dataSource = self;
    
    self.MytableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.MytableView];
    
   
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tabArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DestinationModel *model = self.tabArr[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Destination"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:
                (UITableViewCellStyleValue2) reuseIdentifier:@"Destination"];
    }
    
    cell.textLabel.text = model.cnname;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.textAlignment = 0;
    cell.detailTextLabel.text = model.enname;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return  cell;
}

#pragma mark --创建头部视图以及collectionV
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.minimumInteritemSpacing = 10;
    
    layout.minimumLineSpacing = 10;
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.itemSize = CGSizeMake((kScreenWidth-30)/2, (kScreenWidth-30)/2*1.2);
    
    layout.headerReferenceSize = CGSizeMake(self.imageV.frame.size.width, self.imageV.frame.size.height+50);

    self.MyCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(10, self.imageV.frame.size.height+50, kScreenWidth-20, (self.collectArr.count+1)/2*(kScreenHeight-50)/2*1.2+30) collectionViewLayout:layout];
    
    self.MyCollectionV.delegate = self;
    
    self.MyCollectionV.dataSource = self;
    
    self.MyCollectionV.scrollEnabled = NO;
    
    self.MyCollectionV.backgroundColor = PKCOLOR(239, 239, 244);
    
    [self.MyCollectionV registerNib:[UINib nibWithNibName:@"DestinationCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ss"];
 
    [self.MyCollectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    
    
   
    
 
    
   
    
    
    return self.MyCollectionV;
    
}

#pragma mark collectionView的头部视图

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *view=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath ];
        
            
        [view addSubview:self.label];
        
        [view addSubview:self.imageV];
        
        return view;
        
    }
    else
    {
        UICollectionReusableView *view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
        view.backgroundColor=[UIColor whiteColor];
        
        return view;
        
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.imageV.frame.size.height+50+(self.collectArr.count+1)/2*(kScreenWidth-30)/2*1.2;
//    return self.MyCollectionV.frame.size.height;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

#pragma mark ---collectionV的代理实现部分

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DestinationModel *model = self.collectArr[indexPath.row];
    
    DestinationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ss" forIndexPath:indexPath];
    
    cell.backV.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
  
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil completed:nil];
    
    cell.countyL.text = model.cnname;
    
    cell.countryEnglish.text = model.enname;
    
    cell.numberOfCity.text = [NSString stringWithFormat:@"%ld",model.count];
    
    cell.numberOfCity.textAlignment = 1;
    
    cell.numberOfCity.alpha = 1;
    
    cell.cityL.text = model.label;
    
    cell.cityL.textAlignment = 1;
    
    cell.cityL.alpha = 1;

    cell.countyL.textColor = [UIColor whiteColor];
    
    cell.countryEnglish.textColor = [UIColor whiteColor];
    
    cell.numberOfCity.textColor = [UIColor whiteColor];
    
    cell.cityL.textColor = [UIColor whiteColor];
    
    return cell;
    
}

#pragma mark ---7大洲的点击方法
// 亚洲
-(void)yazhou:(UIButton *)btn
{
    
    [self.tabArr removeAllObjects];
    [self buttonGreeenWithButton:btn];
    [self.collectArr removeAllObjects];

    NSDictionary *dic = self.AllArr[btn.tag-100];

    self.tabArr = [DestinationModel AllmodelConfigure:dic];
    
    self.collectArr = [DestinationModel hotmodelConfigure:dic];
    
    self.label.text = @"亚洲热门目的地";

    [self.MytableView reloadData];
    
    [self.MyCollectionV reloadData];
    
}

//欧洲
-(void)ouzhou:(UIButton *)btn
{
    [self.tabArr removeAllObjects];
    [self buttonGreeenWithButton:btn];
    [self.collectArr removeAllObjects];
    
    NSDictionary *dic = self.AllArr[btn.tag-100];
    
    self.tabArr = [DestinationModel AllmodelConfigure:dic];
    
    self.collectArr = [DestinationModel hotmodelConfigure:dic];
    
    self.label.text = @"欧洲热门目的地";

    [self.MytableView reloadData];
    
    [self.MyCollectionV reloadData];
    
}

//北美洲
-(void)beimiezhou:(UIButton *)btn
{
    
    [self.tabArr removeAllObjects];
    [self buttonGreeenWithButton:btn];
    [self.collectArr removeAllObjects];
    
    NSDictionary *dic = self.AllArr[btn.tag-100];
    
    self.tabArr = [DestinationModel AllmodelConfigure:dic];
    
    self.collectArr = [DestinationModel hotmodelConfigure:dic];
    
    self.label.text = @"北美洲洲热门目的地";

    [self.MytableView reloadData];
    
    [self.MyCollectionV reloadData];
    
}

//南美洲
-(void)nanmeizhou:(UIButton *)btn
{
    [self.tabArr removeAllObjects];
    [self buttonGreeenWithButton:btn];
    [self.collectArr removeAllObjects];
    
    NSDictionary *dic = self.AllArr[btn.tag-100];
    
    self.tabArr = [DestinationModel AllmodelConfigure:dic];
    
    self.collectArr = [DestinationModel hotmodelConfigure:dic];
    
    self.label.text = @"南美洲热门目的地";

    [self.MytableView reloadData];
    
    [self.MyCollectionV reloadData];
    
}

//大洋洲

-(void)dayangzhou:(UIButton *)btn
{
    [self.tabArr removeAllObjects];
    [self buttonGreeenWithButton:btn];
    [self.collectArr removeAllObjects];

    NSDictionary *dic = self.AllArr[btn.tag-100];
    
    self.tabArr = [DestinationModel AllmodelConfigure:dic];
    
    self.collectArr = [DestinationModel hotmodelConfigure:dic];
    
    self.label.text = @"大洋洲洲热门目的地";

    [self.MytableView reloadData];
    
    [self.MyCollectionV reloadData];
}

//非洲

-(void)feizhou:(UIButton *)btn
{
    [self.tabArr removeAllObjects];
    [self buttonGreeenWithButton:btn];
    [self.collectArr removeAllObjects];

    NSDictionary *dic = self.AllArr[btn.tag-100];

    self.tabArr = [DestinationModel AllmodelConfigure:dic];
    
    self.collectArr = [DestinationModel hotmodelConfigure:dic];
    
    self.label.text = @"非洲洲热门目的地";

    [self.MytableView reloadData];
    
    [self.MyCollectionV reloadData];
  
}

//南极洲
-(void)nanjizhou:(UIButton *)btn
{
    [self buttonGreeenWithButton:btn];
    [self.tabArr removeAllObjects];
    
    [self.collectArr removeAllObjects];

    NSDictionary *dic = self.AllArr[btn.tag-100];

    self.tabArr = [DestinationModel AllmodelConfigure:dic];
    
    self.collectArr = [DestinationModel hotmodelConfigure:dic];
    
    self.label.text = @"南极洲热门目的地";

    [self.MytableView reloadData];
    
    [self.MyCollectionV reloadData];

}
- (void)buttonGreeenWithButton:(UIButton *)butn {
    for (UIButton *btn in self.buttonArr) {
        [btn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    }
    [butn setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
}


#pragma mark ---适配屏幕的方法

-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height{
    
    
    return CGRectMake(x*(kScreenWidth/375), y*(kScreenHeight/667), width*(kScreenWidth/375), height*(kScreenHeight/667));
    
    
}

#pragma mark ---tableView的点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DestinationModel *model = self.tabArr[indexPath.row];
    
    DestinationDetailViewController *detailVC = [[DestinationDetailViewController alloc]init];
    
    detailVC.myID = model.Myid;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

#pragma mark ---CollectionView的点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

  DestinationModel *model = self.collectArr[indexPath.row];
    
    if ([model.label isEqualToString:@"旅行地"]) {
        
        DestinationWebViewController *WebV = [[DestinationWebViewController alloc]init];
        WebV.webID = [NSString stringWithFormat:@"%@",model.Myid];
        [self.navigationController pushViewController:WebV animated:YES];
        
    }else{
        
    DestinationDetailViewController *detailVC = [[DestinationDetailViewController alloc]init];
    
    detailVC.myID = model.Myid;
        detailVC.countryEN = model.enname;
        
        
    [self.navigationController pushViewController:detailVC animated:YES];
  }

}


-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}


-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *act = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"ss" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
    }];
    
    NSArray *arr = [NSArray arrayWithObjects:act, nil];
    
    return arr;
}



//-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    UITableViewRowAction *rowaction = [[UITableViewRowAction alloc]init];
////    
////    NSArray *arr = [NSArray arrayWithObjects:rowaction, nil];
////    
////    return arr;
//    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        <#code#>
//    }]
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
