//
//  NSTimer+ResumeAndPause.h
//  A段
//
//  Created by lanou on 16/6/23.
//  Copyright © 2016年 tongwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (ResumeAndPause)

-(void)pause;

-(void)resume;

-(void)resumeAfterTime:(NSTimeInterval )time;

@end
