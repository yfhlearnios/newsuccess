//
//  dhcTableViewController.m
//  iLife
//
//  Created by mirror on 16/4/28.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import "dhcTableViewController.h"
#import "DHCTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "indeViewController.h"
#import "hdetailViewController.h"
@interface dhcTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)  NSDictionary *contentDic;
@property (nonatomic,strong)  NSString *nostr;
@end

@implementation dhcTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.tableFooterView=[[UIView alloc]init];
    if (self.flag.integerValue==1) {
        
    }
    else if (self.flag.integerValue==2){
        
    }
    else{
        [self zerodo];
    }
       // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)zerodo{
    self.contentArr=[[NSMutableArray alloc]init];
    self.nostr=@"1";
    NSString *path=@"http://japi.juhe.cn/health_knowledge/infoList";
    NSString *api_id=@"143";
    NSString *mothod=@"GET";
    NSDictionary *param=@{@"page":self.nostr,@"dtype":@"json"};
    [[JHAPISDK shareJHAPISDK]executeWorkWithAPI:path APIID:api_id Parameters:param Method:mothod Success:^(id responseObject) {
        self.contentDic=[responseObject objectForKey:@"result"];
        NSArray *arr=[self.contentDic objectForKey:@"data"];
        for (NSDictionary *dic in arr) {
            [self.contentArr addObject:dic];
        }
        [self.tableview reloadData];
    } Failure:^(NSError *error) {
        ;
    }];
    self.tableview.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.nostr=@"1";
        [self loaddata];
    }];
    self.tableView.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.nostr=[NSString stringWithFormat:@"%ld",self.nostr.integerValue+1];
        [self loaddata];
    }];


}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DHCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dhccell" forIndexPath:indexPath];
    NSDictionary *dic =[self.contentArr objectAtIndex:indexPath.row];
    if (self.flag.integerValue==2) {
        cell.biaoti.text=@"医院名称";
        cell.title.text=[dic objectForKey:@"title"];
    }
    else{
    cell.title.text =[dic objectForKey:@"title"];
    }
    return cell;
}
-(void)loaddata{
    NSString *path=@"http://japi.juhe.cn/health_knowledge/infoList";
    NSString *api_id=@"143";
    NSString *mothod=@"GET";
    NSDictionary *param=@{@"page":self.nostr,@"dtype":@"json"};
    [SVProgressHUD showInfoWithStatus:@"正在加载数据"];
    [[JHAPISDK shareJHAPISDK]executeWorkWithAPI:path APIID:api_id Parameters:param Method:mothod Success:^(id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        self.contentDic=[responseObject objectForKey:@"result"];
        NSArray *arr=[self.contentDic objectForKey:@"data"];
        for (NSDictionary *dic in arr) {
            [self.contentArr addObject:dic];
        }
        [self enfrsh];
    } Failure:^(NSError *error) {
        ;
    }];
}
-(void)enfrsh{
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    [self.tableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.flag.integerValue==2) {
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        hdetailViewController *vc= (hdetailViewController *)[story instantiateViewControllerWithIdentifier:@"hdetailViewController"];
        vc.responseDic = [self.contentArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    indeViewController *vc= (indeViewController *)[story instantiateViewControllerWithIdentifier:@"indeViewController"];
    vc.responseDic =[self.contentArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    }

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
