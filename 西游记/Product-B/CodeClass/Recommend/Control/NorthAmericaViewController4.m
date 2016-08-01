//
//  NorthAmericaViewController4.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "NorthAmericaViewController4.h"
#import "SleeveImageCell.h"
#import "IntercontinentalModel.h"
#import "IntroHeadView.h"
#import "SleeveDisCountViewController.h"
@interface NorthAmericaViewController4 ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray* dataSource;
    UICollectionView* _collectionView;
}
@property (nonatomic,strong) IntroHeadView *headView;
@end

@implementation NorthAmericaViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建一个网格布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.footerReferenceSize = CGSizeMake(0, 0);
    layout.headerReferenceSize = CGSizeMake(100, 30);
    //创建UICollectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-108) collectionViewLayout:layout];
    //指定代理
    _collectionView.delegate = self;
    //指定数据源代理
    _collectionView.dataSource = self;
    //添加到当前视图上显示
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerClass:[SleeveImageCell class] forCellWithReuseIdentifier:@"SleeveImageCell"];
    [_collectionView registerClass:[IntroHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
    [self reloadDataSource];
}

-(void)reloadDataSource{
    [RequestManager requestWithURLString:NORTHAMERICA pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        dataSource = [IntercontinentalModel modelCongifureWithJsonDic:dic];
        [_collectionView reloadData];
    } error:^(NSError *error) {
        
    }];
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return dataSource.count;
}

//返回collectionView某一组总共显示的Item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *arr = dataSource[section];
    return arr.count;
}
//创建或刷新cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IntercontinentalModel *model = dataSource[indexPath.section][indexPath.row];
    static NSString* sleeveId=@"SleeveImageCell";
    SleeveImageCell* sleeveCell=[collectionView dequeueReusableCellWithReuseIdentifier:sleeveId forIndexPath:indexPath];
    NSString* imageStr=[NSString stringWithFormat:@"%@/260_390.jpg?cover_updatetime=%@",model.cover,model.cover_updatetime];
    [sleeveCell.recImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:kPlacehodeImage completed:nil];
    
    return sleeveCell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    IntercontinentalModel *model = dataSource[indexPath.section][indexPath.row];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        _headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
        _headView.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
        _headView.titleLabel.text = model.name;
        return _headView;
    }else
    {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot" forIndexPath:indexPath];
        view.backgroundColor = [UIColor yellowColor];
        return view;
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    IntercontinentalModel *model = dataSource[indexPath.section][indexPath.row];
    SleeveDisCountViewController *sleDis = [[SleeveDisCountViewController alloc]init];
    sleDis.sleeveID = model.guide_id;
    sleDis.name = model.guide_cnname;
    [self.navigationController pushViewController:sleDis animated:YES];
}

//设置某一个网格的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110*(kScreenWidth/375.0), 160*(kScreenHeight/667.0));
}
//设置collectionView当前页距离四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 2.5*(kScreenWidth/375.0), 0, 2.5*(kScreenHeight/375.0));
}

//设置最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5*(kScreenHeight/667.0);
}
//设置最小列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5*(kScreenHeight/375.0);
}

@end
