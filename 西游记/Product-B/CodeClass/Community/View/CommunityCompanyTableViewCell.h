//
//  CommunityCompanyTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityCompanyModel.h"
@interface CommunityCompanyTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *timeL;// 开始时间 结束时间 国家
@property (nonatomic, strong)UILabel *titleL;// 内容
@property (nonatomic, strong)UILabel *usernameL;// 名字 公布时间
@property (nonatomic, strong)UIImageView *viewsV;
@property (nonatomic, strong)UILabel *viewsL;  //  视力
@property (nonatomic, strong)UIImageView *replysV;
@property (nonatomic, strong)UILabel *replysL;// 回答

- (void)cellConfigerModel:(CommunityCompanyModel *)model;
@end
