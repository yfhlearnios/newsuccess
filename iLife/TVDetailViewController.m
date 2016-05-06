//
//  TVDetailViewController.m
//  iLife
//
//  Created by mirror on 16/4/27.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import "TVDetailViewController.h"
#import "webViewController.h"
@interface TVDetailViewController ()

@end

@implementation TVDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"节目详情";
    self.name.text=[self.responseDic objectForKey:@"cName"];
    self.time.text=[self.responseDic objectForKey:@"time"];
    self.content.text=[self.responseDic objectForKey:@"pName"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)link:(id)sender {
    webViewController *web=[[webViewController alloc]init];
    web.url=[self.responseDic objectForKey:@"pUrl"];
    [self.navigationController pushViewController:web animated:YES]; 
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
