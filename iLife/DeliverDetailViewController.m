//
//  DeliverDetailViewController.m
//  iLife
//
//  Created by mirror on 16/4/25.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import "DeliverDetailViewController.h"

@interface DeliverDetailViewController ()

@end

@implementation DeliverDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"快递详情";
    self.date.text=self.dateStr;
    self.remark.text=self.remarkStr;
    // Do any additional setup after loading the view.
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
