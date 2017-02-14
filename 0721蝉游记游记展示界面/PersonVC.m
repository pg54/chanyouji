//
//  PersonVC.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/1.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "PersonVC.h"
#import "UIImageView+WebCache.h"

@interface PersonVC ()

@end

@implementation PersonVC
- (IBAction)backButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)messageButton:(UIButton *)sender {
}

- (IBAction)addButton:(UIButton *)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _zhedie.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 10);
    [self getData:_dic];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)getData:(NSDictionary *)dic
{
    NSLog(@"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%@",dic);
    //_personName.text = dic[@"""name"""];
    NSString *str = dic[@"image"];
    NSLog(@"%@",str);
    [_personPhoto sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"TabBarIconMyNormal@3x"]];
    //_personTrip.text = dic[@"""trips_count"];
    

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
