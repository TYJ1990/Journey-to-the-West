//
//  NSTimer+ResumeAndPause.m
//  A段
//
//  Created by lanou on 16/6/23.
//  Copyright © 2016年 tongwei. All rights reserved.
//

#import "NSTimer+ResumeAndPause.h"

@implementation NSTimer (ResumeAndPause)

-(void)pause{
    if (!self.isValid) {
        return;
    }
    [self setFireDate:[NSDate distantFuture]];
}

-(void)resume{
    if (!self.isValid) {
        return;
    }
    [self setFireDate:[NSDate date]];
}

-(void)resumeAfterTime:(NSTimeInterval)time{
    if (!self.isValid) {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

@end
