//
//  MineViewController.m
//  Product-B
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MineViewController.h"
#import "HeaderView.h"
#import "AlertSheet.h"
#import "LoginViewController.h"
const CGFloat TopViewH = 200; // 图片的高度
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)HeaderView *headView;
@property (nonatomic, strong)NSMutableArray *cellArray;
@property (nonatomic, strong)UINavigationBar *navigationBar;
@property (nonatomic, strong)NSMutableArray *imageArray;
@property (nonatomic, strong) AlertSheet *alertSheet;
@property (nonatomic, strong) UIView *blurView;
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation MineViewController
- (NSMutableArray *)cellArray
{
    if (!_cellArray) {
        _cellArray = [@[@"我的订单",@"我收藏的折扣",@"我的优惠劵",@"我收藏的目的地",@"我的足迹",@"等我点评的目的地",@"我发布的帖子",@"我的问答",@"我的结伴",@"我的讨论组"] mutableCopy] ;
    }
    return _cellArray;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;// 状态栏字体颜色
    
}

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [@[@"",@"ding",@"zhe",@"you",@"",@"mu",@"zu",@"dian",@"",@"tie",@"wen",@"jie",@"tao"]mutableCopy];
    }
    return _imageArray;   
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
}
//    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, 200, 300)];
//    _imageView.image = [UIImage imageNamed:@"10.jpg"];
//    _imageView.userInteractionEnabled = YES;
//    [self.view addSubview:_imageView];
//    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
//    tapGesture.numberOfTapsRequired = 1;
//    tapGesture.numberOfTouchesRequired = 1;
//    [tapGesture addTarget:self action:@selector(tapSaveImageToIphone)];
//    [self.imageView addGestureRecognizer:tapGesture];
//    
//}
//
//- (void)tapSaveImageToIphone{
//    
//    /**
//     *  将图片保存到iPhone本地相册
//     *  UIImage *image            图片对象
//     *  id completionTarget       响应方法对象
//     *  SEL completionSelector    方法
//     *  void *contextInfo
//     */
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    
//}
- (void)initTableView {
     self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;// 滚动条
    [self.view addSubview:self.tableView];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
        view.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = view;
    [self initHeadView];
}
- (void)initHeadView {
    self.headView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    self.headView.backgroundColor  = [UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0];
     self.headView.imageV.userInteractionEnabled = YES;
    [self.headView.loginL addTarget:self action:@selector(loginAction:) forControlEvents:(UIControlEventTouchUpInside)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickImage:)];
    [self.headView.imageV addGestureRecognizer:tap];
    [self.tableView addSubview:self.headView];
}
#pragma mark --- 头像 ---
- (void)pickImage:(UITapGestureRecognizer *)tap {
    /*
    [self.view addSubview:self.blurView];
    [self.view addSubview:self.alertSheet];
    [UIView animateWithDuration:0.3 animations:^{
        _alertSheet.frame = CGRectMake(0, kScreenHeight * 0.6, kScreenWidth, kScreenHeight * 0.35);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _alertSheet.frame = CGRectMake(0, kScreenHeight * 0.7, kScreenWidth, kScreenHeight * 0.35);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _alertSheet.frame = CGRectMake(0, kScreenHeight*0.65, kScreenWidth, kScreenHeight * 0.35);
            }];
        }];
    }];
    */
    UIImageWriteToSavedPhotosAlbum(self.headView.imageV.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已存入手机相册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [alert show];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [alert show];
    }
    
}




//遮罩
-(UIView *)blurView{
    if (!_blurView) {
        _blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _blurView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelSelectImg)];
        [_blurView addGestureRecognizer:tap];
        _blurView.alpha = 0.4;
    }
    return _blurView;
}

//弹出框
-(AlertSheet *)alertSheet{
    if (!_alertSheet) {
        _alertSheet = [[[NSBundle mainBundle] loadNibNamed:@"AlertSheetView" owner:nil options:nil] firstObject];
        __weak MineViewController *weakSelf = self;
        _alertSheet.cancelBlock = ^{
            [weakSelf cancelSelectImg];
        };
        _alertSheet.selectFromLibraryBlock = ^{
            [weakSelf selectFromLibrary];
        };
        _alertSheet.takePhotoBlock = ^{
            [weakSelf takephotos];
        };
        _alertSheet.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight * 0.35);
    }
    return _alertSheet;
}

#pragma mark -- 拍照或者从相册中选取

//拍照
-(void)takephotos{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:^{
            [self cancelSelectImg];
        }];
    }else{
        [self cancelSelectImg];
    }
}
//从相册中选取
-(void)selectFromLibrary{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:^{
            [self cancelSelectImg];
        }];
    }else{
        [self cancelSelectImg];
    }
}


//取消选取
-(void)cancelSelectImg{
    [UIView animateWithDuration:0.5 animations:^{
        self.alertSheet.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight * 0.35);
    } completion:^(BOOL finished) {
        [self.blurView removeFromSuperview];
        [self.alertSheet removeFromSuperview];
        _blurView = nil;
        _alertSheet = nil;
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // UIImagePickerControllerEditedImage 裁剪之后
    // UIImagePickerControllerOrignageImage 原始的
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.headView.imageV.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.cellArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
     }
        cell.textLabel.text = self.cellArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 40;
  
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = 0;
    offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        self.headView.frame = CGRectMake(offsetY / 2, offsetY, kScreenWidth - offsetY, 250 - offsetY);  // 修改头部的frame值就行了
    }
}

- (void)loginAction:(UIButton *)button
{
    LoginViewController *VC = [[LoginViewController alloc] init];
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:naVC animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
