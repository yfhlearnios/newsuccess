//
//  hdetailViewController.m
//  iLife
//
//  Created by mirror on 16/4/28.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import "hdetailViewController.h"

@interface hdetailViewController ()

@end

@implementation hdetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name.text=[self.responseDic objectForKey:@"title"];
    self.address.text=[self.responseDic objectForKey:@"address"];;
    self.phone.text=[self.responseDic objectForKey:@"telephone"];;
    self.route.text=[self.responseDic objectForKey:@"luxian"];;
    self.level.text=[self.responseDic objectForKey:@"level"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)save:(id)sender {//hosarr
    NSMutableArray *marr=[[NSMutableArray alloc]init];
    NSString *title;
    NSMutableArray *tarr =[[NSUserDefaults standardUserDefaults]objectForKey:@"hosarr"];
    BOOL insert=YES;
    if (tarr) {
        for (NSDictionary *dic in tarr) {
            [marr addObject:dic];
            title = [dic objectForKey:@"title"];
            if ([title isEqualToString:self.name.text]) {
                insert=NO;
            }
        }
    }
    if (insert) {
        [marr addObject:self.responseDic];
    }
    [[NSUserDefaults standardUserDefaults]setObject:marr forKey:@"hosarr"];

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
