//
//  CommunityDeltaLatestModel.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityDeltaLatestModel : NSObject

@property (nonatomic, strong)NSString *photo;// 图片
@property (nonatomic, strong)NSString *replys;// 回答
@property (nonatomic, strong)NSString *title;// 内容
@property (nonatomic, strong)NSString *username;// 名字
@property (nonatomic, strong)NSString *view_url;// webView
@property (nonatomic, strong)NSNumber *publish_time;// 时间
+ (NSMutableArray *)modelConfigerJsonDic:(NSDictionary *)jsonDic;
@end
