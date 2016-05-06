//
//  hdetailViewController.h
//  iLife
//
//  Created by mirror on 16/4/28.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hdetailViewController : UIViewController

@property (nonatomic , strong) NSDictionary * responseDic;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *route;
@property (weak, nonatomic) IBOutlet UILabel *phone;

@end
