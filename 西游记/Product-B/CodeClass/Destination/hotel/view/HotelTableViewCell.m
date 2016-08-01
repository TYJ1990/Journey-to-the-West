//
//  HotelTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "HotelTableViewCell.h"

@implementation HotelTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[UIImageView alloc]initWithFrame:[self createFrimeWithX:10 andY:10 andWidth:100 andHeight:80]];
        [self.contentView addSubview:self.imageV];
        self.cnnameL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:120 andY:10 andWidth:200 andHeight:20]];
        self.cnnameL.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:self.cnnameL];
        self.rankingL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:300 andY:10 andWidth:60 andHeight:20]];
        self.rankingL.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.rankingL];
        
        self.ennameL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:120 andY:30 andWidth:200 andHeight:20]];
        self.ennameL.font = [UIFont systemFontOfSize:12];
        self.ennameL.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:self.ennameL];
        self.starL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:120 andY:60 andWidth:250 andHeight:20]];
        self.starL.font = [UIFont systemFontOfSize:12];
        self.starL.textColor = [UIColor orangeColor];
        
        [self.contentView addSubview:self.starL];
        self.priceL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:300 andY:70 andWidth:60 andHeight:20]];
        self.priceL.font = [UIFont systemFontOfSize:12];
        self.priceL.textColor = [UIColor redColor];
        [self.contentView addSubview:self.priceL];

    }
    
    return self;
}




// 适配屏幕方法
-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height{
    
    return CGRectMake(x*(kScreenWidth/375), y*(kScreenHeight/667), width*(kScreenWidth/375), height*(kScreenHeight/667));
}

@end
