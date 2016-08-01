//
//  LoginViewController.m
//  Product-B
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LoginViewController.h"
#import "IphoneRegistViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;// 状态栏字体颜色
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSInteger tag = textField.tag;
    if (tag == 1) {
        
        UITextField *nextTF = [self.view viewWithTag:2];
        [nextTF becomeFirstResponder];
    }else
    {
        [textField resignFirstResponder];
    }
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
     self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)popBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)regist:(id)sender {
    IphoneRegistViewController *iphoneVC = [[IphoneRegistViewController alloc] init];
    [self.navigationController pushViewController:iphoneVC animated:YES];
}
- (IBAction)login:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
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
