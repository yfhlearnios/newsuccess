//
//  RegisterViewController.m
//  iLife
//
//  Created by mirror on 16/4/18.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)register:(id)sender {
    if(self.username.text ==nil){
        [SVProgressHUD showErrorWithStatus:@"请输入用户名"];
    }
    else if (self.username.text.length<4){
        [SVProgressHUD showErrorWithStatus:@"用户名的长度至少4位～"];
    }
    else if (self.password.text==nil){
        [SVProgressHUD showErrorWithStatus:@"请输入注册密码"];
    }
    else if (self.password.text.length<6)
    {
        [SVProgressHUD showErrorWithStatus:@"密码长度至少为6位"];
    }
    else if (![self.password.text isEqualToString:self.ensure.text]){
        [SVProgressHUD showErrorWithStatus:@"密码与确认密码不一致"];
    }
    else{
        NSString *key = self.username.text;
        [[NSUserDefaults standardUserDefaults]setObject:self.password.text forKey:key];
        [SVProgressHUD showWithStatus:@"正在注册"];
        [self performSelector:@selector(succeed) withObject:nil afterDelay:1.5f];
    }
}
-(void)succeed{
    [SVProgressHUD showSuccessWithStatus:@"注册成功"];
    [self.navigationController popViewControllerAnimated:YES];
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
