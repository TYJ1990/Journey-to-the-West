//
//  RecommendFirstCollectionReusableView.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RecommendFirstCollectionReusableView.h"
#import "RecommendScrollViewModel.h"
#import "SleeveViewController.h"
#import "WRDiscountViewController.h"
#import "MapViewController.h"
@implementation RecommendFirstCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.frame=CGRectMake(0, 0, kScreenWidth, kScreenWidth/64 * 30 + 100);
    }
    return self;
}

-(void)creatSubViewsWithImagArrar:(NSMutableArray *)modelArr{
    
    _scrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/64 * 30) DurationTime:2.5];
    _scrollView.fetchContentView = ^ NSString *(NSInteger index){
        return ((RecommendScrollViewModel *)modelArr[index]).photo;
    };
    __block RecommendViewController *vc = self.reVC;
    _scrollView.pages = modelArr.count;
    _scrollView.tapBlock = ^(NSInteger index){
        
            RecommendScrollViewModel *model = modelArr[index];
            RecommendWebViewController *VC = [[RecommendWebViewController alloc] init];
            VC.pathStr = model.url;
        VC.discountID = nil;
        [vc.navigationController pushViewController:VC animated:YES];
    };
    [self addSubview:_scrollView];
    NSArray* arrBtn=@[@"看锦囊",@"抢折扣",@"旅途中"];
    for (int i=0; i<3; i++) {
        UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((kScreenWidth/3.3)*i+ 20 , kScreenWidth/64 * 30 + 10, kScreenWidth / 3.3, 40);
        [btn setTitle:arrBtn[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:PKCOLOR(230, 230, 230)];
        btn.tag=10+i;
        [self addSubview:btn];
    }
    
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(10, kScreenWidth/64 * 30 + 50, 100, 30)];
    label.text=@"发现下一站";
    label.font=[UIFont systemFontOfSize:13];
    label.textColor = PKCOLOR(100, 100, 100);
    label.backgroundColor = PKCOLOR(230, 230, 230);
    [self addSubview:label];

 
}
-(void)pressBtn:(UIButton *)btn{
    if (btn.tag==10) {
        SleeveViewController* sleeve=[[SleeveViewController alloc]init];
        [self.reVC.navigationController pushViewController:sleeve animated:YES];
    }else if (btn.tag==11){
        WRDiscountViewController* discount=[[WRDiscountViewController alloc]init];
        [self.reVC.navigationController pushViewController:discount animated:YES];
    }else{
        MapViewController *mapVC = [[MapViewController alloc] init];
        [self.reVC.navigationController pushViewController:mapVC animated:YES];
    }

}
@end
