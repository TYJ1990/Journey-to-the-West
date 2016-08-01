//
//  IntroHeadView.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "IntroHeadView.h"
@implementation IntroHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

-(void)creatSubViews{
       self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textColor = [UIColor orangeColor];
    [self addSubview:self.titleLabel];
}

@end
