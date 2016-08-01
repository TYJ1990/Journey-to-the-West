//
//  ListTableViewController.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ListTableViewController.h"
#import "ListTableViewCell.h"
#import "SleeveHtmlWebController.h"
@interface ListTableViewController ()

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ListTableViewCell"];
     UIBarButtonItem *liftitem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:1]style:0 target:self action:@selector(returnView)];
    self.navigationItem.leftBarButtonItem = liftitem;
    self.title = @"目录";
}

-(void)returnView{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.pageNum inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell" forIndexPath:indexPath];
    if (indexPath.row < 9) {
        cell.numberLa.text = [NSString stringWithFormat:@"0%ld",indexPath.row + 1];
    }else{
        cell.numberLa.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    }
    
    cell.listLa.text = self.dataSource[indexPath.row][@"title"];
    if (indexPath.row == self.pageNum) {
        cell.numberLa.textColor = [UIColor greenColor];
        cell.listLa.textColor = [UIColor greenColor];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SleeveHtmlWebController *htmlVC = [[SleeveHtmlWebController alloc] init];
    htmlVC.sleeveNameID = self.sleeveNameID;
    self.pageNumber(indexPath.row);
    [self.navigationController popViewControllerAnimated:YES];
    ListTableViewCell *cell = (ListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    for (ListTableViewCell *cell in tableView.visibleCells) {
        cell.numberLa.textColor = [UIColor lightGrayColor];
        cell.listLa.textColor = [UIColor lightGrayColor];
    }
    cell.numberLa.textColor = [UIColor greenColor];
    cell.listLa.textColor = [UIColor greenColor];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (ListTableViewCell *cell in self.tableView.visibleCells) {
        cell.numberLa.textColor = [UIColor lightGrayColor];
        cell.listLa.textColor = [UIColor lightGrayColor];
    }
    [self.tableView reloadData];

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
