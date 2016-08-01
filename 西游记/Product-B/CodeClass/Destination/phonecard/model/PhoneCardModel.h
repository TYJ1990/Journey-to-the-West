//
//  PhoneCardModel.h
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneCardModel : NSObject

@property(nonatomic,strong)NSNumber *tableID;
@property(nonatomic,strong)NSString *photo;
@property(nonatomic,strong)NSNumber *price;
@property(nonatomic,strong)NSString *sold; // 已出售数量
@property(nonatomic,strong)NSString *title;



+(NSMutableArray *)PhoneCardModelConfigure:(NSDictionary *)jsonDic;


@end
