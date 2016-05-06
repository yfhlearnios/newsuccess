//
//  DeliverTableViewController.m
//  iLife
//
//  Created by mirror on 16/4/25.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import "DeliverTableViewController.h"
#import "DeliverTableViewCell.h"
#import "DeliverDetailViewController.h"

@interface DeliverTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *resulArr;

@end

@implementation DeliverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.tableFooterView=[[UIView alloc]init];
    self.title = @"快递信息";
    NSDictionary *dic=[self.responseDic objectForKey:@"result"];
    self.resulArr =[dic objectForKey:@"list"];
    NSLog(@"%@",self.resulArr);
    NSLog(@"%@",self.responseDic);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.resulArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DeliverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dic = [self.resulArr objectAtIndex:indexPath.row];
    NSString *datetime=[dic objectForKey:@"datetime"];
    NSString *remark =[dic objectForKey:@"remark"];
    cell.date.text=[NSString stringWithFormat:@"时间:%@",datetime];
    cell.remark.text=[NSString stringWithFormat:@"详细情况:%@",remark];
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.resulArr objectAtIndex:indexPath.row];
    NSString *datetime=[dic objectForKey:@"datetime"];
    NSString *remark =[dic objectForKey:@"remark"];
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DeliverDetailViewController *vc= (DeliverDetailViewController *)[story instantiateViewControllerWithIdentifier:@"DeliverDetailViewController"];
    vc.dateStr=datetime;
    vc.remarkStr=remark;
    [self.navigationController pushViewController:vc animated:YES];

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
