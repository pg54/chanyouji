//
//  HomeViewController.h
//  0707 蝉游记
//
//  Created by pangang on 15/7/10.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BoxView;
@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UIImageView *changeImage;

@property (weak, nonatomic) IBOutlet UIButton *tripButton;

@property (weak, nonatomic) IBOutlet UIButton *articlesButton;
@property (weak, nonatomic) IBOutlet UIButton *distinationButton;

@property (weak, nonatomic) IBOutlet UIView *costumView;

@property (nonatomic, strong) NSString *URLString;

@property (nonatomic, strong) NSDictionary *personDic;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, weak) BoxView *boxView;

@property (nonatomic, copy) NSDictionary *dict;



- (void)initThreeView;

- (void)boxReload;



@end
