//
//  CellModel.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *photo;
@property (nonatomic,strong) NSString *replys;
@property (nonatomic,strong) NSNumber *views;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *view_url;
+ (NSMutableArray *)modelCongifureWithJsonDic:(NSDictionary *)jsonDic;
@end
