//
//  EntranceTicketsModel.h
//  Product-B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntranceTicketsModel : NSObject

@property(nonatomic,strong)NSNumber *TabID; // ID
@property(nonatomic,strong)NSString *photo; // 图片
@property(nonatomic,strong)NSNumber *price; // 价格
@property(nonatomic,strong)NSString *sold; // 已经出售了多少件
@property(nonatomic,strong)NSString *title; // 标题


+(NSMutableArray *)tableArrModelConfigure:(NSDictionary *)jsonDic;





@end
