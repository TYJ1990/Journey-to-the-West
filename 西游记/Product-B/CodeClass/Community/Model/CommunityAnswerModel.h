//
//  CommunityAnswerModel.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityAnswerModel : NSObject

@property (nonatomic, strong)NSString *add_time;// 时间
@property (nonatomic, strong)NSNumber *answer_num; // 回答
@property (nonatomic, strong)NSString *appview_url;// 下个界面的webView
@property (nonatomic, strong)NSNumber *ask_num; // 同问
@property (nonatomic, strong)NSString *author;  // 名字
@property (nonatomic, strong)NSString *content; // 内容
@property (nonatomic, strong)NSString *title; // 题名

+ (NSMutableArray *)modelConfigerJsonDic:(NSDictionary *)jsonDic;

@end
