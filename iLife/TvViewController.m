//
//  TvViewController.m
//  iLife
//
//  Created by mirror on 16/4/25.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import "TvViewController.h"
#import "TVTableViewController.h"

@interface TvViewController ()<ShadeViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tv;
@property (nonnull,strong)  NSMutableArray *pickerContentArray;
@property (strong, nonatomic) UIPickerView *carNumberPickerView;
@property (strong, nonatomic) ShadeView *shadeView;
@property  (nonatomic) NSInteger no;
@end

@implementation TvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerContentArray =[[NSMutableArray alloc]init];
    self.title=@"电视节目";
    NSString *path=@"http://japi.juhe.cn/tv/getChannel";
    NSString *api_id=@"129";
    NSString *method=@"GET";
    NSDictionary *param=@{@"pId":@"1"};
    [[JHAPISDK shareJHAPISDK]executeWorkWithAPI:path APIID:api_id Parameters:param Method:method Success:^(id responseObject) {
        NSArray *result=[responseObject objectForKey:@"result"];
        for (NSDictionary *dic in result) {
            [self.pickerContentArray addObject:dic];
        }
    } Failure:^(NSError *error) {
        ;
    }];
     param=@{@"pId":@"2"};
    [[JHAPISDK shareJHAPISDK]executeWorkWithAPI:path APIID:api_id Parameters:param Method:method Success:^(id responseObject) {
        NSArray *result1=[responseObject objectForKey:@"result"];
        for (NSDictionary *dic in result1) {
            [self.pickerContentArray addObject:dic];
        }
    } Failure:^(NSError *error) {
        ;
    }];
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
    NSString *path=@"http://japi.juhe.cn/tv/getProgram";
    NSString *api_id=@"129";
    NSString *method=@"GET";
    NSDictionary *dic = [self.pickerContentArray objectAtIndex:self.no];
    NSString * code = [dic objectForKey:@"rel"];
    NSDictionary *param=@{@"code":code};
    [SVProgressHUD showWithStatus:@"正在查询"];
    [[JHAPISDK shareJHAPISDK]executeWorkWithAPI:path APIID:api_id Parameters:param Method:method Success:^(id responseObject) {
       NSNumber *errNum =[responseObject objectForKey:@"error_code"];
        if (errNum.integerValue==0) {
            [SVProgressHUD showSuccessWithStatus:@"查询成功"];
            UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TVTableViewController *vc= (TVTableViewController *)[story instantiateViewControllerWithIdentifier:@"TVTableViewController"];
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
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerContentArray.count;
}
#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSDictionary *dic = self.pickerContentArray[row];
    return [dic objectForKey:@"channelName"];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSDictionary *dic =self.pickerContentArray[row];
    self.no=row;
    self.tv.text = [dic objectForKey:@"channelName"];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
