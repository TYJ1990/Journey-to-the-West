//
//  CommCollectionReusableView.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommCollectionReusableView.h"

@implementation CommCollectionReusableView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.015, 5, 160, 30)];
        [self addSubview:self.titleL];
       self.view1 = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.015, 35, self.frame.size.width * 0.45, 1)];
        self.view1.backgroundColor = [UIColor grayColor];
        [self addSubview:self.view1];
  }
    return self;
    
}


@end
