//
//  PhoneCardTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PhoneCardTableViewCell.h"

@implementation PhoneCardTableViewCell

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
        self.titleL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:120 andY:10 andWidth:250 andHeight:20]];
        self.titleL.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.titleL];
        self.soldL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:120 andY:80 andWidth:150 andHeight:20]];
        self.soldL.font = [UIFont systemFontOfSize:12];
        self.soldL.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.soldL];
        self.priceL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:300 andY:80 andWidth:60 andHeight:20]];
        self.priceL.textColor = [UIColor orangeColor];
        self.priceL.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.priceL];
        
    }
    
    return self;
}


-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height{
    
    return CGRectMake(x*(kScreenWidth/375), y*(kScreenHeight/667), width*(kScreenWidth/375), height*(kScreenHeight/667));
    
}

@end
