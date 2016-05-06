//
//  DeliverViewController.m
//  iLife
//
//  Created by mirror on 16/4/25.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import "DeliverViewController.h"
#import "DeliverTableViewController.h"

@interface DeliverViewController ()<ShadeViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) UIPickerView *carNumberPickerView;
@property (strong, nonatomic) ShadeView *shadeView;
@property (weak, nonatomic) IBOutlet UILabel *lb_pass;
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (nonatomic,strong) NSString *nostr;
@property (nonatomic) NSInteger no;
@property (nonatomic, strong) NSArray *pickerContentArray;
@end

@implementation DeliverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerContentArray=@[@"顺丰",@"申通",@"圆通",@"韵达",@"天天",@"EMS",@"中通",@"汇通"];
    self.title=@"快递查询";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
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
    self.lb_pass.text=self.pickerContentArray[row];
    self.no=row;
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
- (IBAction)select:(id)sender {
    self.shadeView = [[ShadeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.shadeView.delegate = self;
    [self.shadeView showWithView:self.view];
}

- (IBAction)chaxun:(id)sender {
    switch (self.no) {
        case 0:{
            self.nostr=@"sf";
            break;
        }
        case 1:{
            self.nostr=@"";
            break;
        }
        case 2:{
            self.nostr=@"sto";
            break;
        }
        case 3:{
            self.nostr=@"yd";
            break;
        }
        case 4:{
            self.nostr=@"tt";
            break;
        }
        case 5:{
            self.nostr=@"EMS";
            break;
        }
        case 6:{
            self.nostr=@"zto";
            break;
        }
        case 7:{
            self.nostr=@"ht";
            break;
        }
            
        default:
            break;
    }
    NSString *path=@"http://v.juhe.cn/exp/index";
    NSString *api_id=@"43";
    NSString *mothod=@"GET";
    NSDictionary *param=@{@"com":@"yd",@"no":self.number.text,@"dtype":@"json"};
    [SVProgressHUD showWithStatus:@"正在查询"];
    [[JHAPISDK shareJHAPISDK] executeWorkWithAPI:path APIID:api_id Parameters:param Method:mothod Success:^(id responseObject) {
        NSNumber *errNum =[responseObject objectForKey:@"error_code"];
        if (errNum.integerValue==0) {
            [SVProgressHUD showSuccessWithStatus:@"查询成功"];
            UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            DeliverTableViewController *vc= (DeliverTableViewController *)[story instantiateViewControllerWithIdentifier:@"DeliverTableViewController"];
            vc.responseDic =responseObject;
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
