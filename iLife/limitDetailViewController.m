//
//  limitDetailViewController.m
//  iLife
//
//  Created by mirror on 16/4/25.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import "limitDetailViewController.h"

@interface limitDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *is;
@property (weak, nonatomic) IBOutlet UILabel *limitnum;
@property (weak, nonatomic) IBOutlet UILabel *fine;
@property (weak, nonatomic) IBOutlet UILabel *remark;

@end

@implementation limitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.date.text=[self.responseDic objectForKey:@"date"];
    self.city.text= [self.responseDic objectForKey:@"cityname"];
    NSNumber *str =[self.responseDic objectForKey:@"isxianxing"];
    if (str.integerValue) {
        self.is.text=@"是";
        NSArray *arr=[self.responseDic objectForKey:@"xxweihao"];
        NSNumber *one =arr[0];
        NSNumber *two =arr[1];
        self.limitnum.text=[NSString stringWithFormat:@"%ld和%ld",one.integerValue,two.integerValue];
    }
    else{
        self.is.text=@"否";
        self.limitnum.text=@"无";
    }
    self.fine.text=[self.responseDic objectForKey:@"fine"];
    self.remark.text =[self.responseDic objectForKey:@"remarks"];
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
