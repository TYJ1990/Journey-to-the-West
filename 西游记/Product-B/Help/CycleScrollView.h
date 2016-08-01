//
//  CycleScrollView.h
//  A段
//
//  Created by lanou on 16/6/21.
//  Copyright © 2016年 tongwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleScrollView : UIView

//视图数量
@property(nonatomic , assign) NSInteger pages;

//刷新视图
@property(nonatomic , copy) NSString *(^fetchContentView)(NSInteger index);

@property (nonatomic , assign) NSInteger currentIndex;
//点击方法

@property (nonatomic , copy) void(^tapBlock)(NSInteger index);

-(instancetype)initWithFrame:(CGRect)frame DurationTime:(NSTimeInterval )durationTime;
@property (nonatomic , strong) UIPageControl *pageControl;

@end
