//
//  hospitalViewController.m
//  iLife
//
//  Created by mirror on 16/4/27.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import "hospitalViewController.h"
#import "hdetailViewController.h"

@interface hospitalViewController ()
@property (weak, nonatomic) IBOutlet UITextField *text;

@end

@implementation hospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)chaxun:(id)sender {
    NSString *path =@"http://op.juhe.cn/onebox/hospital/query";
    NSString *api_id=@"78";
    NSString *method=@"GET ";
    NSDictionary *param=@{@"hospital":self.text.text};
    [SVProgressHUD showWithStatus:@"正在查询"];

    [[JHAPISDK shareJHAPISDK]executeWorkWithAPI:path APIID:api_id Parameters:param Method:method Success:^(id responseObject) {
        NSNumber *errNum =[responseObject objectForKey:@"error_code"];
        if (errNum.integerValue==0) {
            [SVProgressHUD showSuccessWithStatus:@"查询成功"];
            UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            hdetailViewController *vc= (hdetailViewController *)[story instantiateViewControllerWithIdentifier:@"hdetailViewController"];
            vc.responseDic =[responseObject objectForKey:@"result"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            NSString * reason=[responseObject objectForKey:@"reason"];
            [SVProgressHUD showInfoWithStatus:reason];
        }
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络有问题"];
    }];
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
