//
//  RecommendScrollViewModel.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendScrollViewModel : NSObject
@property (nonatomic,strong) NSString *photo;
@property (nonatomic,strong) NSString *url;
+ (NSMutableArray *)modelCongifureWithJsonDic:(NSDictionary *)jsonDic;
@end
