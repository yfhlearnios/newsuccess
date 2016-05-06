//
//  healthViewController.m
//  iLife
//
//  Created by mirror on 16/4/27.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import "healthViewController.h"

@interface healthViewController ()<ShadeViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *health;
@property (strong, nonatomic) UIPickerView *carNumberPickerView;
@property (strong, nonatomic) ShadeView *shadeView;
@property (nonatomic, strong) NSArray *pickerContentArray;
@property (nonatomic,strong) NSString *nostr;


@end

@implementation healthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path=@"http://japi.juhe.cn/health_knowledge/categoryList";
    NSString *api_id=@"143";
    NSString *mothod=@"GET";
//    NSDictionary *param=@{@"com":@"yd",@"no":@"1700194023945",@"dtype":@"json"};
    [[JHAPISDK shareJHAPISDK]executeWorkWithAPI:path APIID:api_id Parameters:nil Method:mothod Success:^(id responseObject) {
        self.pickerContentArray =[responseObject objectForKey:@"result"];
    } Failure:^(NSError *error) {
        ;
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goin:(id)sender {
    
}
- (IBAction)select:(id)sender {
    self.shadeView = [[ShadeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.shadeView.delegate = self;
    [self.shadeView showWithView:self.view];
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
    NSDictionary *dic = [self.pickerContentArray objectAtIndex:row];
    self.nostr =[dic objectForKey:@"id"];
    self.health.text=[dic objectForKey:@"name"];
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
