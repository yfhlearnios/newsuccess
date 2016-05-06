//
//  DeliverDetailViewController.h
//  iLife
//
//  Created by mirror on 16/4/25.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeliverDetailViewController : UIViewController
@property (nonatomic,strong) NSString *dateStr;
@property (nonatomic,strong) NSString *remarkStr;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *remark;

@end
