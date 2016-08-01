//
//  CommunityAnswerTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityAnswerTableViewCell.h"
#import "AdjustHeight.h"
@implementation CommunityAnswerTableViewCell

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
        self.contentL = [[UILabel alloc] init];
        [self.contentView addSubview:self.contentL];
        self.authorL = [[UILabel alloc] init];
        [self.contentView addSubview:self.authorL];
        self.askL = [[UILabel alloc] init];
        [self.contentView addSubview:self.askL];
        self.ask_numL = [[UILabel alloc] init];
        [self.contentView addSubview:self.ask_numL];
        self.answerL = [[UILabel alloc] init];
        [self.contentView addSubview:self.answerL];
        self.answer_numL = [[UILabel alloc] init];
        [self.contentView addSubview:self.answer_numL];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleL.frame = CGRectMake(self.contentView.frame.size.width * 0.015, self.contentView.frame.size.height * 0.015, self.contentView.frame.size.width , 30);
    self.contentL.frame = CGRectMake(self.contentView.frame.size.width * 0.015, self.contentView.frame.size.height * 0.3, self.contentView.frame.size.width - 20, 30);
    self.authorL.frame = CGRectMake(self.contentView.frame.size.width * 0.02, self.contentView.frame.size.height * 0.65, self.contentView.frame.size.width * 0.8, 30);
    self.askL.frame = CGRectMake(self.contentView.frame.size.width * 0.6, self.contentView.frame.size.height * 0.65, 40, 30);
    self.ask_numL.frame = CGRectMake(self.contentView.frame.size.width * 0.7, self.contentView.frame.size.height * 0.65, 30, 30);
    self.answerL.frame = CGRectMake(self.contentView.frame.size.width * 0.8, self.contentView.frame.size.height * 0.65, 40, 30);
    self.answer_numL.frame = CGRectMake(self.contentView.frame.size.width * 0.9, self.contentView.frame.size.height * 0.65, 30, 30);
}

- (void)cellConfigerModel:(CommunityAnswerModel *)model
{
    self.titleL.text = model.title;
    self.titleL.font = [UIFont systemFontOfSize:13];
    self.contentL.text = model.content;
    self.contentL.font = [UIFont systemFontOfSize:11];
    self.contentL.numberOfLines = 0;
    self.contentL.lineBreakMode = NSLineBreakByCharWrapping;
    // 转化时间
    NSString *timeString = [NSString stringWithFormat:@"%@",model.add_time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd "];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[timeString intValue]];
    self.authorL.text = [NSString stringWithFormat:@"%@|%@",model.author,[formatter stringFromDate:confromTimesp]];
    self.authorL.font = [UIFont systemFontOfSize:11];
    
    self.askL.text = @"同问";
    self.askL.font = [UIFont systemFontOfSize:11];
    self.ask_numL.text = [NSString stringWithFormat:@"%@",model.ask_num];
    self.ask_numL.font = [UIFont systemFontOfSize:11];
    self.answerL.text = @"回答";
    self.answerL.font = [UIFont systemFontOfSize:11];
    self.answer_numL.text = [NSString stringWithFormat:@"%@",model.answer_num];
    self.answer_numL.font = [UIFont systemFontOfSize:11];
}




@end
