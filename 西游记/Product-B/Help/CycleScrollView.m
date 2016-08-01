//
//  CycleScrollView.m
//  A段
//
//  Created by lanou on 16/6/21.
//  Copyright © 2016年 tongwei. All rights reserved.
//

#import "CycleScrollView.h"
#import "NSTimer+ResumeAndPause.h"

@interface CycleScrollView ()<UIScrollViewDelegate>
@property (nonatomic , strong) UIScrollView *baseScrollView;
@property (nonatomic , assign) NSTimeInterval durantionTime;
@property (nonatomic , strong) NSTimer *timer;
@property (nonatomic , strong) NSMutableArray *contentViews;

@end

@implementation CycleScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _baseScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _baseScrollView.contentSize = CGSizeMake(_baseScrollView.width * 3, _baseScrollView.height);
        _baseScrollView.pagingEnabled = YES;
        _baseScrollView.bounces = NO;
        _baseScrollView.delegate = self;
        _baseScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_baseScrollView];
        _currentIndex = 0;
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(_baseScrollView.width/3.0 *2, _baseScrollView.height/4.0 *3, _baseScrollView.width/3.0, _baseScrollView.height/4.0)];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = PKCOLOR(200, 150, 180);
        
        [self addSubview:_pageControl];
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame DurationTime:(NSTimeInterval)durationTime{
    self = [self initWithFrame:frame];
    if (durationTime > 0) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:(_durantionTime = durationTime) target:self selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        [_timer pause];
    }
    return self;
}

//定时器启动
-(void)timerDidFire:(NSTimer *)timer{
    CGPoint point = CGPointMake(_baseScrollView.contentOffset.x + _baseScrollView.width, 0);
    [_baseScrollView setContentOffset:point animated:YES];
}

-(void)setPages:(NSInteger)pages{
    if (pages>0) {
        _pages = pages;
        _pageControl.numberOfPages = _pages;
        [self configurateContentViews];
        [_timer resumeAfterTime:_durantionTime];
    }
}

//配置视图内容
-(void)configurateContentViews{
    [_baseScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setContentViewData];
    NSInteger i=0;
    for (UIView *view in _contentViews) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        CGRect frame = view.frame;
        frame.origin.x = _baseScrollView.width * i;
        view.frame = frame;
        i ++;
        [_baseScrollView addSubview:view];
        //添加点击方法
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:tap];
    }
    [_baseScrollView setContentOffset:CGPointMake(_baseScrollView.width, 0)];
}

//设置数据
-(void)setContentViewData{
    if (_contentViews == nil) {
        _contentViews = [@[] mutableCopy];
    }
    [_contentViews removeAllObjects];
    if (self.fetchContentView) {
        NSArray *arr = @[@(-1),@(0),@(1)];
        for (NSInteger i = 0; i < 3; i ++) {
            NSString *url = self.fetchContentView([self judgeIndex:_currentIndex + [arr[i] integerValue]]);
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.bounds];
            imageV.userInteractionEnabled = YES;
            [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kPlacehodeImage completed:nil];
            [_contentViews addObject:imageV];
        }
        
    }
}

//判断索引
-(NSInteger )judgeIndex:(NSInteger )index{
    if (index == _pages) {
        return 0;
    }else if (index == -1){
        return _pages-1;
    }else{
        return index;
    }
}


#pragma mark -- scrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 2*scrollView.width) {
        _currentIndex = [self judgeIndex:_currentIndex +1];
        [self configurateContentViews];
    }else if (scrollView.contentOffset.x == 0){
        _currentIndex = [self judgeIndex:_currentIndex - 1];
        [self configurateContentViews];
    }
    _pageControl.currentPage = _currentIndex;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer pause];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_timer resumeAfterTime:_durantionTime];
}

-(void)click:(UITapGestureRecognizer *)sender{
    
    if (self.tapBlock) {
        self.tapBlock(_currentIndex);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
