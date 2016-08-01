//
//  CommunityCompanyTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityCompanyTableViewCell.h"

@implementation CommunityCompanyTableViewCell

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
        self.timeL = [[UILabel alloc] init];
        [self.contentView addSubview:self.timeL];
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
    self.timeL.frame = CGRectMake(self.contentView.frame.size.width * 0.015, self.contentView.frame.size.height * 0.015, self.contentView.frame.size.width * 0.9, 30);
    self.titleL.frame = CGRectMake(self.contentView.frame.size.width * 0.015, self.contentView.frame.size.height * 0.3, self.contentView.frame.size.width - 10, 30);
    self.usernameL.frame = CGRectMake(self.contentView.frame.size.width * 0.02, self.contentView.frame.size.height * 0.65, self.contentView.frame.size.width * 0.6, 30);
    self.viewsV.frame = CGRectMake(self.contentView.frame.size.width * 0.6, self.contentView.frame.size.height * 0.7, 20, 20);
    self.viewsL.frame = CGRectMake(self.contentView.frame.size.width * 0.7, self.contentView.frame.size.height * 0.65, 30, 30);
    self.replysV.frame = CGRectMake(self.contentView.frame.size.width * 0.8, self.contentView.frame.size.height * 0.7, 20, 20);
    self.replysL.frame = CGRectMake(self.contentView.frame.size.width * 0.9, self.contentView.frame.size.height * 0.65, 30, 30);

}

- (void)cellConfigerModel:(CommunityCompanyModel *)model
{
    // 转化时间
    NSString *startString = [NSString stringWithFormat:@"%@",model.start_time];
    NSString *endString = [NSString stringWithFormat:@"%@",model.end_time];
    NSString *publishString = [NSString stringWithFormat:@"%@",model.publish_time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd "];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[startString intValue]];
    NSDate *confromTimesp1 = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[endString intValue]];
    NSDate *confromTimesp2 = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[publishString intValue]];
    
    self.timeL.text = [NSString stringWithFormat:@"%@-%@|%@",[formatter stringFromDate:confromTimesp],[formatter stringFromDate:confromTimesp1],model.citys_str];
    self.timeL.font = [UIFont systemFontOfSize:13];
    self.titleL.text = model.title;
    self.titleL.font = [UIFont systemFontOfSize:13];
    self.usernameL.text = [NSString stringWithFormat:@"%@|%@",model.username,[formatter stringFromDate:confromTimesp2]];
    self.usernameL.font = [UIFont systemFontOfSize:13];
    self.viewsV.image = [UIImage imageNamed:@"views"];
    self.viewsL.text = [NSString stringWithFormat:@"%@",model.views];
    self.viewsL.font = [UIFont systemFontOfSize:13];
    self.replysV.image = [UIImage imageNamed:@"reply"];
    self.replysL.text = [NSString stringWithFormat:@"%@",model.replys];
    self.replysL.font = [UIFont systemFontOfSize:13];
    
    
    
    
}

@end
