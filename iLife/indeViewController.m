//
//  indeViewController.m
//  iLife
//
//  Created by mirror on 16/4/28.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import "indeViewController.h"

@interface indeViewController ()

@end

@implementation indeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name.text=[self.responseDic objectForKey:@"title"];
    self.desc.text=[self.responseDic objectForKey:@"description"];
    self.key.text= [self.responseDic objectForKey:@"keywords"];
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
- (IBAction)save:(id)sender {
    
    NSMutableArray *marr=[[NSMutableArray alloc]init];
    NSString *title;
    NSMutableArray *tarr =[[NSUserDefaults standardUserDefaults]objectForKey:@"indearr"];
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
    [[NSUserDefaults standardUserDefaults]setObject:marr forKey:@"indearr"];
}

@end
