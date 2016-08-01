//
//  CommunityAnswerTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityAnswerModel.h"
@interface CommunityAnswerTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *titleL;// 题名
@property (nonatomic, strong)UILabel *contentL; // 内容
@property (nonatomic, strong)UILabel *authorL; // 名字-时间
@property (nonatomic, strong)UILabel *askL;
@property (nonatomic, strong)UILabel *ask_numL; // 同问数量
@property (nonatomic, strong)UILabel *answerL;
@property (nonatomic, strong)UILabel *answer_numL;// 回答数量

- (void)cellConfigerModel:(CommunityAnswerModel *)model;
@end
