//
//  indeViewController.h
//  iLife
//
//  Created by mirror on 16/4/28.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface indeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *key;
@property (weak, nonatomic) IBOutlet UITextView *desc;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (nonatomic,strong) NSDictionary *responseDic;
@end
