//
//  describeTripViewController.h
//  0707 蝉游记
//
//  Created by pangang on 15/7/16.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface describeTripViewController : UIViewController

@property (nonatomic,strong) NSString *URLString;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *comments;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (nonatomic,strong) NSString *tableHeadURL;



@end
