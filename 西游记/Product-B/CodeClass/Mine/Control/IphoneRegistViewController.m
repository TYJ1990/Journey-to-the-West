//
//  IphoneRegistViewController.m
//  Product-B
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 lanou. All rights reserved.
//
#define iphoneURL @"http://open.qyer.com/qyer/user/active_code?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&country_code=86&lat=31.13008999113264&lon=121.2839831100757&mobile=%@&page=1&track_app_channel=App%2520Store&track_app_version=6.9.4&track_device_info=iPhone%25205s&track_deviceid=94F70022-4846-4FC9-A365-FE5CB11C6A2A&track_os=ios%25209.3.2&v=1"
#define iphURL @"http://open.qyer.com/qyer/user/active_code?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&country_code=86&lat=31.13008999113264&lon=121.2839831100757&mobile=%@&page=1&track_app_channel=App2520Store&track_app_version=6.9.4&track_device_info=iPhone25205s&track_deviceid=94F70022-4846-4FC9-A365-FE5CB11C6A2A&track_os=ios25209.3.2&v=1"
#import "IphoneRegistViewController.h"

@interface IphoneRegistViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *iphoneNumber;
@property(nonatomic,strong) NSTimer *timer;
@end
static NSInteger num = 60;
@implementation IphoneRegistViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;// 状态栏字体颜色
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)next:(id)sender {
   
    
    if (self.iphoneNumber.text.length == 0) {
        CAKeyframeAnimation *cak = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
        CGFloat centerUserTFx = self.iphoneNumber.center.x;
        CGFloat leftx = centerUserTFx - 5;
        CGFloat rightx = centerUserTFx + 5;
        NSNumber *ssL = [NSNumber numberWithFloat:leftx];
        NSNumber *ssC = [NSNumber numberWithFloat:centerUserTFx];
        NSNumber *ssR = [NSNumber numberWithFloat:rightx];
        cak.values = @[ssL,ssC,ssR];
        cak.duration = 0.1;
        cak.repeatCount = 3;
        [self.iphoneNumber.layer addAnimation:cak forKey:nil];
        [self showAlterView:@"账号还没输入"];
        return;
    }else{
        if ([self isMobileNumber:self.iphoneNumber.text]) {
            if (num < 60) {
                UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"验证码已发送" message:@"在一分钟后尝试重新发送。" preferredStyle:(UIAlertControllerStyleActionSheet)];
                [self presentViewController:alter animated:YES completion:^{
                    sleep(1);
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
            }else{
                num = 60;
                UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"验证码已发送" message:@"验证码已发送到你请求的手机号码。如果没有收到，可以在一分钟后尝试重新发送。" preferredStyle:(UIAlertControllerStyleActionSheet)];
                [self presentViewController:alter animated:YES completion:^{
                    sleep(1);
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                
               // self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(lessTime) userInfo:nil repeats:YES];
                //[self.timer setFireDate:[NSDate date]];
                
                [AVOSCloud requestSmsCodeWithPhoneNumber:self.iphoneNumber.text appName:@"有毒气" operation:@"注册账号" timeToLive:10 callback:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        NSLog(@"成功");
                    }else{
                        NSLog(@"%ld",error.code);
                    }
                }];
            }
        }else{
            UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:@"不是手机号" preferredStyle:(UIAlertControllerStyleActionSheet)];
            [self presentViewController:alter animated:YES completion:^{
                sleep(1);
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
    }

}
- (IBAction)popBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)showAlterView:(NSString *)title;
{
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    [self presentViewController:alterVC animated:YES completion:^{
        sleep(1);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.iphoneNumber resignFirstResponder];
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
