//
//  PlanViewController.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/31.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanViewController : UIViewController

@property (nonatomic,strong) NSString *URLString;
@property (nonatomic,strong) NSString *labelString;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
