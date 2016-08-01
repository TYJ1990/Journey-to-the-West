//
//  SleHeadView.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "SleHeadView.h"

@implementation SleHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.la = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        [self addSubview:self.la];
        self.la.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:15];
        self.backgroundColor = [UIColor whiteColor];
       // self.la.textColor = PKCOLOR(100, 100, 100);
    }
    return self;

}
@end
