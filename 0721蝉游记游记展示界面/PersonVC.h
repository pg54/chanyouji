//
//  PersonVC.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/1.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonVC : UIViewController
@property (nonatomic, strong) NSDictionary *dic;
@property (weak, nonatomic) IBOutlet UIView *personView;
@property (weak, nonatomic) IBOutlet UIImageView *personPhoto;
@property (weak, nonatomic) IBOutlet UILabel *personName;

@property (weak, nonatomic) IBOutlet UILabel *personTrip;
@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (weak, nonatomic) IBOutlet UIButton *tripButton;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *zhedieButton;
@property (weak, nonatomic) IBOutlet UIImageView *changeImage;
@property (weak, nonatomic) IBOutlet UIButton *zhedie;


@end
