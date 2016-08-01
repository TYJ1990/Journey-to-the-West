//
//  EntranceCollectionViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "EntranceCollectionViewCell.h"

@implementation EntranceCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.imageV = [[UIImageView alloc]initWithFrame:[self createFrimeWithX:0 andY:0 andWidth:90 andHeight:40]];
        
        
        
        self.titleL = [[UILabel alloc]initWithFrame:[self createFrimeWithX:0 andY:40 andWidth:90 andHeight:30]];
        
        self.titleL.font = [UIFont systemFontOfSize:12];
        self.titleL.textAlignment = 1;

        
        [self.contentView addSubview:self.imageV];
        
        [self.contentView addSubview:self.titleL];
        
        
        self.topV = [[UIView alloc]initWithFrame:[self createFrimeWithX:0 andY:0 andWidth:90 andHeight:1]];
        self.topV.backgroundColor =[UIColor lightGrayColor];
        [self.contentView addSubview:self.topV];
        self.bottomL = [[UIView alloc]initWithFrame:[self createFrimeWithX:0 andY:70 andWidth:90 andHeight:1]];
        self.bottomL.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.bottomL];
        self.leftL = [[UIView alloc]initWithFrame:[self createFrimeWithX:0 andY:0 andWidth:1 andHeight:70]];
        self.leftL.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.leftL];
        
        self.rightL = [[UIView alloc]initWithFrame:[self createFrimeWithX:90 andY:0 andWidth:1 andHeight:70]];
        self.rightL.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.rightL];
        
        
        
        
 
        
        
        
        
        
    }
    return self;
}


-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height{
    
    return CGRectMake(x*(kScreenWidth/375), y*(kScreenHeight/667), width*(kScreenWidth/375), height*(kScreenHeight/667));
    
}

@end
