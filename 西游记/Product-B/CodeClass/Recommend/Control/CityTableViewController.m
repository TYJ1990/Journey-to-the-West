//
//  CityTableViewController.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//
#define cityURL @"http://open.qyer.com/qyer/footprint/gone_poi_list?cate_id=0&city_id=63&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=31.13005474338136&lon=121.2839950560124&page=1&track_app_channel=App%2520Store&track_app_version=6.9.4&track_device_info=iPhone7%2C2&track_deviceid=FDA917EF-BF2C-4F87-A49E-81DE31077108&track_os=ios%25209.2&user_id=1070870&v=1"
#import "CityTableViewController.h"
#import "CityModel.h"
#import "CityListTableViewCell.h"
@interface CityTableViewController ()
@property (nonatomic,strong) NSMutableArray *modelArr;
@end

@implementation CityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CityListTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"CityListTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self requestNet];
}
- (void)requestNet {
    [RequestManager requestWithURLString:cityURL pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.modelArr = [CityModel modelCongifureWithJsonDic:dic];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityModel *model = self.modelArr[indexPath.row];
    CityListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityListTableViewCell" forIndexPath:indexPath];
    [cell cellConfigireWithModel:model];
    if ([model.my_reivew isEqualToString:@""]) {
        cell.intro.hidden = YES;
        cell.imageLine.hidden = NO;
        cell.lableLine.hidden = YES;
    }else if(![model.my_reivew isEqualToString:@""]){
         cell.intro.hidden = NO;
        cell.intro.text = model.my_reivew;
        cell.imageLine.hidden = YES;
        cell.lableLine.hidden = NO;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityModel *model = self.modelArr[indexPath.row];
if ([model.my_reivew isEqualToString:@""]) {
        return 101;
    }else if(![model.my_reivew isEqualToString:@""]){
        return 131;
    }
    return 131;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
