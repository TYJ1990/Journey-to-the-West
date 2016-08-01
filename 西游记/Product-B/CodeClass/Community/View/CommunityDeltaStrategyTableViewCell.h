//
//  CommunityDeltaStrategyTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityDeltaStrategyAllModel.h"
@interface CommunityDeltaStrategyTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *titleL;// 题名
@property (nonatomic, strong)UILabel *usernameL; // 名字 时间
@property (nonatomic, strong)UIImageView *viewsV;
@property (nonatomic, strong)UILabel *viewsL;// 眼睛
@property (nonatomic, strong)UIImageView *replysV;
@property (nonatomic, strong)UILabel *replysL; // 回答
- (void)cellConfigerModel:(CommunityDeltaStrategyAllModel *)model;
@end
