//
//  WriterHeadView.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "WriterHeadView.h"
@interface WriterHeadView()
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *heLine;
@end
@implementation WriterHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backImag = [[UIImageView alloc] init];
        [self addSubview:self.backImag];
        self.imageV = [[UIImageView alloc] init];
        [self addSubview:self.imageV];
        self.addObserve = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.addObserve.titleLabel.textAlignment = 1;
        [self.addObserve setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.addObserve.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.addObserve];
        self.fans = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.fans.titleLabel.textAlignment = 1;
        [self.fans setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.fans.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.fans];
        self.line = [[UIView alloc] init];
        self.heLine = [[UIView alloc] init];
        [self addSubview:self.line];
        [self addSubview:self.heLine];
        self.nameL = [[UILabel alloc] init];
        self.nameL.textAlignment = 1;
        self.nameL.textColor = [UIColor whiteColor];
        self.nameL.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.nameL];
    }
    return self;

}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.frame;
    self.imageV.frame = CGRectMake(frame.size.width/2 - 25, frame.size.height/6, 50, 50);
    self.imageV.layer.masksToBounds = YES;
    self.imageV.layer.cornerRadius = 25;
    self.addObserve.frame = CGRectMake(frame.size.width/2 - ((kScreenWidth-20) / 2 - 2),frame.size.height - 30, (kScreenWidth-20) / 2 - 2,30);
    self.fans.frame = CGRectMake((frame.size.width-20) / 2 - 14,frame.size.height - 30, (kScreenWidth-20) / 2 - 2,30);
    self.line.frame = CGRectMake(frame.size.width/2 - ((kScreenWidth-20) / 2 - 2), frame.size.height - 32, kScreenWidth - 20, 0.5);
    self.heLine.frame = CGRectMake(frame.size.width / 2-0.5, frame.size.height - 28, 0.5, 25);
    self.line.backgroundColor = [UIColor lightGrayColor];
    self.heLine.backgroundColor = [UIColor lightGrayColor];
    self.backImag.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.nameL.frame = CGRectMake(frame.size.width/2 - 50, frame.size.height/6 + 55, 100, 30);
    self.nameL.textAlignment = 1;
}

@end
