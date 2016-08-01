//
//  CommunityDeltaLatestTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityDeltaLatestTableViewCell.h"

@implementation CommunityDeltaLatestTableViewCell

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
        self.photoV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.photoV];
        self.usernameL = [[UILabel alloc] init];
        [self.contentView addSubview:self.usernameL];
        self.titleL = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleL];
        self.publish_timeL = [[UILabel alloc] init];
        [self.contentView addSubview:self.publish_timeL];
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
    self.photoV.frame = CGRectMake(self.contentView.frame.size.width * 0.05, self.contentView.frame.size.height * 0.15, self.contentView.frame.size.width * 0.13, self.contentView.frame.size.height * 0.5);
    self.usernameL.frame = CGRectMake(self.contentView.frame.size.width * 0.2, self.contentView.frame.size.height * 0.05, 160, 30);
    self.titleL.frame = CGRectMake(self.contentView.frame.size.width * 0.2, self.contentView.frame.size.height * 0.4, self.contentView.frame.size.width * 0.7, 30);
    self.publish_timeL.frame = CGRectMake(self.contentView.frame.size.width * 0.2, self.contentView.frame.size.height * 0.7, 160, 30);
    self.replysV.frame = CGRectMake(self.contentView.frame.size.width * 0.8, self.contentView.frame.size.height * 0.75, 20, 20);
    self.replysL.frame = CGRectMake(self.contentView.frame.size.width * 0.9, self.contentView.frame.size.height * 0.7, 30, 30);
}

- (void)cellConfigerModel:(CommunityDeltaLatestModel *)model
{
    [self.photoV sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    self.usernameL.text = model.username;
    self.usernameL.font = [UIFont systemFontOfSize:13];
    self.titleL.text = model.title;
    self.titleL.font = [UIFont systemFontOfSize:11];
    self.titleL.numberOfLines = 0;
    self.titleL.lineBreakMode = NSLineBreakByCharWrapping;
    NSString *timeString = [NSString stringWithFormat:@"%@",model.publish_time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss "];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[timeString intValue]];
    self.publish_timeL.text = [formatter stringFromDate:confromTimesp];
    self.publish_timeL.font = [UIFont systemFontOfSize:11];
    self.publish_timeL.textColor = [UIColor grayColor];
    self.replysV.image = [UIImage imageNamed:@"reply"];
    self.replysL.text = model.replys;
    self.replysL.font = [UIFont systemFontOfSize:11];
    
}

@end
