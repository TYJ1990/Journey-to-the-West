//
//  SleDetailHeaderView.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/7.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "SleDetailHeaderView.h"
#import "AppDelegate.h"
@implementation SleDetailHeaderView


-(instancetype)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

-(void)creatSubviews{
//    UIApplication* application=[UIApplication sharedApplication];
//    AppDelegate* delegate=application.delegate;
    
    //self.imageHeader=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:self.frame.size.width andHeight:self.frame.size.height]];
    self.imageHeader=[[UIImageView alloc] init];
    self.imageHeader.userInteractionEnabled=YES;
    [self addSubview:self.imageHeader];
    
    self.downlondBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //self.downlondBtn.frame=[delegate createFrimeWithX:self.frame.size.width-50 andY:self.frame.size.height-25 andWidth:50 andHeight:50];
    [self.downlondBtn setTitle:@"下载" forState:UIControlStateNormal];
    self.downlondBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.downlondBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.downlondBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.downlondBtn setBackgroundColor:[UIColor greenColor]];
    self.downlondBtn.layer.borderWidth=1;
    self.downlondBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.downlondBtn.layer.cornerRadius=50/2.f;
    [self addSubview:self.downlondBtn];
    
    
    self.progress=[[UIProgressView alloc] init];
    //设置当前进度
    self.progress.progress = 0;
    //设置填充
    self.progress.tintColor = [UIColor redColor];
    self.progress.hidden=YES;
    [self addSubview:self.progress];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageHeader.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.downlondBtn.frame=CGRectMake(self.frame.size.width-55, self.frame.size.height-50, 50, 50);
    self.progress.frame = CGRectMake(self.frame.size.width-105, self.frame.size.height+5, 90, 50);
}

-(void)pressBtn:(id)sender{
    UIButton* btn=(UIButton* )sender;
    if ([self.delegate respondsToSelector:@selector(downloandSleeve:)]) {
        [self.delegate downloandSleeve:btn];
    }else{
        NSLog(@"被动方没有实现协议方法");
    }
}

@end
