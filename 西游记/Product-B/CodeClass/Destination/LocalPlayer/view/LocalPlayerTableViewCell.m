//
//  LocalPlayerTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LocalPlayerTableViewCell.h"

@implementation LocalPlayerTableViewCell

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
        self.titleL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:120 andY:10 andWidth:240 andHeight:50]];
        self.titleL.font = [UIFont systemFontOfSize:15];
        self.titleL.numberOfLines = 0;
        [self.contentView addSubview:self.titleL];
        self.soldL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:120 andY:70 andWidth:100 andHeight:20]];
        self.soldL.textColor = [UIColor grayColor];
        self.soldL.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.soldL];
        self.priceL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:300 andY:70 andWidth:70 andHeight:30]];
        self.priceL.textColor = [UIColor orangeColor];
        self.priceL.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.priceL];
    }
    return self;
}


-(void)passValue:(LocalPlayerModel *)model
{
    
    if (model) {
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil completed:nil];
        self.titleL.text = model.title;
        self.priceL.text = [NSString stringWithFormat:@"%@",model.price];
        self.soldL.text = model.sold;
        self.priceL.text =[NSString stringWithFormat:@"%@", model.price];
    }
}


-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height
{
    
    return CGRectMake(x*(kScreenWidth/375), y*(kScreenHeight/667), width*(kScreenWidth/375), height*(kScreenHeight/667));
}


@end
