//
//  SleDetailTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "SleDetailTableViewCell.h"

@implementation SleDetailTableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
