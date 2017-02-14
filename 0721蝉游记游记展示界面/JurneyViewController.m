//
//  JurneyViewController.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/2.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "JurneyViewController.h"
#import "MyHTTPRequest.h"
#import "JurneyCell.h"
#import "JurneyModel.h"
#import "UIImageView+WebCache.h"
#import "describeTripViewController.h"
#import "Netinterface.h"
#import "CacheTool.h"

@interface JurneyViewController ()<UITableViewDataSource,UITableViewDelegate,MyHTTPRequestDelegate>
{
    UITableView *userTableView;
    CGFloat width;
    CGFloat height;
    NSArray *dataSourceArray;
}

@end

@implementation JurneyViewController
- (IBAction)backButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width, height-64)];
    userTableView.dataSource = self;
    userTableView.delegate = self;
    [userTableView registerNib:[UINib nibWithNibName:@"JurneyCell" bundle:nil] forCellReuseIdentifier:@"jurCell"];
    
    [self.view addSubview:userTableView];
    [self getData:_URLString];
    
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)getData:(NSString *)string
{
    NSDictionary *dict = [CacheTool putoutwithID:string];
    if (dict) {
        [self serializingWith:dict];
    }else
    {
        NSURL *url = [NSURL URLWithString:string];
        MyHTTPRequest *request = [[MyHTTPRequest alloc] initWithURL:url];
        request.delegate = self;
        [request startAsynchronous];
    }
}

- (void)requestFinsh:(NSDictionary *)dic
{
    [CacheTool addTrip:dic andID:_URLString];
    [self serializingWith:dic];
}

- (void)requestFailed:(NSString *)str
{
    NSLog(@"%@",str);
}

- (void)serializingWith:(NSDictionary *)dic
{
    NSArray *array = (NSArray *)dic;
    dataSourceArray = [MTLJSONAdapter modelsOfClass:[JurneyModel class] fromJSONArray:array error:nil];
    [userTableView reloadData];

}

#pragma mark    -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSourceArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JurneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jurCell"];
    JurneyModel *model = dataSourceArray[indexPath.row];
    NSLog(@"%@",model.image_url);
    [cell.frontImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    NSString *destinStr = [NSString stringWithFormat:@"%@旅行地",[model.plan_days_count stringValue]];
    cell.destinCountLabel.text = destinStr;
    NSString *dayStr = [NSString stringWithFormat:@"%@天",[model.plan_nodes_count stringValue]];
    cell.dayCountLabel.text = dayStr;
    cell.titleLabel.text = model.name;
    cell.describeLabel.text = model.descriptions;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    describeTripViewController *describeVC = [[describeTripViewController alloc] init];
    JurneyModel *model = dataSourceArray[indexPath.row];
    NSString *num = [model.ID stringValue];
    NSLog(@"[model.ID stringValue]====================%@",[model.ID stringValue]);
    NSString *str = [NSString stringWithFormat:tripDescribe,num];
    describeVC.URLString = str;
    NSLog(@"describeVC.URLString=======================================%@",str);
    [self.navigationController pushViewController:describeVC animated:nil];
    

}

#pragma mark    -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
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
