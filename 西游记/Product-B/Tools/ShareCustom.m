//
//  ShareCustom.m
//  Product-B
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//
//屏幕宽度相对iPhone6屏幕宽度的比例
#define KWidth_Scale    [UIScreen mainScreen].bounds.size.width/375.0f
#import "ShareCustom.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>
static id _publishContent;//类方法中的全局变量这样用（类型前面加static）
static UIViewController *_controller;
@implementation ShareCustom

+(void)shareWithContent:(id)publishContent controller:(UIViewController *)controller/*只需要在分享按钮事件中 构建好分享内容publishContent传过来就好了*/
{
    _publishContent = publishContent;
    _controller = controller;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    blackView.backgroundColor = PKCOLOR(100, 100, 100);
    blackView.alpha = 0.65;
    blackView.tag = 440;
    [window addSubview:blackView];
    
    UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-300*KWidth_Scale)/2.0f, (kScreenHeight-270*KWidth_Scale)/2.0f, 300*KWidth_Scale, 270*KWidth_Scale)];
    shareView.backgroundColor = [UIColor whiteColor];
    shareView.tag = 441;
    [window addSubview:shareView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shareView.width, 45*KWidth_Scale)];
    titleLabel.text = @"分享到";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15*KWidth_Scale];
    titleLabel.textColor = [UIColor clearColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    [shareView addSubview:titleLabel];
    
    NSArray *btnImages = @[@"微信好友", @"朋友圈", @"QQ好友", @"空间", @"微信收藏", @"微博", @"豆瓣", @"短信"];
    NSArray *btnTitles = @[@"微信好友", @"微信朋友圈", @"QQ好友", @"QQ空间", @"微信收藏", @"新浪微博", @"豆瓣", @"短信"];
    for (NSInteger i=0; i<8; i++) {
        CGFloat top = 0.0f;
        if (i<4) {
            top = 10*KWidth_Scale;
            
        }else{
            top = 90*KWidth_Scale;
        }
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10*KWidth_Scale+(i%4)*70*KWidth_Scale, titleLabel.bottom+top, 70*KWidth_Scale, 70*KWidth_Scale)];
        [button setImage:[UIImage imageNamed:btnImages[i]] forState:UIControlStateNormal];
        [button setTitle:btnTitles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:11*KWidth_Scale];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [button setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 15*KWidth_Scale, 30*KWidth_Scale, 15*KWidth_Scale)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(40*KWidth_Scale, -40*KWidth_Scale, 5*KWidth_Scale, 0)];
        button.tag = 331+i;
        [button addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [shareView addSubview:button];
    }
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake((shareView.width-40*KWidth_Scale)/2.0f, shareView.height-40*KWidth_Scale-18*KWidth_Scale, 40*KWidth_Scale, 40*KWidth_Scale)];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"差号.png"] forState:UIControlStateNormal];
    cancleBtn.tag = 339;
    [cancleBtn addTarget:self action:@selector(canceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:cancleBtn];
    
    //为了弹窗不那么生硬，这里加了个简单的动画
    shareView.transform = CGAffineTransformMakeScale(1/300.0f, 1/270.0f);
    blackView.alpha = 0;
    [UIView animateWithDuration:0.35f animations:^{
        shareView.transform = CGAffineTransformMakeScale(1, 1);
        blackView.alpha = 0.45;
    } completion:^(BOOL finished) {
        
    }];
    
}

+(void)shareBtnClick:(UIButton *)btn
{
    //    NSLog(@"%@",[ShareSDK version]);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [window viewWithTag:440];
    UIView *shareView = [window viewWithTag:441];
    //为了弹窗不那么生硬，这里加了个简单的动画
    shareView.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.35f animations:^{
        shareView.transform = CGAffineTransformMakeScale(1/300.0f, 1/270.0f);
        blackView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [shareView removeFromSuperview];
        [blackView removeFromSuperview];
    }];
    
    int shareType = 0;
    id publishContent = _publishContent;
    switch (btn.tag) {
        case 331:
        {
            shareType = SSDKPlatformSubTypeWechatSession;
        }
            break;
            
        case 332:
        {
            shareType = SSDKPlatformSubTypeWechatTimeline;
        }
            break;
            
        case 333:
        {
            shareType = SSDKPlatformSubTypeQQFriend;
        }
            break;
            
        case 334:
        {
            shareType = SSDKPlatformSubTypeQZone;
        }
            break;
            
        case 335:
        {
            shareType = SSDKPlatformSubTypeWechatFav;
        }
            break;
            
        case 336:
        {
            shareType = SSDKPlatformTypeSinaWeibo;
        }
            break;
            
        case 337:
        {
            shareType = SSDKPlatformTypeDouBan;
        }
            break;
            
        case 338:
        {
            shareType = SSDKPlatformTypeSMS;
        }
            break;
            
            default:
            break;
    }
    
    /*
     调用shareSDK的无UI分享类型，
     链接地址：http://bbs.mob.com/forum.php?mod=viewthread&tid=110&extra=page%3D1%26filter%3Dtypeid%26typeid%3D34
     */
    [ShareSDK share:shareType //传入分享的平台类型
         parameters:_publishContent
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"分享成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
                [alterVC addAction:cancel];
                [_controller showDetailViewController:alterVC sender:nil];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
                [alterVC addAction:cancel];
                [_controller showDetailViewController:alterVC sender:nil];
                break;
            }
            default:
                break;
        }
    }];
}


+ (void)canceBtnClick:(UIButton *)btn {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [window viewWithTag:440];
    UIView *shareView = [window viewWithTag:441];
    //为了弹窗不那么生硬，这里加了个简单的动画
    shareView.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.35f animations:^{
        shareView.transform = CGAffineTransformMakeScale(1/300.0f, 1/270.0f);
        blackView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [shareView removeFromSuperview];
        [blackView removeFromSuperview];
    }];

}
@end
