//
//  CountryCollViewController.m
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CountryCollViewController.h"
#import "WordModel.h"
#import "CountryModel.h"
#import "CountryCollectionViewCell.h"
#import "CountryHeadView.h"
#import "CityTableViewController.h"
@interface CountryCollViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) NSMutableArray *worldArr;
@property (nonatomic,strong) NSMutableArray *totalArr;
@property (nonatomic,strong) UICollectionView *collectionView;
@end
@implementation CountryCollViewController
static NSString * const reuseIdentifier = @"CountryCollectionViewCell";
- (NSMutableArray *)totalArr {
    if (!_totalArr) {
        _totalArr = [NSMutableArray array];
    }
    return _totalArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CountryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = PKCOLOR(230, 230, 230);
    [self requestNet];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:1] style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
    self.title = @"旅行地";
}
- (void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)requestNet {
    [RequestManager requestWithURLString:self.urlStr pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.worldArr = [WordModel modelCongifureWithJsonDic:dic];
        WordModel *modle = self.worldArr[0];
        modle.isSelect = YES;
        NSMutableArray *IDArr = [NSMutableArray array];
        for (int i = 0; i < self.worldArr.count; i++) {
            NSArray *array = @[];
            [self.totalArr addObject:array];
        WordModel *modle = self.worldArr[i];
            [IDArr addObject:modle.countryID];
        [RequestManager requestWithURLString:[NSString stringWithFormat:self.countryURL,modle.countryID] pardic:nil requesttype:requestGET finish:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *arr = [CountryModel modelCongifureWithJsonDic:dic];
            NSInteger index = [IDArr indexOfObject:modle.countryID];
            [self.totalArr replaceObjectAtIndex:index withObject:arr];
            [self.collectionView reloadData];
        } error:^(NSError *error) {
            
        }];
        }
    } error:^(NSError *error) {
    }];
    
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.worldArr.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    WordModel *modle = self.worldArr[section];
    if (modle.isSelect == YES){
        NSArray *arr = self.totalArr[section];
        return arr.count;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *arr = self.totalArr[indexPath.section];
    CountryModel *model = arr[indexPath.row];
    CountryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell cellConfigureWithModel:model];
//    cell.countryC.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
//    cell.cOUNTRYe.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    return cell;
}
//设置某一个网格的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(175*(kScreenWidth/375.0), 120*(kScreenHeight/667.0));
}
//设置collectionView当前页距离四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 6*(kScreenWidth/375.0), 4*(kScreenWidth/375.0), 6*(kScreenWidth/375.0));
}
//设置最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 6*(kScreenWidth/375.0);
}
//设置最小列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 6*(kScreenWidth/375.0);
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    WordModel *model = self.worldArr[indexPath.section];
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        static NSString* header=@"head";
        CountryHeadView *headview =  [[NSBundle mainBundle] loadNibNamed:@"CountryHeadView" owner:nil options:nil].firstObject;
        headview.frame = CGRectMake(0, 0, kScreenWidth, 50);
        headview.countryName.text = model.cnname;
        if (model.isSelect == YES) {
            headview.typeL.text = @"收起";
            headview.typeImg.image = [UIImage imageNamed:@"上"];
        }else{
            headview.typeL.text = @"展开";
            headview.typeImg.image = [UIImage imageNamed:@"下"];
        }
        headview.tag = 100 + indexPath.section;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zhanaki:)];
        [headview addGestureRecognizer:tap];
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
        [view addSubview:headview];
        return  view;
    }else{
        UICollectionReusableView *footview=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot" forIndexPath:indexPath];
        return  footview;
    }
}
//返回组头视图的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 50);
    
}

//返回组脚视图的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}
- (void)zhanaki:(UITapGestureRecognizer *)tap {
    CountryHeadView *headview = (CountryHeadView *)tap.view;
    NSInteger section = headview.tag - 100;
    WordModel *model = self.worldArr[section];
    model.isSelect = !model.isSelect;
    [self.collectionView reloadData];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CityTableViewController *cityVC = [[CityTableViewController alloc] init];
    [self.navigationController pushViewController:cityVC animated:YES];
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
