//
//  CommunityDeltaLatestTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityDeltaLatestModel.h"
@interface CommunityDeltaLatestTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *photoV; // 图片
@property (nonatomic, strong)UILabel *usernameL;// 名字
@property (nonatomic, strong)UILabel *titleL;// 内容
@property (nonatomic, strong)UILabel *publish_timeL;// 时间
@property (nonatomic, strong)UIImageView *replysV;
@property (nonatomic, strong)UILabel *replysL;// 回答

- (void)cellConfigerModel:(CommunityDeltaLatestModel *)model;





@end
