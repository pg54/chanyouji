//
//  PlanViewController.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/31.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "PlanViewController.h"
#import "Netinterface.h"
#import "PlanCell.h"
#import "PlanModel.h"
#import "CacheTool.h"
#import "MyHTTPRequest.h"
#import "UIImageView+WebCache.h"
#import "TacticViewController.h"
#import "JurneyViewController.h"
#import "DestinationViewController.h"
#import "TopicViewController.h"

@interface PlanViewController ()<UITableViewDataSource,UITableViewDelegate,MyHTTPRequestDelegate>
{
    NSMutableArray *dataSourceArray;
    UITableView *userTableView;
}

@end

@implementation PlanViewController
- (IBAction)backButton:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    dataSourceArray = [[NSMutableArray alloc] init];
    _titleLabel.text = _labelString;
    userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-63)];
    userTableView.dataSource = self;
    userTableView.delegate = self;
    [userTableView registerNib:[UINib nibWithNibName:@"PlanCell" bundle:nil] forCellReuseIdentifier:@"pCell"];
    [self.view addSubview:userTableView];
    
    [self getData:_URLString];
    
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)getData:(NSString *)str
{
    NSDictionary *dic = [CacheTool putoutwithID:str];
    if (dic) {
        [self serializingWith:dic];
    }else
    {
        NSURL *url = [NSURL URLWithString:_URLString];
        MyHTTPRequest *request = [[MyHTTPRequest alloc] initWithURL:url];
        request.delegate = self;
        [request startAsynchronous];
    }
    

}
#pragma mark    -MyHTTPRequestDelegate
- (void)requestFinsh:(NSDictionary *)dic
{
    NSLog(@"%@",dic);
    [self serializingWith:dic];
    [CacheTool addTrip:dic andID:_URLString];

}
- (void)requestFailed:(NSString *)str
{
    NSLog(@"%@",str);

}

- (void)serializingWith:(NSDictionary *)dic
{
    
    for (NSDictionary *dic1 in dic ) {
        PlanModel *model = [[PlanModel alloc] init];
        model.chineseStr = dic1[@"name_zh_cn"];
        model.englishStr = dic1[@"name_en"];
        model.frontImageURL = dic1[@"image_url"];
        model.ID = dic1[@"id"];
        [dataSourceArray addObject:model];
    }
    [userTableView reloadData];
    
    
}


#pragma mark    -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSourceArray.count;

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pCell"];
    PlanModel *model = dataSourceArray[indexPath.row];
    [cell.fronImageView sd_setImageWithURL:[NSURL URLWithString:model.frontImageURL]];
    cell.chineseLabel.text = model.chineseStr;
    cell.englishLabel.text = model.englishStr;
    //
    cell.tacticButton.tag = [model.ID integerValue];
    cell.journeyButton.tag = [model.ID integerValue];
    cell.destinationButton.tag = [model.ID integerValue];
    cell.topicButton.tag = [model.ID integerValue];
    
    [cell.tacticButton addTarget:self action:@selector(tacticClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.journeyButton addTarget:self action:@selector(journeyClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.destinationButton addTarget:self action:@selector(destinationClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.topicButton addTarget:self action:@selector(topicClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;

}

- (void)tacticClick:(UIButton *)sender
{
    
    TacticViewController *tacVC = [[TacticViewController alloc] init];
    NSInteger num = (NSInteger)sender.tag;
    NSString *string = [NSString stringWithFormat:TACTIC,num];
    tacVC.URLString = string;
    [self.navigationController pushViewController:tacVC animated:YES];
    

}
- (void)journeyClick:(UIButton *)sender
{
    JurneyViewController *jurVC = [[JurneyViewController alloc] init];
    NSInteger num = (NSInteger)sender.tag;
    NSString *string = [NSString stringWithFormat:GLJURNEY,num];
    jurVC.URLString = string;
    [self.navigationController pushViewController:jurVC animated:YES];
    
}
- (void)destinationClick:(UIButton *)sender
{
    DestinationViewController *desVC = [[DestinationViewController alloc] init];
    NSInteger num = (NSInteger)sender.tag;
    NSString *string = [NSString stringWithFormat:GLDES,num];
    desVC.URLString = string;
    [self.navigationController pushViewController:desVC animated:YES];
    
}
- (void)topicClick:(UIButton *)sender
{
    TopicViewController *topVC = [[TopicViewController alloc] init];
    NSInteger num = (NSInteger)sender.tag;
    NSString *string = [NSString stringWithFormat:GLTOPIC,num];
    topVC.URLString = string;
    [self.navigationController pushViewController:topVC animated:YES];
                                  
    
}


#pragma mark    -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280;
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
