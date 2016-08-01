//
//  LocalPlayerCollectionViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LocalPlayerCollectionViewCell.h"

@implementation LocalPlayerCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleL = [[UILabel alloc]initWithFrame:self.contentView.frame];
        self.titleL.textAlignment = 1;
        self.titleL.font = [UIFont systemFontOfSize:12];
        self.titleL.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleL];
    }
    return self;
}



-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height
{
    return CGRectMake(x*(kScreenWidth/375), y*(kScreenHeight/667), width*(kScreenWidth/375), height*(kScreenHeight/667));
}

@end
