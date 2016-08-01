//
//  CityModel.h
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
@property (nonatomic,strong) NSString *beenstr;
@property (nonatomic,strong) NSString *cnname;
@property (nonatomic,strong) NSDictionary *discount;
@property (nonatomic,strong) NSString *enname;
@property (nonatomic,strong) NSNumber *has_mguide;
@property (nonatomic,strong) NSString *my_reivew;
@property (nonatomic,strong) NSString *photo;
@property (nonatomic,strong) NSString *ranking;
+ (NSMutableArray *)modelCongifureWithJsonDic:(NSDictionary *)jsonDic;

@end
