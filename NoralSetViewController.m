//
//  NoralSetViewController.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/8.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "NoralSetViewController.h"
#import "LoginRegist.h"

@interface NoralSetViewController ()

@end

@implementation NoralSetViewController
- (IBAction)login:(UIButton *)sender {
    LoginRegist *logVC = [[LoginRegist alloc] init];
    [self.navigationController pushViewController:logVC animated:YES];
}
- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
