//
//  TVTableViewCell.h
//  iLife
//
//  Created by mirror on 16/4/27.
//  Copyright © 2016年 Mirror. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
