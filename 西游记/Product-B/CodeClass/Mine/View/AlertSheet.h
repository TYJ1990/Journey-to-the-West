//
//  AlertSheet.h
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 tongwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertSheet : UIView
@property (nonatomic , copy) void(^cancelBlock)();//取消按钮
@property (nonatomic , copy) void(^takePhotoBlock)();//拍照
@property (nonatomic , copy) void(^selectFromLibraryBlock)();//从相册中选取
@end
