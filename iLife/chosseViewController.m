//
//  chosseViewController.m
//  iLife
//
//  Created by mirror on 16/4/28.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import "chosseViewController.h"
#import "indeViewController.h"
#import "dhcTableViewController.h"
@interface chosseViewController ()

@end

@implementation chosseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)inde:(id)sender {
    NSMutableArray *arr=[[NSUserDefaults standardUserDefaults]objectForKey:@"indearr"];
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    dhcTableViewController *vc= (dhcTableViewController *)[story instantiateViewControllerWithIdentifier:@"dhcTableViewController"];
    vc.contentArr =arr;
    vc.flag=@"1";
    [self.navigationController pushViewController:vc animated:YES];

}
- (IBAction)hospital:(id)sender {
    NSMutableArray *arr=[[NSUserDefaults standardUserDefaults]objectForKey:@"hosarr"];
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    dhcTableViewController *vc= (dhcTableViewController *)[story instantiateViewControllerWithIdentifier:@"dhcTableViewController"];
    vc.contentArr =arr;
    vc.flag=@"2";
    [self.navigationController pushViewController:vc animated:YES];
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
