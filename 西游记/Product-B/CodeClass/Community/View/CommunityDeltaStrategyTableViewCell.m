//
//  CommunityDeltaStrategyTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityDeltaStrategyTableViewCell.h"

@implementation CommunityDeltaStrategyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleL = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleL];
        self.usernameL = [[UILabel alloc] init];
        [self.contentView addSubview:self.usernameL];
        self.viewsV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.viewsV];
        self.viewsL = [[UILabel alloc] init];
        [self.contentView addSubview:self.viewsL];
        self.replysV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.replysV];
        self.replysL = [[UILabel alloc] init];
        [self.contentView addSubview:self.replysL];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleL.frame = CGRectMake(self.contentView.frame.size.width * 0.02, self.contentView.frame.size.height * 0.1, self.contentView.frame.size.width * 0.9, 60);
    self.usernameL.frame = CGRectMake(self.contentView.frame.size.width * 0.03, self.contentView.frame.size.height * 0.7, 200, 30);
    self.viewsV.frame = CGRectMake(self.contentView.frame.size.width * 0.6, self.contentView.frame.size.height * 0.75, 20, 20);
    self.viewsL.frame = CGRectMake(self.contentView.frame.size.width * 0.67, self.contentView.frame.size.height * 0.7, 40, 30);
    self.replysV.frame = CGRectMake(self.contentView.frame.size.width * 0.8, self.contentView.frame.size.height * 0.75, 20, 20);
    self.replysL.frame = CGRectMake(self.contentView.frame.size.width * 0.87, self.contentView.frame.size.height * 0.7, 40, 30);
}
- (void)cellConfigerModel:(CommunityDeltaStrategyAllModel *)model
{
    self.titleL.text = model.title;
    self.titleL.lineBreakMode = NSLineBreakByCharWrapping;
    self.titleL.numberOfLines = 0;
    self.titleL.font = [UIFont systemFontOfSize:13];
    NSString *timeString = [NSString stringWithFormat:@"%@",model.publish_time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[timeString intValue]];
    self.usernameL.text = [NSString stringWithFormat:@"%@|%@",model.username,[formatter stringFromDate:confromTimesp]];
    self.usernameL.font = [UIFont systemFontOfSize:10];
    self.viewsV.image = [UIImage imageNamed:@"views"];
    self.viewsL.text = model.views;
    self.viewsL.font = [UIFont systemFontOfSize:10];
    self.replysV.image = [UIImage imageNamed:@"reply"];
    self.replysL.text = model.replys;
    self.replysL.font = [UIFont systemFontOfSize:10];
}

@end
