//
//  EntranceTicketsTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "EntranceTicketsTableViewCell.h"

@implementation EntranceTicketsTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[UIImageView alloc]initWithFrame:[self createFrimeWithX:10 andY:10 andWidth:100 andHeight:80]];
        
        self.titleL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:120 andY:10 andWidth:250 andHeight:40]];
        
        self.titleL.numberOfLines = 0;
        self.titleL.font = [UIFont systemFontOfSize:15];
        
        self.soldL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:120 andY:70 andWidth:150 andHeight:20]];
        
        self.soldL.textColor = [UIColor grayColor];
        self.soldL.font = [UIFont systemFontOfSize:12];
        
        
        self.priceL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:300 andY:70 andWidth:75 andHeight:20]];
        
        self.priceL.textColor = [UIColor redColor];
        self.priceL.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:self.imageV];
        
        [self.contentView addSubview:self.titleL];
        
        [self.contentView addSubview:self.soldL];
        
        [self.contentView addSubview:self.priceL];
        
    }
    
    return self;
    
}


-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height{
    
    return CGRectMake(x*(kScreenWidth/375), y*(kScreenHeight/667), width*(kScreenWidth/375), height*(kScreenHeight/667));
    
}
@end
