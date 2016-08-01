//
//  IntercontinentalModel.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntercontinentalModel : NSObject
@property (nonatomic,strong) NSString *cover;
@property (nonatomic,strong) NSString *cover_updatetime;
@property (nonatomic,strong) NSString *file;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *guide_id;
@property (nonatomic,strong) NSString *guide_cnname;
+ (NSMutableArray *)modelCongifureWithJsonDic:(NSDictionary *)jsonDic;
@end
