//
//  CommunityDeltaStrategyAllModel.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityDeltaStrategyAllModel : NSObject

@property (nonatomic, strong)NSString *publish_time;// 时间
@property (nonatomic, strong)NSString *replys; // 回答
@property (nonatomic, strong)NSString *title;// 题名
@property (nonatomic, strong)NSString *username;// 名字
@property (nonatomic, strong)NSString *view_url;// 下个界面
@property (nonatomic, strong)NSString *views;// 眼睛

+ (NSMutableArray *)modelConfigerJsonDic:(NSDictionary *)jsonDic;
@end
