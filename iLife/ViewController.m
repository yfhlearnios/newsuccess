//
//  ViewController.m
//  iLife
//
//  Created by mirror on 16/4/18.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(id)sender {
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
    else{
        NSString *key=self.username.text;
        NSString *password=(NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:key];
        if ([password isEqualToString:self.password.text]) {
            [SVProgressHUD showWithStatus:@"正在登录"];
            [self performSelector:@selector(succeed) withObject:nil afterDelay:0.5f];
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
        }
    }

}
-(void)succeed{
    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc= [story instantiateViewControllerWithIdentifier:@"roottabbar"];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
