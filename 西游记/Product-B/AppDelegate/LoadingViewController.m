//
//  LoadingViewController.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LoadingViewController.h"
#import "NSTimer+ResumeAndPause.h"
#import "AppDelegate.h"
#import "MyTabBarViewController.h"
@interface LoadingViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic , strong) NSTimer *timer;
@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -22, kScreenWidth, kScreenHeight + 22)];
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 4, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self configurateContentViews];
    [self.view addSubview:_scrollView];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
}
- (void)timerDidFire:(NSTimer *)timer {
    if (_scrollView.contentOffset.x < kScreenWidth * 3) {
        CGPoint point = CGPointMake(_scrollView.contentOffset.x + _scrollView.width, 0);
        [_scrollView setContentOffset:point animated:YES];
    }
}
- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _button.frame = CGRectMake(kScreenWidth / 2 - 80, kScreenHeight - 80, 160, 60);
        [_button setTitle:@"开启旅游生活" forState:(UIControlStateNormal)];
        _button.titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:18];
        [_button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_button addTarget:self action:@selector(changeController) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _button;
}
- (void)changeController {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = [[MyTabBarViewController alloc] init];
}
//配置视图内容
-(void)configurateContentViews{
    for (int i = 0; i < 4; i ++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight +22)];
        imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]];
        if (i == 3) {
            [imageV addSubview:self.button];
            imageV.userInteractionEnabled = YES;
        }
        [_scrollView addSubview:imageV];
    }
    
}


#pragma mark -- scrollViewDelegate
- (BOOL)prefersStatusBarHidden {
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
