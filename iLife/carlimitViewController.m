//
//  carlimitViewController.m
//  iLife
//
//  Created by mirror on 16/4/25.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import "carlimitViewController.h"
#import "limitDetailViewController.h"

@interface carlimitViewController ()<ShadeViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) UIPickerView *carNumberPickerView;
@property (strong, nonatomic) ShadeView *shadeView;
@property (nonatomic, strong) NSArray *pickerContentArray;
@property (nonatomic,strong) NSString *nostr;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (nonatomic) NSInteger no;
@end

@implementation carlimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"限行查询";
    self.pickerContentArray=@[@"北京",@"贵阳",@"杭州",@"兰州",@"天津"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)select:(id)sender {
    self.shadeView = [[ShadeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.shadeView.delegate = self;
    [self.shadeView showWithView:self.view];
}
- (IBAction)chaxun:(id)sender {
    switch (self.no) {
        case 0:{
            self.nostr=@"beijing";
            break;
        }
        case 1:{
            self.nostr=@"guiyang";
            break;
        }
        case 2:{
            self.nostr=@"hangzhou";
            break;
        }
        case 3:{
            self.nostr=@"lanzhou";
            break;
        }
        case 4:{
            self.nostr=@"tianjin";
            break;
        }
            default:
            break;
    }
    NSString *path=@"http://v.juhe.cn/xianxing/index";
    NSString *api_id=@"182";
    NSString *method=@"GET";
    NSDictionary *dic=@{@"city":self.nostr,@"type":@(1)};
    [SVProgressHUD showWithStatus:@"正在查询"];
    [[JHAPISDK shareJHAPISDK]executeWorkWithAPI:path APIID:api_id Parameters:dic Method:method Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSNumber *errNum =[responseObject objectForKey:@"error_code"];
        if (errNum.integerValue==0) {
        [SVProgressHUD showSuccessWithStatus:@"查询成功"];
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        limitDetailViewController *vc= (limitDetailViewController *)[story instantiateViewControllerWithIdentifier:@"limitDetailViewController"];
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
-(void)show{
    self.carNumberPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.4)];
    self.carNumberPickerView.backgroundColor = [UIColor whiteColor];
    self.carNumberPickerView.dataSource = self;
    self.carNumberPickerView.delegate = self;
    [self.view addSubview:self.carNumberPickerView];
    
    [UIView animateWithDuration:ShadeAnimationTime animations:^{
        self.carNumberPickerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 0.4, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.6);
    }];
}
-(void)dismiss{
    [UIView animateWithDuration:ShadeAnimationTime animations:^{
        self.carNumberPickerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.6);
    } completion:^(BOOL finished) {
        [self.carNumberPickerView removeFromSuperview];
    }];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerContentArray.count;
}
#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.pickerContentArray[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.city.text=self.pickerContentArray[row];
    self.no=row;
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
