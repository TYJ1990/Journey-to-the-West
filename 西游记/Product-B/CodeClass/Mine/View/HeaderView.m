//
//  HeaderView.m
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc] init];
        self.imageV.image = [UIImage imageNamed:@"navImg"];
        [self addSubview:self.imageV];
        
        self.loginButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.loginButton setBackgroundImage:[UIImage imageNamed:@"jie"]  forState:(UIControlStateNormal)];
        self.loginButton.layer.masksToBounds = YES;
        self.loginButton.layer.cornerRadius = 25;
        self.loginL = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self addSubview:self.loginL];
        [self.loginL setTitle:@"登录 | 注册" forState:(UIControlStateNormal)];
        [self addSubview:self.loginButton];
        
        self.teiButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.teiL = [[UILabel alloc] init];
        self.teiL.text = @"收藏的帖子";
        self.teiL.font = [UIFont systemFontOfSize:13];
        [self.imageV addSubview:self.teiL];
        [self.imageV addSubview:self.teiButton];
        
        self.jinButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.jinButton setBackgroundImage:[UIImage imageNamed:@"jin"]forState:(UIControlStateNormal)];
        self.jinL = [[UILabel alloc] init];
        self.jinL.text = @"我的锦囊";
        self.jinL.font = [UIFont systemFontOfSize:13];
        [self.imageV addSubview:self.jinL];
        [self.imageV addSubview:self.jinButton];
        
        self.xingButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.xingButton setBackgroundImage:[UIImage imageNamed:@"xing"]forState:(UIControlStateNormal)];
        self.xingL = [[UILabel alloc] init];
        self.xingL.text = @"我的行程";
        self.xingL.font = [UIFont systemFontOfSize:13];
        [self.imageV addSubview:self.xingL];
        [self.imageV addSubview:self.xingButton];
        
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(0, 0, self.frame.size.width,self.frame.size.height);
    self.loginButton.frame = CGRectMake(self.frame.size.width * 0.15, self.frame.size.height * 0.45, 50, 50);
    self.teiButton.frame = CGRectMake(self.frame.size.width * 0.1, self.frame.size.height * 0.77, 27, 27);
    [self.teiButton setBackgroundImage:[UIImage imageNamed:@"tie"] forState:(UIControlStateNormal)];
    self.teiL.frame = CGRectMake(self.frame.size.width * 0.080, self.frame.size.height * 0.85, self.frame.size.width * 0.25, 30);
    self.jinL.frame = CGRectMake(self.frame.size.width * 0.430, self.frame.size.height * 0.85, self.frame.size.width * 0.25, 30);
    self.jinButton.frame = CGRectMake(self.frame.size.width * 0.45, self.frame.size.height * 0.76, 30, 30);
    self.xingButton.frame = CGRectMake(self.frame.size.width * 0.8, self.frame.size.height * 0.76, 30, 30);
    self.xingL.frame = CGRectMake(self.frame.size.width * 0.775, self.frame.size.height * 0.85, self.frame.size.width * 0.25, 30);
    self.loginL.frame = CGRectMake(self.frame.size.width * 0.3, self.frame.size.height * 0.46, 100, 30);


}



@end
