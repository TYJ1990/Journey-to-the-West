//
//  CommunityCompanyModel.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityCompanyModel : NSObject
@property (nonatomic, strong)NSString *appview_url;// 下个界面的WebView
@property (nonatomic, strong)NSString *citys_str;// 国家
@property (nonatomic, strong)NSString *end_time; // 结束时间
@property (nonatomic, strong)NSString *publish_time; // 公布时间
@property (nonatomic, strong)NSNumber *replys;// 回答
@property (nonatomic, strong)NSString *start_time;// 开始时间
@property (nonatomic, strong)NSString *title;// 内容
@property (nonatomic, strong)NSString *username;// 名字
@property (nonatomic, strong)NSNumber *views;//  视力

+ (NSMutableArray *)modelConfigerJsonDic:(NSDictionary *)JsonDic;

@end
