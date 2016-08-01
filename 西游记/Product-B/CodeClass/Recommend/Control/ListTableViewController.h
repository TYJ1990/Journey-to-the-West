//
//  ListTableViewController.h
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray *dataSource;
@property(nonatomic,copy) NSString* sleeveNameID;
@property (nonatomic,assign) NSInteger pageNum;
@property (nonatomic,copy) void(^pageNumber)(NSInteger n);
@end
