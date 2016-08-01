//
//  ScenicTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ScenicTableViewCell.h"

@implementation ScenicTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[UIImageView alloc]initWithFrame:[self createFrimeWithX:10 andY:10 andWidth:100 andHeight:100]];
        [self.contentView addSubview:self.imageV];
        self.titleLabel = [[UILabel alloc]initWithFrame:[self createFrimeWithX:120 andY:10 andWidth:200 andHeight:20]];
        [self.contentView addSubview:self.titleLabel];
        self.gradeV = [[UIImageView alloc]initWithFrame:[self createFrimeWithX:120 andY:40 andWidth:80 andHeight:20 ]];
        [self.contentView addSubview:self.gradeV];
        self.gradeL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:180 andY:40 andWidth:40 andHeight:20]];
        [self.contentView addSubview:self.gradeL];
        self.rankL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:220 andY:40 andWidth:175 andHeight:20]];
        [self.contentView addSubview:self.rankL];
        self.beennumberL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:120 andY:60 andWidth:200 andHeight:20]];
        [self.contentView addSubview:self.beennumberL];
        self.catenameL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:120 andY:90 andWidth:180 andHeight:20]];
        [self.contentView addSubview:self.catenameL];
        self.distanceL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:300 andY:90 andWidth:70 andHeight:20]];
        [self.contentView addSubview:self.distanceL];
        self.DiscountitleL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:40 andY:130 andWidth:240 andHeight:20]];
        self.DiscountitleL.font = [UIFont systemFontOfSize:12];
        self.DiscountitleL.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:self.DiscountitleL];
        self.DiscountpriceL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:310 andY:130 andWidth:55 andHeight:20]];
        self.DiscountpriceL.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.DiscountpriceL];
        self.DiscountpriceL.textColor = [UIColor grayColor];
        
        self.DiscountitleL2 = [[UILabel alloc]initWithFrame:[self createFrimeWithX:40 andY:160 andWidth:240 andHeight:20]];
        self.DiscountitleL2.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.DiscountitleL2];
        self.DiscountitleL2.textColor = [UIColor grayColor];
        
        self.DiscountpriceL2 = [[UILabel alloc]initWithFrame:[self createFrimeWithX:310 andY:160 andWidth:55 andHeight:20]];
        self.DiscountpriceL2.font = [UIFont systemFontOfSize:12];
        self.DiscountpriceL2.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.DiscountpriceL2];
    }
    return self;
}


-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height{
    return CGRectMake(x*(kScreenWidth/375), y*(kScreenHeight/667), width*(kScreenWidth/375), height*(kScreenHeight/667));
}

@end
