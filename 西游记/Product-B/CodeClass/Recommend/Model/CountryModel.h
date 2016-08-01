//
//  CountryModel.h
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryModel : NSObject
@property (nonatomic,strong) NSString *cnname;
@property (nonatomic,strong) NSString *enname;
@property (nonatomic,strong) NSString *photo;
@property (nonatomic,strong) NSString *poi_count;
@property (nonatomic,strong) NSNumber *cityID;
+ (NSMutableArray *)modelCongifureWithJsonDic:(NSDictionary *)jsonDic;
@end
